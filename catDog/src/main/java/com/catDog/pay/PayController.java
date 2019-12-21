package com.catDog.pay;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.catDog.customer.SessionInfo;

@Controller("pay.payController")
public class PayController {
	@Autowired
	private PayService service;
	
	@RequestMapping(value="/pay/pay", method=RequestMethod.GET)
	public String payForm(
			@RequestParam int productNum,
			@RequestParam int quantity,
			Model model,
			HttpSession session
			) throws Exception{
		Pay product = service.readProudct(productNum);
		product.setProductCount(quantity);
		product.setProductSum(product.getPrice()*quantity);
		product.setPoint((int)(product.getProductSum() * 0.01));
		product.setTotal(product.getProductSum()+2500);
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		Pay customer = null;
		if(info != null) {
			customer = service.readCustomer(info.getMemberIdx());
		}
		model.addAttribute("customer",customer);
		model.addAttribute("product",product);
		return ".pay.pay";
	}
	
	@RequestMapping(value="/pay/pay", method=RequestMethod.POST)
	public String paySubmit(
			@RequestParam String productNum, 
			Pay pay
			) throws Exception{

		pay.setPoint(pay.getPoint()-pay.getUsePoint());	
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
