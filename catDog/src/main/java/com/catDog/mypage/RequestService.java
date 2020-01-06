package com.catDog.mypage;

import java.util.List;
import java.util.Map;

import com.catDog.pay.Pay;

public interface RequestService {
	public List<Pay> requestList(Map<String, Object> map);
	public List<Pay> requestDetailList(String requestNum) throws Exception;
	public int dataCount(Map<String, Object> map);
	public Pay readCustomer(long num);
	public List<Pay> readRequestNum(Map<String, Object> map);
	public void requestCancle(String requestNum) throws Exception;
	public void refundRequest(Pay pay) throws Exception;
	public void requestRefund(String requestNum) throws Exception;
}
