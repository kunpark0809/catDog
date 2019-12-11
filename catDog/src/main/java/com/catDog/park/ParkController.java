package com.catDog.park;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("park.ParkController")
public class ParkController {
	@RequestMapping(value="/park/list")
	public String list() throws Exception {
		return ".park.list";
	}
	
}
