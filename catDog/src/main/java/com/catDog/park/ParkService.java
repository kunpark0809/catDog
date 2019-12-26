package com.catDog.park;

import java.util.List;
import java.util.Map;

public interface ParkService {

	public void insertPark(Park dto, String pathname) throws Exception;
	public void insertImgFile(Park dto, String pathname) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	
	public void updateHitCount(int recommendNum) throws Exception;
	
	public List<Park> listPark(Map<String, Object> map);
	public Park readPark(int recommendNum);
	
	public Park preReadPark(Map<String, Object> map);
	public Park nextReadPark(Map<String, Object> map);
	
	public void updatePark(Park dto, String pathname) throws Exception;
	public void updateImgFile(Park dto) throws Exception;
	public void deletePark(int recommendNum, String pathname, String userId) throws Exception;
	
	public void insertRate(Park dto) throws Exception;
	public List<Park> listRate(Map<String, Object> map);
	public int rateCount(Map<String, Object> map);
	public void deleteRate(Map<String, Object> map) throws Exception;
	
}
