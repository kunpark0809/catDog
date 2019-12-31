package com.catDog.company;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("company.roadController")
public class RoadController {
	
	@RequestMapping(value="/company/road", method=RequestMethod.GET)
	public String method() {
		return ".company.road";
	}

}
