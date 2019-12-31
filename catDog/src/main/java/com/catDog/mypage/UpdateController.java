package com.catDog.mypage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.catDog.customer.Customer;

@Controller("mypage.updateController")
public class UpdateController {
	@Autowired
	private UpdateService service;
	
	@Autowired
	private BCryptPasswordEncoder bcryptEncoder;
	
	@RequestMapping(value="/mypage/update", method=RequestMethod.GET)
	public String updateSubmit(Customer dto, final RedirectAttributes reAttr, Model model) {
		try {
			String encPwd = bcryptEncoder.encode(dto.getUserPwd());
			dto.setUserPwd(encPwd);
			
			service.updateMemberDetail(dto);
		} catch (Exception e) {
		}
		
		StringBuilder sb = new StringBuilder();
		sb.append(dto.getNickName()+ "님의 회원정보가 정상적으로 변경되었습니다.<br>");
		sb.append("메인화면으로 이동 하시기 바랍니다.<br>");
		
		reAttr.addFlashAttribute("title", "회원 정보 수정");
		reAttr.addFlashAttribute("message", sb.toString());
		
		return "redirect:/customer/register";
	}
}
