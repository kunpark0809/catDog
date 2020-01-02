package com.catDog.pay;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.catDog.customer.SessionInfo;

@Controller("pay.payController")
public class PayController {
	@Autowired
	private PayService service;
	
	@RequestMapping(value="/pay/cart")
	public String cart(
			HttpSession session,
			Model model 
			) throws Exception{
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		List<Pay> cartList = null;
		if(info != null) {
			cartList = service.cartList(info.getMemberIdx());
		}
		model.addAttribute("cartList",cartList);
		return ".pay.cart";
	}
	
	@RequestMapping(value="/pay/insertCart")
	@ResponseBody
	public void insertCart(
			@RequestParam int productNum,
			@RequestParam int productCount,
			HttpSession session
			) throws Exception{
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		Pay product = service.readProudct(productNum);
		product.setProductCount(productCount);
		product.setProductSum(product.getPrice()*productCount);
		product.setNum(info.getMemberIdx());
		service.insertCart(product);
	}
	
	@RequestMapping(value="/pay/deleteCart")
	public String deleteCart(
			@RequestParam List<String> productCheck,
			HttpSession session
			) throws Exception{
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		Map<String, Object> map = new HashMap<>();
		map.put("num", info.getMemberIdx());
		map.put("list", productCheck);
		service.deleteCart(map);
		
		return "redirect:/pay/cart";
	}
	
	@RequestMapping(value="/pay/direct/pay", method=RequestMethod.GET)
	public String payForm(
			@RequestParam int productNum,
			@RequestParam int productCount,
			Model model,
			HttpSession session
			) throws Exception{
		Pay product = service.readProudct(productNum);
		product.setProductCount(productCount);
		product.setProductSum(product.getPrice()*productCount);
		product.setPoint((int)(product.getProductSum() * 0.01));
		product.setTotal(product.getProductSum()+2500);
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		Pay customer = null;
		if(info != null) {
			product.setNum(info.getMemberIdx());
			customer = service.readCustomer(info.getMemberIdx());
		}
		model.addAttribute("customer",customer);
		model.addAttribute("product",product);
		model.addAttribute("mode","direct");
		return ".pay.pay";
	}
	
	@RequestMapping(value="/pay/cart/payForm", method=RequestMethod.POST)
	public String payForm(
			@RequestParam List<String> productCheck,
			Model model,
			HttpSession session
			) throws Exception{
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		Pay customer = null;
		Map<String, Object> map = new HashMap<>();
		map.put("list", productCheck);
		
		if(info != null) {
			map.put("num", info.getMemberIdx());
			customer = service.readCustomer(info.getMemberIdx());
			List<Pay> cartList=service.cartPayList(map);
			model.addAttribute("cartList",cartList);
		}
		model.addAttribute("customer",customer);
		model.addAttribute("mode","cart");
		return ".pay.pay";
	}
	
	@RequestMapping(value="/pay/direct/pay", method=RequestMethod.POST)
	public String paySubmit(
			@RequestParam String productNum, 
			Pay pay,
			HttpSession session
			) throws Exception{

		pay.setPoint(pay.getPoint()-pay.getUsePoint());	
		SessionInfo info = (SessionInfo)session.getAttribute("member");
	
		if(info != null) {
			pay.setNum(info.getMemberIdx());
			pay.setUserId(info.getUserId());
		}
		
		String requestNum = service.insertRequest(pay);
		service.insertRequestDetail(pay);
		return "redirect:/pay/complete?requestNum="+requestNum;
	}

	@RequestMapping(value="/pay/cart/pay", method=RequestMethod.POST)
	public String paySubmit( 
			@RequestParam List<String> payCartNum,
			Pay pay,
			HttpSession session
			) throws Exception{

		pay.setPoint(pay.getPoint()-pay.getUsePoint());	
		SessionInfo info = (SessionInfo)session.getAttribute("member");
	
		if(info != null) {
			pay.setNum(info.getMemberIdx());
			pay.setUserId(info.getUserId());
		}
		
		String requestNum = service.insertRequest(pay);
				
		for(String ss : payCartNum) {
			Pay dto = service.readCart(ss);
			dto.setRequestNum(requestNum);
			service.insertRequestDetail(dto);
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", payCartNum);
		map.put("num", info.getMemberIdx());
		service.deleteCart(map);
		return "redirect:/pay/complete?requestNum="+requestNum;
	}
	
	@RequestMapping(value="/pay/complete", method=RequestMethod.GET)
	public String payComplete(
			@RequestParam String requestNum,
			Model model
			) throws Exception{
		List<Pay> list = service.requestList(requestNum);
		if(list==null || list.size()==0) {
			return "redirect:/";
		}
		model.addAttribute("list",list);
		return ".pay.complete";
	}
	
	@RequestMapping(value="/pay/changeCount", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> changeCountForm(
			@RequestParam int productNum
			){
		Pay product = service.readProudct(productNum);
		
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("product", product);
		return model;
	}
	
	@RequestMapping(value="/pay/changeCount", method=RequestMethod.POST)
	public String changeCountSubmit(
			Pay pay,
			HttpSession session
			){
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		pay.setNum(info.getMemberIdx());
		
		try {
			service.updateCount(pay);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/pay/cart";
	}
}
