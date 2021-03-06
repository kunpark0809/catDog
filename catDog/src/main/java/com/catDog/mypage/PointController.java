package com.catDog.mypage;

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

@Controller("mypage.pointController")
public class PointController {
	@Autowired
	private PointService service;
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="/mypage/point")
	public String list(@RequestParam(value="page", defaultValue="1") int current_page,
					   @RequestParam(defaultValue="all") String condition,
					   @RequestParam(defaultValue="") String keyword, HttpServletRequest req,
					   Model model, HttpSession session) throws Exception {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String cp = req.getContextPath();
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("keyword", keyword);
		map.put("condition", condition);
		map.put("num", info.getMemberIdx());
		int dataCount = service.dataCount(map);
		
		int rows = 10;
		int offset = (current_page-1)*rows;
		if(offset < 0) offset = 0;
		
		int total_page = myUtil.pageCount(rows, dataCount);
		
		map.put("rows", rows);
		map.put("offset", offset);
		
		List<Point> list = service.listPoint(map);
		
		String listUrl = cp+"/mypage/point";
		
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("page", current_page);
		model.addAttribute("paging", paging);
		model.addAttribute("listUrl", listUrl);
		
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return ".mypage.point";
	}
	
	
}
