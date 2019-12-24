package com.catDog.event;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Event {
	private int listNum;
	private int eventNum;
	private long num;
	private String userId;
	private String subject;
	private String content;
	private String created;
	private String startDate;
	private String endDate;
	private int hitCount;
	
	private int eventPicNum;
	private String imageFileName;
	private MultipartFile mainUpload;
	private List<MultipartFile> upload;
	
	public int getListNum() {
		return listNum;
	}
	public void setListNum(int listNum) {
		this.listNum = listNum;
	}
	public int getEventNum() {
		return eventNum;
	}
	public void setEventNum(int eventNum) {
		this.eventNum = eventNum;
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
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public int getHitCount() {
		return hitCount;
	}
	public void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}
	public int getEventPicNum() {
		return eventPicNum;
	}
	public void setEventPicNum(int eventPicNum) {
		this.eventPicNum = eventPicNum;
	}
	public String getImageFileName() {
		return imageFileName;
	}
	public void setImageFilename(String imageFileName) {
		this.imageFileName = imageFileName;
	}

	public MultipartFile getMainUpload() {
		return mainUpload;
	}
	public void setMainUpload(MultipartFile mainUpload) {
		this.mainUpload = mainUpload;
	}
	public List<MultipartFile> getUpload() {
		return upload;
	}
	public void setUpload(List<MultipartFile> upload) {
		this.upload = upload;
	}
	
	
}