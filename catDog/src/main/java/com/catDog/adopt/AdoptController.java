package com.catDog.adopt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("adopt.adoptController")
public class AdoptController {
	@Autowired
	private AdoptService service;
	
	@RequestMapping(value="/adopt/list")
	public String list() throws Exception{
		return ".adopt.list";
	}
}
