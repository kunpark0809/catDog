package com.catDog.dogShop;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

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
	public void insertProduct(DogShop dto, String pathname) throws Exception {
		try {
			dto.setProductNum(dao.selectOne("dogshop.productSeq"));
			
			
			if(!dto.getMain().isEmpty()) {
				String saveFilename = fileManager.doFileUpload(dto.getMain(), pathname);
				if(saveFilename != null) {
					dto.setImageFileName(saveFilename);
				}
			}
			
			dao.insertData("dogshop.insertDogProduct",dto);
			
			if(! dto.getUpload().isEmpty()) {
				for(MultipartFile mf : dto.getUpload()) {
					String saveFilename = fileManager.doFileUpload(mf, pathname);
					if(saveFilename == null) continue;
					
					dto.setImageFileName(saveFilename);
					insertImgFile(dto);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	@Override
	public void insertImgFile(DogShop dto) throws Exception{
		try {
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

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("dogshop.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<DogShop> readProduct(int productNum) {
		List<DogShop> list = null;
		try {
			list = dao.selectList("dogshop.readProduct",productNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}


	
	
}
