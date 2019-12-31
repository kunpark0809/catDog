package com.catDog.company;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("company.helloController")
public class HelloController {
	
	@RequestMapping(value="/company/hello", method=RequestMethod.GET)
	public String method() {
		return ".company.hello";
	}

}
