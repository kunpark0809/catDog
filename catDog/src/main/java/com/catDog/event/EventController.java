package com.catDog.event;

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

import com.catDog.common.MyUtil;
import com.catDog.customer.SessionInfo;

@Controller("evert.eventController")
public class EventController {
	@Autowired
	private EventService service;
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="/event/list")
	public String list(@RequestParam(value="page", defaultValue="1") int current_page,
					   @RequestParam(defaultValue="all") String condition,
					   @RequestParam(defaultValue="") String keyword, HttpServletRequest req,
					   Model model) throws Exception {
		
		String cp = req.getContextPath();
		
		int rows = 6;
		int total_page;
		int dataCount;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		dataCount = service.dataCount(map);
		total_page = myUtil.pageCount(rows, dataCount);
		
		if(total_page < current_page)
			current_page = total_page;
		
		int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
		map.put("offset", offset);
		map.put("rows", rows);
		
		List<Event> list = service.listEvent(map);
		
		int listNum, n = 0;
		for(Event dto : list) {
			listNum = dataCount - (offset + n);
			dto.setListNum(listNum);
			n++;
		}
		
		String query = "";
		String listUrl = cp+"/event/list";
		String articleUrl = cp+"/event/article?page=" + current_page;
		if(keyword.length()!=0) {
			query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "utf-8");
		}
		
		if(query.length()!=0) {
			listUrl = cp+"/event/list?" + query;
			articleUrl = cp+"/event/article?page=" + current_page + "&" + query;
		}
		
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("page", current_page);
		model.addAttribute("paging", paging);
		
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return ".event.list";
	}

	@RequestMapping(value="/event/created", method=RequestMethod.GET)
	public String createdForm(Model model) throws Exception {
		
		model.addAttribute("mode", "created");
		return ".event.created";
	}
	
	@RequestMapping(value="/event/created", method=RequestMethod.POST)
	public String createdSubmit(Event dto, HttpSession session) throws Exception {
		String root=session.getServletContext().getRealPath("/");
		String path=root+"uploads"+File.separator+"event";
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		try {
			dto.setNum(info.getMemberIdx());
			
			service.insertEvent(dto, path);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/event/list";
	}
	
	@RequestMapping(value="/event/article", method=RequestMethod.GET)
	public String article(@RequestParam int eventNum, @RequestParam(defaultValue="1") String page,
						  @RequestParam(defaultValue="all") String condition,
						  @RequestParam(defaultValue="") String keyword, Model model) throws Exception {
		List<Event> list = service.readEvent(eventNum);
		keyword = URLDecoder.decode(keyword, "utf-8");
		
		String query="page="+page;
		if(list.size() == 0) {
			return "redirect:/event/list?"+query;
		}
		
		service.updateHitCount(eventNum);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("eventNum", eventNum);
		
		Event preReadEvent = service.preReadEvent(map);
		Event nextReadEvent = service.nextReadEvent(map);
		
		model.addAttribute("preReadEvent", preReadEvent);
		model.addAttribute("nextReadEvent", nextReadEvent);
		
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		model.addAttribute("list", list);
		
		return ".event.article";
	}
	
	public String updateForm() throws Exception {
		
		return null;
	}
	
	public String updateSubmit() throws Exception {
		
		return null;
	}
	
	@RequestMapping(value="/event/delete", method=RequestMethod.GET)
	public String delete(@RequestParam int eventNum, @RequestParam String page,
						 @RequestParam(defaultValue="all") String condition,
						 @RequestParam(defaultValue="") String keyword, HttpSession session) throws Exception {
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "utf-8");
		}
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"event";
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		try {
			service.deleteEvent(eventNum, pathname, info.getUserId());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/event/list?"+query;
	}
}
