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

@Controller("mainController")
public class MainController {
	@Autowired
	private CsService service;
	 
	@RequestMapping(value="/main", method=RequestMethod.GET)
	public String method(HttpServletRequest req,
			Model model) {
		String cp = req.getContextPath();
		
		int rows = 5;
		Map<String, Object> map = new HashMap<String, Object>();		
		map.put("offset", 0);
		map.put("rows", rows);
		
		List<Notice> list = service.listNotice(map);
		
		String listUrl = cp+"/notice/list";
		
		model.addAttribute("list", list);
		model.addAttribute("listUrl", listUrl);
		
		return ".mainLayout";
	}
}
