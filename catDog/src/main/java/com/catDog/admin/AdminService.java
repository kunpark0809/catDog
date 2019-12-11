package com.catDog.admin;

import java.util.Map;

public interface AdminService {
	public int calculateTotal(Map<String, Object> map);

	public Money calculateProduct(Map<String, Object> map);

}
