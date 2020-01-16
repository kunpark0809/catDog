package com.catDog.mypage;

import java.io.File;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.catDog.customer.Customer;
import com.catDog.customer.SessionInfo;

@Controller("mypage.updateController")
public class UpdateController {
	@Autowired
	private UpdateService service;
	
	@Autowired
	private BCryptPasswordEncoder bcryptEncoder;
	
	@RequestMapping(value="/mypage/pwd", method=RequestMethod.GET)
	public String pwdForm(String dropout, Model model) {
		
		if(dropout==null) {
			model.addAttribute("mode", "update");
		}
		
		return ".mypage.pwd";
	}
	
	@RequestMapping(value="/mypage/pwd", method=RequestMethod.POST)
	public String pwdSubmit(@RequestParam String userPwd, @RequestParam String mode,
							final RedirectAttributes reAttr, Model model, HttpSession session) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Customer dto=service.readCustomer(info.getUserId());
		if(dto==null) {
			session.invalidate();
			return "redirect:/";
		}
		
		boolean bPwd = bcryptEncoder.matches(userPwd, dto.getUserPwd());
		
		if(! bPwd) {
			if(mode.equals("update")) {
				model.addAttribute("mode", "update");
			}
			model.addAttribute("message", "패스워드가 일치하지 않습니다.");
			return ".mypage.pwd";
		}
		
		model.addAttribute("dto", dto);
		model.addAttribute("menu","mypage");
		model.addAttribute("mode", "update");
		
		return ".customer.register";
	}
	
	@RequestMapping(value="/mypage/update", method=RequestMethod.POST)
	public String updateSubmit(Customer dto, final RedirectAttributes reAttr, Model model, HttpSession session) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		dto.setNum(info.getMemberIdx());
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"photo";
		try {
			String encPwd = bcryptEncoder.encode(dto.getUserPwd());
			dto.setUserPwd(encPwd);
			service.updateMemberDetail(dto, pathname);
			
		} catch (Exception e) {
		}
		
		StringBuilder sb = new StringBuilder();
		sb.append(dto.getNickName()+ "님의 회원정보가 정상적으로 변경되었습니다.<br>");
		sb.append("메인화면으로 이동 하시기 바랍니다.<br>");
		
		reAttr.addFlashAttribute("title", "회원 정보 수정");
		reAttr.addFlashAttribute("message", sb.toString());
		
		return "redirect:/customer/complete";
	}

}
