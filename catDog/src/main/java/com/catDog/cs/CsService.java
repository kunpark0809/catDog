package com.catDog.cs;

import java.util.List;
import java.util.Map;

public interface CsService {
	// Notice
	public void insertNotice(Notice dto, String pathname) throws Exception;
	
	public int noticeDataCount(Map<String, Object> map);
	public List<Notice> listNotice(Map<String, Object> map);
	public List<Notice> listNoticeTop();
	
	public void updateHitCount(int noticeNum) throws Exception;
	public Notice readNotice(int noticeNum);
	public Notice preReadNotice(Map<String, Object> map);
	public Notice nextReadNotice(Map<String, Object> map);
	
	public void updateNotice(Notice dto, String pathname) throws Exception;
	public void deleteNotice(int noticeNum, String pathname) throws Exception;
	
	public void insertFile(Notice dto) throws Exception;
	public List<Notice> listFile(int noticeNum);
	public Notice readFile(int fileNum);
	public void deleteFile(Map<String, Object> map) throws Exception;
	
	// Qna
	public void insertQna(Qna dto) throws Exception;
	
	public int qnaDataCount(Map<String, Object> map);
	public List<Qna> listQna(Map<String, Object> map);
	
	public Qna readQnaQuestion(int qnaNum);
	public Qna readQnaAnswer(int qnaNum);
	
	public Qna preReadQnaQuestion(Map<String, Object> map);
	public Qna nextReadQnaQuestion(Map<String, Object> map);
	
	public void updateQna(Qna dto) throws Exception;
	public void updateQnaAnswer(Qna dto) throws Exception;
	
	public void deleteQnaQuestion(int qnaNum) throws Exception;
	public void deleteQnaAnswer(int qnaNum) throws Exception;
	
	public void insertQnaCategory(Qna dto) throws Exception;
	public void updateQnaCategory(Qna dto) throws Exception;
	public void deleteQnaCategory(int qnaCategoryNum) throws Exception;
	public List<Qna> listQnaCategory();
	public List<Qna> listCategory(Map<String, Object> map);
	
	//Faq
	public void insertFaq(Qna dto) throws Exception;
	public int faqDataCount(Map<String, Object> map);
	public List<Qna> listFaq(Map<String, Object> map);
	
	public Qna readFaq(int faqNum);
	
	public void updateFaq(Qna dto) throws Exception;
	
	public void deleteFaq(int faqNum) throws Exception;
}
