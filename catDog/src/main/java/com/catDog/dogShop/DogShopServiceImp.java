package com.catDog.dogShop;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.catDog.common.FileManager;
import com.catDog.common.dao.CommonDAO;

@Service("dogShop.dogShopService")
public class DogShopServiceImp implements DogShopService{
	
	@Autowired
	private CommonDAO dao;
		
	@Autowired
	private FileManager fileManager;
	
	@Override
	public List<DogShop> smallSortList() {
		List<DogShop> list = null;
		try {
			list = dao.selectList("dogshop.smallSortList");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void insertProduct(DogShop dto) throws Exception {
		try {
			dto.setProductNum(dao.selectOne("dogshop.productSeq"));
			dao.insertData("dogshop.insertDogProduct",dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	@Override
	public void insertImgFile(DogShop dto, String pathname) throws Exception{
		try {
			String saveFilename = fileManager.doFileUpload(dto.getUpload(), pathname);
			if(saveFilename!=null) {
				dto.setImageFileName(saveFilename);
			}
			dao.insertData("dogshop.insertImgFile",dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<DogShop> listDogProduct(Map<String, Object> map) {
		List<DogShop> list = null;
		try {
			list = dao.selectList("dogshop.listDogProduct", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}


	
	
}
