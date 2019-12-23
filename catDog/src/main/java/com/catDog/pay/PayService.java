package com.catDog.pay;

import java.util.List;

public interface PayService {
	public Pay readProudct(int productNum);
	public Pay readCustomer(long num);
	public void insertCustomer(Pay pay) throws Exception;
	public void insertRequest(Pay pay) throws Exception;
	public void insertCart(Pay product) throws Exception;
	public List<Pay> cartList(long num);
}
