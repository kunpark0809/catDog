package com.catDog.company;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("company.privacyInfoController")
public class PrivacyInfoController {
	
	@RequestMapping(value="/company/privacyInfo", method=RequestMethod.GET)
	public String method() {
		return ".company.privacyInfo";
	}

}
