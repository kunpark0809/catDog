package com.catDog.pay;

import java.util.List;

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
		List<Pay> cartList = service.cartList(info.getMemberIdx());
		
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
	
	@RequestMapping(value="/pay/pay", method=RequestMethod.GET)
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
			customer = service.readCustomer(info.getMemberIdx());
			service.insertCart(product);
		}
		model.addAttribute("customer",customer);
		model.addAttribute("product",product);
		return ".pay.pay";
	}
	
	@RequestMapping(value="/pay/pay", method=RequestMethod.POST)
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
		
		service.insertRequest(pay);
		return ".pay.complete";
	}
	
	@RequestMapping(value="/pay/complete")
	public String payComplete(
			@RequestParam String productNum 
			) throws Exception{
		return ".pay.complete";
	}
}
