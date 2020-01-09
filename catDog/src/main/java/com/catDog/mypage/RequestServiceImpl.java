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

	@Override
	public Pay readCustomer(long num) {
		Pay dto = null;
		try {
			dto = dao.selectOne("request.readCumstomer",num);
			
			if(dto != null) {
				if(dto.getTel() !=null) {
					String[] s = dto.getTel().split("-");
					dto.setTel1(s[0]);
					dto.setTel2(s[1]);
					dto.setTel3(s[2]);
				}
				
				if(dto.getEmail() !=null) {
					String[] s = dto.getEmail().split("@");
					dto.setEmail1(s[0]);
					dto.setEmail2(s[1]);
					
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	return dto;
	}

	@Override
	public List<Pay> readRequestNum(Map<String, Object> map) {
		List<Pay> list = null;
		try {
			list = dao.selectList("request.readRequestNum", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void requestCancle(String requestNum) throws Exception {
		try {
			dao.updateData("request.requestCancle", requestNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void refundRequest(Pay pay) throws Exception {
		try {
			dao.insertData("request.refundRequest", pay);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void requestRefund(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("request.requestRefund", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public Pay readExpress(String requestNum) {
		Pay dto = null;
		try {
			dto = dao.selectOne("request.readExpress", requestNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void swapRequest(Pay pay) throws Exception {
		try {
			dao.insertData("request.swapRequest", pay);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void requestSwap(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("request.requestSwap", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
}
