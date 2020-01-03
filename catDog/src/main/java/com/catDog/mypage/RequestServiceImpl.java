package com.catDog.mypage;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.catDog.common.dao.CommonDAO;
import com.catDog.pay.Pay;

@Service("mypage.requestService")
public class RequestServiceImpl implements RequestService {

	@Autowired
	private CommonDAO dao;

	// 주문상세
	@Override
	public List<Pay> requestDetailList(String requestNum) throws Exception {
		List<Pay> list = null;
		
		try {
			list = dao.selectList("request.readRequestDetail",requestNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("request.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Pay> requestList(Map<String, Object> map) {
		List<Pay> list = null;
		
		try {
			list = dao.selectList("request.readRequest", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
