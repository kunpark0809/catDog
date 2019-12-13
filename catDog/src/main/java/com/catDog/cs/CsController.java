package com.catDog.cs;

import java.io.File;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
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

import com.catDog.common.FileManager;
import com.catDog.common.MyUtil;
import com.catDog.customer.SessionInfo;

@Controller("cs.csController")
public class CsController {
	@Autowired
	private CsService service;
	
	@Autowired
	private MyUtil util;
	
	@Autowired
	private FileManager fileManager;
	
	@RequestMapping(value="/notice/list")
	public String noticeList(
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
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
		
		dataCount = service.noticeDataCount(map);
		if(dataCount != 0)
			total_page = util.pageCount(rows, dataCount);
		
		if(total_page < current_page)
			current_page = total_page;
		
		List<Notice> noticeList = null;
		if(current_page==1) {
			noticeList = service.listNoticeTop();
		}
		
		int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
		map.put("offset", offset);
		map.put("rows", rows);
		
		List<Notice> list = service.listNotice(map);
		
		Date endDate = new Date();
		long gap;
		
		int listNum, n = 0;
		for(Notice dto : list) {
			listNum = dataCount - (offset + n);
			dto.setListNum(listNum);
			
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date beginDate = formatter.parse(dto.getCreated());
			
			gap = (endDate.getTime()-beginDate.getTime()) / (60*60*1000);
			dto.setGap(gap);
			
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
		
		listUrl = cp+"/notice/list";
		articleUrl = cp + "/notice/article?page="+current_page;
		if(query.length()!=0) {
			listUrl = listUrl + "?" + query;
			articleUrl = articleUrl + "&" + query;
		}
		
		String paging = util.paging(current_page, total_page, listUrl);
		
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("paging", paging);
		model.addAttribute("articleUrl", articleUrl);
		
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return ".notice.list";
	}
	
	@RequestMapping(value="/notice/created", method=RequestMethod.GET)
	public String createdForm(Model model,
			  				  HttpSession session) throws Exception {
		model.addAttribute("mode", "created");
		return ".notice.created";
	}
	
	@RequestMapping(value="/notice/created", method=RequestMethod.POST)
	public String createdSubmit(Notice dto,
								HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root+"uploads"+File.separator+"notice";
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {			
			dto.setNum(info.getMemberIdx());			
			service.insertNotice(dto, pathname);
		} catch (Exception e) {
		}	
		return "redirect:/notice/list";
	}
	
	@RequestMapping(value="/qna/list")
	public String qnaList(
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			Model model) throws Exception {
		
		return ".qna.list";
	}
	
	@RequestMapping(value="/faq/list")
	public String faqList(
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			Model model) throws Exception {
		
		return ".faq.list";
	}
}
