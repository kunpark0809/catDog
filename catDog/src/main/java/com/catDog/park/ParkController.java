package com.catDog.park;


import java.io.File;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.catDog.customer.SessionInfo;


@Controller("park.ParkController")
public class ParkController {
	
@Autowired
private ParkService service;

	@RequestMapping(value="/park/list")
	public String list() throws Exception {

	
		return ".park.list";
	}

	@RequestMapping(value="/park/created", method=RequestMethod.GET)
	public String createdForm(Model model) throws Exception {
		
		model.addAttribute("mode", "created");
		return ".park.created";
	}
	
	@RequestMapping(value="/park/created", method=RequestMethod.POST)
	public String createdSubmit(
			Park dto,
			HttpSession session) throws Exception {
		String root=session.getServletContext().getRealPath("/");
		String path=root+"uploads"+File.separator+"park";
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		dto.setUserId(info.getUserId());
		
		try {
			service.insertPark(dto, path);
		} catch (Exception e) {
		}
		
		return "redirect:/park/list";
	}
	

}
