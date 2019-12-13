package com.catDog.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("admin.adminController")
public class AdminController {
	
	@Autowired
	private AdminService service;

	@RequestMapping(value="/admin/member", method=RequestMethod.GET)
	public String memberManage() throws Exception{

		
		
		
		return ".admin.member";
	}

}


