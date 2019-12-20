package com.catDog.pay;

public interface PayService {
	public Pay readProudct(int productNum);
	public Pay readCustomer(long num);
	public void insertCustomer(Pay pay) throws Exception;
	public void insertRequest(Pay pay) throws Exception;
}
