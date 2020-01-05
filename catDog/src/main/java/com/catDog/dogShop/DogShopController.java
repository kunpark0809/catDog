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
import org.springframework.web.bind.annotation.ResponseBody;

import com.catDog.common.MyUtil;
import com.catDog.customer.SessionInfo;

@Controller("dogShop.dogShopController")
public class DogShopController {
	@Autowired
	private DogShopService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="/dogshop/list")
	public String list(
			@RequestParam(defaultValue="0") int smallSortNum,
			@RequestParam(defaultValue="1", name="page") int current_page,
			HttpServletRequest req,
			Model model
			) throws Exception{
		String cp = req.getContextPath();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("smallSortNum", smallSortNum);
		List<DogShop> smallSortList = service.smallSortList();
		
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
		model.addAttribute("smallSortList",smallSortList);
		model.addAttribute("dataCount",dataCount);
		model.addAttribute("total_page",total_page);
		model.addAttribute("articleUrl",articleUrl);
		model.addAttribute("paging",paging);
		model.addAttribute("smallSortNum",smallSortNum);
		model.addAttribute("page",current_page);
		return ".dogshop.list";
	}
	
	@RequestMapping(value="/dogshop/created", method=RequestMethod.GET)
	public String createdForm(
			@RequestParam(defaultValue="0") int smallSortNum,
			@RequestParam(defaultValue="1") String page,
			Model model
			) throws Exception{
		List<DogShop> bigSortList = service.bigSortList();
		List<DogShop> smallSortList = service.smallSortList();
		
		model.addAttribute("bigSortList",bigSortList);
		model.addAttribute("smallSortList",smallSortList);
		model.addAttribute("smallSortNum",smallSortNum);
		model.addAttribute("page",page);
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
		List<DogShop> smallSortList = service.smallSortList();
		
		DogShop dto = service.readProduct(productNum);
		String query = "smallSortNum="+smallSortNum+"&page="+page;
		if(dto==null) {
			return "redirect:/dogshop/list?"+query;
		}

		List<DogShop> picList = service.readProductPic(productNum);
		model.addAttribute("smallSortNum",smallSortNum);
		model.addAttribute("page",page);
		model.addAttribute("query",query);
		model.addAttribute("picList", picList);
		model.addAttribute("dto", dto);
		model.addAttribute("smallSortList",smallSortList);
		return ".dogshop.article";
	}
	
	@RequestMapping(value="/dogshop/update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam(defaultValue="0") String smallSortNum,
			@RequestParam int productNum,
			@RequestParam(defaultValue="1") String page,
			Model model
			) throws Exception{
		
		DogShop dto = service.readProduct(productNum);
		List<DogShop> picList = service.readProductPic(productNum);
		List<DogShop> bigSortList = service.bigSortList();
		List<DogShop> smallSortList = service.smallSortList();
		
		model.addAttribute("bigSortList",bigSortList);
		model.addAttribute("smallSortList",smallSortList);
		model.addAttribute("smallSortNum",smallSortNum);
		model.addAttribute("picList", picList);
		model.addAttribute("dto", dto);
		model.addAttribute("mode","update");
		model.addAttribute("page",page);
		return ".dogshop.created";
	}
	
	@RequestMapping(value="/dogshop/update", method=RequestMethod.POST)
	public String updateSubmit(
			@RequestParam(defaultValue="0") String smallSortNum,
			DogShop dto,
			HttpSession session
			) throws Exception{
		String root = session.getServletContext().getRealPath("/");
		String pathname = root+"uploads"+File.separator+"dogshop";
		
		service.updateproduct(dto, pathname);

		return "redirect:/dogshop/list?smallSortNum="+smallSortNum;
	}
	
	@RequestMapping(value="/dogshop/delete", method=RequestMethod.GET)
	public String delete(
			@RequestParam(defaultValue="0") String smallSortNum,
			@RequestParam int productNum,
			@RequestParam(defaultValue="1") String page,
			HttpSession session,
			Model model
			) throws Exception{
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root+"uploads"+File.separator+"dogshop";
		
		service.deleteProduct(productNum, pathname, info.getUserId());
		
		return "redirect:/dogshop/list?"+"smallSortNum="+smallSortNum+"&page="+page;
	}
	
	@RequestMapping(value="/dogshop/deleteFile", method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> deleteFile(
			@RequestParam String picNum,
			HttpSession session
			) throws Exception{
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root+"uploads"+File.separator+"dogshop";
		String state = "false";
		
		try {
			service.deleteImgFile(picNum, pathname, info.getUserId());
			state = "true";
		} catch (Exception e) {
		}
		
		Map<String,Object> model = new HashMap<>();
		model.put("state", state);
		
		return model;
	}
	
	@RequestMapping(value="/dogshop/pay")
	public String pay(
			@RequestParam String productNum
			) throws Exception{
		
		return ".dogshop.pay";
	}
}
