package com.catDog.aband;

import java.io.File;
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

import com.catDog.common.MyUtil;
import com.catDog.customer.SessionInfo;

@Controller("aband.abandonedController")
public class AbandController {
	@Autowired
	private AbandService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value= {"/abandoned/list","/aband/list"})
	public String list(
			@RequestParam(value="page", defaultValue="1") int current_page,
			HttpServletRequest req,
			Model model
			) throws Exception {
		
		String cp = req.getContextPath();
		Map<String, Object> map = new HashMap<String, Object>();
	
		String query="page="+current_page;
		
		int dataCount = service.dataCount(map);
		
		int rows = 12;
		int offset = (current_page-1)*rows;
		if(offset  < 0) offset = 0;
		
		int total_page = myUtil.pageCount(rows, dataCount);
		
		map.put("rows", rows);
		map.put("offset", offset);
		
		List<Aband> list = service.listAband(map);
		
		String listUrl = cp+"/aband/list?"+query;
		String articleUrl = cp+"/aband/article?"+query;
		
		String paging = myUtil.paging(current_page, total_page, listUrl);

		model.addAttribute("list",list);
		model.addAttribute("dataCount",dataCount);
		model.addAttribute("total_page",total_page);
		model.addAttribute("articleUrl",articleUrl);
		model.addAttribute("paging",paging);
		model.addAttribute("page",current_page);
		
		return ".aband.list";
	}
	@RequestMapping(value="/aband/created", method=RequestMethod.GET)
	public String createdForm(
			Model model
			) throws Exception{
		
		model.addAttribute("mode","created");
		return ".aband.created";
	}
	
	@RequestMapping(value="/aband/created", method=RequestMethod.POST)
	public String createdSubmit(
			Aband dto,
			Model model,
			HttpSession session
			) throws Exception{
		String root = session.getServletContext().getRealPath("/");
		String pathname = root+"uploads"+File.separator+"aband";
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		dto.setNum(info.getMemberIdx());
		dto.setNickName(info.getNickName());
		
		service.insertAdopt(dto, pathname);
		
		return "redirect:/aband/list";
	}
	
}
