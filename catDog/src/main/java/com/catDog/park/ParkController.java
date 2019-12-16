package com.catDog.park;

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


@Controller("park.Park")
public class ParkController {
	
@Autowired
private ParkService service;

@Autowired
private MyUtil myUtil;

	@RequestMapping(value="/park/list")
	public String list(
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			Model model
			) throws Exception{
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		List<Park> list = service.listPark(map);
		
		
		model.addAttribute("list",list);
	
		return ".park.list";
	}
	
	@RequestMapping(value="/park/created", method=RequestMethod.GET)
	public String createdForm(
			HttpSession session,
			Model model) throws Exception {
		
		model.addAttribute("mode", "created");
		return ".park.created";
	}
	
	@RequestMapping(value="/park/created", method=RequestMethod.POST)
	public String createdSubmit(
			Park dto,
			HttpSession session) throws Exception {
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"park";
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		try {
			dto.setNum(info.getMemberIdx());
			
			service.insertPark(dto, pathname);
			service.insertImgFile(dto, pathname);
		} catch (Exception e) {
		}
		
		return "redirect:/park/list";
	}
	

}
