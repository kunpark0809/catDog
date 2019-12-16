package com.catDog.park;

import java.util.List;
import java.util.Map;

public interface ParkService {

	public void insertPark(Park dto, String pathname) throws Exception;
	public void insertImgFile(Park dto, String pathname) throws Exception;
	public int dataCount(Map<String, Object> map);
	public List<Park> listPark(Map<String, Object> map);
	public Park readPark(int num);
	public Park preReadPark(Map<String, Object> map);
	public Park nextReadPark(Map<String, Object> map);
	public void updatePark(Park dto, String pathname) throws Exception;
	public void deletePark(int num, String pathname, String userId) throws Exception;
}
