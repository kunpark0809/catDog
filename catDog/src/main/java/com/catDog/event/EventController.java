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
import org.springframework.web.bind.annotation.ResponseBody;

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
	
	
	@RequestMapping(value="/event/update", method=RequestMethod.GET)
	public String updateForm(Event dto, @RequestParam int eventNum,
							 @RequestParam String page, HttpSession session,
							 Model model) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		service.readEvent(eventNum);
		
		if(dto == null)
			return "redirect:/event/list?page="+page;
		
		if(! dto.getUserId().equals(info.getUserId())) {
			return "redirect:/event/list?page="+page;
		}
		
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("mode", "update");
		
		return ".event.created";
	}
	
	@RequestMapping(value="/event/update", method=RequestMethod.POST)
	public String updateSubmit(Event dto, @RequestParam String page,
							   HttpSession session) throws Exception {
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"event";
		
		try {
			service.updateEvent(dto, pathname);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/event/article?EventNum="+dto.getEventNum()+"&page="+page;
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
	
	@RequestMapping(value="/event/listReply")
	public String listReply(@RequestParam int eventNum, Model model,
							@RequestParam(value="pageNo", defaultValue="1") int current_page) throws Exception {
		
		int rows=5;
		int total_page=0;
		int dataCount=0;
		
		Map<String, Object> map = new HashMap<>();
		map.put("eventNum", eventNum);
		
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
		
		return "event/listReply";
	}
	
	@RequestMapping(value="/event/insertReply", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertReply(Reply dto, HttpSession session) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
				String state="true";
		
		try {
			dto.setUserId(info.getUserId());
			service.insertReply(dto);
		} catch (Exception e) {
			state="false";
		}
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	@RequestMapping(value="/event/deleteReply", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteReply(@RequestParam Map<String, Object> paramMap) {
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
	
	@RequestMapping(value="/event/listReplyAnswer")
	public String listReplyAnswer(@RequestParam int answer, Model model) throws Exception {
		List<Reply> listReplyAnswer=service.listReplyAnswer(answer);
		for(Reply dto : listReplyAnswer) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		
		model.addAttribute("listReplyAnswer", listReplyAnswer);
		
		return "event/listReplyAnswer";
	}
	
	@RequestMapping(value="/event/countReplyAnswer")
	@ResponseBody
	public Map<String, Object> countReplyAnswer(@RequestParam(value="answer") int answer) {
		int count=service.replyAnswerCount(answer);
		Map<String, Object> model=new HashMap<>();
		
		model.put("count", count);
		
		return model;
	}
	
}
