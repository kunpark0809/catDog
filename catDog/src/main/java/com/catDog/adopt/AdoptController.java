package com.catDog.adopt;

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
 
@Controller("adopt.adoptController")
public class AdoptController {
	@Autowired
	private AdoptService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="/adopt/list")
	public String list(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			Model model
			) throws Exception{
		
		String cp = req.getContextPath();
		Map<String, Object> map = new HashMap<String, Object>();
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		String query="page="+current_page;
		
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		map.put("keyword", keyword);
		map.put("condition", condition);
		int dataCount = service.dataCount(map);
		
		
		int rows = 12;
		int offset = (current_page-1)*rows;
		if(offset  < 0) offset = 0;
		
		int total_page = myUtil.pageCount(rows, dataCount);
		
		map.put("rows", rows);
		map.put("offset", offset);
		
		List<Adopt> list = service.listAdopt(map);
		
		String listUrl = cp+"/adopt/list?"+query;
		String articleUrl = cp+"/adopt/article?"+query;
		
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("condition",condition);
		model.addAttribute("keyword",keyword);
		model.addAttribute("list",list);
		model.addAttribute("dataCount",dataCount);
		model.addAttribute("total_page",total_page);
		model.addAttribute("articleUrl",articleUrl);
		model.addAttribute("paging",paging);
		model.addAttribute("page",current_page);
		
		return ".adopt.list";
	}
	
	@RequestMapping(value="/adopt/created", method=RequestMethod.GET)
	public String createdForm(
			Model model
			) throws Exception{
		
		model.addAttribute("mode","created");
		return ".adopt.created";
	}
	
	@RequestMapping(value="/adopt/created", method=RequestMethod.POST)
	public String createdSubmit(
			Adopt dto,
			Model model,
			HttpSession session
			) throws Exception{
		String root = session.getServletContext().getRealPath("/");
		String pathname = root+"uploads"+File.separator+"adopt";
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		dto.setNum(info.getMemberIdx());
		dto.setNickName(info.getNickName());
		
		service.insertAdopt(dto, pathname);
		
		return "redirect:/adopt/list";
	}
	
	@RequestMapping(value="/adopt/article")
	public String article(
			@RequestParam int adoptionNum,
			@RequestParam(defaultValue="1") int page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			Model model
			) throws Exception{
		
			service.updateHitCount(adoptionNum);
			Adopt dto = service.readAdopt(adoptionNum);
			
			String query = "page="+page;
			
			keyword = URLDecoder.decode(keyword, "utf-8");
			
			if(keyword.length()!=0) {
				query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
			}
			
			if(dto==null) {
				return "redirect:/adopt/list?"+query;
			}
			Map<String, Object> map = new HashMap<>();
			map.put("adoptionNum", adoptionNum);
			map.put("keyword", keyword);
			map.put("condition", condition);
			Adopt preDto = service.preReadAdopt(map);
			Adopt nextDto = service.nextReadAdopt(map);
			
			model.addAttribute("condition",condition);
			model.addAttribute("keword",keyword);
			model.addAttribute("dto",dto);
			model.addAttribute("preDto",preDto);
			model.addAttribute("nextDto",nextDto);
			model.addAttribute("page",page);
			model.addAttribute("query",query);
			
		return ".adopt.article";
	}
	
	@RequestMapping(value="/adopt/update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam int adoptionNum,
			@RequestParam(defaultValue="1") int page,
			Model model
			)throws Exception{
		Adopt dto = service.readAdopt(adoptionNum);
		
		if(dto==null) {
			return "redirect:/adopt/list?page="+page;
		}
		
		model.addAttribute("page",page);
		model.addAttribute("dto",dto);
		model.addAttribute("mode","update");
		return ".adopt.created";
	}
	
	@RequestMapping(value="/adopt/update", method=RequestMethod.POST)
	public String updateSubmit(
			@RequestParam(defaultValue="1") int page,
			Adopt dto,
			HttpSession session
			)throws Exception{
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root+"uploads"+File.separator+"adopt";
		
		service.updateAdopt(dto, pathname);
		
		return "redirect:/adopt/list?page="+page;
	}
	
	@RequestMapping(value="/adopt/delete")
	public String delete(
			@RequestParam int adoptionNum,
			@RequestParam(defaultValue="1") int page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpSession session
			) throws Exception{
		keyword = URLDecoder.decode(keyword, "utf-8");
		String query="page="+page;
		
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"adopt";
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		try {
			service.deleteAdopt(adoptionNum, pathname, info.getUserId());
		} catch (Exception e) {
		}
		
		
		return "redirect:/adopt/list?"+query;
	}
	
	@RequestMapping(value="/adopt/updateStatue")
	public String updateStatus(
			@RequestParam int adoptionNum,
			@RequestParam(defaultValue="1") int page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			@RequestParam int status,
			HttpSession session
			) throws Exception{
		keyword = URLDecoder.decode(keyword, "utf-8");
		String query="page="+page;
		
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Map<String, Object> map = new HashMap<>();
		map.put("num", info.getMemberIdx());
		map.put("adoptionNum", adoptionNum);
		map.put("status", status);
		
		try {
			service.updateStatus(map);
		} catch (Exception e) {
		}
		
		
		return "redirect:/adopt/list?"+query;
	}
	
	@RequestMapping(value="/adopt/insertReply")
	@ResponseBody
	public Map<String,Object> insertReply(
				@RequestParam int adoptionNum,
				@RequestParam String content,
				@RequestParam (defaultValue="0")String parent,
				HttpSession session
			) throws Exception{
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		Map<String,Object> map = new HashMap<>();
		map.put("num", info.getMemberIdx());
		map.put("nickName", info.getNickName());
		map.put("adoptionNum",adoptionNum);
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
	
	@RequestMapping(value="/adopt/listReply")
	public String listReply(
				@RequestParam int adoptionNum,
				@RequestParam(value="pageNo",defaultValue="1") int current_page,
				Model model
			) throws Exception{
		
		Map<String,Object> map = new HashMap<>();

		int rows=15;
		int offset = (current_page-1)*rows;
		if(offset < 0) offset = 0;
		
		map.put("rows", rows);
		map.put("offset",offset);
		map.put("adoptionNum", adoptionNum);
		
		List<Reply> replyList = service.listReply(map);
		int replyCount = service.replyCount(map);
		
		int total_page=myUtil.pageCount(rows, replyCount);
		if(total_page < current_page)
			total_page=current_page;
		
		for(Reply dto : replyList) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			dto.setAnswerCount(service.replyAnswerCount(dto.getAdoptionReplyNum()));
		}
		
		String paging = myUtil.pagingMethod(current_page, total_page, "listPage");
		
		model.addAttribute("replyList", replyList);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("replyCount", replyCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		return "/adopt/listReply";
	}
	
	@RequestMapping(value="/adopt/countReplyAnswer")
	@ResponseBody
	public Map<String, Object> countReplyAnswer(
				@RequestParam int parent
			) throws Exception{
		int count=service.replyAnswerCount(parent);
		
		Map<String, Object> model=new HashMap<>();
		model.put("count", count);
		return model;
	}
	
	@RequestMapping(value="/adopt/listReplyAnswer")
	public String listReplyAnswer(
			@RequestParam int parent,
			Model model
			) throws Exception {
		
		List<Reply> listReplyAnswer=service.listReplyAnswer(parent);
		for(Reply dto : listReplyAnswer) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		
		model.addAttribute("listReplyAnswer", listReplyAnswer);
		return "adopt/listReplyAnswer";
	}

	// 댓글 및 댓글의 답글 삭제 : AJAX-JSON
	@RequestMapping(value="/adopt/deleteReply", method=RequestMethod.POST)
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
