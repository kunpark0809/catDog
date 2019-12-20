package com.catDog.admin;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.catDog.common.MyUtil;
import com.catDog.customer.Customer;
import com.catDog.customer.CustomerService;
import com.catDog.customer.CustomerServiceImpl;

import oracle.net.aso.h;

@Controller("admin.adminController")
public class AdminController {

	@Autowired
	private AdminService service;

	@Autowired
	private MyUtil myUtil;
	
	@Autowired
	private CustomerService service2;

	@RequestMapping(value = "/admin/member")
	public String memberManage(@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition, @RequestParam(defaultValue = "") String keyword,
			 HttpServletRequest req, Model model) throws Exception {

		if (req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "UTF-8");
		}

		int rows = 50;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);

		int dataCount = service.memberCount(map);
		int total_page = myUtil.pageCount(rows, dataCount);

		if (total_page < current_page)
			current_page = total_page;

		int offset = (current_page - 1) * rows;
		if (offset < 0)
			offset = 0;
		map.put("offset", offset);
		map.put("rows", rows);

		List<Member> list = service.memberList(map);

		String cp = req.getContextPath();
		String query = "rows=" + rows;
		String listUrl = cp + "/admin/member";

		if (keyword.length() != 0) {
			query += "&condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
		}
		listUrl += "?" + query;

		String paging = myUtil.paging(current_page, total_page, listUrl);

		model.addAttribute("list", list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);

		model.addAttribute("rows", rows);
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);

		return ".admin.member";
	}

	@RequestMapping(value = "/admin/memberRevive")
	public String memberRevive(@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition, @RequestParam(defaultValue = "") String keyword,
			@RequestParam String userId, Model model) throws Exception {

		try {
			
			Map<String, Object> map = new HashMap<>();
			map.put("userId", userId);
			map.put("enabled", 1);

			service2.updateEnabled(map);
			service2.failureReset(userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("page", current_page);
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		
		return "redirect:/admin/member";
	}
	
	@RequestMapping(value = "/admin/memberBan")
	public String memberBan(@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition, @RequestParam(defaultValue = "") String keyword,
			@RequestParam String userId, Model model) throws Exception {

		try {
			
			Map<String, Object> map = new HashMap<>();
			map.put("userId", userId);
			map.put("enabled", 0);

			service2.updateEnabled(map);
			
			Customer customer = new Customer();
			customer.setUserId(userId);
			customer.setStateCode(2);
			customer.setMemo("사이트 규정을 위배하여 추방");
			service2.insertMemberState(customer);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("page", current_page);
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return "redirect:/admin/member";
	}

	@RequestMapping(value = "/admin/bbs")
	public String bbsManage(@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition, @RequestParam(defaultValue = "") String keyword,
			@RequestParam(defaultValue = "0") int group, 
			HttpServletRequest req, Model model) throws Exception {

		if (req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "UTF-8");
		}

		int rows = 50;
		
		Map<String, Object> map = new HashMap<>();

		if (keyword != null && keyword != "") {
			map.put("condition", condition);
			map.put("keyword", keyword);
		}

		int dataCount = service.reportCount(map);
		int total_page = myUtil.pageCount(rows, dataCount);
		if (current_page > total_page)
			current_page = total_page;

		int offset = (current_page - 1) * rows;
		if (offset < 0)
			offset = 0;

		map = new HashMap<>();
		map.put("offset", offset);
		map.put("rows", rows);

		List<Report> list = service.reportList(map);

		String cp = req.getContextPath();
		String query = "rows=" + rows;
		String listUrl = cp + "/admin/bbs";

		if (keyword.length() != 0) {
			query += "&condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
		}
		listUrl += "?" + query;

		String paging = myUtil.paging(current_page, total_page, listUrl);

		model.addAttribute("group", group);
		model.addAttribute("list", list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);

		model.addAttribute("rows", rows);
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);

		return ".admin.bbs";
	}

	@RequestMapping(value = "/admin/cs/list")
	public String csList() throws Exception {

		return ".admin.cs.list";
	}

	@RequestMapping(value = "/admin/play")
	public String playManage() throws Exception {

		return ".admin.play";
	}

	@RequestMapping(value = "/admin/money")
	public String moneyManage() throws Exception {

		return ".admin.money";
	}

}
