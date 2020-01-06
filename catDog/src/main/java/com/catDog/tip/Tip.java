package com.catDog.tip;

import org.springframework.web.multipart.MultipartFile;

public class Tip {
	private int listNum;
	
	private int tipNum;
	private String subject;
	private String content;
	private String created;
	private int hitCount;
	private long num;
	
	private int tipPicNum;
	private String imageFileName;
	private MultipartFile upload;
	
	private String userId;
	private String nickName;
	
	private int tipLikeCount;
	
	private int tipReportCount;
	private int reportNum;
	private int boardSort;
	private int reportedPostNum;
	private String reportDate;
	private int reporterNum;
	private int reportedNum;
	private int reasonSortNum;

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
	
	public int getListNum() {
		return listNum;
	}
	public void setListNum(int listNum) {
		this.listNum = listNum;
	}
	public int getTipNum() {
		return tipNum;
	}
	public void setTipNum(int tipNum) {
		this.tipNum = tipNum;
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
	public long getNum() {
		return num;
	}
	public void setNum(long num) {
		this.num = num;
	}
	public int getTipPicNum() {
		return tipPicNum;
	}
	public void setTipPicNum(int tipPicNum) {
		this.tipPicNum = tipPicNum;
	}
	public String getImageFileName() {
		return imageFileName;
	}
	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}
	public MultipartFile getUpload() {
		return upload;
	}
	public void setUpload(MultipartFile upload) {
		this.upload = upload;
	}
	public int getTipLikeCount() {
		return tipLikeCount;
	}
	public void setTipLikeCount(int tipLikeCount) {
		this.tipLikeCount = tipLikeCount;
	}
	public int getTipReportCount() {
		return tipReportCount;
	}
	public void setTipReportCount(int tipReportCount) {
		this.tipReportCount = tipReportCount;
	}
	public int getReportNum() {
		return reportNum;
	}
	public void setReportNum(int reportNum) {
		this.reportNum = reportNum;
	}
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
	
}
