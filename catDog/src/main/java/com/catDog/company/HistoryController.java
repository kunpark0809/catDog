package com.catDog.company;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("company.historyController")
public class HistoryController {
	
	@RequestMapping(value="/company/history", method=RequestMethod.GET)
	public String method() {
		return ".company.history";
	}

}
