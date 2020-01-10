package com.catDog.aband;

public class Reply {
	private long num;
	private String nickName;
	private String content;
	private String created;
	private int parent;
	
	private int replyCount;
	private int adoptionReplyNum;
	
	private int answerCount;
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
	public int getParent() {
		return parent;
	}
	public void setParent(int parent) {
		this.parent = parent;
	}
	public int getReplyCount() {
		return replyCount;
	}
	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}
	public int getAdoptionReplyNum() {
		return adoptionReplyNum;
	}
	public void setAdoptionReplyNum(int adoptionReplyNum) {
		this.adoptionReplyNum = adoptionReplyNum;
	}
	public int getAnswerCount() {
		return answerCount;
	}
	public void setAnswerCount(int answerCount) {
		this.answerCount = answerCount;
	}
	
	
}
