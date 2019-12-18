package com.catDog.cs;

import java.io.File;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.catDog.common.FileManager;
import com.catDog.common.MyUtil;
import com.catDog.customer.SessionInfo;

@Controller("cs.csController")
public class CsController {
	@Autowired
	private CsService service;
	
	@Autowired
	private MyUtil util;
	
	@Autowired
	private FileManager fileManager;
	
	@RequestMapping(value="/notice/list")
	public String noticeList(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			Model model) throws Exception {
		
		String cp = req.getContextPath();
		
		int rows = 5;
		int total_page = 0;
		int dataCount = 0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		dataCount = service.noticeDataCount(map);
		if(dataCount != 0)
			total_page = util.pageCount(rows, dataCount);
		
		if(total_page < current_page)
			current_page = total_page;
		
		List<Notice> noticeList = null;
		if(current_page==1) {
			noticeList = service.listNoticeTop();
		}
		
		int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
		map.put("offset", offset);
		map.put("rows", rows);
		
		List<Notice> list = service.listNotice(map);
		
		Date endDate = new Date();
		long gap;
		
		int listNum, n = 0;
		for(Notice dto : list) {
			listNum = dataCount - (offset + n);
			dto.setListNum(listNum);
			
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date beginDate = formatter.parse(dto.getCreated());
			
			gap = (endDate.getTime()-beginDate.getTime()) / (60*60*1000);
			dto.setGap(gap);
			
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
		
		listUrl = cp+"/notice/list";
		articleUrl = cp + "/notice/article?page="+current_page;
		if(query.length()!=0) {
			listUrl = listUrl + "?" + query;
			articleUrl = articleUrl + "&" + query;
		}
		
		String paging = util.paging(current_page, total_page, listUrl);
		
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("paging", paging);
		model.addAttribute("articleUrl", articleUrl);
		
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return ".notice.list";
	}
	
	@RequestMapping(value="/notice/created", method=RequestMethod.GET)
	public String createdForm(Model model,
			  				  HttpSession session) throws Exception {
		model.addAttribute("mode", "created");
		return ".notice.created";
	}
	
	@RequestMapping(value="/notice/created", method=RequestMethod.POST)
	public String createdSubmit(Notice dto,
								HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root+"uploads"+File.separator+"notice";
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {			
			dto.setNum(info.getMemberIdx());			
			service.insertNotice(dto, pathname);
		} catch (Exception e) {
		}	
		return "redirect:/notice/list";
	}
	
	@RequestMapping(value="/notice/update", method=RequestMethod.GET)
	public String updateForm(@RequestParam int noticeNum,
							 @RequestParam String page,
							 HttpSession session,
							 Model model) {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		Notice dto = service.readNotice(noticeNum);
		if(dto==null || ! dto.getUserId().equals(info.getUserId())) {
			return "redirect:/notice/list?page="+page;
		}
		
		List<Notice> listFile = service.listFile(noticeNum);
		
		model.addAttribute("mode", "update");
		model.addAttribute("dto", dto);
		model.addAttribute("listFile", listFile);
		model.addAttribute("page", page);
		
		return ".notice.created";
	}
	
	@RequestMapping(value="/notice/update", method=RequestMethod.POST)
	public String updateSubmit(Notice dto,
							   @RequestParam String page,
							   HttpSession session) {
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "notice";
		
		try {
			service.updateNotice(dto, pathname);
		} catch (Exception e) {			
		}
		return "redirect:/notice/list?page="+page;
	}
	
	
	@RequestMapping(value="/notice/zipdownload")
	public void zip(@RequestParam int noticeNum,
					HttpServletResponse resp,
					HttpSession session) throws Exception {
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "notice";
		
		boolean b = false;
		List<Notice> list = service.listFile(noticeNum);
		
		if(list.size()>0) {
			String []sources = new String[list.size()];
			String []originals = new String[list.size()];
			String zipFileName = noticeNum+".zip";
			
			// 압축을 할 때는 경로가 꼭 있어야 한다. \aaaa.txt 같이.
			for(int idx=0; idx<list.size(); idx++) {
				sources[idx] = pathname+File.separator+list.get(idx).getSaveFileName();
				originals[idx] = File.separator+list.get(idx).getOriginalFileName();
			}
			b = fileManager.doZipFileDownload(sources, originals, zipFileName, resp);			
		}
		
		if(! b) {
			resp.setContentType("text/html;charset=utf-8");
			PrintWriter out = resp.getWriter();
			out.print("<script>alert('다운불가...');history.back();</script>");
		}
	}
	
	@RequestMapping(value="/notice/article", method=RequestMethod.GET)
	public String article(
			@RequestParam int noticeNum,			
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			Model model,
			@CookieValue(defaultValue="0") int cnum,
			HttpServletResponse resp) throws Exception {
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		
		String query = "page="+page;
		if(keyword.length()!=0) {
			query += "&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "utf-8");
		}
		
		if(noticeNum!=cnum) {
			service.updateHitCount(noticeNum);
			
			Cookie ck = new Cookie("cnum", Integer.toString(noticeNum));
			resp.addCookie(ck);
		}
		
		Notice dto = service.readNotice(noticeNum);
		if(dto==null)
			return "redirect:/notice/list?"+query;
		
		// 스타일로 처리하는 경우 : style="white-space:pre;"
        // dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
        
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("condition", condition);
        map.put("keyword", keyword);
        map.put("noticeNum", noticeNum);
        
        Notice preReadDto = service.preReadNotice(map);
        Notice nextReadDto = service.nextReadNotice(map);
        
        // 파일
        List<Notice> listFile = service.listFile(noticeNum);
        
        model.addAttribute("dto", dto);
        model.addAttribute("preReadDto", preReadDto);
        model.addAttribute("nextReadDto", nextReadDto);
        model.addAttribute("listFile", listFile);
        
        model.addAttribute("page", page);
        model.addAttribute("query", query);
		
		return ".notice.article";
	}
	
	@RequestMapping("/notice/download")
	public void down(@RequestParam int noticeFileNum,
					HttpServletResponse resp,
					HttpSession session) throws Exception {
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator +"notice";
		
		Notice dto = service.readFile(noticeFileNum);
		boolean b = false;
		
		if(dto != null) {
			b = fileManager.doFileDownload(dto.getSaveFileName(), dto.getOriginalFileName(),
							pathname, resp);
		}
		
		if(! b) {
			resp.setContentType("text/html;charset=utf-8");
			PrintWriter out = resp.getWriter();
			out.print("<script>alert('파일 다운로드가 실패 했습니다.';history.back();</script>");
		}
	}
	
	@RequestMapping(value="/notice/deleteFile", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteFile(
					@RequestParam int noticeFileNum,
					HttpSession session) throws Exception {
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator +"notice";
		
		String state = "false";
		Notice dto = service.readFile(noticeFileNum);
		if(dto!=null) {
			fileManager.doFileDelete(dto.getSaveFileName(), pathname);
			
			Map<String, Object> map = new HashMap<>();
			map.put("field", "noticeFileNum");
			map.put("num", noticeFileNum);
			
			try {
				service.deleteFile(map);
				state = "true";
			} catch (Exception e) {
				
			}
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	@RequestMapping(value="/notice/delete")
	public String delete(@RequestParam int noticeNum,
						 @RequestParam String page,
						 @RequestParam(defaultValue="all") String condition,
						 @RequestParam(defaultValue="") String keyword,
						 HttpSession session) throws Exception {
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		
		String query = "page="+page;
		if(keyword.length()!=0) {
			query += "&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "utf-8");
		}
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator +"notice";
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		Notice dto = service.readNotice(noticeNum);
		if(dto!=null && (dto.getUserId().equals(info.getUserId()) || info.getUserId().equals("admin"))) {
			service.deleteNotice(noticeNum, pathname);
		}
		
		return "redirect:/notice/list?"+query;
	}
	
	
	@RequestMapping(value="/qna/list")
	public String qnaList(
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			Model model) throws Exception {
		
		String cp = req.getContextPath();
		
		int rows = 5;
		int total_page;
		int dataCount;

		if (req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "UTF-8");
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);

		dataCount = service.qnaDataCount(map);
		total_page = util.pageCount(rows, dataCount);
		
		if (total_page < current_page)
			current_page = total_page;

		int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);
        
        List<Qna> list = service.listQna(map);
        
        int listNum, n = 0;
        for(Qna dto : list) {
        	listNum = dataCount - (offset + n);
			dto.setListNum(listNum);
			n++;
        }
        
        String query = "";
		String listUrl;
		String articleUrl;
		if(keyword.length()!=0) {
			query = "condition=" +condition + 
       	         "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
		}
		
		listUrl = cp+"/qna/list";
		articleUrl = cp + "/qna/article?pageNo="+current_page;
		if(query.length()!=0) {
			listUrl = listUrl + "?" + query;
			articleUrl = articleUrl + "&" + query;
		}
        
        String paging = util.pagingMethod(current_page, total_page, listUrl);
        
        model.addAttribute("list", list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("paging", paging);
		model.addAttribute("total_page", total_page);
		model.addAttribute("articleUrl", articleUrl);
		
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return ".qna.list";
	}
	
	@RequestMapping(value="/qna/created", method=RequestMethod.GET)
	public String qnaCreatedForm(Model model) throws Exception {
		List<Qna> listCategory = service.listQnaCategory();
		
		model.addAttribute("pageNo", "1");
		model.addAttribute("listCategory", listCategory);
		model.addAttribute("mode", "created");
		return ".qna.created";
	}
	
	@RequestMapping(value="/qna/created", method=RequestMethod.POST)
	public String qnaCreatedSubmit(
			Qna dto,
			HttpSession session) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		try {
			dto.setNum(info.getMemberIdx());
			service.insertQna(dto);
		} catch (Exception e) {
		}
		return "redirect:/qna/list";
	}
	
	@RequestMapping(value="/qna/article")
	public String qnaArticle(
			@RequestParam int qnaNum,
			@RequestParam String pageNo,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			HttpSession session,
			Model model) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		if(req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
		Qna questionDto = service.readQnaQuestion(qnaNum);
		if(questionDto==null) {
			return ".qna.list";
		}
		if(questionDto.getQuestionPrivate()==1 &&
				 (! info.getUserId().equals("admin") && ! info.getUserId().equals(questionDto.getUserId()))) {
			return ".qna.list";
		}
		
		questionDto.setContent(questionDto.getContent().replaceAll("\n", "<br>"));
		
		Qna answerDto = service.readQnaAnswer(questionDto.getQnaNum());
		if(answerDto!=null) {
			answerDto.setContent(answerDto.getContent().replaceAll("\n", "<br>"));
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("num", questionDto.getQnaNum());
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		Qna preReadDto = service.preReadQnaQuestion(map);
		Qna nextReadDto = service.nextReadQnaQuestion(map);
		
		model.addAttribute("questionDto", questionDto);
		model.addAttribute("answerDto", answerDto);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto", nextReadDto);
		model.addAttribute("pageNo", pageNo);
		
		return ".qna.article";
	}
	
	@RequestMapping(value="/qna/update", method=RequestMethod.GET)
	public String updateQnaForm(
			@RequestParam int qnaNum,
			@RequestParam String pageNo,
			HttpSession session,
			Model model) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Qna dto = service.readQnaQuestion(qnaNum);
		if(dto==null) {
			return ".qna.list";
		}
		
		if(! info.getUserId().equals(dto.getUserId())) {
			return ".qna.list";
		}
		
		List<Qna> listCategory = service.listQnaCategory();
		
		model.addAttribute("mode", "update");
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("dto", dto);		
		model.addAttribute("listCategory", listCategory);
		
		return ".qna.created";
	}
	
	@RequestMapping(value="/qna/update", method=RequestMethod.POST)
	public String updateQnaSubmit(
			@RequestParam String pageNo,
			Qna dto,
			HttpSession session) throws Exception {
		
		try {
			SessionInfo info=(SessionInfo)session.getAttribute("member");
			dto.setUserId(info.getUserId());
			service.updateQna(dto);
		} catch (Exception e) {
		}
		return "redirect:/qna/list?pageNo="+pageNo;
	}
	
	@RequestMapping(value="/qna/answer", method=RequestMethod.GET)
	public String qnaAnswerForm(
			@RequestParam int qnaNum,
			@RequestParam String pageNo,
			HttpSession session,
			Model model) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Qna dto = service.readQnaQuestion(qnaNum);
		if(dto==null) {
			return ".qna.list";
		}
		
		if(! info.getUserId().equals("admin")) {
			return ".qna.list";
		}
		
		dto.setContent("["+dto.getSubject()+"] 에 대한 답변입니다.\n");
		
		List<Qna> listCategory = service.listQnaCategory();
		
		model.addAttribute("mode", "answer");
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("dto", dto);		
		model.addAttribute("listCategory", listCategory);		

		return ".qna.created";
	}
	
	@RequestMapping(value="/qna/answer", method=RequestMethod.POST)
	public String qnaAnswerSubmit(
			Qna dto,
			HttpSession session) throws Exception {
		try {
			SessionInfo info=(SessionInfo)session.getAttribute("member");
			dto.setUserId(info.getUserId());
			service.insertQna(dto);
		} catch (Exception e) {
		}
		return "redirect:/qna/list";
	}
	
	@RequestMapping(value="/qna/delete", method=RequestMethod.POST)
	public String deleteQna(
			@RequestParam int qnaNum,
			@RequestParam String mode,
			HttpSession session) throws Exception {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		Qna dto = service.readQnaQuestion(qnaNum);
		if(dto!=null) {
			if(info.getUserId().equals(dto.getUserId())||info.getUserId().equals("admin")) {
				try {
					if(mode.equals("question")) {
						service.deleteQnaQuestion(qnaNum);
					} else if(mode.equals("answer")) {
						service.deleteQnaAnswer(qnaNum);;
					}
				} catch (Exception e) {
				}
			}
		}
		return "redirect:/qna/list";
	}
	
	@RequestMapping(value="/faq/list")
	public String faqList(
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			Model model) throws Exception {
		
		return ".faq.list";
	}
	
}
