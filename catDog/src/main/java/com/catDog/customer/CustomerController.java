package com.catDog.customer;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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

import com.catDog.admin.AdminService;
import com.catDog.admin.Report;

@Controller("customer.customerController")
public class CustomerController {
	@Autowired
	private CustomerService service;

	@Autowired
	private AdminService service2;

	@Autowired
	private BCryptPasswordEncoder bcryptEncoder;

	@RequestMapping(value = "/customer/userIdCheck", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> idCheck(@RequestParam String userId) throws Exception {

		String p = "true";
		Customer dto = service.loginCustomer(userId);
		if (dto != null || userId.startsWith("admin"))
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

	@RequestMapping(value = "/customer/login")
	public String loginForm(String login_error, Model model) {
		// 로그인 폼

		return ".customer.login";
	}

	@RequestMapping(value = "/customer/noAuthorized")
	public String noAuth() {
		// 접근 권한이 없는 경우
		return ".customer.noAuthorized";
	}

	@RequestMapping(value = "/customer/expired")
	public String expired() {
		// 세션이 만료된 경우
		return ".customer.expired";
	}

	@RequestMapping(value = "/customer/register", method = RequestMethod.GET)
	public String registerForm(Model model) {

		model.addAttribute("menu", "customer");
		model.addAttribute("mode", "register");

		return ".customer.register";
	}

	/*
	 * RedirectAttributes RedirectAttributes에 데이터등을 저장하면 Redirect 된 후 즉시 사라지게 되고
	 * 사용자가 F5등을 눌러 리로드 하더라도 서버로 다시 submit 되어 저장되지 않게할 수 있다.
	 */
	@RequestMapping(value = "/customer/register", method = RequestMethod.POST)
	public String registerSubmit(Customer dto, final RedirectAttributes reAttr, Model model, HttpSession session)
			throws Exception {

		String root = session.getServletContext().getRealPath("	");
		String pathname = root + "uploads" + File.separator + "photo";

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
		sb.append(dto.getUserId() + "(" + dto.getName() + ")님의 회원 가입이 정상적으로 처리되었습니다.<br>");
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

		return ".customer.complete";
	}

	@RequestMapping(value = "/customer/updatePwd", method = RequestMethod.GET)
	public String updatePwdForm() throws Exception {
		return ".customer.updatePwd";
	}

	@RequestMapping(value = "/customer/updatePwd", method = RequestMethod.POST)
	public String updatePwdSubmit(@RequestParam String userPwd, HttpSession session) throws Exception {

		SessionInfo info = (SessionInfo) session.getAttribute("member");
		Customer dto = service.readCustomer(info.getUserId());
		String encPassword = bcryptEncoder.encode(userPwd);
		dto.setUserPwd(encPassword);

		try {
			service.updatePwd(dto);
		} catch (Exception e) {
		}

		return "redirect:/";
	}

	@RequestMapping(value = "/customer/idFind", method = RequestMethod.GET)
	public String idFindForm(HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info != null) {
			return "redirect:/";
		}

		return ".customer.idFind";
	}

	@RequestMapping(value = "/customer/pwdFind", method = RequestMethod.GET)
	public String pwdFindForm(HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info != null) {
			return "redirect:/";
		}

		return ".customer.pwdFind";
	}

	@RequestMapping(value = "/customer/pwdFind", method = RequestMethod.POST)
	public String pwdFindSubmit(@RequestParam String userId, final RedirectAttributes reAttr, Model model)
			throws Exception {

		Customer dto = service.readCustomer(userId);
		if (dto == null || dto.getEmail() == null || dto.getEnabled() == 0) {
			model.addAttribute("message", "등록된 아이디가 아닙니다.");
			return ".customer.pwdFind";
		}

		try {
			service.generatePwd(dto);
		} catch (Exception e) {
			model.addAttribute("message", "이메일 전송이 실패했습니다.");
			return ".customer.pwdFind";
		}

		StringBuilder sb = new StringBuilder();
		sb.append("회원님의 이메일로 임시패스워드를 전송했습니다.<br>");
		sb.append("로그인 후 패스워드를 변경하시기 바랍니다.<br>");

		reAttr.addFlashAttribute("title", "패스워드 찾기");
		reAttr.addFlashAttribute("message", sb.toString());

		return "redirect:/customer/complete";
	}

	@RequestMapping("/customer/recentReport")
	@ResponseBody
	public Map<String, Object> recentReport(HttpSession session, HttpServletRequest req) throws Exception {
		Map<String, Object> model = new HashMap<>();

		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String userId = info.getUserId();
		String url = req.getContextPath();

		Report report = service2.recentReport(userId);

		if (report.getBoardSort() == 1) {
			url += "/tip/article?tipNum=" + report.getReportedPostNum();
		} else if (report.getBoardSort() == 2) {
			url += "/pet/article?myPetNum=" + report.getReportedPostNum();
		} else if (report.getBoardSort() == 3) {
			url += "/freeBoard/article?bbsNum=" + report.getReportedPostNum();
		}

		model.put("url", url);
		model.put("reportDate", report.getReportDate());
		model.put("reasonName", report.getReasonName());
		model.put("reportCount", info.getReportCount());

		return model;
	}

	@RequestMapping("/customer/deactivateWarn")
	@ResponseBody
	public Map<String, Object> deactivateWarn(HttpSession session, HttpServletRequest req) throws Exception {
		Map<String, Object> model = new HashMap<>();

		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String userId = info.getUserId();

		try {
			service2.deactivateWarn(userId);
			session.setAttribute("member.warn", 0);
			model.put("status", 1);
		} catch (Exception e) {
			e.printStackTrace();
			model.put("status", 0);
		}

		return model;
	}

}
