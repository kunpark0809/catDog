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
	public int calculateTotal(Map<String, Object> map) {
		int result = -1;

		try {
			result = dao.selectOne("admin.calculateTotal", map);
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
	public List<Member> listMember(Map<String, Object> map) {
		List<Member> list = null;

		try {
			dao.selectList("admin.listMember", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

}
