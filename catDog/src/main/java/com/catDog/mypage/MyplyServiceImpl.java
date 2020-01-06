package com.catDog.mypage;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.catDog.common.dao.CommonDAO;

@Service("mypage.myplyService")
public class MyplyServiceImpl implements MyplyService {
	@Autowired
	private CommonDAO dao;
	
/*	@Override
	public List<Myply> listMpLostPet(Map<String, Object> map) {
		List<Myply> list = null;
		
		try {
			list=dao.selectList("myply.listMpLostPet", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Myply> readMpLostPet(long num) {
		List<Myply> list = null;
		try {
			list = dao.selectList("myply.readMpLostPet", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCountMpLostPet(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("myply.dataCountMpLostPet", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Myply> listMpAdoption(Map<String, Object> map) {
		List<Myply> list = null;
		
		try {
			list=dao.selectList("myply.listMpAdoption", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Myply> readMpAdoption(long num) {
		List<Myply> list = null;
		try {
			list = dao.selectList("myply.readMpAdoption", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCountMpAdoption(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("myply.dataCountMpAdoption", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Myply> listMpTip(Map<String, Object> map) {
		List<Myply> list = null;
		
		try {
			list=dao.selectList("myply.listMpTip", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Myply> readMpTip(long num) {
		List<Myply> list = null;
		try {
			list = dao.selectList("myply.readMpTip", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCountMpTip(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("myply.dataCountMpTip", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}*/

	@Override
	public List<Myply> listMpMyPet(Map<String, Object> map) {
		List<Myply> list = null;
		
		try {
			list=dao.selectList("myply.listMpMyPet", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Myply> readMpMyPet(long num) {
		List<Myply> list = null;
		try {
			list = dao.selectList("myply.readMpMyPet", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCountMpMyPet(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("myply.dataCountMpMyPet", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
/*
	@Override
	public List<Myply> listMpBbs(Map<String, Object> map) {
		List<Myply> list = null;
		
		try {
			list=dao.selectList("myply.listMpBbs", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Myply> readMpBbs(long num) {
		List<Myply> list = null;
		try {
			list = dao.selectList("myply.readMpBbs", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCountMpBbs(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("myply.dataCountMpBbs", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}*/

	@Override
	public List<Myply> listMpQna(Map<String, Object> map) {
		List<Myply> list = null;
		
		try {
			list=dao.selectList("myply.listMpQna", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Myply> readMpQna(long num) {
		List<Myply> list = null;
		try {
			list = dao.selectList("myply.readMpQna", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCountMpQna(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("myply.dataCountMpQna", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

}
