package com.catDog.mpqna;

public class Mpqna {
	private long num;
	private String userId;
	private String nickName;

	private int qnaListNum;
	private int qnaNum;
	private int qnaCategoryNum;
	private String qnaCategory;
	private String qnaSubject;
	private String qnaCreated;
	private int qnaIsAnswer;
	private Integer qnaParent;
	
	public int getQnaIsAnswer() {
		return qnaIsAnswer;
	}
	public void setQnaIsAnswer(int qnaIsAnswer) {
		this.qnaIsAnswer = qnaIsAnswer;
	}
	public Integer getQnaParent() {
		return qnaParent;
	}
	public void setQnaParent(Integer qnaParent) {
		this.qnaParent = qnaParent;
	}
	public long getNum() {
		return num;
	}
	public void setNum(long num) {
		this.num = num;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public int getQnaNum() {
		return qnaNum;
	}
	public void setQnaNum(int noticeNum) {
		this.qnaNum = noticeNum;
	}
	public String getQnaSubject() {
		return qnaSubject;
	}
	public void setQnaSubject(String noticeSubject) {
		this.qnaSubject = noticeSubject;
	}
	public String getQnaCreated() {
		return qnaCreated;
	}
	public void setQnaCreated(String noticeCreated) {
		this.qnaCreated = noticeCreated;
	}
	public int getQnaCategoryNum() {
		return qnaCategoryNum;
	}
	public void setQnaCategoryNum(int qnaCategoryNum) {
		this.qnaCategoryNum = qnaCategoryNum;
	}
	public String getQnaCategory() {
		return qnaCategory;
	}
	public void setQnaCategory(String qnaCategory) {
		this.qnaCategory = qnaCategory;
	}
	public int getQnaListNum() {
		return qnaListNum;
	}
	public void setQnaListNum(int qnaListNum) {
		this.qnaListNum = qnaListNum;
	}
	
}
