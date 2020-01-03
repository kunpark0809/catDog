package com.catDog.pet;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.catDog.common.FileManager;
import com.catDog.common.dao.CommonDAO;

@Service("pet.PetServiceImpl")
public class PetServiceImpl implements PetService {

	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;


	@Override
	public void insertPet(Pet dto, String pathname) throws Exception {
		try {
			String saveFilename=fileManager.doFileUpload(dto.getUpload(), pathname);
			if(saveFilename!=null) {
				dto.setImageFileName(saveFilename);

				dao.insertData("pet.insertPet", dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	
	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("pet.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<Pet> listPet(Map<String, Object> map) {
		List<Pet> list=null;
		
		try {
			list=dao.selectList("pet.listPet", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	
	@Override
	public Pet readPet(int myPetNum) {
		Pet dto = null;
		try {
			dto = dao.selectOne("pet.readPet",myPetNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
		

	@Override
	public Pet preReadPet(Map<String, Object> map) {
		Pet dto=null;
		
		try {
			dto=dao.selectOne("pet.preReadPet", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public Pet nextReadPet(Map<String, Object> map) {
		Pet dto=null;
		
		try {
			dto=dao.selectOne("pet.nextReadPet", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void updatePet(Pet dto, String pathname) throws Exception {
		try {
		
			if(! dto.getUpload().isEmpty()) {
				String saveFilename=fileManager.doFileUpload(dto.getUpload(), pathname);
				dto.setImageFileName(saveFilename);
				
		}
			
			dao.updateData("pet.updatePet", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}


	
	@Override
	public void updateHitCount(int myPetNum) throws Exception {
		try {
			dao.updateData("pet.updateHitCount", myPetNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void deletePet(int myPetNum, String pathname, String userId) throws Exception {
		try {
			Pet dto=readPet(myPetNum);
			if(dto==null || (! userId.equals("admin") && ! userId.equals(dto.getUserId())))
				return;
			
				if(dto.getImageFileName()!=null)
				fileManager.doFileDelete(dto.getImageFileName(), pathname);
			
			dao.deleteData("pet.deletePet", myPetNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}


	@Override
	public void insertPetLike(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("pet.insertPetLike", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}


	@Override
	public int petLikeCount(int myPetNum) {
		int result=0;
		try {
			result=dao.selectOne("pet.petLikeCount", myPetNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}


	@Override
	public void insertPetReport(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}


	@Override
	public int petReportCount(int reportNum) {
		// TODO Auto-generated method stub
		return 0;
	}
}
