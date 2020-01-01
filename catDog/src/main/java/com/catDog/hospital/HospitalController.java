package com.catDog.hospital;

import java.io.File;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.catDog.common.MyUtil;
import com.catDog.customer.SessionInfo;

@Controller("hospital.Hospital")
public class HospitalController {
	
@Autowired
private HospitalService service;

@Autowired
private MyUtil myUtil;

@RequestMapping(value="/hospital/list")
public String list(
		@RequestParam(value="page", defaultValue="1") int current_page,
		@RequestParam(defaultValue="all") String condition,
		@RequestParam(defaultValue="") String keyword,
		HttpServletRequest req,
		Model model) throws Exception {

	String cp = req.getContextPath();

	Map<String, Object> map = new HashMap<String, Object>();
	
	map.put("keyword", keyword);
	map.put("condition", condition);
			
	int dataCount = service.dataCount(map);
	
	int rows = 6;
	int offset = (current_page-1)*rows;
	if(offset  < 0) offset = 0;
	
	int total_page = myUtil.pageCount(rows, dataCount);
	
	map.put("rows", rows);
	map.put("offset", offset);
	
	List<Hospital> list = service.listHospital(map);
	
	String listUrl = cp+"/hospital/list";
	String articleUrl = cp+"/hospital/article?page=" + current_page;
	
	String paging = myUtil.paging(current_page, total_page, listUrl);
	
	model.addAttribute("list", list);
	model.addAttribute("dataCount", dataCount);
	model.addAttribute("total_page", total_page);
	model.addAttribute("articleUrl", articleUrl);
	model.addAttribute("page", current_page);
	model.addAttribute("paging", paging);
	
	model.addAttribute("condition", condition);
	model.addAttribute("keyword", keyword);		
	
	return ".hospital.list";
}
	
	@RequestMapping(value="/hospital/created", method=RequestMethod.GET)
	public String createdForm(
			HttpSession session,
			Model model) throws Exception {
		
		model.addAttribute("mode", "created");
		return ".hospital.created";
	}
	
	@RequestMapping(value="/hospital/created", method=RequestMethod.POST)
	public String createdSubmit(
			Hospital dto,
			HttpSession session) throws Exception {
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"hospital";
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		try {
			dto.setNum(info.getMemberIdx());
			
			service.insertHospital(dto, pathname);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/hospital/list";
	}
	
	@RequestMapping(value="/hospital/article", method=RequestMethod.GET)
	public String article(
			@RequestParam int recommendNum,
			@RequestParam(defaultValue="1") String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			Model model
			) throws Exception{
		Hospital dto = service.readHospital(recommendNum);
		
		String query="page="+page;
		if(dto == null) {
			return "redirect:/hospital/list?"+query;
		}
		
		service.updateHitCount(recommendNum);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("recommendNum", recommendNum);
		
		Hospital preReadHospital = service.preReadHospital(map);
		Hospital nextReadHospital = service.nextReadHospital(map);
		
		model.addAttribute("preReadHospital", preReadHospital);
		model.addAttribute("nextReadHospital", nextReadHospital);
		
		model.addAttribute("page",page);
		model.addAttribute("query",query);
		model.addAttribute("dto",dto);
		
		return ".hospital.article";
	}
	
	@RequestMapping(value="/hospital/delete", method=RequestMethod.GET)
	public String delete(
			@RequestParam int recommendNum,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpSession session
			) throws Exception {
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		String query="page="+page;
		
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"hospital";
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		try {
			service.deleteHospital(recommendNum, pathname, info.getUserId());
		} catch (Exception e) {
		}
		
		return "redirect:/hospital/list?"+query;
	}
	
	@RequestMapping(value="/hospital/update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam int recommendNum,
			@RequestParam String page,
			HttpSession session,
			Model model
			) throws Exception {
		
		
		
		Hospital dto = service.readHospital(recommendNum);
		
		if(dto == null)
			return "redirect:/hospital/list?page="+page;
		
		if(dto.getUserId().indexOf("admin") < 0) {
			return "redirect:/hospital/list?page="+page;
		}
		
		model.addAttribute("page", page);
		model.addAttribute("mode", "update");
		model.addAttribute("dto", dto);
		
		return ".hospital.created";
	}
	
	@RequestMapping(value="/hospital/update", method=RequestMethod.POST)
	public String updateSubmit(
			Hospital dto,
			@RequestParam String page,
			HttpSession session
			) throws Exception {
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"hospital";
		
		try {
			service.updateHospital(dto, pathname);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/hospital/article?recommendNum="+dto.getRecommendNum()+"&page="+page;
	}
	
	@RequestMapping(value="/hospital/insertRate", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertRate(
			Hospital dto,
			HttpSession session
			) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		String state="true";
		
		try {
			dto.setNum(info.getMemberIdx());
			service.insertRate(dto);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	@RequestMapping(value="/hospital/listRate")
	public String listRate(
			@RequestParam int recommendNum,
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			Model model
			) throws Exception {
		
		int rows=5;
		int total_page=0;
		int dataCount=0;
		
		Map<String, Object> map=new HashMap<>();
		map.put("recommendNum", recommendNum);
		
		dataCount=service.rateCount(map);
		total_page = myUtil.pageCount(rows, dataCount);
		if(current_page>total_page)
			current_page=total_page;
		
        int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);
		List<Hospital> listRate=service.listRate(map);
		
		for(Hospital dto : listRate) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		
		String paging=myUtil.pagingMethod(current_page, total_page, "listPage");
		
		model.addAttribute("listRate", listRate);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("rateCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		return "hospital/listRate";
	}
	
		@RequestMapping(value="/hospital/deleteRate", method=RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> deleteRate(
				@RequestParam Map<String, Object> paramMap
				) {
			
			String state="true";
			try {
				service.deleteRate(paramMap);
			} catch (Exception e) {
				state="false";
			}
		
			Map<String, Object> map = new HashMap<>();
			map.put("state", state);
			return map;
		}
	
}