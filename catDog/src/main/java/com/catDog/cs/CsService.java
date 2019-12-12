package com.catDog.cs;

import java.util.List;
import java.util.Map;

public interface CsService {
	// Notice
	public void insertNotice(Notice dto, String pathname) throws Exception;
	
	public int noticeDataCount(Map<String, Object> map);
	public List<Notice> listNotice(Map<String, Object> map);
	public List<Notice> listNoticeTop();
	
	public void updateHitCount(int num) throws Exception;
	public Notice readNotice(int num);
	public Notice preReadNotice(Map<String, Object> map);
	public Notice nextReadNotice(Map<String, Object> map);
	
	public void updateNotice(Notice dto, String pathname) throws Exception;
	public void deleteNotice(int num, String pathname) throws Exception;
	
	public void insertFile(Notice dto) throws Exception;
	public List<Notice> listFile(int num);
	public Notice readFile(int fileNum);
	public void deleteFile(Map<String, Object> map) throws Exception;
	
	// Qna
	public void insertQna(Qna dto) throws Exception;
	public int qnaDataCount(Map<String, Object> map);
	public List<Qna> listQna(Map<String, Object> map);
	
	public Qna readQna(int num);
	public Qna preReadQna(Map<String, Object> map);
	public Qna nextReadQna(Map<String, Object> map);
	
	public void updateQna(Qna dto) throws Exception;
	
	public void deleteQna(int num) throws Exception;
	
	//Faq
	public void insertFaq(Qna dto) throws Exception;
	public int faqDataCount(Map<String, Object> map);
	public List<Qna> listFaq(Map<String, Object> map);
	
	public Qna readFaq(int num);
	public Qna preReadFaq(Map<String, Object> map);
	public Qna nextReadFaq(Map<String, Object> map);
	
	public void updateFaq(Qna dto) throws Exception;
	
	public void deleteFaq(int num) throws Exception;
}
