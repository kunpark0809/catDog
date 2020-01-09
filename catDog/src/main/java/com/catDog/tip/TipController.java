package com.catDog.tip;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.catDog.common.MyUtil;
import com.catDog.customer.SessionInfo;

@Controller("tip.Tip")
public class TipController {
	
@Autowired
private TipService service;

@Autowired
private MyUtil myUtil;

@RequestMapping(value="/tip/list")
public String list(
		@RequestParam(value="page", defaultValue="1") int current_page,
		@RequestParam(defaultValue="all") String condition,
		@RequestParam(defaultValue="") String keyword,
		HttpServletRequest req,
		Model model) throws Exception {
	
	String cp = req.getContextPath();
	
	int rows = 5;
	int total_page = 0;
	int dataCount = 0;
	
	if(req.getMethod().equalsIgnoreCase("GET")) {
		keyword = URLDecoder.decode(keyword, "utf-8");
	}
	
	Map<String, Object> map = new HashMap<String, Object>();
	map.put("condition", condition);
	map.put("keyword", keyword);
	
	dataCount = service.dataCount(map);
	
	if(dataCount != 0)
		total_page = myUtil.pageCount(rows, dataCount);
	
	if(total_page < current_page)
		current_page = total_page;

	
	int offset = (current_page-1) * rows;
	if(offset < 0) offset = 0;
	map.put("offset", offset);
	map.put("rows", rows);
	
	List<Tip> list = service.listTip(map);
	
	int listNum, n = 0;
	for(Tip dto : list) {
		listNum = dataCount - (offset + n);
		dto.setListNum(listNum);
		
		dto.setCreated(dto.getCreated().substring(0, 10));
		n++;
	}
	
	String query = "";
	String listUrl;
	String articleUrl;
	if(keyword.length()!=0) {
		query = "condition=" +condition + 
   	         "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
	}
	
	listUrl = cp+"/tip/list";
	articleUrl = cp + "/tip/article?page="+current_page;
	if(query.length()!=0) {
		listUrl = listUrl + "?" + query;
		articleUrl = articleUrl + "&" + query;
	}
	
	String paging = myUtil.paging(current_page, total_page, listUrl);

	model.addAttribute("list", list);
	model.addAttribute("page", current_page);
	model.addAttribute("total_page", total_page);
	model.addAttribute("dataCount", dataCount);
	model.addAttribute("paging", paging);
	model.addAttribute("articleUrl", articleUrl);
	
	model.addAttribute("condition", condition);
	model.addAttribute("keyword", keyword);
	
	return ".tip.list";
}

	@RequestMapping(value="/tip/created", method=RequestMethod.GET)
	public String createdForm(
			HttpSession session,
			Model model) throws Exception {
		List<Tip> listCategory = service.listTipCategory();
		
		model.addAttribute("listCategory", listCategory);
		model.addAttribute("mode", "created");
		return ".tip.created";
	}
	
	@RequestMapping(value="/tip/created", method=RequestMethod.POST)
	public String createdSubmit(
			Tip dto,
			HttpSession session) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		try {
			dto.setNum(info.getMemberIdx());
			
			service.insertTip(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/tip/list";
	}

	@RequestMapping(value="/tip/article", method=RequestMethod.GET)
	public String article(
			@RequestParam int tipNum,
			@RequestParam(defaultValue="1") String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			Model model
			) throws Exception{
		Tip dto = service.readTip(tipNum);
		
		String query="page="+page;
		if(dto == null) {
			return "redirect:/tip/list?"+query;
		}
		
		service.updateHitCount(tipNum);
		dto.setTipLikeCount(service.tipLikeCount(tipNum));
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("tipNum", tipNum);
		
		Tip preReadTip = service.preReadTip(map);
		Tip nextReadTip = service.nextReadTip(map);
		
		model.addAttribute("preReadTip", preReadTip);
		model.addAttribute("nextReadTip", nextReadTip);
		
		model.addAttribute("page",page);
		model.addAttribute("query",query);
		model.addAttribute("dto",dto);
		
		return ".tip.article";
	}
	
	@RequestMapping(value="/tip/delete", method=RequestMethod.GET)
	public String delete(
			@RequestParam int tipNum,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpSession session
			) throws Exception {
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		String query="page="+page;
		
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		try {
			service.deleteTip(tipNum, info.getUserId());
		} catch (Exception e) {
		}
		
		return "redirect:/tip/list?"+query;
	}
	
	@RequestMapping(value="/tip/update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam int tipNum,
			@RequestParam String page,
			HttpSession session,
			Model model
			) throws Exception {
		
		Tip dto = service.readTip(tipNum);
		
		if(dto == null)
			return "redirect:/tip/list?page="+page;
		
		List<Tip> listCategoty = service.listTipCategory();
		
		model.addAttribute("page", page);
		model.addAttribute("mode", "update");
		model.addAttribute("dto", dto);
		model.addAttribute("listCategory", listCategoty);
		
		return ".tip.created";
	}
	
	@RequestMapping(value="/tip/update", method=RequestMethod.POST)
	public String updateSubmit(
			Tip dto,
			@RequestParam String page,
			HttpSession session
			) throws Exception {
		
		try {
			service.updateTip(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/tip/article?tipNum="+dto.getTipNum()+"&page="+page;
	}
	
	@RequestMapping(value="/tip/listReply")
	public String listReply(@RequestParam int tipNum, Model model,
							@RequestParam(value="pageNo", defaultValue="1") int current_page) throws Exception {
		
		int rows=5;
		int total_page=0;
		int dataCount=0;
		
		Map<String, Object> map = new HashMap<>();
		map.put("tipNum", tipNum);
		
		dataCount=service.replyCount(map);
		total_page = myUtil.pageCount(rows, dataCount);
		if(current_page>total_page)
			current_page=total_page;
		
		int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
		map.put("offset", offset);
		map.put("rows", rows);
		List<Reply> listReply=service.listReply(map);
		
		for(Reply dto : listReply) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		
		String paging=myUtil.pagingMethod(current_page, total_page, "listPage");
		
		model.addAttribute("listReply", listReply);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("replyCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		return "tip/listReply";
	}

	
	@RequestMapping(value="/tip/insertReply", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertReply(
			Reply dto,
			HttpSession session
			) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
				String state="true";
		
		try {
			dto.setNum(info.getMemberIdx());
			service.insertReply(dto);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}
	

	@RequestMapping(value="/tip/deleteReply", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteReply(
			@RequestParam Map<String, Object> paramMap
			) {
		String state="true";
		
		try {
			service.deleteReply(paramMap);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> map = new HashMap<>();
				map.put("state", state);
		return map;
	}
	
	@RequestMapping(value="/tip/listReplyParent")
	public String listReplyParent(
			@RequestParam int parent,
			Model model
			) throws Exception {
		
		List<Reply> listReplyParent=service.listReplyParent(parent);
		
		for(Reply dto : listReplyParent) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		
		model.addAttribute("listReplyParent", listReplyParent);
		
		return "tip/listReplyParent";
	}
	
	@RequestMapping(value="/tip/countReplyParent")
	@ResponseBody
	public Map<String, Object> countReplyParent(
			@RequestParam(value="parent") int parent
			) {
		int count=service.replyParentCount(parent);
		
		Map<String, Object> model=new HashMap<>();
		
		model.put("count", count);
		
		return model;
	}
	

	// 게시글 좋아요 추가 :  : AJAX-JSON
	@RequestMapping(value="/tip/insertTipLike", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertTipLike(
			@RequestParam int tipNum,
			HttpSession session
			) {
		String state="true";
		int tipLikeCount=0;
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Map<String, Object> paramMap=new HashMap<>();
		paramMap.put("tipNum", tipNum);
		paramMap.put("num", info.getMemberIdx());
		
		try {
			service.insertTipLike(paramMap);
		} catch (Exception e) {
			state="false";
		}
			
		tipLikeCount = service.tipLikeCount(tipNum);
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		model.put("tipLikeCount", tipLikeCount);
		
		return model;
	}

	// 게시글 신고추가 :  : AJAX-JSON
	@RequestMapping(value="/tip/insertTipReport", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertTipReport(
			@RequestParam int reportedPostNum,
			@RequestParam int reporterNum,
			@RequestParam int reportedNum,
			@RequestParam int reasonSortNum,
			HttpSession session
			) {
		String state="true";
		int tipReportCount=0;
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Map<String, Object> paramMap=new HashMap<>();
		paramMap.put("reportedPostNum", reportedPostNum);
		paramMap.put("reporterNum", info.getMemberIdx());
		paramMap.put("reportedNum", reportedNum);
		paramMap.put("reasonSortNum", reasonSortNum);
		
		try {
			service.insertTipReport(paramMap);
		} catch (Exception e) {
			state="false";
		}

		tipReportCount = service.tipReportCount(reportedPostNum);

		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		model.put("tipReportCount", tipReportCount);

		return model;
	}
	
}
