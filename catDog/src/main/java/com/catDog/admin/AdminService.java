package com.catDog.admin;

import java.util.List;
import java.util.Map;

public interface AdminService {

	public Money calculateProduct(Map<String, Object> map);

	public List<Member> memberList(Map<String, Object> map);

	public int memberCount(Map<String, Object> map);

	public List<Report> reportList(Map<String, Object> map);

	public int reportCount(Map<String, Object> map);


	public int quarterSales(String yearMonth);

	public int yearSales(String year);

	public int monthSales(String yearMonth);

	

}
