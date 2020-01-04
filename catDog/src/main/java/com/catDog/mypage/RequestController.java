package com.catDog.mypage;

import java.net.URLDecoder;
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
import com.catDog.dogShop.DogShopService;
import com.catDog.pay.Pay;

@Controller("mypage.requestController")
public class RequestController {
	@Autowired
	private RequestService service;
	
	@Autowired
	private DogShopService dogShopService;
	
	@Autowired
	private MyUtil util;
	
	@RequestMapping(value="/mypage/requestCheck")
	public String requestList(
			@RequestParam(value="page", defaultValue="1") int current_page,
			HttpServletRequest req,
			HttpSession session,
			Model model) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String cp = req.getContextPath();
		
		int rows = 5;
		int total_page = 0;
		int dataCount = 0;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("num", info.getMemberIdx());
		dataCount = service.dataCount(map);
		if(dataCount != 0)
			total_page = util.pageCount(rows, dataCount);
		
		if(total_page < current_page)
			current_page = total_page;
		
		int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
		map.put("offset", offset);
		map.put("rows", rows);
		
		List<Pay> list = service.requestList(map);
		
		String listUrl;
		String detailUrl;
		
		listUrl = cp+"/mypage/requestCheck";
		
		String paging = util.pagingMethod(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("page", current_page);
		model.addAttribute("paging", paging);
		model.addAttribute("total_page", total_page);
		
		return ".mypage.requestCheck";
	}
	
	@RequestMapping(value="/mypage/requestDetailCheck")
	public String requestDetailCheck() throws Exception {
		
		
		return ".mypage.requestDetailCheck";
	}
}
