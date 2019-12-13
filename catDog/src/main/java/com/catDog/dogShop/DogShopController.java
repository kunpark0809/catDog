package com.catDog.dogShop;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller("dogShop.dogShopController")
public class DogShopController {
	@Autowired
	private DogShopService service;
	
	
	
	@RequestMapping(value="/dogshop/list")
	public String list(
			@RequestParam(defaultValue="") String smallSortNum,
			Model model
			) throws Exception{
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("smallSortNum", smallSortNum);
		List<DogShop> list = service.listDogProduct(map);
		
		List<DogShop> sortList = service.smallSortList();
		
		model.addAttribute("list",list);
		model.addAttribute("sortList",sortList);
		return ".dogshop.list";
	}
	
	@RequestMapping(value="/dogshop/created", method=RequestMethod.GET)
	public String createdForm(
			Model model
			) throws Exception{
		
		List<DogShop> sortList = service.smallSortList();
		
		model.addAttribute("sortList",sortList);
		model.addAttribute("mode","created");
		return ".dogshop.created";
	}
	
	@RequestMapping(value="/dogshop/created", method=RequestMethod.POST)
	public String createdSubmit(
			DogShop dto,
			HttpSession session
			) throws Exception{
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root+"uploads"+File.separator+"dogshop";
		try {
			service.insertProduct(dto);
			service.insertImgFile(dto, pathname);
		} catch (Exception e) {
		}
		
		
		
		
		return "redirect:/dogshop/list";
	}
}
