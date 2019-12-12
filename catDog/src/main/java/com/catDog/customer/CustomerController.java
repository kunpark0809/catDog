package com.catDog.customer;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.catDog.common.FileManager;


@Controller("customer.customerController")
public class CustomerController {
	@Autowired
	private CustomerService service;

	@Autowired
	private BCryptPasswordEncoder bcryptEncoder;

	@RequestMapping(value = "/customer/userIdCheck", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> idCheck(@RequestParam String userId) throws Exception {

		String p = "true";
		Customer dto = service.loginCustomer(userId);
		if (dto != null)
			p = "false";

		Map<String, Object> model = new HashMap<>();
		model.put("passed", p);
		return model;
	}
	
	@RequestMapping(value = "/customer/nickNameCheck", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> nickNameCheck(@RequestParam String nickName) throws Exception {

		String p = "true";
		Customer dto = service.nickNameCheck(nickName);
		if (dto != null)
			p = "false";

		Map<String, Object> model = new HashMap<>();
		model.put("passed", p);
		return model;
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
	
	@RequestMapping(value="/customer/register", method=RequestMethod.GET)
	public String registerForm(Model model) {
		
		model.addAttribute("mode", "register");
		
		return ".customer.register";
	}
	
	/*
	 * RedirectAttributes RedirectAttributes에 데이터등을 저장하면 Redirect 된 후 즉시 사라지게 되고
	 * 사용자가 F5등을 눌러 리로드 하더라도 서버로 다시 submit 되어 저장되지 않게할 수 있다.
	 */
	@RequestMapping(value = "/customer/register", method = RequestMethod.POST)
	public String registerSubmit(Customer dto, final RedirectAttributes reAttr, Model model, HttpSession session) throws Exception {

		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"photo";
		
		try {
			// 패스워드 암호화
			String encPwd = bcryptEncoder.encode(dto.getUserPwd());
			dto.setUserPwd(encPwd);
			service.insertMember(dto, pathname);
		} catch (Exception e) {
			model.addAttribute("mode", "member");
			model.addAttribute("message", "모종의 사유로 회원가입이 실패했습니다.");

			return ".customer.register";
		}

		StringBuilder sb = new StringBuilder();
		sb.append(dto.getUserId() +"("+dto.getName()+")님의 회원 가입이 정상적으로 처리되었습니다.<br>");
		sb.append("이제부터 멍냥멍냥을 자유롭게 이용하실 수 있습니다.<br>");

		// 리다이렉트된 페이지에 값 넘기기
		reAttr.addFlashAttribute("message", sb.toString());
		reAttr.addFlashAttribute("title", "회원 가입");

		return "redirect:/customer/complete";
	}
	
	
	@RequestMapping(value = "/customer/complete")
	public String complete(@ModelAttribute("message") String message) throws Exception {

		// 컴플릿 페이지(complete.jsp)의 출력되는 message와 title는 RedirectAttributes 값이다.
		// F5를 눌러 새로 고침을 하면 null이 된다.

		if (message == null || message.length() == 0) // F5를 누른 경우
			return "redirect:/";

		return ".member.complete";
	}
	
}
