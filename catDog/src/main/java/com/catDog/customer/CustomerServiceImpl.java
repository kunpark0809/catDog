package com.catDog.customer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.catDog.common.dao.CommonDAO;

@Service("customer.customerService")
public class CustomerServiceImpl implements CustomerService {
	
	@Autowired
	private  CommonDAO dao;

	@Override
	public Customer loginCustomer(String userId) {
		Customer dto=null;
		
		try {
			dto=dao.selectOne("customer.loginCustomer", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public Customer readCustomer(String userId) {
		Customer dto=null;
		
		try {
			dto=dao.selectOne("customer.readCustomer", userId);
			
			if(dto!=null) {
				if(dto.getEmail()!=null) {
					String [] s=dto.getEmail().split("@");
					dto.setEmail1(s[0]);
					dto.setEmail2(s[1]);
				}

				if(dto.getTel()!=null) {
					String [] s=dto.getTel().split("-");
					dto.setTel1(s[0]);
					dto.setTel2(s[1]);
					dto.setTel3(s[2]);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}


}
