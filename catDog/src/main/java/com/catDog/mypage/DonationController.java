package com.catDog.mypage;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("mypage.donationController")
public class DonationController {
	
	@RequestMapping(value="/mypage/donation")
	public String donation() throws Exception{
		
		return null;
	}
}
