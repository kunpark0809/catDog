package com.catDog.shop;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.catDog.common.FileManager;
import com.catDog.common.dao.CommonDAO;

@Service("shop.shopService")
public class ShopServiceImp implements ShopService{
	
	@Autowired
	private CommonDAO dao;
		
	@Autowired
	private FileManager fileManager;
	
	@Override
	public List<Shop> bigSortList() {
		List<Shop> list = null;
		
		try {
			list = dao.selectList("shop.bigSortList");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public List<Shop> smallSortList(String bigSortNum) {
		List<Shop> list = null;
		try {
			list = dao.selectList("shop.smallSortList",bigSortNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void insertProduct(Shop dto, String pathname) throws Exception {
		try {
			dto.setProductNum(dao.selectOne("shop.productSeq"));
			
			
			if(!dto.getMain().isEmpty()) {
				String saveFilename = fileManager.doFileUpload(dto.getMain(), pathname);
				if(saveFilename != null) {
					dto.setImageFileName(saveFilename);
				}
			}
			
			dao.insertData("shop.insertProduct",dto);
			
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
	public void insertImgFile(Shop dto) throws Exception{
		try {
			dao.insertData("shop.insertImgFile",dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Shop> listDogProduct(Map<String, Object> map) {
		List<Shop> list = null;
		try {
			list = dao.selectList("shop.listProduct", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("shop.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<Shop> readProductPic(int productNum) {
		List<Shop> list = null;
		try {
			list = dao.selectList("shop.readProductPic",productNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	@Override
	public Shop readProduct(int productNum) {
		Shop dto = null;
		try {
			dto = dao.selectOne("shop.readProduct",productNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	@Override
	public void deleteProduct(int productNum, String pathname, String userId) throws Exception {
		try {
			Shop dto = readProduct(productNum);
			if(dto==null || ( userId.indexOf("admin") < 0)) {
				return;
			}
			
			dao.updateData("shop.deleteProduct",productNum);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void deleteImgFile(String productPicNum, String pathname, String userId) throws Exception {
		try {
			Shop dto = dao.selectOne("shop.readPicNum", productPicNum);
			
			if(dto==null || ( userId.indexOf("admin") < 0)) {
				return;
			}
			
			if(dto.getImageFileName()!=null) {
				fileManager.doFileDelete(dto.getImageFileName(),pathname);
			}
			
			dao.deleteData("shop.deletePic", productPicNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updateproduct(Shop dto, String pathname) throws Exception {
		
		try {
			if(!dto.getMain().isEmpty()) {
				
				if(dto.getImageFileName()!=null)
					fileManager.doFileDelete(dto.getImageFileName(),pathname);
				
				String savename = fileManager.doFileUpload(dto.getMain(), pathname);
				if(savename != null)
					dto.setImageFileName(savename);
			}
			
			
			dao.updateData("shop.updateProduct",dto);
			
			if(!dto.getUpload().isEmpty()) {
				for(MultipartFile mf : dto.getUpload()) {
					String savename = fileManager.doFileUpload(mf, pathname);
					if(savename !=null) {
						dto.setImageFileName(savename);
						insertImgFile(dto);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void insertReview(Shop dto) throws Exception {
		try {
			dao.insertData("shop.reviewInsert",dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public List<Shop> reviewList(Map<String, Object> map) {
		List<Shop> list = null;
		try {
			list = dao.selectList("shop.listReview",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int reviewCount(Map<String, Object> map) {
		int result = 0;
		try {
			result=dao.selectOne("shop.reviewCount",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	
	


	
	
}
