package com.catDog.funeral;

import java.util.List;
import java.util.Map;

public interface FuneralService {

	public void insertFuneral(Funeral dto, String pathname) throws Exception;
	public void insertImgFile(Funeral dto, String pathname) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	
	public void updateHitCount(int recommendNum) throws Exception;
	
	public List<Funeral> listFuneral(Map<String, Object> map);
	public Funeral readFuneral(int recommendNum);
	
	public Funeral preReadFuneral(Map<String, Object> map);
	public Funeral nextReadFuneral(Map<String, Object> map);
	
	public void updateFuneral(Funeral dto, String pathname) throws Exception;
	public void updateImgFile(Funeral dto) throws Exception;
	public void deleteFuneral(int recommendNum, String pathname, String userId) throws Exception;
	
	public void insertRate(Funeral dto) throws Exception;
	public List<Funeral> listRate(Map<String, Object> map);
	public int rateCount(Map<String, Object> map);
	public void deleteRate(Map<String, Object> map) throws Exception;
	
}
