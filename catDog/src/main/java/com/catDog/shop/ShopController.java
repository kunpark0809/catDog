package com.catDog.shop;

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.catDog.common.MyUtil;
import com.catDog.customer.SessionInfo;

@Controller("shop.shopController")
public class ShopController {
	@Autowired
	private ShopService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="/shop/list")
	public String list(
			@RequestParam(defaultValue="1") String bigSortNum,
			@RequestParam(defaultValue="0") int smallSortNum,
			@RequestParam(defaultValue="1", name="page") int current_page,
			HttpServletRequest req,
			Model model
			) throws Exception{
		String cp = req.getContextPath();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bigSortNum", bigSortNum);
		map.put("smallSortNum", smallSortNum);
		
		List<Shop> smallSortList = service.smallSortList(bigSortNum);
		
		int dataCount = service.dataCount(map);
		
		
		int rows = 15;
		int offset = (current_page-1)*rows;
		if(offset  < 0) offset = 0;
		
		int total_page = myUtil.pageCount(rows, dataCount);
		
		map.put("rows", rows);
		map.put("offset", offset);
		
		List<Shop> list = service.listDogProduct(map);
		
		String query = "bigSortNum="+bigSortNum+"&smallSortNum="+smallSortNum;
		String listUrl = cp+"/shop/list?"+query;
		String articleUrl = cp+"/shop/article?page="+current_page+"&"+query;
		
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		
		model.addAttribute("list",list);
		model.addAttribute("smallSortList",smallSortList);
		model.addAttribute("dataCount",dataCount);
		model.addAttribute("total_page",total_page);
		model.addAttribute("articleUrl",articleUrl);
		model.addAttribute("paging",paging);
		model.addAttribute("smallSortNum",smallSortNum);
		model.addAttribute("bigSortNum",bigSortNum);
		model.addAttribute("page",current_page);
		return ".shop.list";
	}
	
	@RequestMapping(value="/shop/smallSort", method=RequestMethod.GET)
	@ResponseBody
	public Map<String,Object> smallSortList(
			@RequestParam String bigSortNum
			) throws Exception{
		
		List<Shop> smallSortList = service.smallSortList(bigSortNum);
		
		Map<String,Object> model = new HashMap<>();
		model.put("smallSortList", smallSortList);
		return model;
	}
	
	@RequestMapping(value="/shop/created", method=RequestMethod.GET)
	public String createdForm(
			Model model
			) throws Exception{
		List<Shop> bigSortList = service.bigSortList();
		
		model.addAttribute("bigSortList",bigSortList);
		model.addAttribute("mode","created");
		return ".shop.created";
	}
	
	@RequestMapping(value="/shop/created", method=RequestMethod.POST)
	public String createdSubmit(
			Shop dto,
			HttpSession session
			) throws Exception{
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root+"uploads"+File.separator+"shop";
		try {
			service.insertProduct(dto, pathname);
		} catch (Exception e) {
		}
		return "redirect:/shop/list?bigSortNum="+dto.getBigSortNum();
	}
	
	@RequestMapping(value="/shop/article")
	public String article(
			@RequestParam(defaultValue="1") String bigSortNum,
			@RequestParam(defaultValue="0") int smallSortNum,
			@RequestParam int productNum,
			@RequestParam(defaultValue="1") String page,
			Model model
			) throws Exception{
		
		
		Shop dto = service.readProduct(productNum);
		
		String query = "bigSortNum="+bigSortNum+"&smallSortNum="+smallSortNum+"&page="+page;
		if(dto==null) {
			return "redirect:/shop/list?"+query;
		}

		List<Shop> picList = service.readProductPic(productNum);
		
		model.addAttribute("bigSortNum",bigSortNum);
		model.addAttribute("smallSortNum",smallSortNum);
		model.addAttribute("page",page);
		model.addAttribute("query",query);
		model.addAttribute("picList", picList);
		model.addAttribute("dto", dto);
		return ".shop.article";
	}
	
	@RequestMapping(value="/shop/update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam(defaultValue="1") String bigSortNum,
			@RequestParam(defaultValue="0") String smallSortNum,
			@RequestParam int productNum,
			@RequestParam(defaultValue="1") String page,
			Model model
			) throws Exception{
		
		Shop dto = service.readProduct(productNum);
		List<Shop> picList = service.readProductPic(productNum);
		List<Shop> bigSortList = service.bigSortList();
		List<Shop> smallSortList = service.smallSortList(dto.getBigSortNum());
		
		model.addAttribute("bigSortList",bigSortList);
		model.addAttribute("bigSortNum",bigSortNum);
		model.addAttribute("smallSortList",smallSortList);
		model.addAttribute("smallSortNum",smallSortNum);
		model.addAttribute("picList", picList);
		model.addAttribute("dto", dto);
		model.addAttribute("mode","update");
		model.addAttribute("page",page);
		return ".shop.created";
	}
	
	@RequestMapping(value="/shop/update", method=RequestMethod.POST)
	public String updateSubmit(
			@RequestParam(defaultValue="1") String bigSortNum,
			Shop dto,
			HttpSession session
			) throws Exception{
		String root = session.getServletContext().getRealPath("/");
		String pathname = root+"uploads"+File.separator+"shop";
		
		service.updateproduct(dto, pathname);

		return "redirect:/shop/list?bigSortNum="+bigSortNum;
	}
	
	@RequestMapping(value="/shop/delete", method=RequestMethod.GET)
	public String delete(
			@RequestParam(defaultValue="1") String bigSortNum,
			@RequestParam int productNum,
			HttpSession session,
			Model model
			) throws Exception{
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root+"uploads"+File.separator+"shop";
		
		service.deleteProduct(productNum, pathname, info.getUserId());
		
		return "redirect:/shop/list?bigSortNum="+bigSortNum;
	}
	
	@RequestMapping(value="/shop/deleteFile", method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> deleteFile(
			@RequestParam String picNum,
			HttpSession session
			) throws Exception{
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root+"uploads"+File.separator+"shop";
		String state = "false";
		
		try {
			service.deleteImgFile(picNum, pathname, info.getUserId());
			state = "true";
		} catch (Exception e) {
		}
		
		Map<String,Object> model = new HashMap<>();
		model.put("state", state);
		
		return model;
	}
	
	@RequestMapping(value="/shop/insertReview", method=RequestMethod.POST)
	public String insertReview(
			Shop dto,
			HttpSession session
			)throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		dto.setNum(info.getMemberIdx());
		try {
			service.insertReview(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/mypage/requestCheck";
	}
	
	@RequestMapping(value="/shop/listRate")
	public String listRate(	
			@RequestParam int productNum,
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			Model model
			)throws Exception{
		
		
		Map<String,Object> map = new HashMap<>();
		map.put("productNum", productNum);
		int reivewCount = service.reviewCount(map);
		int rows = 10;
		int total_page=myUtil.pageCount(rows, reivewCount);
		int offset = (current_page-1)*rows;
		if(offset<0) offset=0;
		
		map.put("rows", rows);
		map.put("offset", offset );
		List<Shop> reviewList = service.reviewList(map);
		
		for(Shop dto : reviewList) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		
		String paging = myUtil.pagingMethod(current_page, total_page, "listReview");
		
		model.addAttribute("reivewCount",reivewCount);
		model.addAttribute("total_page",total_page);
		model.addAttribute("reviewList",reviewList);
		model.addAttribute("paging",paging);
		
		return "/shop/review";
	}
}
