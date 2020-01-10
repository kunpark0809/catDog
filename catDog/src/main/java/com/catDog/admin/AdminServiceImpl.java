package com.catDog.admin;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.catDog.common.dao.CommonDAO;

@Service("admin.adminService")
public class AdminServiceImpl implements AdminService {

	@Autowired
	private CommonDAO dao;

	@Override
	public int daySales(String day) {
		int result = 0;

		try {
			result = dao.selectOne("admin.daySales", day);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public int daySalesVolume(String day) {
		int result = 0;

		try {
			result = dao.selectOne("admin.daySalesVolume", day);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public int weekSales(Map<String, Object> map) {
		int result = 0;

		try {
			result = dao.selectOne("admin.weekSales", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public int weekSalesVolume(Map<String, Object> map) {
		int result = 0;

		try {
			result = dao.selectOne("admin.weekSalesVolume", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public int monthSales(String yearMonth) {
		int result = 0;

		try {
			result = dao.selectOne("admin.monthSales", yearMonth);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public int monthSalesVolume(String yearMonth) {
		int result = 0;

		try {
			result = dao.selectOne("admin.monthSalesVolume", yearMonth);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	// smallSortNum과 year를 map에 넣으면 해당 year에 상품소분류가 smallSortNum인 상품의 총매출을 월별로 산출.
	// List<Money>로 리턴. 각각의 Money 객체는 한 월의 해당 소분류 총매출이며 해당 월에 매출이 0이면 출력하지 않음.
	@Override
	public List<Money> monthSalesByCategory(Map<String, Object> map) {
		List<Money> list = null;

		try {
			list = dao.selectList("admin.monthSalesByCategory", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public int quarterSales(int yearMonth) {
		int result = 0;

		try {
			result = dao.selectOne("admin.quarterSales", yearMonth);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public int quarterSalesToToday(Map<String, Object> map) {
		int result = 0;

		try {
			result = dao.selectOne("admin.quarterSalesToToday", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public int yearSales(String year) {
		int result = 0;

		try {
			result = dao.selectOne("admin.yearSales", year);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public int yearSalesVolume(String year) {
		int result = 0;

		try {
			result = dao.selectOne("admin.yearSalesVolume", year);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public Money categorySales(Map<String, Object> map) {
		Money result = null;

		try {
			result = dao.selectOne("admin.categorySales", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public Money categorySalesVolume(Map<String, Object> map) {
		Money result = null;

		try {
			result = dao.selectOne("admin.categorySalesVolume", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public String getCategory(int smallSortNum) {
		String result = null;

		try {
			result = dao.selectOne("admin.getCategory", smallSortNum);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public Money calculateProduct(Map<String, Object> map) {
		Money money = null;

		try {
			money = dao.selectOne("admin.calculateProduct", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return money;
	}

	@Override
	public int totalSales() {
		int result = 0;

		try {
			result = dao.selectOne("admin.totalSales");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public int totalSalesVolume() {
		int result = 0;

		try {
			result = dao.selectOne("admin.totalSalesVolume");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public List<Member> memberList(Map<String, Object> map) {
		List<Member> list = null;

		try {
			list = dao.selectList("admin.memberList", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public int memberCount(Map<String, Object> map) {
		int result = -1;
		try {
			result = dao.selectOne("admin.memberCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public List<Report> reportList(Map<String, Object> map) {
		List<Report> list = null;

		try {
			list = dao.selectList("admin.reportList", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public List<Report> totalReportList(Map<String, Object> map) {
		List<Report> list = null;

		try {
			list = dao.selectList("admin.totalReportList", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public void updateReport(Map<String, Object> map) throws Exception {

		try {
			dao.updateData("admin.updateReport", map);
		} catch (Exception e) {
			throw e;
		}

	}

	@Override
	public void updateWarn(String reportedId) throws Exception {

		try {
			dao.updateData("admin.updateWarn", reportedId);
		} catch (Exception e) {
			throw e;
		}

	}
	
	@Override
	public void deactivateWarn(String reportedId) throws Exception {

		try {
			dao.updateData("admin.deactivateWarn", reportedId);
		} catch (Exception e) {
			throw e;
		}

	}
	
	@Override
	public Report recentReport(String userId) throws Exception{
		Report result = null;
		
		try {
			result = dao.selectOne("admin.recentReport", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	

	@Override
	public int checkReportCount(String reportedId) {
		int result = 0;
		
		try {
			result = dao.selectOne("admin.checkReportCount", reportedId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
	
	@Override
	public int reportCount(Map<String, Object> map) {
		int result = 0;

		try {
			result = dao.selectOne("admin.reportCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public int requestCount(Map<String, Object> map) {
		int result = 0;

		try {
			result = dao.selectOne("admin.requestCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public List<Shop> requestList(Map<String, Object> map) {
		List<Shop> list = null;

		try {
			list = dao.selectList("admin.requestList", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public int selectTip(int tipNum) {
		int result = 0;

		try {
			result = dao.selectOne("admin.selectTip", tipNum);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public int selectMyPet(int myPetNum) {
		int result = 0;

		try {
			result = dao.selectOne("admin.selectMyPet", myPetNum);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public int selectBbs(int bbsNum) {
		int result = 0;

		try {
			result = dao.selectOne("admin.selectBbs", bbsNum);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public List<Shop> requestDetailList(int requestNum) {
		List<Shop> list = null;

		try {
			list = dao.selectList("admin.requestDetailList", requestNum);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public void deleteTip(int reportedPostNum) throws Exception {
		try {
			dao.deleteData("admin.deleteTip", reportedPostNum);
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public void deleteMyPet(int reportedPostNum) throws Exception {
		try {
			dao.deleteData("admin.deleteMyPet", reportedPostNum);
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public void deleteBbs(int reportedPostNum) throws Exception {
		try {
			dao.deleteData("admin.deleteBbs", reportedPostNum);
		} catch (Exception e) {
			throw e;
		}
	}

}
