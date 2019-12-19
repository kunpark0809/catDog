package com.catDog.pay;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller("pay.payController")
public class PayController {
	@Autowired
	private PayService service;
	
	@RequestMapping(value="/pay/pay", method=RequestMethod.GET)
	public String payForm(
			@RequestParam int productNum,
			@RequestParam int quantity,
			Model model
			) throws Exception{
		Pay product = service.readProudct(productNum);
		product.setProductCount(quantity);
		product.setProductSum(product.getPrice()*quantity);
		product.setPoint((int)(product.getProductSum() * 0.01));
		model.addAttribute("product",product);
		return ".pay.pay";
	}
	
	@RequestMapping(value="/pay/pay", method=RequestMethod.POST)
	public String paySubmit(
			@RequestParam String productNum 
			) throws Exception{
		return ".pay.pay";
	}
	
	@RequestMapping(value="/pay/complete")
	public String payComplete(
			@RequestParam String productNum 
			) throws Exception{
		return ".pay.complete";
	}
}
