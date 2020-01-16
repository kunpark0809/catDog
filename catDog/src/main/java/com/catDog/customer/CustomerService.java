package com.catDog.customer;

import java.util.List;
import java.util.Map;

public interface CustomerService {
	public Customer loginCustomer(String userId) throws Exception;

	public Customer readCustomer(String userId) throws Exception;

	public Customer nickNameCheck(String nickName) throws Exception;

	public void insertMember(Customer dto, String pathname) throws Exception;

	public void updateEnabled(Map<String, Object> map) throws Exception;

	public int failureCount(String userId);

	public void failureReset(String userId) throws Exception;

	public void updateFailure(String userId) throws Exception;

	public List<Customer> listMemberState(String userId);

	public Customer readMemberState(String userId);

	public void deleteCustomerDetail(int num) throws Exception;

	public void deleteMemberDetail(int num) throws Exception;

	public void insertMemberState(Customer customer) throws Exception;

	public void updateFailureReset(String userId) throws Exception;

	public void updateLastLogin(String userId) throws Exception;

	public void updatePwd(Customer dto) throws Exception;

	public void generatePwd(Customer dto) throws Exception;

	public String findId(Map<String, Object> map) throws Exception;

}
