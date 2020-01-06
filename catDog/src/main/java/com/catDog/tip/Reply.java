package com.catDog.tip;

public class Reply {
	private int tipReplyNum;
	private String content;
	private String created;
	private int parent;
	private long num;
	private int tipNum;
	
	private String userId;
	private String nickName;
	
	private int parentCount;

	public int getTipReplyNum() {
		return tipReplyNum;
	}

	public void setTipReplyNum(int tipReplyNum) {
		this.tipReplyNum = tipReplyNum;
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

	public long getNum() {
		return num;
	}

	public void setNum(long num) {
		this.num = num;
	}

	public int getTipNum() {
		return tipNum;
	}

	public void setTipNum(int tipNum) {
		this.tipNum = tipNum;
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
