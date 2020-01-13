package com.catDog.mptip;

public class Mptip {
	private long num;
	private String userId;
	private String nickName;
	
	private int tipListNum;
	private int tipNum;
	private String tipSubject;
	private String tipCreated;
	private int tipHitCount;
	private int tipCategoryNum;

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

	public int getTipNum() {
		return tipNum;
	}
	public void setTipNum(int tipNum) {
		this.tipNum = tipNum;
	}
	public String getTipSubject() {
		return tipSubject;
	}
	public void setTipSubject(String tipSubject) {
		this.tipSubject = tipSubject;
	}
	public String getTipCreated() {
		return tipCreated;
	}
	public void setTipCreated(String tipCreated) {
		this.tipCreated = tipCreated;
	}
	public int getTipHitCount() {
		return tipHitCount;
	}
	public void setTipHitCount(int tipHitCount) {
		this.tipHitCount = tipHitCount;
	}
	public int getTipListNum() {
		return tipListNum;
	}
	public void setTipListNum(int tipListNum) {
		this.tipListNum = tipListNum;
	}
	public int getTipCategoryNum() {
		return tipCategoryNum;
	}
	public void setTipCategoryNum(int tipCategoryNum) {
		this.tipCategoryNum = tipCategoryNum;
	}

	
}
