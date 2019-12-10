package com.catDog.customer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("customer.customerController")
public class CustomerController {
	@Autowired
	private CustomerService service;

	@RequestMapping(value="/customer/complete")
	public String complete(
			@ModelAttribute("message") String message) throws Exception{
		// 컴플릿 페이지(complete.jsp)의 출력되는 message와 title는 RedirectAttributes 값이다. 
		// F5를 눌러 새로 고침을 하면 null이 된다.
		
		if(message==null || message.length()==0) // F5를 누른 경우
			return "redirect:/";
		
		return ".customer.complete";
	}
	
	@RequestMapping(value="/customer/login", method=RequestMethod.GET)
	public String loginForm(
			String login_error,
			Model model 
			) {
		// 로그인 폼
		boolean bLoginError = login_error != null;
		String msg="";
		if(bLoginError) {
			msg = "아이디 또는 패스워드가 일치 하지 않습니다.";
			model.addAttribute("message", msg);
		}
		
		return ".customer.login";
	}
	
	@RequestMapping(value="/customer/noAuthorized")
	public String noAuth() {
		// 접근 권한이 없는 경우
		return ".customer.noAuthorized";
	}
	
	@RequestMapping(value="/customer/expired")
	public String expired() {
		// 세션이 만료된 경우
		return ".customer.expired";
	}
	
}
