package com.catDog.catShop;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("catShop.catShopController")
public class CatShopController {
	@RequestMapping(value="/catshop/list")
	public String list(
			Model model
			) throws Exception{
		
		return ".catshop.list";
	}
}
