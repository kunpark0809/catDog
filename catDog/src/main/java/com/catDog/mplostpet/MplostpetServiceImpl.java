package com.catDog.mplostpet;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.catDog.common.dao.CommonDAO;

@Service("mplostpet.mplostpetService")
public class MplostpetServiceImpl implements MplostpetService {
	@Autowired
	private CommonDAO dao;
	
	@Override
	public List<Mplostpet> listMpLostPet(Map<String, Object> map) {
		List<Mplostpet> list = null;
		
		try {
			list=dao.selectList("mplostpet.listMpLostPet", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCountMpLostPet(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("mplostpet.dataCountMpLostPet", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

}
