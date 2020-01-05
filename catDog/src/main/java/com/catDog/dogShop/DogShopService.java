package com.catDog.dogShop;

import java.util.List;
import java.util.Map;

public interface DogShopService {
	public List<DogShop> bigSortList();
	public List<DogShop> smallSortList();
	public void insertProduct(DogShop dto, String pathname) throws Exception;
	public void insertImgFile(DogShop dto) throws Exception;
	public void updateproduct(DogShop dto, String pathname) throws Exception;
	public void deleteProduct(int productNum, String pathname, String userId) throws Exception;
	public void deleteImgFile(String productPicNum, String pathname, String userId) throws Exception;
	
	public List<DogShop> listDogProduct(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	public List<DogShop> readProductPic(int productNum);
	public DogShop readProduct(int productNum);
}
