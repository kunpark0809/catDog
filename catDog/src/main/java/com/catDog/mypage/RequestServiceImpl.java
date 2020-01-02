package com.catDog.mypage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.catDog.common.dao.CommonDAO;

@Service("mypage.requestService")
public class RequestServiceImpl implements RequestService {

	@Autowired
	private CommonDAO dao;
}
