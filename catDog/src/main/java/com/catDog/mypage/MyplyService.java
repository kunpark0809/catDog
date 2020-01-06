package com.catDog.mypage;

import java.util.List;
import java.util.Map;

public interface MyplyService {
/*	public List<Myply> listMpLostPet(Map<String, Object> map);
	public List<Myply> readMpLostPet(long num);
	public int dataCountMpLostPet(Map<String, Object> map);
	
	public List<Myply> listMpAdoption(Map<String, Object> map);
	public List<Myply> readMpAdoption(long num);
	public int dataCountMpAdoption(Map<String, Object> map);
	
	public List<Myply> listMpTip(Map<String, Object> map);
	public List<Myply> readMpTip(long num);
	public int dataCountMpTip(Map<String, Object> map);*/
	
	public List<Myply> listMpMyPet(Map<String, Object> map);
	public List<Myply> readMpMyPet(long num);
	public int dataCountMpMyPet(Map<String, Object> map);
	
	/*public List<Myply> listMpBbs(Map<String, Object> map);
	public List<Myply> readMpBbs(long num);
	public int dataCountMpBbs(Map<String, Object> map);*/
	
	public List<Myply> listMpQna(Map<String, Object> map);
	public List<Myply> readMpQna(long num);
	public int dataCountMpQna(Map<String, Object> map);
}
