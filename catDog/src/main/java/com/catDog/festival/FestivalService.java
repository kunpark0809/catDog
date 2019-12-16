package com.catDog.festival;

import java.util.List;
import java.util.Map;

public interface FestivalService {
	public void insertFestival(Festival dto) throws Exception;
	
	public List<Festival> listMonth(Map<String, Object> map) throws Exception;
	public List<Festival> listDay(Map<String, Object> map) throws Exception;
	
	public Festival readFestival(int eventNum) throws Exception;
	
	public void updateFestival(Festival dto) throws Exception;
	public void deleteFestival(Map<String, Object> map) throws Exception;
}
