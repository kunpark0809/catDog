package com.catDog.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.catDog.cs.CsService;
import com.catDog.cs.Notice;
import com.catDog.park.Park;
import com.catDog.park.ParkService;
import com.catDog.shop.Shop;
import com.catDog.shop.ShopService;

@Controller("mainController")
public class MainController {
	
	@Autowired
	private ParkService parkService;
	
	@Autowired
	private CsService service;
	
	@Autowired
	private ShopService shopService;
	 
	@RequestMapping(value="/main", method=RequestMethod.GET)
	public String method(HttpServletRequest req,
			Model model) {
		String cp = req.getContextPath();
		
		int rows = 5;
		Map<String, Object> noticeMap = new HashMap<String, Object>();		
		noticeMap.put("offset", 0);
		noticeMap.put("rows", rows);
		
		List<Notice> noticeList = service.listNotice(noticeMap);
		
		String noticeListUrl = cp+"/notice/article?page=1";
		
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("noticeListUrl", noticeListUrl);
		
		Map<String, Object> parkMap = new HashMap<String, Object>();
		parkMap.put("offset", 0);
		parkMap.put("rows", 3);
		
		List<Park> parkList = parkService.listPark(parkMap);
		
		String parkListUrl = cp+"/park/article?page=1";
		
		model.addAttribute("parkList", parkList);
		model.addAttribute("parkListUrl", parkListUrl);
		
		Map<String, Object> reviewMap = new HashMap<String, Object>();
		reviewMap.put("offset", 0);
		reviewMap.put("rows", rows);
		
		List<Shop> reviewList = shopService.listAllReview(reviewMap);
		
		String reviewListUrl = cp+"/shop/article?";
		
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("reviewListUrl", reviewListUrl);
		
		
		
		return ".mainLayout";
	}
}
