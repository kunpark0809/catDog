package com.catDog.dogShop;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("dogShop.dogShopController")
public class DogShopController {
	@Autowired
	private DogShopService service;
	
	@RequestMapping(value="/dogshop/list")
	public String list() throws Exception{
		return ".dogshop.list";
	}
}
