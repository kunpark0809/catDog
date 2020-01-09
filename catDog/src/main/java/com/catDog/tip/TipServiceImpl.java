package com.catDog.tip;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.catDog.common.dao.CommonDAO;


@Service("tip.TipServiceImpl")
public class TipServiceImpl implements TipService {
	
	@Autowired
	private CommonDAO dao;
	
	@Override
	public void insertTip(Tip dto) throws Exception {
		try {
			dto.setTipNum(dao.selectOne("tip.seq"));
			dao.insertData("tip.insertTip", dto);
	
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	
	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("tip.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<Tip> listTip(Map<String, Object> map) {
		List<Tip> list=null;
		
		try {
			list=dao.selectList("tip.listTip", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	@Override
	public List<Tip> listTipTop() {
		List<Tip> listTipTop = null;

		try {
			listTipTop = dao.selectList("tip.listTipTop");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listTipTop;
	}

	@Override
	public Tip readTip(int tipNum) {
		Tip dto = null;
		try {
			dto = dao.selectOne("tip.readTip",tipNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
		

	@Override
	public Tip preReadTip(Map<String, Object> map) {
		Tip dto=null;
		
		try {
			dto=dao.selectOne("tip.preReadTip", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public Tip nextReadTip(Map<String, Object> map) {
		Tip dto=null;
		
		try {
			dto=dao.selectOne("tip.nextReadTip", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	@Override
	public void updateHitCount(int tipNum) throws Exception {
		try {
			dao.updateData("tip.updateHitCount", tipNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	

	@Override
	public void updateTip(Tip dto) throws Exception {
		try {
			dao.updateData("tip.updateTip", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}


	@Override
	public void deleteTip(int tipNum, String userId) throws Exception {
		try {
			Tip dto = readTip(tipNum);
	
			if(dto==null || (! userId.equals("admin") && ! userId.equals(dto.getUserId())))
				return;
	
			
			
			dao.deleteData("tip.deleteTip", tipNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	@Override
	public void insertReply(Reply dto) throws Exception {
		try {
			dao.insertData("tip.insertReply", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Reply> listReply(Map<String, Object> map) {
		List<Reply> list=null;
		try {
			list=dao.selectList("tip.listReply", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}


	@Override
	public int replyCount(Map<String, Object> map) {
		int result = 0;
		try {
			result=dao.selectOne("tip.replyCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}


	@Override
	public void deleteReply(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("tip.deleteReply", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}


	@Override
	public List<Reply> listReplyParent(int parent) {
		List<Reply> list = null;
		try {
			list=dao.selectList("tip.listReplyParent", parent);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int replyParentCount(int parent) {
		int result=0;
		try {
			result = dao.selectOne("tip.replyParentCount", parent);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}


	@Override
	public void insertTipLike(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("tip.insertTipLike", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}



	@Override
	public int tipLikeCount(int tipNum) {
		int result=0;
		try {
			result=dao.selectOne("tip.tipLikeCount", tipNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void insertTipReport(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("tip.insertTipReport", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}


	@Override
	public int tipReportCount(int tipNum) {
		int result=0;
		try {
			result=dao.selectOne("tip.tipReportCount", tipNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}


	@Override
	public void insertTipCategory(Tip dto) throws Exception {
		try {
			dao.insertData("tip.insertTipCategory", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updateTipCategory(Tip dto) throws Exception {
		try {
			dao.updateData("tip.updateTipCategory", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}


	@Override
	public void deleteTipCategory(int tipCategoryNum) throws Exception {
		try {
			dao.deleteData("tip.deleteTipCategory", tipCategoryNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}


	@Override
	public List<Tip> listTipCategory() {
		List<Tip> list = null;
		try {
			list=dao.selectList("tip.listTipCategory");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}


}
