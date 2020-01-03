package com.catDog.mypage;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.catDog.common.dao.CommonDAO;

@Service("mypage.pointService")
public class PointServiceImpl implements PointService {
	@Autowired
	private CommonDAO dao;
	
	@Override
	public List<Point> listPoint(Map<String, Object> map) {
		List<Point> list = null;
		
		try {
			list=dao.selectList("point.listPoint", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Point> readPoint(long num) {
		List<Point> list = null;
		
		try {
			list = dao.selectList("point.readPoint", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("point.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

}
