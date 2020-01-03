package com.catDog.pet;

import java.util.List;
import java.util.Map;

public interface PetService {

	public void insertPet(Pet dto, String pathname) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	
	public void updateHitCount(int myPetNum) throws Exception;
	
	public List<Pet> listPet(Map<String, Object> map);
	public Pet readPet(int myPetNum);
	
	public Pet preReadPet(Map<String, Object> map);
	public Pet nextReadPet(Map<String, Object> map);
	
	public void updatePet(Pet dto, String pathname) throws Exception;
	public void deletePet(int myPetNum, String pathname, String userId) throws Exception;
	
	public void insertPetLike(Map<String, Object> map) throws Exception;
	public int petLikeCount(int myPetNum);
	
	public void insertPetReport(Map<String, Object> map) throws Exception;
	public int petReportCount(int reportNum);
}
