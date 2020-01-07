package com.catDog.mpmypet;

public class Mpmypet {
	private long num;
	private String userId;
	private String nickName;
	
	private int petListNum;
	private int myPetNum;
	private String myPetSubject;
	private String myPetCreated;
	private int myPetHitCount;
	

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
	public int getMyPetNum() {
		return myPetNum;
	}
	public void setMyPetNum(int myPetNum) {
		this.myPetNum = myPetNum;
	}
	public String getMyPetSubject() {
		return myPetSubject;
	}
	public void setMyPetSubject(String myPetSubject) {
		this.myPetSubject = myPetSubject;
	}
	public String getMyPetCreated() {
		return myPetCreated;
	}
	public void setMyPetCreated(String myPetCreated) {
		this.myPetCreated = myPetCreated;
	}
	public int getMyPetHitCount() {
		return myPetHitCount;
	}
	public void setMyPetHitCount(int myPetHitCount) {
		this.myPetHitCount = myPetHitCount;
	}
	
	public int getPetListNum() {
		return petListNum;
	}
	public void setPetListNum(int petListNum) {
		this.petListNum = petListNum;
	}
	
}
