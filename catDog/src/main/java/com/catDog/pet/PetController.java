package com.catDog.pet;

import java.io.File;
import java.net.URLDecoder;
import java.net.URLEncoder;
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
import com.catDog.customer.SessionInfo;

@Controller("pet.PetController")
public class PetController {
	
@Autowired
private PetService service;

@Autowired
private MyUtil myUtil;

@RequestMapping(value="/pet/list")
public String list(
		@RequestParam(value="page", defaultValue="1") int current_page,
		@RequestParam(defaultValue="all") String condition,
		@RequestParam(defaultValue="") String keyword,
		HttpServletRequest req,
		Model model) throws Exception {

	String cp = req.getContextPath();

	Map<String, Object> map = new HashMap<String, Object>();
	
	map.put("keyword", keyword);
	map.put("condition", condition);
			
	int dataCount = service.dataCount(map);
	
	int rows = 6;
	int offset = (current_page-1)*rows;
	if(offset  < 0) offset = 0;
	
	int total_page = myUtil.pageCount(rows, dataCount);
	
	map.put("rows", rows);
	map.put("offset", offset);
	
	List<Pet> list = service.listPet(map);
	
	String listUrl = cp+"/pet/list";
	String articleUrl = cp+"/pet/article?page=" + current_page;
	
	String paging = myUtil.paging(current_page, total_page, listUrl);
	
	model.addAttribute("list", list);
	model.addAttribute("dataCount", dataCount);
	model.addAttribute("total_page", total_page);
	model.addAttribute("articleUrl", articleUrl);
	model.addAttribute("page", current_page);
	model.addAttribute("paging", paging);
	
	model.addAttribute("condition", condition);
	model.addAttribute("keyword", keyword);		
	
	return ".pet.list";
}
	
	@RequestMapping(value="/pet/created", method=RequestMethod.GET)
	public String createdForm(
			HttpSession session,
			Model model) throws Exception {
		
		model.addAttribute("mode", "created");
		return ".pet.created";
	}
	
	@RequestMapping(value="/pet/created", method=RequestMethod.POST)
	public String createdSubmit(
			Pet dto,
			HttpSession session) throws Exception {
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"pet";
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		try {
			dto.setNum(info.getMemberIdx());
			service.insertPet(dto, pathname);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/pet/list";
	}
	
	@RequestMapping(value="/pet/article", method=RequestMethod.GET)
	public String article(
			@RequestParam int myPetNum,
			@RequestParam(defaultValue="1") String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			Model model
			) throws Exception{
		Pet dto = service.readPet(myPetNum);
		
		String query="page="+page;
		if(dto == null) {
			return "redirect:/pet/list?"+query;
		}
		
		service.updateHitCount(myPetNum);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("myPetNum", myPetNum);
		
		Pet preReadPet = service.preReadPet(map);
		Pet nextReadPet = service.nextReadPet(map);
		
		model.addAttribute("preReadPet", preReadPet);
		model.addAttribute("nextReadPet", nextReadPet);
		
		model.addAttribute("page",page);
		model.addAttribute("query",query);
		model.addAttribute("dto",dto);
		
		return ".pet.article";
	}
	
	@RequestMapping(value="/pet/delete", method=RequestMethod.GET)
	public String delete(
			@RequestParam int myPetNum,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpSession session
			) throws Exception {
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		String query="page="+page;
		
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"pet";
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		try {
			service.deletePet(myPetNum, pathname, info.getUserId());
		} catch (Exception e) {
		}
		
		return "redirect:/pet/list?"+query;
	}
	
	@RequestMapping(value="/pet/update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam int myPetNum,
			@RequestParam String page,
			HttpSession session,
			Model model
			) throws Exception {
		
		Pet dto = service.readPet(myPetNum);
		
		if(dto == null)
			return "redirect:/pet/list?page="+page;
		
		if(dto.getUserId().indexOf("admin") < 0) {
			return "redirect:/pet/list?page="+page;
		}
		
		model.addAttribute("page", page);
		model.addAttribute("mode", "update");
		model.addAttribute("dto", dto);
		
		return ".pet.created";
	}
	
	@RequestMapping(value="/pet/update", method=RequestMethod.POST)
	public String updateSubmit(
			Pet dto,
			@RequestParam String page,
			HttpSession session
			) throws Exception {
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"pet";
		
		try {
			service.updatePet(dto, pathname);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/pet/article?myPetNum="+dto.getMyPetNum()+"&page="+page;
	}
	
}