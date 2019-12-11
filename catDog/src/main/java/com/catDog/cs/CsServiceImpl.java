package com.catDog.cs;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

@Service("cs.csService")
public class CsServiceImpl implements CsService {

	@Override
	public void insertNotice(Notice dto, String pathname) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Notice> listNotice(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Notice> listNoticeTop() {
		// TODO Auto-generated method stub
		return null;
	}

}
