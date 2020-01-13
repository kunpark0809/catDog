package com.catDog.aband;

import org.springframework.web.multipart.MultipartFile;

public class Aband {
	private int lostPetNum;
	private int sort; // 분류 번호
	private String subject; // 제목
	private String content; // 내용
	private String created; // 작성날짜
	private String lostDate; // 사건날짜
	private int hitCount; // 조회수
	private String addr; // 발견 or 잃어버린 장소
	private long num; // 고객번호
	private String nickName; // 닉네임
	private String imageFileName; 
	private int status; // 진행상황
	private int speciesSort; // 동물분류
	  
	private MultipartFile upload;

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


	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getCreated() {
		return created;
	}

	public void setCreated(String created) {
		this.created = created;
	}

	public int getHitCount() {
		return hitCount;
	}

	public void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public long getNum() {
		return num;
	}

	public void setNum(long num) {
		this.num = num;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getImageFileName() {
		return imageFileName;
	}

	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getSpeciesSort() {
		return speciesSort;
	}

	public void setSpeciesSort(int speciesSort) {
		this.speciesSort = speciesSort;
	}

	public MultipartFile getUpload() {
		return upload;
	}

	public void setUpload(MultipartFile upload) {
		this.upload = upload;
	}

	public String getLostDate() {
		return lostDate;
	}

	public void setLostDate(String lostDate) {
		this.lostDate = lostDate;
	}
	
	
}
