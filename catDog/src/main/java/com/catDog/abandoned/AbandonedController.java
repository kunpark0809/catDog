package com.catDog.abandoned;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("abandoned.abandonedController")
public class AbandonedController {
	@Autowired
	private AbandonedService service;
	
	@RequestMapping(value="/abandoned/list")
	public String list() throws Exception {
		return ".abandoned.list";
	}
	
}
