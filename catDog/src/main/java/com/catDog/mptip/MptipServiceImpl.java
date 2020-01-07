package com.catDog.mptip;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.catDog.common.dao.CommonDAO;

@Service("mptip.mptipService")
public class MptipServiceImpl implements MptipService {
	@Autowired
	private CommonDAO dao;

	@Override
	public List<Mptip> listMpTip(Map<String, Object> map) {
		List<Mptip> list = null;
		
		try {
			list=dao.selectList("mptip.listMpTip", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCountMpTip(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("mptip.dataCountMpTip", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}


}
