package com.catDog.mpqna;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.catDog.common.dao.CommonDAO;

@Service("mpqna.mpqnaService")
public class MpqnaServiceImpl implements MpqnaService {
	@Autowired
	private CommonDAO dao;

	@Override
	public List<Mpqna> listMpQna(Map<String, Object> map) {
		List<Mpqna> list = null;
		
		try {
			list=dao.selectList("mpqna.listMpQna", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCountMpQna(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("mpqna.dataCountMpQna", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

}
