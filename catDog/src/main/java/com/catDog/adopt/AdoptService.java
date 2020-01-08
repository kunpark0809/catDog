package com.catDog.adopt;

import java.util.List;
import java.util.Map;


public interface AdoptService {
	public void insertAdopt(Adopt dto,String pathname) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public List<Adopt> listAdopt(Map<String, Object> map);
	
	
	public void updateHitCount(int adoptionNum) throws Exception;
	public Adopt readAdopt(int adoptionNum);
	
	public void updateAdopt(Adopt dto,String pathname) throws Exception;
	public void deleteAdopt(int adoptionNum,String pathname, String userId) throws Exception;
	
	public Adopt preReadAdopt(Map<String, Object> map);
	public Adopt nextReadAdopt(Map<String, Object> map);
}
