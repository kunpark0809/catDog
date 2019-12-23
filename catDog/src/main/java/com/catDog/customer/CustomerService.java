package com.catDog.customer;

import java.util.List;
import java.util.Map;

public interface CustomerService {
	public Customer loginCustomer(String userId) throws Exception;

	public Customer readCustomer(String userId) throws Exception;

	public Customer nickNameCheck(String nickName) throws Exception;

	void insertMember(Customer dto, String pathname) throws Exception;

	void updateEnabled(Map<String, Object> map) throws Exception;

	int failureCount(String userId);

	void failureReset(String userId) throws Exception;

	void updateFailure(String userId) throws Exception;

	List<Customer> listMemberState(String userId);

	Customer readMemberState(String userId);

	void deleteCustomerDetail(int num) throws Exception;

	void deleteMemberDetail(int num) throws Exception;

	void insertMemberState(Customer customer) throws Exception;

	void updateFailureReset(String userId) throws Exception;

	void updateLastLogin(String userId) throws Exception;

	void updatePwd(Customer dto) throws Exception;

	void generatePwd(Customer dto) throws Exception;

}
