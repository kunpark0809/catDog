package com.catDog.mpbbs;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.catDog.common.dao.CommonDAO;

@Service("mpbbs.mpbbsService")
public class MpbbsServiceImpl implements MpbbsService {
	@Autowired
	private CommonDAO dao;
	
	@Override
	public List<Mpbbs> listMpBbs(Map<String, Object> map) {
		List<Mpbbs> list = null;
		
		try {
			list=dao.selectList("mpbbs.listMpBbs", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCountMpBbs(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("mpbbs.dataCountMpBbs", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

}
