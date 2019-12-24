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
	public int monthSales(int yearMonth) {
		int result = -1;

		try {
			result = dao.selectOne("admin.monthSales", yearMonth);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}
	
	@Override
	public int quarterSales(int yearMonth) {
		int result = -1;

		try {
			result = dao.selectOne("admin.quarterSales", yearMonth);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}
	
	@Override
	public int yearSales(int year) {
		int result = -1;

		try {
			result = dao.selectOne("admin.yearSales", year);
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
