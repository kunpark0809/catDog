package com.catDog.admin;

import java.util.List;
import java.util.Map;

public interface AdminService {

	public Money calculateProduct(Map<String, Object> map);

	List<Member> memberList(Map<String, Object> map);

	int memberCount(Map<String, Object> map);

	List<Report> reportList(Map<String, Object> map);

	int reportCount(Map<String, Object> map);


	int quarterSales(int yearMonth);

	int yearSales(int year);

	int monthSales(int yearMonth);

	

}
