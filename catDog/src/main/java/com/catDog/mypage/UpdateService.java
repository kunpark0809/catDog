package com.catDog.mypage;

import com.catDog.customer.Customer;


public interface UpdateService {
	void updateMemberDetail(Customer dto, String pathname) throws Exception;
	Customer readCustomer(String userId);
	
	
}
