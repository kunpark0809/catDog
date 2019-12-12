package com.catDog.admin;

public class Money {
	private int requestNum, requsetDetailNum, productNum, productCount;
	private int productSum; // 한 품목 상품 개수
	private int point, purchase; // 포인트 사용금액 / 실 결제금액
	private String payMethod;
	private String name; // 상품명

	public int getRequestNum() {
		return requestNum;
	}

	public void setRequestNum(int requestNum) {
		this.requestNum = requestNum;
	}

	public int getRequsetDetailNum() {
		return requsetDetailNum;
	}

	public void setRequsetDetailNum(int requsetDetailNum) {
		this.requsetDetailNum = requsetDetailNum;
	}

	public int getProductNum() {
		return productNum;
	}

	public void setProductNum(int productNum) {
		this.productNum = productNum;
	}

	public int getProductCount() {
		return productCount;
	}

	public void setProductCount(int productCount) {
		this.productCount = productCount;
	}

	public int getProductSum() {
		return productSum;
	}

	public void setProductSum(int productSum) {
		this.productSum = productSum;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public int getPurchase() {
		return purchase;
	}

	public void setPurchase(int purchase) {
		this.purchase = purchase;
	}

	public String getPayMethod() {
		return payMethod;
	}

	public void setPayMethod(String payMethod) {
		this.payMethod = payMethod;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
