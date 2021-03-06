package com.catDog.pay;

import java.util.List;
import java.util.Map;

public interface PayService {
	public Pay readProudct(int productNum);
	public Pay readCustomer(long num);
	public void insertCustomer(Pay pay) throws Exception;
	public void insertCart(Pay product) throws Exception;
	public Pay readCart(String cartNum) throws Exception;
	public List<Pay> requestList(String requestNum) throws Exception;
	public String insertRequest(Pay pay) throws Exception;
	public void insertRequestDetail(Pay pay) throws Exception;
	public void deleteCart(Map<String, Object> map);
	public List<Pay> cartList(long num);
	public List<Pay> cartPayList(Map<String, Object> map);
	public void updateCount(Pay pay) throws Exception;
}
