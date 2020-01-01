package com.catDog.cafe;

import java.util.List;
import java.util.Map;
 
public interface CafeService {

	public void insertCafe(Cafe dto, String pathname) throws Exception;
	public void insertImgFile(Cafe dto, String pathname) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	
	public void updateHitCount(int recommendNum) throws Exception;
	
	public List<Cafe> listCafe(Map<String, Object> map);
	public Cafe readCafe(int recommendNum);
	
	public Cafe preReadCafe(Map<String, Object> map);
	public Cafe nextReadCafe(Map<String, Object> map);
	
	public void updateCafe(Cafe dto, String pathname) throws Exception;
	public void updateImgFile(Cafe dto) throws Exception;
	public void deleteCafe(int recommendNum, String pathname, String userId) throws Exception;
	
	public void insertRate(Cafe dto) throws Exception;
	public List<Cafe> listRate(Map<String, Object> map);
	public int rateCount(Map<String, Object> map);
	public void deleteRate(Map<String, Object> map) throws Exception;
	
}
