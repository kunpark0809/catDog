package com.catDog.park;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.catDog.common.dao.CommonDAO;

public class ParkServiceImpl implements ParkService {

	@Autowired
	private CommonDAO dao;
	
	@Override
	public void insertPark(Park dto, String pathname) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Park> listPark(Map<String, Object> map) {
		List<Park> list = null;
		try {
			list=dao.selectList("park.listPark", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return list;
	}

	@Override
	public Park readPark(int num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Park preReadPark(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Park nextReadPark(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updatePark(Park dto, String pathname) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deletePark(int num, String pathname, String userId) throws Exception {
		// TODO Auto-generated method stub
		
	}

	

}
