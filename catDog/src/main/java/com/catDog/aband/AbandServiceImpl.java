package com.catDog.aband;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.catDog.common.FileManager;
import com.catDog.common.dao.CommonDAO;

@Service("aband.abandonedService")
public class AbandServiceImpl implements AbandService{

	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
	@Override
	public void insertAdopt(Aband dto, String pathname) throws Exception {
		try {
			if(!dto.getUpload().isEmpty()) {
				String saveName = fileManager.doFileUpload(dto.getUpload(), pathname);
				if(saveName != null) {
					dto.setImageFileName(saveName);
				}
			}
			
			dao.insertData("aband.insertAband",dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result =dao.selectOne("aband.dataCount", map);
		} catch (Exception e){
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<Aband> listAband(Map<String, Object> map) {
		List<Aband> list = null;
		try {
			list = dao.selectList("aband.listAband",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

}
