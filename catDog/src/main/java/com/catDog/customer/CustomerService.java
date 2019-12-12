package com.catDog.customer;

public interface CustomerService {
	public Customer loginCustomer(String userId) throws Exception;

	public Customer readCustomer(String userId) throws Exception;

	public Customer nickNameCheck(String nickName) throws Exception;

	void insertMember(Customer dto, String pathname) throws Exception;
}
