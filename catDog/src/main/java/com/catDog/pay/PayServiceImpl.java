package com.catDog.pay;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.catDog.common.dao.CommonDAO;

@Service("pay.payService")
public class PayServiceImpl implements PayService{
	
	@Autowired
	private CommonDAO dao;
	
	@Override
	public Pay readProudct(int productNum) {
		Pay dto = null;
		try {
			dto = dao.selectOne("pay.readProduct", productNum); 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

}
