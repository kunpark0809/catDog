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

	public List<Money> monthSales(Map<String, Object> map);

	public String getCategory(int smallSortNum);

	Money categorySalesVolume(Map<String, Object> map);

	Money categorySales(Map<String, Object> map);

}
