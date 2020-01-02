package com.catDog.pet;

import java.io.File;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.catDog.common.FileManager;
import com.catDog.common.dao.CommonDAO;
import com.catDog.customer.SessionInfo;

@Service("pet.PetServiceImpl")
public class PetServiceImpl implements PetService {

	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
	@Autowired
	private PetService service;
	

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
			// 업로드한 파일이 존재한 경우
			String saveFilename = fileManager.doFileUpload(dto.getUpload(), pathname);
		
			if (saveFilename != null) {
				// 이전 파일 지우기
					if(dto.getImageFileName().length()!=0) {
					fileManager.doFileDelete(dto.getImageFileName(), pathname);
				}
					
				dto.setImageFileName(saveFilename);
			}
			
			dao.updateData("photo.updatePhoto", dto);
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
			Pet dto = readPet(myPetNum);
	
			if(dto==null || userId.indexOf("admin") != 0 )
				return;
	
			fileManager.doFileDelete(dto.getImageFileName(), pathname);
			

			dao.deleteData("pet.deletePet", myPetNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@RequestMapping(value="/pet/delete", method=RequestMethod.GET)
	public String delete(@RequestParam int myPetNum,
						 @RequestParam String page,
						 @RequestParam(defaultValue="all") String condition,
						 @RequestParam(defaultValue="") String keyword,
						 HttpSession session
						 ) throws Exception {
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		String query="page="+page;
		
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "utf-8");
		}
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"pet";
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		try {
			service.deletePet(myPetNum, pathname, info.getUserId());
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/pet/list?"+query;
	}


	
}
