package com.catDog.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller("admin.adminController")
public class AdminController {
	
	@Autowired
	private AdminService service;
}
