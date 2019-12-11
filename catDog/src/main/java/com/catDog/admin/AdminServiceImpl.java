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
	public int calculateSales(Map<String, Object> map) {
		int result = -1;

		try {
			result = dao.selectOne("admin.calculateTotal", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

}
