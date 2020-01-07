package com.catDog.mpbbs;

public class Mpbbs {
	private long num;
	private String userId;
	private String nickName;
	
	private int bbsListNum;
	private int bbsNum;
	private String bbsSubject;
	private String bbsCreated;
	private int bbsHitCount;

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

	public int getBbsNum() {
		return bbsNum;
	}
	public void setBbsNum(int bbsNum) {
		this.bbsNum = bbsNum;
	}
	public String getBbsSubject() {
		return bbsSubject;
	}
	public void setBbsSubject(String bbsSubject) {
		this.bbsSubject = bbsSubject;
	}
	public String getBbsCreated() {
		return bbsCreated;
	}
	public void setBbsCreated(String bbsCreated) {
		this.bbsCreated = bbsCreated;
	}
	public int getBbsHitCount() {
		return bbsHitCount;
	}
	public void setBbsHitCount(int bbsHitCount) {
		this.bbsHitCount = bbsHitCount;
	}
	public int getBbsListNum() {
		return bbsListNum;
	}
	public void setBbsListNum(int bbsListNum) {
		this.bbsListNum = bbsListNum;
	}
	
}
