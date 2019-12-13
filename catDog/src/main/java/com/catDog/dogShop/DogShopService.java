package com.catDog.dogShop;

import java.util.List;
import java.util.Map;

public interface DogShopService {
	public List<DogShop> smallSortList();
	public void insertProduct(DogShop dto) throws Exception;
	public void insertImgFile(DogShop dto, String pathname) throws Exception;
	public List<DogShop> listDogProduct(Map<String, Object> map);
}
