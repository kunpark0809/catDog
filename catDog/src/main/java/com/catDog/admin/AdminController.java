package com.catDog.admin;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.DecimalFormat;
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

import oracle.net.aso.h;
import oracle.security.o3logon.a;

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

	// 1년 매출을 월별, 품목별로
	@RequestMapping(value = "/admin/money/yearSalesChart")
	@ResponseBody
	public Map<String, Object> yearSalesChart(@RequestParam(defaultValue = "2020") int year) throws Exception {
		Map<String, Object> result = new HashMap<>();

		int totalYearSales = 0;

		Map<String, Object> map = null; // service.monthSales에 넣을때 쓸 map

		Map<String, Object> map2 = null; // JSONObject 형식으로 담을 map

		List<Money> moneyList = null;// monthSales를 return하여 받을 map

		int[] data = null; // 각 월의 정보를 담을 배열.

		List<Map<String, Object>> productList = new ArrayList<>(); // 보낼 list

		for (int i = 1; i <= 16; i++) {
			map = new HashMap<>();
			map2 = new HashMap<>();
			moneyList = new ArrayList<>();

			String name = service.getCategory(i);
			if (i <= 8) {
				name = "고양이)" + name;
			} else if (i >= 9) {
				name = "개)" + name;
			}

			map.put("year", year);
			map.put("smallSortNum", i);

			moneyList = service.monthSales(map);// moneyList에 한 소분류의 연간 총매출정보가 담겨짐. 월별로 산출되고 없으면 0

			data = new int[12];

			if (moneyList != null) {
				for (Money monthlySale : moneyList) {
					int month = Integer.parseInt(monthlySale.getRequestDate().substring(4));// 월을 가져옴(없는지 있는지 판별해야함)
					data[month - 1] = monthlySale.getProductSum();
					totalYearSales += monthlySale.getProductSum();
				}
			}

			// data에 담아진 소품목 연간 총매출을 map에 담기
			map2.put("name", name);
			map2.put("data", data);

			productList.add(map2);

		}

		// productList에 모든 품목의 정보가 담김

		result.put("productList", productList);
		result.put("year", year);

		DecimalFormat df = new DecimalFormat("#,###");

		result.put("totalYearSales", df.format(totalYearSales));
		return result;
	}

	// 품목별 매출
	@RequestMapping(value = "/admin/money/categorySalesChart")
	@ResponseBody
	public Map<String, Object> categorySalesChart(@RequestParam(defaultValue = "2020") int year) throws Exception {

		// categorySales,categorySalesVolume에 넣을 map
		Map<String, Object> map = null;

		// JSONObject 형식으로 담을 map
		Map<String, Object> map2 = null;

		// map2들을 담을 list
		List<Map<String, Object>> series = new ArrayList<>();

		// 리턴할 Map
		Map<String, Object> result = new HashMap<>();

		// 반복시 쓸 Money 객체
		Money dto = null;

		// 품목명 저장할 String
		String smallSortName = null;

		// 매출 저장할 int
		int sales = 0;
		int salesVolume = 0;

		for (int i = 1; i <= 16; i++) {
			smallSortName = null;
			sales = 0;
			salesVolume = 0;
			
			map = new HashMap<>();
			map.put("smallSortNum", i);
			map.put("year", year);

			dto = new Money();

			// 해당 년의 결제액 처리하기
			dto = service.categorySales(map);
			if (dto != null)
				sales = dto.getSales();

			dto = new Money();

			// 해당 년의 판매개수 처리하기
			dto = service.categorySalesVolume(map);
			if (dto != null)
				salesVolume = dto.getSalesVolume();

			
			// 이름 처리하기
			smallSortName = service.getCategory(i);

			if (i <= 8) {
				smallSortName = "고양이)" + smallSortName;
			} else if (i >= 9) {
				smallSortName = "개)" + smallSortName;
			}

			if (smallSortName != null && salesVolume != 0) {
				map2 = new HashMap<>();
				map2.put("name", smallSortName);
				map2.put("y", sales);
				map2.put("z", salesVolume);

				series.add(map2);

			}
		}
	
		result.put("year", year);
		result.put("series", series);

		return result;
	}

	// 3년 매출을 분기별, 품목별로
	@RequestMapping(value = "/admin/money/quarterSalesChart")
	@ResponseBody
	public Map<String, Object> quarteSalesChart(@RequestParam(defaultValue = "2019") int year) throws Exception {
		Map<String, Object> result = new HashMap<>();

		Map<String, Object> map = null; // service.quarterSales에 넣을때 쓸 map

		Map<String, Object> map2 = null; // JSONObject 형식으로 담을 map

		List<Money> moneyList = null;// quarterSales를 return하여 받을 map

		int[] data = null; // 각 월의 정보를 담을 배열.

		List<Map<String, Object>> productList = new ArrayList<>(); // 보낼 list

		for (int i = 1; i <= 16; i++) {
			map = new HashMap<>();
			map2 = new HashMap<>();
			moneyList = new ArrayList<>();

			String name = service.getCategory(i);
			if (i <= 8) {
				name = "고양이)" + name;
			} else if (i >= 9) {
				name = "개)" + name;
			}

			// 여기부터 다시 만들기
			map.put("year", year);
			map.put("smallSortNum", i);

			moneyList = service.monthSales(map);// moneyList에 한 소분류의 연간 총매출정보가 담겨짐. 월별로 산출되고 없으면 0

			data = new int[12];

			if (moneyList != null) {
				for (Money monthlySale : moneyList) {
					int month = Integer.parseInt(monthlySale.getRequestDate().substring(4));// 월을 가져옴(없는지 있는지 판별해야함)
					data[month - 1] = monthlySale.getProductSum();
				}
			}

			// data에 담아진 소품목 연간 총매출을 map에 담기
			map2.put("name", name);
			map2.put("data", data);

			productList.add(map2);

		}

		// productList에 모든 품목의 정보가 담김

		result.put("productList", productList);
		result.put("year", year);

		// DecimalFormat df = new DecimalFormat("#,###");

		// result.put("totalYearSales", df.format(totalYearSales));
		return result;
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
