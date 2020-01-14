package com.catDog.pet;

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

@Controller("pet.PetController")
public class PetController {
	
@Autowired
private PetService service;

@Autowired
private MyUtil myUtil;

@RequestMapping(value="/pet/list")
public String list(
		@RequestParam(value="page", defaultValue="1") int current_page,
		@RequestParam(defaultValue="all") String condition,
		@RequestParam(defaultValue="") String keyword,
		HttpServletRequest req,
		Model model) throws Exception {

	String cp = req.getContextPath();

	int rows = 12;
	int total_page;
	int dataCount;

	if(req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
		keyword = URLDecoder.decode(keyword, "utf-8");
	}
	
    // 전체 페이지 수
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("condition", condition);
    map.put("keyword", keyword);

	dataCount = service.dataCount(map);
	total_page = myUtil.pageCount(rows, dataCount);

	if (total_page < current_page)
		current_page = total_page;

    int offset = (current_page-1) * rows;
	if(offset < 0) offset = 0;
    map.put("offset", offset);
    map.put("rows", rows);

	List<Pet> list = service.listPet(map);

	// 글번호 만들기
	int listNum, n = 0;
	for(Pet dto : list) {
		listNum = dataCount - (offset + n);
		dto.setListNum(listNum);
		n++;
	}

    String query = "";
    String listUrl = cp+"/pet/list";
    String articleUrl = cp+"/pet/article?page=" + current_page;
    if(keyword.length()!=0) {
    	query = "condition=" +condition + 
    	           "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
    }
    
    if(query.length()!=0) {
    	listUrl = cp+"/pet/list?" + query;
    	articleUrl = cp+"/pet/article?page=" + current_page + "&"+ query;
    }
	
    String paging = myUtil.paging(current_page, total_page, listUrl);
    		
	model.addAttribute("list", list);
	model.addAttribute("dataCount", dataCount);
	model.addAttribute("total_page", total_page);
	model.addAttribute("articleUrl", articleUrl);
	model.addAttribute("page", current_page);
	model.addAttribute("paging", paging);
	
	model.addAttribute("condition", condition);
	model.addAttribute("keyword", keyword);
	
	return ".pet.list";
}
	
	@RequestMapping(value="/pet/created", method=RequestMethod.GET)
	public String createdForm(
			HttpSession session,
			Model model) throws Exception {
		
		model.addAttribute("mode", "created");
		return ".pet.created";
	}
	
	@RequestMapping(value="/pet/created", method=RequestMethod.POST)
	public String createdSubmit(
			Pet dto,
			HttpSession session) throws Exception {
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"pet";
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		try {
			dto.setNum(info.getMemberIdx());
			service.insertPet(dto, pathname);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/pet/list";
	}

	@RequestMapping(value="/pet/article", method=RequestMethod.GET)
	public String article(
			@RequestParam int myPetNum,
			@RequestParam(defaultValue="1") String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			Model model
			) throws Exception{
		Pet dto = service.readPet(myPetNum);
		
		String query="page="+page;
		if(dto == null) {
			return "redirect:/pet/list?"+query;
		}
		
		service.updateHitCount(myPetNum);
		dto.setPetLikeCount(service.petLikeCount(myPetNum));
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("myPetNum", myPetNum);
		
		Pet preReadPet = service.preReadPet(map);
		Pet nextReadPet = service.nextReadPet(map);
		
		model.addAttribute("preReadPet", preReadPet);
		model.addAttribute("nextReadPet", nextReadPet);
		
		model.addAttribute("page",page);
		model.addAttribute("query",query);
		model.addAttribute("dto",dto);
		
		return ".pet.article";
	}
	
	@RequestMapping(value="/pet/delete", method=RequestMethod.GET)
	public String delete(
			@RequestParam int myPetNum,
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
		String pathname=root+"uploads"+File.separator+"pet";
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		try {
			service.deletePet(myPetNum, pathname, info.getUserId());
		} catch (Exception e) {
		}
		
		return "redirect:/pet/list?"+query;
	}
	
	@RequestMapping(value="/pet/update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam int myPetNum,
			@RequestParam String page,
			HttpSession session,
			Model model
			) throws Exception {

		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Pet dto = service.readPet(myPetNum);
		if (dto == null)
			return "redirect:/pet/list?page="+page;

		if(! dto.getUserId().equals(info.getUserId())) {
			return "redirect:/pet/list?page="+page;
		}
		
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("mode", "update");
		
		return ".pet.created";
	}
	
	@RequestMapping(value="/pet/update", method=RequestMethod.POST)
	public String updateSubmit(
			Pet dto,
			@RequestParam String page,
			HttpSession session
			) throws Exception {
	
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"pet";
		
		try {
			service.updatePet(dto, pathname);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/pet/article?myPetNum="+dto.getMyPetNum()+"&page="+page;
	}

	// 게시글 좋아요 추가 :  : AJAX-JSON
	@RequestMapping(value="/pet/insertPetLike", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertPetLike(
			@RequestParam int myPetNum,
			HttpSession session
			) {
		String state="true";
		int petLikeCount=0;
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Map<String, Object> paramMap=new HashMap<>();
		paramMap.put("myPetNum", myPetNum);
		paramMap.put("num", info.getMemberIdx());
		
		try {
			service.insertPetLike(paramMap);
		} catch (Exception e) {
			state="false";
		}
			
		petLikeCount = service.petLikeCount(myPetNum);
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		model.put("petLikeCount", petLikeCount);
		
		return model;
	}
	
	
	// 게시글 신고추가 :  : AJAX-JSON
	@RequestMapping(value="/pet/insertPetReport", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertPetReport(
			@RequestParam int reportedPostNum,
			@RequestParam int reporterNum,
			@RequestParam int reportedNum,
			@RequestParam int reasonSortNum,
			HttpSession session
			) {
		String state="true";
		int petReportCount=0;
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Map<String, Object> paramMap=new HashMap<>();
		paramMap.put("reportedPostNum", reportedPostNum);
		paramMap.put("reporterNum", info.getMemberIdx());
		paramMap.put("reportedNum", reportedNum);
		paramMap.put("reasonSortNum", reasonSortNum);
		
		try {
			service.insertPetReport(paramMap);
		} catch (Exception e) {
			state="false";
		}

		petReportCount = service.petReportCount(reportedPostNum);

		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		model.put("petReportCount", petReportCount);

		return model;
	}
	
}