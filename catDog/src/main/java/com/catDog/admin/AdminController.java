package com.catDog.admin;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.catDog.common.MyUtil;
import com.catDog.customer.Customer;
import com.catDog.customer.CustomerService;

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
			@RequestParam(defaultValue = "0") int group, HttpServletRequest req, Model model) throws Exception {

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
	public String moneyManage(@RequestParam(defaultValue = "0") int group, Model model) throws Exception {
		model.addAttribute("group", group);
		
		return ".admin.money";
	}

	// 1년 매출을 월별로 보여줌
	@RequestMapping(value = "/admin/money/yearSalesChart")
	@ResponseBody
	public Map<String, Object> yearSalesChart(@RequestParam(defaultValue="2019") int year) throws Exception {
		Map<String, Object> model = new HashMap<String, Object>();

		List<Map<String, Object>> list = new ArrayList<>();
		Map<String, Object> map;

		map = new HashMap<>();
		map.put("name", year + "년");

		int[] sales = new int[12];
		int yearMonth;

		for (int i = 0; i < 12; i++) {

			yearMonth = year * 100 + i+1;

			sales[i] = service.monthSales(Integer.toString(yearMonth));
		}

		map.put("data", sales);

		list.add(map);

		model.put("title", year+"년 월별 매출");
		model.put("series", list);

		return model;

	}

	// produces 속성 : response의 Content-Type
	@RequestMapping(value = "/hchart/pie3d", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String pie3d() throws Exception {
		JSONArray arr = new JSONArray();
		JSONObject ob = new JSONObject();
		ob.put("name", "접속자");

		JSONArray ja = new JSONArray();
		ja.put(new JSONArray("['07-10시',10]"));
		ja.put(new JSONArray("['10-13시',30]"));
		ja.put(new JSONArray("['13-16시',33]"));
		ja.put(new JSONArray("['16-19시',20]"));
		ja.put(new JSONArray("['기타',15]"));

		ob.put("data", ja);

		arr.put(ob);

		return arr.toString();
	}

}
