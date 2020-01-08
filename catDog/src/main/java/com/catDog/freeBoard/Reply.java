package com.catDog.freeBoard;

public class Reply {
	private int bbsReplyNum;
	private String content;
	private String created;
	private int parent;
	private int bbsNum;
	private long num;

	private String userId;
	private String nickName;

	private int parentCount;

	public int getBbsReplyNum() {
		return bbsReplyNum;
	}

	public void setBbsReplyNum(int bbsReplyNum) {
		this.bbsReplyNum = bbsReplyNum;
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

	public int getBbsNum() {
		return bbsNum;
	}

	public void setBbsNum(int bbsNum) {
		this.bbsNum = bbsNum;
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

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public int getParentCount() {
		return parentCount;
	}

	public void setParentCount(int parentCount) {
		this.parentCount = parentCount;
	}
	
	
}
