package com.catDog.mypage;

import java.util.List;
import java.util.Map;

public interface PointService {
	public List<Point> listPoint(Map<String, Object> map);
	public List<Point> readPoint(long num);
	public int dataCount(Map<String, Object> map);
	
}
