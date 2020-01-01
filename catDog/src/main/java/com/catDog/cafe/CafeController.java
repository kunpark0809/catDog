package com.catDog.cafe;

import java.io.File;
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

@Controller("cafe.Cafe")
public class CafeController {
	
@Autowired
private CafeService service;

@Autowired
private MyUtil myUtil;

@RequestMapping(value="/cafe/list")
public String list(
		@RequestParam(value="page", defaultValue="1") int current_page,
		@RequestParam(defaultValue="all") String condition,
		@RequestParam(defaultValue="") String keyword,
		HttpServletRequest req,
		Model model) throws Exception {

	String cp = req.getContextPath();

	Map<String, Object> map = new HashMap<String, Object>();
	
	map.put("keyword", keyword);
	map.put("condition", condition);
			
	int dataCount = service.dataCount(map);
	
	int rows = 6;
	int offset = (current_page-1)*rows;
	if(offset  < 0) offset = 0;
	
	int total_page = myUtil.pageCount(rows, dataCount);
	
	map.put("rows", rows);
	map.put("offset", offset);
	
	List<Cafe> list = service.listCafe(map);
	
	String listUrl = cp+"/cafe/list";
	String articleUrl = cp+"/cafe/article?page=" + current_page;
	
	String paging = myUtil.paging(current_page, total_page, listUrl);
	
	model.addAttribute("list", list);
	model.addAttribute("dataCount", dataCount);
	model.addAttribute("total_page", total_page);
	model.addAttribute("articleUrl", articleUrl);
	model.addAttribute("page", current_page);
	model.addAttribute("paging", paging);
	
	model.addAttribute("condition", condition);
	model.addAttribute("keyword", keyword);		
	
	return ".cafe.list";
}
	
	@RequestMapping(value="/cafe/created", method=RequestMethod.GET)
	public String createdForm(
			HttpSession session,
			Model model) throws Exception {
		
		model.addAttribute("mode", "created");
		return ".cafe.created";
	}
	
	@RequestMapping(value="/cafe/created", method=RequestMethod.POST)
	public String createdSubmit(
			Cafe dto,
			HttpSession session) throws Exception {
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"cafe";
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		try {
			dto.setNum(info.getMemberIdx());
			
			service.insertCafe(dto, pathname);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/cafe/list";
	}
	
	@RequestMapping(value="/cafe/article", method=RequestMethod.GET)
	public String article(
			@RequestParam int recommendNum,
			@RequestParam(defaultValue="1") String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			Model model
			) throws Exception{
		Cafe dto = service.readCafe(recommendNum);
		 
		String query="page="+page;
		if(dto == null) {
			return "redirect:/cafe/list?"+query;
		}
		
		service.updateHitCount(recommendNum);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("recommendNum", recommendNum);
		
		Cafe preReadCafe = service.preReadCafe(map);
		Cafe nextReadCafe = service.nextReadCafe(map);
		
		model.addAttribute("preReadCafe", preReadCafe);
		model.addAttribute("nextReadCafe", nextReadCafe);
		
		model.addAttribute("page",page);
		model.addAttribute("query",query);
		model.addAttribute("dto",dto);
		
		return ".cafe.article";
	}
	
	@RequestMapping(value="/cafe/delete", method=RequestMethod.GET)
	public String delete(
			@RequestParam int recommendNum,
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
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"cafe";
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		try {
			service.deleteCafe(recommendNum, pathname, info.getUserId());
		} catch (Exception e) {
		}
		
		return "redirect:/cafe/list?"+query;
	}
	
	@RequestMapping(value="/cafe/update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam int recommendNum,
			@RequestParam String page,
			HttpSession session,
			Model model
			) throws Exception {
		
		
		
		Cafe dto = service.readCafe(recommendNum);
		
		if(dto == null)
			return "redirect:/cafe/list?page="+page;
		
		if(dto.getUserId().indexOf("admin") < 0) {
			return "redirect:/cafe/list?page="+page;
		}
		
		model.addAttribute("page", page);
		model.addAttribute("mode", "update");
		model.addAttribute("dto", dto);
		
		return ".cafe.created";
	}
	
	@RequestMapping(value="/cafe/update", method=RequestMethod.POST)
	public String updateSubmit(
			Cafe dto,
			@RequestParam String page,
			HttpSession session
			) throws Exception {
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"cafe";
		
		try {
			service.updateCafe(dto, pathname);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/cafe/article?recommendNum="+dto.getRecommendNum()+"&page="+page;
	}
	
	@RequestMapping(value="/cafe/insertRate", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertRate(
			Cafe dto,
			HttpSession session
			) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		String state="true";
		
		try {
			dto.setNum(info.getMemberIdx());
			service.insertRate(dto);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	@RequestMapping(value="/cafe/listRate")
	public String listRate(
			@RequestParam int recommendNum,
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			Model model
			) throws Exception {
		
		int rows=5;
		int total_page=0;
		int dataCount=0;
		
		Map<String, Object> map=new HashMap<>();
		map.put("recommendNum", recommendNum);
		
		dataCount=service.rateCount(map);
		total_page = myUtil.pageCount(rows, dataCount);
		if(current_page>total_page)
			current_page=total_page;
		
        int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);
		List<Cafe> listRate=service.listRate(map);
		
		for(Cafe dto : listRate) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		
		String paging=myUtil.pagingMethod(current_page, total_page, "listPage");
		
		model.addAttribute("listRate", listRate);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("rateCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		return "cafe/listRate";
	}
	
		@RequestMapping(value="/cafe/deleteRate", method=RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> deleteRate(
				@RequestParam Map<String, Object> paramMap
				) {
			
			String state="true";
			try {
				service.deleteRate(paramMap);
			} catch (Exception e) {
				state="false";
			}
		
			Map<String, Object> map = new HashMap<>();
			map.put("state", state);
			return map;
		}
	
}