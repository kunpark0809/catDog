package com.catDog.dogShop;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("dogShop.dogShopController")
public class DogShopController {
	@Autowired
	private DogShopService service;
	
	@RequestMapping(value="/dogshop/list")
	public String list(
			
			Model model
			) throws Exception{
		
		List<DogShop> sortList = service.smallSortList();
		
		model.addAttribute("sortList",sortList);
		return ".dogshop.list";
	}
	
	@RequestMapping(value="/dogshop/created", method=RequestMethod.GET)
	public String createdForm(
			Model model
			) throws Exception{
		
		List<DogShop> sortList = service.smallSortList();
		
		model.addAttribute("sortList",sortList);
		return ".dogshop.created";
	}
}
