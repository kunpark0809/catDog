package com.catDog.company;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("company.accessTermsController")
public class AccessTermsController {
	
	@RequestMapping(value="/company/accessTerms", method=RequestMethod.GET)
	public String method() {
		return ".company.accessTerms";
	}

}
