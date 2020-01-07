package com.catDog.mpadoption;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.catDog.common.dao.CommonDAO;

@Service("mpadoption.myplyService")
public class MpadoptionServiceImpl implements MpadoptionService {
	@Autowired
	private CommonDAO dao;

	@Override
	public List<Mpadoption> listMpAdoption(Map<String, Object> map) {
		List<Mpadoption> list = null;
		
		try {
			list=dao.selectList("mpadoption.listMpAdoption", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCountMpAdoption(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("mpadoption.dataCountMpAdoption", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

}
