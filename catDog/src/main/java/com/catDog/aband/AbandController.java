package com.catDog.aband;

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

@Controller("aband.abandonedController")
public class AbandController {
	@Autowired
	private AbandService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value= {"/abandoned/list","/aband/list"})
	public String list(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(value="sort", defaultValue="0") int sort,
			@RequestParam(defaultValue="all") String species,
			@RequestParam(defaultValue="all") String area,
			HttpServletRequest req,
			Model model
			) throws Exception {
		
		String cp = req.getContextPath();
		Map<String, Object> map = new HashMap<String, Object>();
	
		area = URLDecoder.decode(area, "utf-8");
		String query="page="+current_page;
		
		if(area.length()!=0) {
			query+="&species="+species+"&area="+URLEncoder.encode(area, "UTF-8");
		}
		
		map.put("sort", sort);
		map.put("species", species);
		map.put("area", area);
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
		model.addAttribute("species",species);
		model.addAttribute("area",area);
		model.addAttribute("sort",sort);
		
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
		
		service.insertAband(dto, pathname);
		
		return "redirect:/aband/list";
	}
	
	@RequestMapping(value="/aband/article")
	public String article(
			@RequestParam(value="page", defaultValue="1") int page,
			@RequestParam(value="sort", defaultValue="0") int sort,
			@RequestParam(defaultValue="all") String species,
			@RequestParam(defaultValue="all") String area,
			@RequestParam int lostPetNum,
			HttpServletRequest req,
			Model model
			) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		area = URLDecoder.decode(area, "utf-8");

		String query="page="+page+"&sort="+sort;
		
		if(area.length()!=0) {
			query+="&species="+species+"&area="+URLEncoder.encode(area, "UTF-8");
		}
		
		map.put("lostPetNum", lostPetNum);
		map.put("species", species);
		map.put("area", area);

		Aband dto = service.readAband(lostPetNum);
		if(dto == null) {
			return "redirect:/aband/list?"+query;
		}
		
		Aband preDto = service.preReadAband(map);
		Aband nextDto = service.nextReadAband(map);
		
		model.addAttribute("page",page);
		model.addAttribute("species",species);
		model.addAttribute("area",area);
		model.addAttribute("sort",sort);
		model.addAttribute("query",query);
		model.addAttribute("dto",dto);
		model.addAttribute("preDto",preDto);
		model.addAttribute("nextDto",nextDto);
		return ".aband.article";
	}
	
	
	
	
	@RequestMapping(value="/aband/update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam(defaultValue="1") int page,
			@RequestParam(value="sort", defaultValue="0") int sort,
			@RequestParam(defaultValue="all") String species,
			@RequestParam(defaultValue="all") String area,
			@RequestParam int lostPetNum,
			HttpServletRequest req,
			Model model
			)throws Exception{
		Aband dto = service.readAband(lostPetNum);
		
		area = URLDecoder.decode(area, "utf-8");

		String query="page="+page+"&sort="+sort;
		
		if(area.length()!=0) {
			query+="&species="+species+"&area="+URLEncoder.encode(area, "UTF-8");
		}
		
		if(dto==null) {
			return "redirect:/aband/list?"+query;
		}
		
		model.addAttribute("query",query);
		model.addAttribute("page",page);
		model.addAttribute("dto",dto);
		model.addAttribute("mode","update");
		return ".aband.created";
	}
	
	@RequestMapping(value="/aband/update", method=RequestMethod.POST)
	public String updateSubmit(
			@RequestParam(defaultValue="1") int page,
			Aband dto,
			Model model,
			HttpSession session
			)throws Exception{
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root+"uploads"+File.separator+"aband";
		
		service.updateAband(dto, pathname);
		
		return "redirect:/aband/list?page="+page;
	}
	
	@RequestMapping(value="/aband/delete")
	public String delete(
			@RequestParam(defaultValue="1") int page,
			@RequestParam(value="sort", defaultValue="0") int sort,
			@RequestParam(defaultValue="all") String species,
			@RequestParam(defaultValue="all") String area,
			@RequestParam int lostPetNum,
			Model model,
			HttpSession session
			) throws Exception{

		area = URLDecoder.decode(area, "utf-8");

		String query="page="+page+"&sort="+sort;
		
		if(area.length()!=0) {
			query+="&species="+species+"&area="+URLEncoder.encode(area, "UTF-8");
		}
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"aband";
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		try {
			service.deleteAband(lostPetNum, pathname, info.getUserId());
		} catch (Exception e) {
		}
		
		
		return "redirect:/aband/list?"+query;
	}
	
	@RequestMapping(value="/aband/updateStatus")
	public String updateStatus(
			@RequestParam(defaultValue="1") int page,
			@RequestParam(value="sort", defaultValue="0") int sort,
			@RequestParam(defaultValue="all") String species,
			@RequestParam(defaultValue="all") String area,
			@RequestParam int lostPetNum,
			Model model,
			@RequestParam int status,
			HttpSession session
			) throws Exception{

		area = URLDecoder.decode(area, "utf-8");

		String query="page="+page+"&sort="+sort;
		
		if(area.length()!=0) {
			query+="&species="+species+"&area="+URLEncoder.encode(area, "UTF-8");
		}
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Map<String, Object> map = new HashMap<>();
		map.put("num", info.getMemberIdx());
		map.put("lostPetNum", lostPetNum);
		map.put("status", status);
		
		try {
			service.updateStatus(map);
		} catch (Exception e) {
		}
		
		
		return "redirect:/aband/list?"+query;
	}
	
	@RequestMapping(value="/aband/insertReply")
	@ResponseBody
	public Map<String,Object> insertReply(
				@RequestParam int lostPetNum,
				@RequestParam String content,
				@RequestParam (defaultValue="0")String parent,
				HttpSession session
			) throws Exception{
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		Map<String,Object> map = new HashMap<>();
		map.put("num", info.getMemberIdx());
		map.put("nickName", info.getNickName());
		map.put("lostPetNum",lostPetNum);
		map.put("content", content);
		map.put("parent", parent);
		String state="false";
		
		try {
			
			service.insertReply(map);
			state="true";
		} catch (Exception e) {
		}
		
		Map<String,Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	@RequestMapping(value="/aband/listReply")
	public String listReply(
				@RequestParam int lostPetNum,
				@RequestParam(value="pageNo",defaultValue="1") int current_page,
				Model model
			) throws Exception{
		
		Map<String,Object> map = new HashMap<>();

		int rows=15;
		int offset = (current_page-1)*rows;
		if(offset < 0) offset = 0;
		
		map.put("rows", rows);
		map.put("offset",offset);
		map.put("lostPetNum", lostPetNum);
		
		List<Reply> replyList = service.listReply(map);
		int replyCount = service.replyCount(map);
		
		int total_page=myUtil.pageCount(rows, replyCount);
		if(total_page < current_page)
			total_page=current_page;
		
		for(Reply dto : replyList) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			dto.setAnswerCount(service.replyAnswerCount(dto.getLostPetReplyNum()));
		}
		
		String paging = myUtil.pagingMethod(current_page, total_page, "listPage");
		
		model.addAttribute("replyList", replyList);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("replyCount", replyCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		return "/aband/listReply";
	}
	
	@RequestMapping(value="/aband/countReplyAnswer")
	@ResponseBody
	public Map<String, Object> countReplyAnswer(
				@RequestParam int parent
			) throws Exception{
		int count=service.replyAnswerCount(parent);
		
		Map<String, Object> model=new HashMap<>();
		model.put("count", count);
		return model;
	}
	
	@RequestMapping(value="/aband/listReplyAnswer")
	public String listReplyAnswer(
			@RequestParam int parent,
			Model model
			) throws Exception {
		
		List<Reply> listReplyAnswer=service.listReplyAnswer(parent);
		for(Reply dto : listReplyAnswer) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		
		model.addAttribute("listReplyAnswer", listReplyAnswer);
		return "/aband/listReplyAnswer";
	}

	// 댓글 및 댓글의 답글 삭제 : AJAX-JSON
	@RequestMapping(value="/aband/deleteReply", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteReply(
			@RequestParam Map<String, Object> paramMap
			) {
		
		String state="true";
		try {
			service.deleteReply(paramMap);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("state", state);
		return map;
	}
}
