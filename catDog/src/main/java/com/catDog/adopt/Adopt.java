package com.catDog.adopt;

import org.springframework.web.multipart.MultipartFile;
 
public class Adopt {
	private long num; // 고객번호
	private String nickName;
	
	private String adoptionNum; // 입양글번호
	private int speciesSort; // 종 분류
	private int status; // 진행분류
	private String created; // 작성일
	private String subject; // 제목
	private String content; // 내용
	private int hitCount; // 조회수
	private String imageFileName;
	
	private MultipartFile upload;
	
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
	public String getAdoptionNum() {
		return adoptionNum;
	}
	public void setAdoptionNum(String adoptionNum) {
		this.adoptionNum = adoptionNum;
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
	public String getCreated() {
		return created;
	}
	public void setCreated(String created) {
		this.created = created;
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
	public int getHitCount() {
		return hitCount;
	}
	public void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}
	public MultipartFile getUpload() {
		return upload;
	}
	public void setUpload(MultipartFile upload) {
		this.upload = upload;
	}
	public String getImageFileName() {
		return imageFileName;
	}
	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}
	
}
