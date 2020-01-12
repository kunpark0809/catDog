package com.catDog.aband;

import java.util.List;
import java.util.Map;


public interface AbandService {
	public void insertAband(Aband dto,String pathname) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public List<Aband> listAband(Map<String, Object> map);
	
	public Aband readAband(int lostPetNum);
	public Aband preReadAband(Map<String, Object> map);
	public Aband nextReadAband(Map<String, Object> map);
	
	public void updateAband(Aband dto,String pathname) throws Exception;
	public void deleteAband(int lostPetNum,String pathname, String userId) throws Exception;
	public void updateStatus(Map<String, Object> map) throws Exception;
	
	public void insertReply(Map<String, Object> map) throws Exception;
	public List<Reply> listReply(Map<String, Object> map);
	public int replyCount(Map<String, Object> map);
	
	public List<Reply> listReplyAnswer(int parent);
	public int replyAnswerCount(int parent);
	public void deleteReply(Map<String, Object> map) throws Exception;
}
