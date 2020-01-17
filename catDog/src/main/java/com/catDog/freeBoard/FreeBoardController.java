package com.catDog.freeBoard;

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

@Controller("freeBoard.FreeBoard")
public class FreeBoardController {

@Autowired
private FreeBoardService service;

@Autowired
private MyUtil myUtil;
	

	@RequestMapping(value="/freeBoard/list")
	public String list(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			Model model) throws Exception {
		
		String cp = req.getContextPath();
		
		int rows = 10;
		int total_page = 0;
		int dataCount = 0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		dataCount = service.dataCount(map);
		
		if(dataCount != 0)
			total_page = myUtil.pageCount(rows, dataCount);
		
		if(total_page < current_page)
			current_page = total_page;

		List<FreeBoard> listFreeBoardTop = null;
		if(current_page==1) {
			listFreeBoardTop = service.listFreeBoardTop();
		}
		
		int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
		map.put("offset", offset);
		map.put("rows", rows);
		
		List<FreeBoard> list = service.listFreeBoard(map);
		
		int listNum, n = 0;
		for(FreeBoard dto : list) {
			listNum = dataCount - (offset + n);
			dto.setListNum(listNum);
			
			dto.setCreated(dto.getCreated().substring(0, 10));
			n++;
		}
		
		String query = "";
		String listUrl;
		String articleUrl;
		if(keyword.length()!=0) {
			query = "condition=" +condition + 
	   	         "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
		}
		
		listUrl = cp+"/freeBoard/list";
		articleUrl = cp + "/freeBoard/article?page="+current_page;
		if(query.length()!=0) {
			listUrl = listUrl + "?" + query;
			articleUrl = articleUrl + "&" + query;
		}
		
		String paging = myUtil.paging(current_page, total_page, listUrl);

		model.addAttribute("listFreeBoardTop", listFreeBoardTop);
		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("paging", paging);
		model.addAttribute("articleUrl", articleUrl);
		
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return ".freeBoard.list";
	}

		@RequestMapping(value="/freeBoard/created", method=RequestMethod.GET)
		public String createdForm(
				HttpSession session,
				Model model) throws Exception {
			
			model.addAttribute("mode", "created");
			return ".freeBoard.created";
		}
		
		@RequestMapping(value="/freeBoard/created", method=RequestMethod.POST)
		public String createdSubmit(
				FreeBoard dto,
				HttpSession session) throws Exception {
			
			SessionInfo info=(SessionInfo)session.getAttribute("member");
			
			try {
				dto.setNum(info.getMemberIdx());
				
				service.insertFreeBoard(dto);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			return "redirect:/freeBoard/list";
		}

		@RequestMapping(value="/freeBoard/article", method=RequestMethod.GET)
		public String article(
				@RequestParam int bbsNum,
				@RequestParam(defaultValue="1") String page,
				@RequestParam(defaultValue="all") String condition,
				@RequestParam(defaultValue="") String keyword,
				Model model
				) throws Exception{
			FreeBoard dto = service.readFreeBoard(bbsNum);
			
			String query="page="+page;
			if(dto == null) {
				return "redirect:/freeBoard/list?"+query;
			}
			
			service.updateHitCount(bbsNum);
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("condition", condition);
			map.put("keyword", keyword);
			map.put("bbsNum", bbsNum);
			
			FreeBoard preReadFreeBoard = service.preReadFreeBoard(map);
			FreeBoard nextReadFreeBoard = service.nextReadFreeBoard(map);
			
			model.addAttribute("preReadFreeBoard", preReadFreeBoard);
			model.addAttribute("nextReadFreeBoard", nextReadFreeBoard);
			
			model.addAttribute("page",page);
			model.addAttribute("query",query);
			model.addAttribute("dto",dto);
			
			return ".freeBoard.article";
		}
		
		@RequestMapping(value="/freeBoard/delete", method=RequestMethod.GET)
		public String delete(
				@RequestParam int bbsNum,
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
			
			SessionInfo info=(SessionInfo)session.getAttribute("member");
			
			try {
				service.deleteFreeBoard(bbsNum, info.getUserId());
			} catch (Exception e) {
			}
			
			return "redirect:/freeBoard/list?"+query;
		}
		
		@RequestMapping(value="/freeBoard/update", method=RequestMethod.GET)
		public String updateForm(
				@RequestParam int bbsNum,
				@RequestParam String page,
				HttpSession session,
				Model model
				) throws Exception {
			
			FreeBoard dto = service.readFreeBoard(bbsNum);
			
			if(dto == null)
				return "redirect:/freeBoard/list?page="+page;
			
			model.addAttribute("page", page);
			model.addAttribute("mode", "update");
			model.addAttribute("dto", dto);
			
			return ".freeBoard.created";
		}
		
		@RequestMapping(value="/freeBoard/update", method=RequestMethod.POST)
		public String updateSubmit(
				FreeBoard dto,
				@RequestParam String page,
				HttpSession session
				) throws Exception {
			
			SessionInfo info=(SessionInfo)session.getAttribute("member");
			
			try {
				dto.setUserId(info.getUserId());
				service.updateFreeBoard(dto);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			return "redirect:/freeBoard/article?bbsNum="+dto.getBbsNum()+"&page="+page;
		}
		
		@RequestMapping(value="/freeBoard/listReply")
		public String listReply(
				@RequestParam int bbsNum,
				Model model,
				@RequestParam(value="pageNo", defaultValue="1") int current_page
			) throws Exception {
			
			int rows=5;
			int total_page=0;
			int dataCount=0;
			
			Map<String, Object> map = new HashMap<>();
			map.put("bbsNum", bbsNum);
			
			dataCount=service.replyCount(map);
			total_page = myUtil.pageCount(rows, dataCount);
			if(current_page>total_page)
				current_page=total_page;
			
			int offset = (current_page-1) * rows;
			if(offset < 0) offset = 0;
			map.put("offset", offset);
			map.put("rows", rows);
			List<Reply> listReply=service.listReply(map);
			
			for(Reply dto : listReply) {
				dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			}
			
			String paging=myUtil.pagingMethod(current_page, total_page, "listPage");
			
			model.addAttribute("listReply", listReply);
			model.addAttribute("pageNo", current_page);
			model.addAttribute("replyCount", dataCount);
			model.addAttribute("total_page", total_page);
			model.addAttribute("paging", paging);
			
			return "freeBoard/listReply";
		}

		
		@RequestMapping(value="/freeBoard/insertReply", method=RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> insertReply(
				Reply dto,
				HttpSession session
				) {
			SessionInfo info=(SessionInfo)session.getAttribute("member");
					String state="true";
			
			try {
				dto.setNum(info.getMemberIdx());
				service.insertReply(dto);
			} catch (Exception e) {
				state="false";
			}
			
			Map<String, Object> model = new HashMap<>();
			model.put("state", state);
			return model;
		}
		

		@RequestMapping(value="/freeBoard/deleteReply", method=RequestMethod.POST)
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
		
		@RequestMapping(value="/freeBoard/listReplyParent")
		public String listReplyParent(
				@RequestParam int parent,
				Model model
				) throws Exception {
			
			List<Reply> listReplyParent=service.listReplyParent(parent);
			
			for(Reply dto : listReplyParent) {
				dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			}
			
			model.addAttribute("listReplyParent", listReplyParent);
			
			return "freeBoard/listReplyParent";
		}
		
		@RequestMapping(value="/freeBoard/countReplyParent")
		@ResponseBody
		public Map<String, Object> countReplyParent(
				@RequestParam(value="parent") int parent
				) {
			int count=service.replyParentCount(parent);
			
			Map<String, Object> model=new HashMap<>();
			
			model.put("count", count);
			
			return model;
		}

		// 게시글 신고추가 :  : AJAX-JSON
		@RequestMapping(value="/freeBoard/insertFreeBoardReport", method=RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> insertFreeBoardReport(
				@RequestParam int reportedPostNum,
				@RequestParam int reporterNum,
				@RequestParam int reportedNum,
				@RequestParam int reasonSortNum,
				HttpSession session
				) {
			String state="true";
			int freeBoardReportCount=0;
			SessionInfo info=(SessionInfo)session.getAttribute("member");
			
			Map<String, Object> paramMap=new HashMap<>();
			paramMap.put("reportedPostNum", reportedPostNum);
			paramMap.put("reporterNum", info.getMemberIdx());
			paramMap.put("reportedNum", reportedNum);
			paramMap.put("reasonSortNum", reasonSortNum);
			
			try {
				service.insertFreeBoardReport(paramMap);
			} catch (Exception e) {
				state="false";
			}

			freeBoardReportCount = service.freeBoardReportCount(reportedPostNum);

			Map<String, Object> model=new HashMap<>();
			model.put("state", state);
			model.put("freeBoardReportCount", freeBoardReportCount);

			return model;
		}
		
	}