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


	
	//smallSortNum과 year를 map에 넣으면 해당 year에 상품소분류가 smallSortNum인 상품의 총매출을 월별로 산출.
	// List<Money>로 리턴. 각각의 Money 객체는 한 월의 해당 소분류 총매출이며 해당 월에 매출이 0이면 출력하지 않음.
	@Override
	public List<Money> monthSales(Map<String, Object> map) {
		List<Money> list = null;

		try {
			list = dao.selectList("admin.monthSalesByCategory", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
	
	@Override
	public int quarterSales(String yearMonth) {
		int result = -1;

		try {
			result = dao.selectOne("admin.quarterSales", yearMonth);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}
	
	@Override
	public int yearSales(String year) {
		int result = -1;

		try {
			result = dao.selectOne("admin.yearSales", year);
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
	public int reportCount(Map<String, Object> map) {
		int result = -1;

		try {
			result = dao.selectOne("admin.reportCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	
}
