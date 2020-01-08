package com.catDog.freeBoard;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.catDog.common.dao.CommonDAO;
import com.catDog.freeBoard.Reply;
import com.catDog.freeBoard.FreeBoard;

@Service("freeBoard.FreeBoardServiceImpl")
public class FreeBoardServiceImpl implements FreeBoardService{

@Autowired
private CommonDAO dao;
	
	@Override
	public void insertFreeBoard(FreeBoard dto) throws Exception {
		try {
			dto.setBbsNum(dao.selectOne("freeBoard.seq"));
			dao.insertData("freeBoard.insertFreeBoard", dto);
	
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("freeBoard.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public void updateHitCount(int bbsNum) throws Exception {
		try {
			dao.updateData("freeBoard.updateHitCount", bbsNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<FreeBoard> listFreeBoard(Map<String, Object> map) {
		List<FreeBoard> list=null;
		
		try {
			list=dao.selectList("freeBoard.listFreeBoard", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public List<FreeBoard> listFreeBoardTop() {
		List<FreeBoard> listFreeBoardTop = null;

		try {
			listFreeBoardTop = dao.selectList("freeBoard.listFreeBoardTop");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listFreeBoardTop;
	}

	@Override
	public FreeBoard readFreeBoard(int bbsNum) {
		FreeBoard dto = null;
		try {
			dto = dao.selectOne("freeBoard.readFreeBoard",bbsNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public FreeBoard preReadFreeBoard(Map<String, Object> map) {
		FreeBoard dto=null;
		
		try {
			dto=dao.selectOne("freeBoard.preReadFreeBoard", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public FreeBoard nextReadFreeBoard(Map<String, Object> map) {
		FreeBoard dto=null;
		
		try {
			dto=dao.selectOne("freeBoard.nextReadFreeBoard", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void updateFreeBoard(FreeBoard dto) throws Exception {
		try {
			dao.updateData("freeBoard.updateFreeBoard", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void deleteFreeBoard(int bbsNum, String userId) throws Exception {
		try {
			FreeBoard dto = readFreeBoard(bbsNum);
	
			if(dto==null || (! userId.equals("admin") && ! userId.equals(dto.getUserId())))
				return;
			
			dao.deleteData("freeBoard.deleteFreeBoard", bbsNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Reply> listReply(Map<String, Object> map) {
		List<Reply> list=null;
		try {
			list=dao.selectList("freeBoard.listReply", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public int replyCount(Map<String, Object> map) {
		int result = 0;
		try {
			result=dao.selectOne("freeBoard.replyCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void insertReply(Reply dto) throws Exception {
		try {
			dao.insertData("freeBoard.insertReply", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void deleteReply(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("freeBoard.deleteReply", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Reply> listReplyParent(int parent) {
		List<Reply> list = null;
		try {
			list=dao.selectList("freeBoard.listReplyParent", parent);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int replyParentCount(int parent) {
		int result=0;
		try {
			result = dao.selectOne("freeBoard.replyParentCount", parent);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}


	@Override
	public void insertFreeBoardReport(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("freeBoard.insertFreeBoardReport", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public int freeBoardReportCount(int bbsNum) {
		int result=0;
		try {
			result=dao.selectOne("freeBoard.freeBoardReportCount", bbsNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}


}
