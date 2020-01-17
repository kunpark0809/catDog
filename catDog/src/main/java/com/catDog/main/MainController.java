package com.catDog.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.catDog.cafe.Cafe;
import com.catDog.cafe.CafeService;
import com.catDog.cs.CsService;
import com.catDog.cs.Notice;
import com.catDog.park.Park;
import com.catDog.park.ParkService;
import com.catDog.pet.Pet;
import com.catDog.pet.PetService;
import com.catDog.shop.Shop;
import com.catDog.shop.ShopService;
import com.catDog.training.Training;
import com.catDog.training.TrainingService;

@Controller("mainController")
public class MainController {
	
	@Autowired
	private ParkService parkService;
	
	@Autowired
	private CsService service;
	
	@Autowired
	private ShopService shopService;
	
	@Autowired
	private PetService petService;
	
	@Autowired
	private CafeService cafeService;
	
	@Autowired
	private TrainingService trainingService;
	 
	@RequestMapping(value="/main", method=RequestMethod.GET)
	public String method(HttpServletRequest req,
			Model model) {
		String cp = req.getContextPath();
		
		int rows = 5;
		Map<String, Object> noticeMap = new HashMap<String, Object>();		
		noticeMap.put("offset", 0);
		noticeMap.put("rows", rows);
		
		List<Notice> noticeList = service.listNotice(noticeMap);
		
		String noticeListUrl = cp+"/notice/article?page=1";
		
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("noticeListUrl", noticeListUrl);
		
		Map<String, Object> parkMap = new HashMap<String, Object>();
		parkMap.put("offset", 0);
		parkMap.put("rows", 1);
		
		List<Park> parkList = parkService.listPark(parkMap);
		
		String parkListUrl = cp+"/park/article?page=1";
		
		model.addAttribute("parkList", parkList);
		model.addAttribute("parkListUrl", parkListUrl);
		
		Map<String, Object> reviewMap = new HashMap<String, Object>();
		reviewMap.put("offset", 0);
		reviewMap.put("rows", rows);
		
		List<Shop> reviewList = shopService.listAllReview(reviewMap);
		
		String reviewListUrl = cp+"/shop/article?";
		
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("reviewListUrl", reviewListUrl);
		
		Map<String, Object> dogProductMap = new HashMap<String, Object>();
		dogProductMap.put("smallSortNum", 0);
		dogProductMap.put("bigSortNum", 1);
		dogProductMap.put("offset", 0);
		dogProductMap.put("rows", 6);
		
		List<Shop> dogProductList = shopService.listDogProduct(dogProductMap);
		
		String dogProductListUrl = cp+"/shop/article?";
		
		model.addAttribute("dogProductList", dogProductList);
		model.addAttribute("dogProductListUrl", dogProductListUrl);
		
		Map<String, Object> catProductMap = new HashMap<String, Object>();
		catProductMap.put("smallSortNum", 0);
		catProductMap.put("bigSortNum", 0);
		catProductMap.put("offset", 0);
		catProductMap.put("rows", 6);
		
		List<Shop> catProductList = shopService.listDogProduct(catProductMap);
		
		String catProductListUrl = cp+"/shop/article?";
		
		model.addAttribute("catProductList", catProductList);
		model.addAttribute("catProductListUrl", catProductListUrl);
		
		Pet cat = petService.readPet(7);
		Pet dog = petService.readPet(33);
		
		String catUrl = cp+"/pet/article?myPetNum=7";
		String dogUrl = cp+"/pet/article?myPetNum=33";
		
		model.addAttribute("cat", cat);
		model.addAttribute("catUrl", catUrl);
		model.addAttribute("dog", dog);
		model.addAttribute("dogUrl", dogUrl);
		
		Cafe cafe = cafeService.readCafe(71);
		String cafeUrl = cp+"/cafe/article?recommendNum=71";
		
		model.addAttribute("cafe", cafe);
		model.addAttribute("cafeUrl", cafeUrl);
		
		Training training = trainingService.readTraining(80);
		String trainingUrl = cp+"/training/article?recommendNum=80";
		
		model.addAttribute("training", training);
		model.addAttribute("trainingUrl", trainingUrl);
		
		return ".mainLayout";
	}
}
