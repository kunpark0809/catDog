package com.catDog.dogShop;

import java.util.List;

public interface DogShopService {
	public List<DogShop> smallSortList();
	public void insertProduct(DogShop dto) throws Exception;
}
