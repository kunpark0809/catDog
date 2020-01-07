package com.catDog.mpmypet;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.catDog.common.dao.CommonDAO;

@Service("mpmypet.mpmypetService")
public class MpmypetServiceImpl implements MpmypetService {
	@Autowired
	private CommonDAO dao;
	

	@Override
	public List<Mpmypet> listMpMyPet(Map<String, Object> map) {
		List<Mpmypet> list = null;
		
		try {
			list=dao.selectList("mpmypet.listMpMyPet", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCountMpMyPet(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("mpmypet.dataCountMpMyPet", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}


}
