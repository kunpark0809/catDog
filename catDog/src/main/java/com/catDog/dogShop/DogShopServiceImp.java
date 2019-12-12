package com.catDog.dogShop;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.catDog.common.dao.CommonDAO;

@Service("dogShop.dogShopService")
public class DogShopServiceImp implements DogShopService{
	
	@Autowired
	private CommonDAO dao;
		
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
	
}
