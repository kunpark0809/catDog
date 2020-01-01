package com.catDog.training;

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

@Controller("training.Training")
public class TrainingController {
	
@Autowired
private TrainingService service;

@Autowired
private MyUtil myUtil;

@RequestMapping(value="/training/list")
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
	
	List<Training> list = service.listTraining(map);
	
	String listUrl = cp+"/training/list";
	String articleUrl = cp+"/training/article?page=" + current_page;
	
	String paging = myUtil.paging(current_page, total_page, listUrl);
	
	model.addAttribute("list", list);
	model.addAttribute("dataCount", dataCount);
	model.addAttribute("total_page", total_page);
	model.addAttribute("articleUrl", articleUrl);
	model.addAttribute("page", current_page);
	model.addAttribute("paging", paging);
	
	model.addAttribute("condition", condition);
	model.addAttribute("keyword", keyword);		
	
	return ".training.list";
}
	
	@RequestMapping(value="/training/created", method=RequestMethod.GET)
	public String createdForm(
			HttpSession session,
			Model model) throws Exception {
		
		model.addAttribute("mode", "created");
		return ".training.created";
	}
	
	@RequestMapping(value="/training/created", method=RequestMethod.POST)
	public String createdSubmit(
			Training dto,
			HttpSession session) throws Exception {
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"training";
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		try {
			dto.setNum(info.getMemberIdx());
			
			service.insertTraining(dto, pathname);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/training/list";
	}
	
	@RequestMapping(value="/training/article", method=RequestMethod.GET)
	public String article(
			@RequestParam int recommendNum,
			@RequestParam(defaultValue="1") String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			Model model
			) throws Exception{
		Training dto = service.readTraining(recommendNum);
		
		String query="page="+page;
		if(dto == null) {
			return "redirect:/training/list?"+query;
		}
		
		service.updateHitCount(recommendNum);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("recommendNum", recommendNum);
		
		Training preReadTraining = service.preReadTraining(map);
		Training nextReadTraining = service.nextReadTraining(map);
		
		model.addAttribute("preReadTraining", preReadTraining);
		model.addAttribute("nextReadTraining", nextReadTraining);
		
		model.addAttribute("page",page);
		model.addAttribute("query",query);
		model.addAttribute("dto",dto);
		
		return ".training.article";
	}
	
	@RequestMapping(value="/training/delete", method=RequestMethod.GET)
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
		String pathname=root+"uploads"+File.separator+"training";
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		try {
			service.deleteTraining(recommendNum, pathname, info.getUserId());
		} catch (Exception e) {
		}
		
		return "redirect:/training/list?"+query;
	}
	
	@RequestMapping(value="/training/update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam int recommendNum,
			@RequestParam String page,
			HttpSession session,
			Model model
			) throws Exception {
		
		
		
		Training dto = service.readTraining(recommendNum);
		
		if(dto == null)
			return "redirect:/training/list?page="+page;
		
		if(dto.getUserId().indexOf("admin") < 0) {
			return "redirect:/training/list?page="+page;
		}
		
		model.addAttribute("page", page);
		model.addAttribute("mode", "update");
		model.addAttribute("dto", dto);
		
		return ".training.created";
	}
	
	@RequestMapping(value="/training/update", method=RequestMethod.POST)
	public String updateSubmit(
			Training dto,
			@RequestParam String page,
			HttpSession session
			) throws Exception {
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"training";
		
		try {
			service.updateTraining(dto, pathname);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/training/article?recommendNum="+dto.getRecommendNum()+"&page="+page;
	}
	
	@RequestMapping(value="/training/insertRate", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertRate(
			Training dto,
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
	
	@RequestMapping(value="/training/listRate")
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
		List<Training> listRate=service.listRate(map);
		
		for(Training dto : listRate) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		
		String paging=myUtil.pagingMethod(current_page, total_page, "listPage");
		
		model.addAttribute("listRate", listRate);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("rateCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		return "training/listRate";
	}
	
		@RequestMapping(value="/training/deleteRate", method=RequestMethod.POST)
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