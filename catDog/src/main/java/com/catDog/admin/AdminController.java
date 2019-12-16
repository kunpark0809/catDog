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

@Controller("admin.adminController")
public class AdminController {

	@Autowired
	private AdminService service;

	@Autowired
	private MyUtil myUtil;

	@RequestMapping(value = "/admin/member")
	public String memberManage(@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition, @RequestParam(defaultValue = "") String keyword,
			@RequestParam(value = "rows", defaultValue = "50") int rows, HttpServletRequest req, Model model)
			throws Exception {

		if (req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "UTF-8");
		}

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

	@RequestMapping(value = "/admin/cs")
	public String csManage() throws Exception {

		return ".admin.cs";
	}

	@RequestMapping(value = "/admin/bbs")
	public String bbsManage() throws Exception {

		return ".admin.bbs";
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
