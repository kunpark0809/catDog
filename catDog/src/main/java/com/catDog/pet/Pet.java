package com.catDog.pet;

import org.springframework.web.multipart.MultipartFile;

public class Pet {
	private int myPetNum;
	private String subject;
	private String created;
	private String imageFileName;
	private int hitCount;
	private long num;
	
	private int listNum;
	
	private String userId;
	private String nickName;
	
	private MultipartFile upload;
	
	private int petLikeCount;
	
	private int petReportCount;
	
	private int reportNum;
	private int boardSort;
	private int reportedPostNum;
	private String reportDate;
	private int reporterNum;
	private int reportedNum;
	private int reasonSortNum;
	
	public int getBoardSort() {
		return boardSort;
	}
	public void setBoardSort(int boardSort) {
		this.boardSort = boardSort;
	}
	public int getReportedPostNum() {
		return reportedPostNum;
	}
	public void setReportedPostNum(int reportedPostNum) {
		this.reportedPostNum = reportedPostNum;
	}
	public String getReportDate() {
		return reportDate;
	}
	public void setReportDate(String reportDate) {
		this.reportDate = reportDate;
	}
	public int getReporterNum() {
		return reporterNum;
	}
	public void setReporterNum(int reporterNum) {
		this.reporterNum = reporterNum;
	}
	public int getReportedNum() {
		return reportedNum;
	}
	public void setReportedNum(int reportedNum) {
		this.reportedNum = reportedNum;
	}
	public int getReasonSortNum() {
		return reasonSortNum;
	}
	public void setReasonSortNum(int reasonSortNum) {
		this.reasonSortNum = reasonSortNum;
	}
	public int getListNum() {
		return listNum;
	}
	public void setListNum(int listNum) {
		this.listNum = listNum;
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
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getCreated() {
		return created;
	}
	public void setCreated(String created) {
		this.created = created;
	}
	public String getImageFileName() {
		return imageFileName;
	}
	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}
	public int getHitCount() {
		return hitCount;
	}
	public void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}
	public long getNum() {
		return num;
	}
	public void setNum(long num) {
		this.num = num;
	}
	public MultipartFile getUpload() {
		return upload;
	}
	public void setUpload(MultipartFile upload) {
		this.upload = upload;
	}
	public int getPetLikeCount() {
		return petLikeCount;
	}
	public void setPetLikeCount(int petLikeCount) {
		this.petLikeCount = petLikeCount;
	}
	public int getPetReportCount() {
		return petReportCount;
	}
	public void setPetReportCount(int petReportCount) {
		this.petReportCount = petReportCount;
	}
	public int getReportNum() {
		return reportNum;
	}
	public void setReportNum(int reportNum) {
		this.reportNum = reportNum;
	}
	
	
}