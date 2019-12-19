package com.catDog.event;

public class Reply {
	private int eventReplyNum;
	private int eventNum;
	private long num;
	private String userId;
	private String content;
	private String created;
	private int answer;
	
	public int getEventReplyNum() {
		return eventReplyNum;
	}
	public void setEventReplyNum(int eventReplyNum) {
		this.eventReplyNum = eventReplyNum;
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
	public int getAnswer() {
		return answer;
	}
	public void setAnswer(int answer) {
		this.answer = answer;
	}
	
	
}
