package com.catDog.freeBoard;

import java.util.List;
import java.util.Map;


public interface FreeBoardService {
	public void insertFreeBoard(FreeBoard dto) throws Exception;

	public int dataCount(Map<String, Object> map);
	
	public void updateHitCount(int bbsNum) throws Exception;

	public List<FreeBoard> listFreeBoard(Map<String, Object> map);
	public List<FreeBoard> listFreeBoardTop();

	public FreeBoard readFreeBoard(int bbsNum);
	public FreeBoard preReadFreeBoard(Map<String, Object> map);
	public FreeBoard nextReadFreeBoard(Map<String, Object> map);

	public void updateFreeBoard(FreeBoard dto) throws Exception;
	public void deleteFreeBoard(int bbsNum, String userId) throws Exception;
	
	public List<Reply> listReply(Map<String, Object> map);
	public int replyCount(Map<String, Object> map);
	public void insertReply(Reply dto) throws Exception;
	public void deleteReply(Map<String, Object> map) throws Exception;
	public List<Reply> listReplyParent(int parent);
	public int replyParentCount(int parent);
	
	public void insertFreeBoardReport(Map<String, Object> map) throws Exception;
	public int freeBoardReportCount(int bbsNum);

}
