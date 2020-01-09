package com.catDog.admin;

import java.util.List;
import java.util.Map;

public interface AdminService {

	public Money calculateProduct(Map<String, Object> map);

	public List<Member> memberList(Map<String, Object> map);

	public int memberCount(Map<String, Object> map);

	public List<Report> reportList(Map<String, Object> map);

	public int reportCount(Map<String, Object> map);

	public int yearSales(String year);

	public String getCategory(int smallSortNum);

	public Money categorySalesVolume(Map<String, Object> map);

	public Money categorySales(Map<String, Object> map);

	public int quarterSales(int yearMonth);

	int quarterSalesToToday(Map<String, Object> map);

	public List<Money> monthSalesByCategory(Map<String, Object> map);

	public int totalSales();

	public int totalSalesVolume();

	public int yearSalesVolume(String year);

	public int monthSales(String yearMonth);

	public int monthSalesVolume(String yearMonth);

	public int daySalesVolume(String day);

	public int daySales(String day);

	public int weekSales(Map<String, Object> map);

	public int weekSalesVolume(Map<String, Object> map);

	public int requestCount(Map<String, Object> map);

	public List<Shop> requestList(Map<String, Object> map);

	public List<Shop> requestDetailList(int requestNum);

	public int selectBbs(int bbsNum);

	public int selectMyPet(int myPetNum);

	public int selectTip(int tipNum);

	public List<Report> totalReportList(Map<String, Object> map);

	public void deleteTip(int reportedPostNum) throws Exception;

	public void deleteMyPet(int reportedPostNum) throws Exception;

	public void deleteBbs(int reportedPostNum) throws Exception;

	public void updateReport(Map<String, Object> map) throws Exception;

	public void updateWarn(String reportedId) throws Exception;

	public int checkReportCount(String reportedId);

	public void deactivateWarn(String reportedId) throws Exception;

}
