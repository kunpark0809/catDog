package com.catDog.dogShop;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.catDog.common.MyUtil;

@Controller("dogShop.dogShopController")
public class DogShopController {
	@Autowired
	private DogShopService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="/dogshop/list")
	public String list(
			@RequestParam(defaultValue="0") int smallSortNum,
			@RequestParam(defaultValue="1") int current_page,
			HttpServletRequest req,
			Model model
			) throws Exception{
		String cp = req.getContextPath();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("smallSortNum", smallSortNum);
		List<DogShop> sortList = service.smallSortList();
		
		int dataCount = service.dataCount(map);
		
		
		int rows = 15;
		int offset = (current_page-1)*rows;
		if(offset  < 0) offset = 0;
		
		int total_page = myUtil.pageCount(rows, dataCount);
		
		map.put("rows", rows);
		map.put("offset", offset);
		
		List<DogShop> list = service.listDogProduct(map);
		
		String listUrl = cp+"/dogshop/list?"+"smallSortNum="+smallSortNum;
		String articleUrl = cp+"/dogshop/article?page="+current_page+"&smallSortNum="+smallSortNum;
		
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		
		model.addAttribute("list",list);
		model.addAttribute("sortList",sortList);
		model.addAttribute("dataCount",dataCount);
		model.addAttribute("total_page",total_page);
		model.addAttribute("articleUrl",articleUrl);
		model.addAttribute("paging",paging);
		model.addAttribute("smallSortNum",smallSortNum);
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
			service.insertProduct(dto, pathname);
		} catch (Exception e) {
		}
		return "redirect:/dogshop/list";
	}
	
	@RequestMapping(value="/dogshop/article")
	public String article(
			@RequestParam(defaultValue="0") int smallSortNum,
			@RequestParam int productNum,
			@RequestParam(defaultValue="1") String page,
			Model model
			) throws Exception{
		List<DogShop> sortList = service.smallSortList();
		
		List<DogShop> list = service.readProduct(productNum);
		String query = "smallSortNum="+smallSortNum+"&page="+page;
		if(list.size() == 0) {
			return "redirect:/dogshop/list?"+query;
		}
		
		model.addAttribute("smallSortNum",smallSortNum);
		model.addAttribute("page",page);
		model.addAttribute("query",query);
		model.addAttribute("list",list);
		model.addAttribute("sortList",sortList);
		return ".dogshop.article";
	}
}
