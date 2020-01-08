package com.catDog.admin;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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

	@RequestMapping(value = "/admin/shop")
	public String shopManage(@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition, @RequestParam(defaultValue = "") String keyword,
			HttpServletRequest req, Model model) throws Exception {

		if (req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "UTF-8");
		}

		int rows = 50;

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);

		int dataCount = service.requestCount(map);
		int total_page = myUtil.pageCount(rows, dataCount);

		if (total_page < current_page)
			current_page = total_page;

		int offset = (current_page - 1) * rows;
		if (offset < 0)
			offset = 0;
		map.put("offset", offset);
		map.put("rows", rows);

		List<Shop> list = service.requestList(map);

		String[] statusesToString = { "입금대기", "결제완료", "배송준비중", "배송중", "배송완료", "취소완료", "환불진행중", "환불완료", "교환진행중", "교환완료",
				"리뷰완료" };

		for (Shop dto : list) {
			dto.setTotalWithComma(NumberFormat.getInstance().format(dto.getTotal()));

			// 같은 주문번호를 가진 requestDetail의 진행상태가 둘 다 같다면 그걸로 표기, 그렇지 않다면 둘 다 표기
			List<Shop> list2 = service.requestDetailList(dto.getRequestNum());

			int[] statuses = new int[list2.size()];

			StringBuilder sb = new StringBuilder();
			for (int i = 0; i < list2.size(); i++) {
				statuses[i] = list2.get(i).getStatus();

				switch (statuses[i]) {
				case 0:
					sb.append(statusesToString[0]);
					break;
				case 1:
					sb.append(statusesToString[1]);
					break;
				case 2:
					sb.append(statusesToString[2]);
					break;
				case 3:
					sb.append(statusesToString[3]);
					break;
				case 4:
					sb.append(statusesToString[4]);
					break;
				case 5:
					sb.append(statusesToString[5]);
					break;
				case 6:
					sb.append(statusesToString[6]);
					break;
				case 7:
					sb.append(statusesToString[7]);
					break;
				case 8:
					sb.append(statusesToString[8]);
					break;
				case 9:
					sb.append(statusesToString[9]);
					break;
				case 10:
					sb.append(statusesToString[10]);
				}
			}
			// statuses[]에 그 requestNum에 맞는 모든 status가 모임
			// sb에 그 번호의 statusToString이 모두 붙음. 쉼표로 구분됨
			StringBuilder sb2 = new StringBuilder();
			for (int i = 0; i <= 10; i++) {
				if (sb.toString().contains(statusesToString[i]))
					sb2.append(statusesToString[i] + "<br>");
			}
			// 입금완료<br>입금준비중 이런식으로 만들기

			if (sb2 != null)
				sb2.replace(sb2.length()-4, sb2.length(), "");// 마지막 <br> 자르기
			dto.setStatusToString(sb2.toString());
		}

		String cp = req.getContextPath();
		String query = "rows=" + rows;
		String listUrl = cp + "/admin/shop";

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

		return ".admin.shop";
	}

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

		Calendar cal = Calendar.getInstance();

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd"); // 오늘 날짜를 담을 포멧
		String today = sdf.format(cal.getTime()); // 오늘 날짜를 yyyyMMdd 꼴로 가져옴

		cal.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
		String sunday = sdf.format(cal.getTime()); // 이번 주의 월요일 날짜를 yyyyMMdd 꼴로 가져옴

		cal.set(Calendar.DAY_OF_WEEK, Calendar.SATURDAY);
		String saturday = sdf.format(cal.getTime()); // 이번 주의 토요일 날짜를 yyyyMMdd 꼴로 가져옴

		Map<String, Object> map = new HashMap<>();

		map.put("sunday", sunday);
		map.put("saturday", saturday);

		String year = today.substring(0, 4);
		String yearMonth = today.substring(0, 6);

		int daySales = service.daySales(today);
		int daySalesVolume = service.daySalesVolume(today);
		int weekSales = service.weekSales(map);
		int weekSalesVolume = service.weekSalesVolume(map);
		int monthSales = service.monthSales(yearMonth);
		int monthSalesVolume = service.monthSalesVolume(yearMonth);
		int yearSales = service.yearSales(year);
		int yearSalesVolume = service.yearSalesVolume(year);
		int totalSales = service.totalSales();
		int totalSalesVolume = service.totalSalesVolume();

		model.addAttribute("daySales", String.format("%,d", daySales));
		model.addAttribute("daySalesVolume", daySalesVolume);
		model.addAttribute("weekSales", String.format("%,d", weekSales));
		model.addAttribute("weekSalesVolume", weekSalesVolume);
		model.addAttribute("monthSales", String.format("%,d", monthSales));
		model.addAttribute("monthSalesVolume", monthSalesVolume);
		model.addAttribute("yearSales", String.format("%,d", yearSales));
		model.addAttribute("yearSalesVolume", yearSalesVolume);
		model.addAttribute("totalSales", String.format("%,d", totalSales));
		model.addAttribute("totalSalesVolume", totalSalesVolume);

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

			moneyList = service.monthSalesByCategory(map);// moneyList에 한 소분류의 연간 총매출정보가 담겨짐. 월별로 산출되고 없으면 0

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

	// 소계에 쓸 분기별 매출
	@RequestMapping(value = "/admin/money/subtotalChart")
	@ResponseBody
	public Map<String, Object> subtotalChart() throws Exception {
		Map<String, Object> result = new HashMap<>();// 최종적으로 데이터를 보낼 맵

		int quarterSales = 0;

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd"); // 오늘 날짜를 담을 포멧
		Date date = new Date();
		String today = sdf.format(date); // 오늘 날짜를 yyyyMMdd 꼴로 가져옴
		int thisYear = Integer.parseInt(today.substring(0, 4));
		int thisMonth = Integer.parseInt(today.substring(4, 6));

		// 그래프의 컬럼 개수 구하기
		int quarterNumber = (thisYear - 2017) * 4;
		if (thisMonth <= 3)
			quarterNumber += 1;
		else if (thisMonth <= 6)
			quarterNumber += 2;
		else if (thisMonth <= 9)
			quarterNumber += 3;
		else if (thisMonth <= 12)
			quarterNumber += 4;

		String[] categories = new String[quarterNumber];

		int[] sales = new int[quarterNumber];

		double[] rates = new double[quarterNumber];

		// 분기별로 매출액 계산하기
		for (int i = 1; i <= quarterNumber; i++) {
			int yearMonth = (2017 + i / 4);// yearMonth에서 year 설정

			// categories 채워넣기
			switch (i % 4) {
			case 1:
				categories[i - 1] = Integer.toString(yearMonth) + ".1Q";
				yearMonth = (yearMonth * 100) + 1;
				break;
			case 2:
				categories[i - 1] = Integer.toString(yearMonth) + ".2Q";
				yearMonth = (yearMonth * 100) + 4;
				break;
			case 3:
				categories[i - 1] = Integer.toString(yearMonth) + ".3Q";
				yearMonth = (yearMonth * 100) + 7;
				break;
			case 0:
				categories[i - 1] = Integer.toString(yearMonth) + ".4Q";
				yearMonth = (yearMonth * 100) + 10;
			}

			// 마지막 컬럼의 값 정리해서 넣기
			if (i == quarterNumber) {
				categories[i - 1] += "(추정)";

				// 날짜 차이 계산하기
				String start = Integer.toString(2017 + i / 4);// 분기 시작의 년 가져옴
				String end = Integer.toString(2017 + i / 4);// 분기 끝의 년 가져옴

				switch (i % 4) {
				case 1:
					start = start + "0101";
					end = end + "0331";
					break;
				case 2:
					start = start + "0401";
					end = end + "0630";
					break;
				case 3:
					start = start + "0701";
					end = end + "0930";
					break;
				case 4:
					start = start + "1001";
					end = end + "1231";
				}

				Date startDate = sdf.parse(start);
				Date endDate = sdf.parse(end);

				Date todayDate = sdf.parse(today);

				long dateFromNow = (todayDate.getTime() - startDate.getTime()) / 24 / 60 / 60 / 1000; // 분기 시작일부터 오늘까지의
																										// 일수
				long dateToEnd = (endDate.getTime() - startDate.getTime()) / 24 / 60 / 60 / 1000; // 분기 시작일부터 말일까지의 일수

				// 오늘까지의 분기매출 계산하기
				Map<String, Object> map2 = new HashMap<>();
				map2.put("startDate", start);
				map2.put("todayDate", today);

				quarterSales = (int) (service.quarterSalesToToday(map2) * (dateToEnd / dateFromNow));

				sales[i - 1] = quarterSales;

			} else if (i != quarterNumber) {
				quarterSales = service.quarterSales(yearMonth);

				sales[i - 1] = quarterSales;
			}
		}

		// quarterSales, categories 넣고 quarterSales 변화율 계산하기
		result.put("categories", categories);
		result.put("sales", sales);

		for (int i = 1; i < quarterNumber; i++) {

			double rate = 0;

			if (sales[i - 1] != 0) {
				rate = (sales[i] - sales[i - 1]) * 100 / sales[i - 1];
			} else {
				if (sales[i] == 0)
					rate = 0;
				else if (sales[i] > 0)
					rate = Double.MAX_VALUE;
			}

			rates[i] = rate;
		}

		result.put("rates", rates);

		return result;
	}

}
