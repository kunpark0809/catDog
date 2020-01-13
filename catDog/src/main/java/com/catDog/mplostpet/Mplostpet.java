package com.catDog.mplostpet;

public class Mplostpet {
	private long num;
	private String userId;
	private String nickName;
	
	private int lostPetListNum;
	private int lostPetNum;
	private int speciesSort;
	private int sort;
	private int status;
	private String lostSubject;
	private String lostCreated;
	private int lostHitCount;
	
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
	public int getLostPetNum() {
		return lostPetNum;
	}
	public void setLostPetNum(int lostPetNum) {
		this.lostPetNum = lostPetNum;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public String getLostSubject() {
		return lostSubject;
	}
	public void setLostSubject(String lostSubject) {
		this.lostSubject = lostSubject;
	}
	public String getLostCreated() {
		return lostCreated;
	}
	public void setLostCreated(String lostCreated) {
		this.lostCreated = lostCreated;
	}
	public int getLostHitCount() {
		return lostHitCount;
	}
	public void setLostHitCount(int lostHitCount) {
		this.lostHitCount = lostHitCount;
	}
	public int getLostPetListNum() {
		return lostPetListNum;
	}
	public void setLostPetListNum(int lostPetListNum) {
		this.lostPetListNum = lostPetListNum;
	}
	public int getSpeciesSort() {
		return speciesSort;
	}
	public void setSpeciesSort(int speciesSort) {
		this.speciesSort = speciesSort;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	
}
