package com.catDog.catShop;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("catShop.catShopController")
public class CatShopController {
	@Autowired
	private CatShopService service;
	
	@RequestMapping(value="/catshop/list")
	public String list() throws Exception{
		return ".catshop.list";
	}
}
