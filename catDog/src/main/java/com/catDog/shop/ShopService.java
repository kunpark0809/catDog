package com.catDog.shop;

import java.util.List;
import java.util.Map;

public interface ShopService {
	public List<Shop> bigSortList();
	public List<Shop> smallSortList(String bigSortNum);
	public void insertProduct(Shop dto, String pathname) throws Exception;
	public void insertImgFile(Shop dto) throws Exception;
	public void updateproduct(Shop dto, String pathname) throws Exception;
	public void deleteProduct(int productNum, String pathname, String userId) throws Exception;
	public void deleteImgFile(String productPicNum, String pathname, String userId) throws Exception;
	
	public List<Shop> listDogProduct(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	public List<Shop> readProductPic(int productNum);
	public Shop readProduct(int productNum);
	
	public void insertReview(Shop dto) throws Exception;
	public int reviewCount(Map<String, Object> map);
	public List<Shop> reviewList(Map<String, Object> map);
	public List<Shop> listAllReview(Map<String, Object> map);
}
