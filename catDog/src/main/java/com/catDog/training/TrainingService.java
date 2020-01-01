package com.catDog.training;

import java.util.List;
import java.util.Map;

public interface TrainingService {

	public void insertTraining(Training dto, String pathname) throws Exception;
	public void insertImgFile(Training dto, String pathname) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	
	public void updateHitCount(int recommendNum) throws Exception;
	
	public List<Training> listTraining(Map<String, Object> map);
	public Training readTraining(int recommendNum);
	
	public Training preReadTraining(Map<String, Object> map);
	public Training nextReadTraining(Map<String, Object> map);
	
	public void updateTraining(Training dto, String pathname) throws Exception;
	public void updateImgFile(Training dto) throws Exception;
	public void deleteTraining(int recommendNum, String pathname, String userId) throws Exception;
	
	public void insertRate(Training dto) throws Exception;
	public List<Training> listRate(Map<String, Object> map);
	public int rateCount(Map<String, Object> map);
	public void deleteRate(Map<String, Object> map) throws Exception;
	
}
