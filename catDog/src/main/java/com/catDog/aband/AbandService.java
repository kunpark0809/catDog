package com.catDog.aband;

import java.util.List;
import java.util.Map;

public interface AbandService {
	public void insertAdopt(Aband dto,String pathname) throws Exception;
	
	
	public int dataCount(Map<String, Object> map);
	public List<Aband> listAband(Map<String, Object> map);
}
