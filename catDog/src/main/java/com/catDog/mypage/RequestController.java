package com.catDog.mypage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.catDog.common.MyUtil;

@Controller("mypage.requestController")
public class RequestController {
	@Autowired
	private RequestService service;
	
	@Autowired
	private MyUtil util;
	
	@RequestMapping(value="/mypage/requestCheck")
	public String requestList() throws Exception {
		
		
		return ".mypage.requestCheck";
	}
}
