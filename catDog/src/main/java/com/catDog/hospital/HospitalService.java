package com.catDog.hospital;

import java.util.List;
import java.util.Map;

public interface HospitalService {

	public void insertHospital(Hospital dto, String pathname) throws Exception;
	public void insertImgFile(Hospital dto, String pathname) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	
	public void updateHitCount(int recommendNum) throws Exception;
	
	public List<Hospital> listHospital(Map<String, Object> map);
	public Hospital readHospital(int recommendNum);
	
	public Hospital preReadHospital(Map<String, Object> map);
	public Hospital nextReadHospital(Map<String, Object> map);
	
	public void updateHospital(Hospital dto, String pathname) throws Exception;
	public void updateImgFile(Hospital dto) throws Exception;
	public void deleteHospital(int recommendNum, String pathname, String userId) throws Exception;
	
	public void insertRate(Hospital dto) throws Exception;
	public List<Hospital> listRate(Map<String, Object> map);
	public int rateCount(Map<String, Object> map);
	public void deleteRate(Map<String, Object> map) throws Exception;
	
}
