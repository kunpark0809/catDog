package com.catDog.tip;

import java.util.List;
import java.util.Map;

import com.catDog.cs.Qna;

public interface TipService {
	public void insertTip(Tip dto) throws Exception;

	public int dataCount(Map<String, Object> map);
	
	public void updateHitCount(int tipNum) throws Exception;

	public List<Tip> listTip(Map<String, Object> map);
	public List<Tip> listTipTop();

	public Tip readTip(int tipNum);
	public Tip preReadTip(Map<String, Object> map);
	public Tip nextReadTip(Map<String, Object> map);

	public void updateTip(Tip dto) throws Exception;
	public void deleteTip(int tipNum, String userId) throws Exception;
	
	public void insertTipCategory(Tip dto) throws Exception;
	public void updateTipCategory(Tip dto) throws Exception;
	public void deleteTipCategory(int tipCategoryNum) throws Exception;
	public List<Tip> listTipCategory();
	
	public List<Reply> listReply(Map<String, Object> map);
	public int replyCount(Map<String, Object> map);
	public void insertReply(Reply dto) throws Exception;
	public void deleteReply(Map<String, Object> map) throws Exception;
	public List<Reply> listReplyParent(int parent);
	public int replyParentCount(int parent);
	
	public void insertTipLike(Map<String, Object> map) throws Exception;
	public int tipLikeCount(int tipNum);
	
	public void insertTipReport(Map<String, Object> map) throws Exception;
	public int tipReportCount(int tipNum);

}
