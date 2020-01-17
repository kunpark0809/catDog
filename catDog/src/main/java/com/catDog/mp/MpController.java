package com.catDog.mp;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.catDog.common.MyUtil;
import com.catDog.customer.SessionInfo;
import com.catDog.mpadoption.Mpadoption;
import com.catDog.mpadoption.MpadoptionService;
import com.catDog.mpbbs.Mpbbs;
import com.catDog.mpbbs.MpbbsService;
import com.catDog.mplostpet.Mplostpet;
import com.catDog.mplostpet.MplostpetService;
import com.catDog.mpmypet.Mpmypet;
import com.catDog.mpmypet.MpmypetService;
import com.catDog.mpqna.Mpqna;
import com.catDog.mpqna.MpqnaService;
import com.catDog.mptip.Mptip;
import com.catDog.mptip.MptipService;

@Controller("mp.mpController")
public class MpController {
	@Autowired
	private MpadoptionService Mpadoptionservice;
	
	@Autowired
	private MpbbsService Mpbbsservice;
	
	@Autowired
	private MplostpetService Mplostpetservice;
	
	@Autowired
	private MpqnaService Mpqnaservice;
	
	@Autowired
	private MpmypetService Mpmypetservice;
	
	@Autowired
	private MptipService Mptipservice;
	
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping("/mypage/main")
	public String main() throws Exception {
		return ".mypage.main";
	}
	
	@RequestMapping("/mypage/qna")
	public String qnaList(@RequestParam(value="pageNo", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req, Model model, HttpSession session) throws Exception {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String cp = req.getContextPath();
		
		int rows = 10;
		int total_page = 0;
		int dataCountMpQna = 0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("num", info.getMemberIdx());
		
		
		dataCountMpQna = Mpqnaservice.dataCountMpQna(map);
		if(dataCountMpQna != 0)
			total_page = myUtil.pageCount(rows, dataCountMpQna);
		
		if(total_page < current_page)
			current_page = total_page;
		
		int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
		map.put("offset", offset);
		map.put("rows", rows);
		
		List<Mpqna> listMpQna = Mpqnaservice.listMpQna(map);
		
		int qnaListNum , n = 0;
		for(Mpqna dto : listMpQna) {
			qnaListNum = dataCountMpQna - (offset + n);
			dto.setQnaListNum(qnaListNum);
			n++;
		}
		
		String query = "";
		String listUrl;
		String articleUrl;
		if(keyword.length()!=0) {
			query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "utf-8");
		}
		
		listUrl = cp+"/mypage/qna/qna";
		articleUrl = cp+"/qna/article?pageNo="+current_page;
		if(query.length()!=0) {
			listUrl = listUrl + "?" + query;
			articleUrl = articleUrl + "&" + query;
		}
		
		String paging = myUtil.pagingMethod(current_page, total_page, "listPage");
		
		model.addAttribute("listMpQna", listMpQna);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("dataCountMpQna", dataCountMpQna);
		model.addAttribute("paging", paging);
		model.addAttribute("articleUrl", articleUrl);
		
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return "/mypage/qna/qna";
		
	}
	@RequestMapping("/mypage/tip")
	public String tipList(@RequestParam(value="pageNo", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req, Model model, HttpSession session) throws Exception {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String cp = req.getContextPath();
		
		int rows = 10;
		int total_page = 0;
		int dataCountMpTip = 0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("num", info.getMemberIdx());
		
		dataCountMpTip = Mptipservice.dataCountMpTip(map);
		if(dataCountMpTip != 0)
			total_page = myUtil.pageCount(rows, dataCountMpTip);
		if(total_page < current_page)
			current_page = total_page;
		
		int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
		map.put("offset", offset);
		map.put("rows", rows);
		
		List<Mptip> listMpTip = Mptipservice.listMpTip(map);
		
		int tipListNum , n =0;
		for(Mptip dto : listMpTip) {
			tipListNum = dataCountMpTip - (offset + n);
			dto.setTipListNum(tipListNum);
			n++;
		}
		
		String query = "";
		String listUrl;
		String articleUrl;
		if(keyword.length()!=0) {
			query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "utf-8");
		}
		
		listUrl = cp+"/mypage/tip/tip";
		articleUrl = cp+"/tip/article?page="+current_page;
		if(query.length()!=0) {
			listUrl = listUrl + "?" + query;
			articleUrl = articleUrl + "&" + query;
		}
		
		String paging = myUtil.pagingMethod(current_page, total_page, "listPage");
		
		model.addAttribute("listMpTip", listMpTip);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("dataCountMpTip", dataCountMpTip);
		model.addAttribute("paging", paging);
		model.addAttribute("articleUrl", articleUrl);
		
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return "/mypage/tip/tip";
		
	}
	@RequestMapping("/mypage/bbs")
	public String bbsList(@RequestParam(value="pageNo", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req, Model model, HttpSession session) throws Exception {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String cp = req.getContextPath();
		
		int rows = 10;
		int total_page = 0;
		int dataCountMpBbs = 0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("num", info.getMemberIdx());
		
		dataCountMpBbs = Mpbbsservice.dataCountMpBbs(map);
		if(dataCountMpBbs != 0)
			total_page = myUtil.pageCount(rows, dataCountMpBbs);
		if(total_page < current_page)
			current_page = total_page;
		
		int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
		map.put("offset", offset);
		map.put("rows", rows);
		
		List<Mpbbs> listMpBbs = Mpbbsservice.listMpBbs(map);
		
		int bbsListNum, n = 0;
		for(Mpbbs dto : listMpBbs) {
			bbsListNum = dataCountMpBbs - (offset + n);
			dto.setBbsListNum(bbsListNum);
			n++;
		}
		
		String query = "";
		String listUrl;
		String articleUrl;
		if(keyword.length()!=0) {
			query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "utf-8");
		}
		
		listUrl = cp+"/mypage/bbs/bbs";
		articleUrl = cp+"/freeBoard/article?page="+current_page;
		if(query.length()!=0) {
			listUrl = listUrl + "?" + query;
			articleUrl = articleUrl + "&" + query;
		}
		
		String paging = myUtil.pagingMethod(current_page, total_page, "listPage");
		
		model.addAttribute("listMpBbs", listMpBbs);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("dataCountMpBbs", dataCountMpBbs);
		model.addAttribute("paging", paging);
		model.addAttribute("articleUrl", articleUrl);
		
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		return "/mypage/bbs/bbs";
	}
	
	@RequestMapping("/mypage/mypet")
	public String mypetList(@RequestParam(value="pageNo", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req, Model model, HttpSession session) throws Exception {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String cp = req.getContextPath();
		
		int rows = 10;
		int total_page = 0;
		int dataCountMpMyPet = 0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("num", info.getMemberIdx());
		
		dataCountMpMyPet = Mpmypetservice.dataCountMpMyPet(map);
		if(dataCountMpMyPet != 0)
			total_page = myUtil.pageCount(rows, dataCountMpMyPet);
		if(total_page < current_page)
			current_page = total_page;
		
		int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
		map.put("offset", offset);
		map.put("rows", rows);
		
		List<Mpmypet> listMpMyPet = Mpmypetservice.listMpMyPet(map);
		
		int petListNum , n = 0;
		for(Mpmypet dto : listMpMyPet) {
			petListNum = dataCountMpMyPet - (offset + n);
			dto.setPetListNum(petListNum);
			n++;
		}
		
		String query = "";
		String listUrl;
		String articleUrl;
		if(keyword.length()!=0) {
			query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "utf-8");
		}
		
		listUrl = cp+"/mypage/mypet/mypet";
		articleUrl = cp+"/pet/article?pageNo="+current_page;
		if(query.length()!=0) {
			listUrl = listUrl + "?" + query;
			articleUrl = articleUrl + "&" + query;
		}
		
		String paging = myUtil.pagingMethod(current_page, total_page, "listPage");
		
		model.addAttribute("listMpMyPet", listMpMyPet);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("dataCountMpMyPet", dataCountMpMyPet);
		model.addAttribute("paging", paging);
		model.addAttribute("articleUrl", articleUrl);
		
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return "/mypage/mypet/mypet";
		
	}

	@RequestMapping("/mypage/lostpet")
	public String lostpetList(@RequestParam(value = "pageNo", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition, @RequestParam(defaultValue = "") String keyword,
			HttpServletRequest req, Model model, HttpSession session) throws Exception {

		SessionInfo info = (SessionInfo) session.getAttribute("member");

		String cp = req.getContextPath();

		int rows = 10;
		int total_page = 0;
		int dataCountMpLostPet = 0;

		if (req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("num", info.getMemberIdx());
		
		int offset = (current_page - 1) * rows;
		if (offset < 0)
			offset = 0;
		map.put("offset", offset);
		map.put("rows", rows);

		dataCountMpLostPet = Mplostpetservice.dataCountMpLostPet(map);
		if (dataCountMpLostPet != 0)
			total_page = myUtil.pageCount(rows, dataCountMpLostPet);
		if (total_page < current_page)
			current_page = total_page;


		List<Mplostpet> listMpLostPet = Mplostpetservice.listMpLostPet(map);

		int lostPetListNum, n = 0;
		for (Mplostpet dto : listMpLostPet) {
			lostPetListNum = dataCountMpLostPet - (offset + n);
			dto.setLostPetListNum(lostPetListNum);
			n++;
		}

		String query = "";
		String listUrl;
		String articleUrl;
		if (keyword.length() != 0) {
			query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "utf-8");
		}

		listUrl = cp + "/mypage/lostpet/lostpet";
		articleUrl = cp + "/aband/article?page=" + current_page;
		if (query.length() != 0) {
			listUrl = listUrl + "?" + query;
			articleUrl = articleUrl + "&" + query;
		}

		String paging = myUtil.pagingMethod(current_page, total_page, "listPage");

		model.addAttribute("listMpLostPet", listMpLostPet);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("dataCountMpLostPet", dataCountMpLostPet);
		model.addAttribute("paging", paging);
		model.addAttribute("articleUrl", articleUrl);

		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return "/mypage/lostpet/lostpet";
		
	}
	
	@RequestMapping("/mypage/adoption")
	public String adoptionList(@RequestParam(value="pageNo", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req, Model model, HttpSession session) throws Exception {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String cp = req.getContextPath();
		
		int rows = 10;
		int total_page = 0;
		int dataCountMpAdoption = 0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("num", info.getMemberIdx());
		
		dataCountMpAdoption = Mpadoptionservice.dataCountMpAdoption(map);
		if(dataCountMpAdoption != 0)
			total_page = myUtil.pageCount(rows, dataCountMpAdoption);
		if(total_page < current_page)
			current_page = total_page;
		
		int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
		map.put("offset", offset);
		map.put("rows", rows);
		
		List<Mpadoption> listMpAdoption = Mpadoptionservice.listMpAdoption(map);
		
		int adoptionListNum , n = 0;
		for(Mpadoption dto : listMpAdoption) {
			adoptionListNum = dataCountMpAdoption - (offset + n);
			dto.setAdoptionListNum(adoptionListNum);
			n++;
		}
		
		String query = "";
		String listUrl;
		String articleUrl;
		if(keyword.length()!=0) {
			query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "utf-8");
		}
		
		listUrl = cp+"/mypage/adoption/adoption";
		articleUrl = cp+"/adopt/article?page="+current_page;
		if(query.length()!=0) {
			listUrl = listUrl + "?" + query;
			articleUrl = articleUrl + "&" + query;
		}
		
		String paging = myUtil.pagingMethod(current_page, total_page, "listPage");
		
		model.addAttribute("listMpAdoption", listMpAdoption);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("dataCountMpAdoption", dataCountMpAdoption);
		model.addAttribute("paging", paging);
		model.addAttribute("articleUrl", articleUrl);
		
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return "/mypage/adoption/adoption";
	}
	
}
