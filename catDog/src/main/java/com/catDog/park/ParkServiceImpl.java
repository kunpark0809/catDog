package com.catDog.park;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.catDog.common.FileManager;
import com.catDog.common.dao.CommonDAO;

@Service("park.parkServiceImpl")
public class ParkServiceImpl implements ParkService {
	
	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;

	@Override
	public void insertPark(Park dto, String pathname) throws Exception {
		try {
			dto.setRecommendNum(dao.selectOne("park.seq"));
			dao.insertData("park.insertPark", dto);
			
			if(! dto.getMainUpload().isEmpty()) {
				String saveFilename = fileManager.doMainFileUpload(dto.getMainUpload(), pathname);
				if(saveFilename != null) {
					dto.setImageFileName(saveFilename);
					insertImgFile(dto, pathname);
				}
			}
			if(! dto.getUpload().isEmpty()) {
				for(MultipartFile mf : dto.getUpload()) {
					String saveFilename = fileManager.doFileUpload(mf, pathname);
					if(saveFilename == null) continue;
					
					dto.setImageFileName(saveFilename);
					insertImgFile(dto, pathname);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	
	@Override
	public void insertImgFile(Park dto, String pathname) throws Exception {
		try {
			dao.insertData("park.insertImgFile",dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("park.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<Park> listPark(Map<String, Object> map) {
		List<Park> list=null;
		
		try {
			list=dao.selectList("park.listPark", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public List<Park> readPark(int recommendNum) {
		List<Park> list = null;
		try {
			list = dao.selectList("park.readPark",recommendNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
		

	@Override
	public Park preReadPark(Map<String, Object> map) {
		Park dto=null;
		
		try {
			dto=dao.selectOne("park.preReadPark", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public Park nextReadPark(Map<String, Object> map) {
		Park dto=null;
		
		try {
			dto=dao.selectOne("park.nextReadPark", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void updatePark(Park dto, String pathname) throws Exception {
		// TODO Auto-generated method stub
		
	}
	

	@Override
	public void updateHitCount(int recommendNum) throws Exception {
		try {
			dao.updateData("park.updateHitCount", recommendNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void deletePark(int recommendNum, String pathname, String userId) throws Exception {
		try {
			List<Park> list=readPark(recommendNum);
			
			if(list==null || (! userId.equals("admin")))
				return;		
			
			if(list.remove(recommendNum)!=null)
				fileManager.doFileDelete(userId, pathname);
			
			dao.deleteData("park.deletePark", recommendNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
}
