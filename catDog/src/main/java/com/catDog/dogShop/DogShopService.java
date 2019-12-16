package com.catDog.dogShop;

import java.util.List;
import java.util.Map;

public interface DogShopService {
	public List<DogShop> smallSortList();
	public void insertProduct(DogShop dto, String pathname) throws Exception;
	public void insertImgFile(DogShop dto) throws Exception;
	public List<DogShop> listDogProduct(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	public List<DogShop> readProduct(int productNum);
}
