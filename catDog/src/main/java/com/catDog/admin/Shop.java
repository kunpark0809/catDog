package com.catDog.admin;

public class Shop {
	// customer 테이블
	private int num;
	private int membership;

	// customerDetail 테이블
	private String email, tel, customerName;

	// memberDetail 테이블
	private String userId;

	// request 테이블
	private String addr, addr1, addr2, zip, memo;
	private int total, status;
//		0: 입금대기
//		1: 결제완료
//		2: 배송준비중
//		3: 배송중
//		4: 배송완료
//		5: 취소완료
//		6: 환불진행중
//		7: 환불완료
//		8: 교환진행중
//		9: 교환완료
//		10: 리뷰완료
	private String totalWithComma;
	private String statusToString;

	// request 테이블
	private int requestNum, requestDetailNum, productNum, productCount, productSum;
	private String requestDate;

	// product 테이블
	private String productName;

	// payment 테이블
	private int point, purchase, stackPoint;
	private int payMethod;
//		 0 : 무통장입금
//		 1 : 신카
//		 2 : 계좌이체
//		 3 : 휴대폰결제

	// refund 테이블
	private String refundReason, refundAccount, bank, refundName;

	// deliver 테이블
	private String invoice;

	// express 테이블
	private String expressName, expressTel;

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public int getMembership() {
		return membership;
	}

	public void setMembership(int membership) {
		this.membership = membership;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getAddr1() {
		return addr1;
	}

	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}

	public String getAddr2() {
		return addr2;
	}

	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}

	public String getZip() {
		return zip;
	}

	public void setZip(String zip) {
		this.zip = zip;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getTotalWithComma() {
		return totalWithComma;
	}

	public void setTotalWithComma(String totalWithComma) {
		this.totalWithComma = totalWithComma;
	}

	public String getStatusToString() {
		return statusToString;
	}

	public void setStatusToString(String statusToString) {
		this.statusToString = statusToString;
	}

	public int getRequestNum() {
		return requestNum;
	}

	public void setRequestNum(int requestNum) {
		this.requestNum = requestNum;
	}

	public int getRequestDetailNum() {
		return requestDetailNum;
	}

	public void setRequestDetailNum(int requestDetailNum) {
		this.requestDetailNum = requestDetailNum;
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

	public String getRequestDate() {
		return requestDate;
	}

	public void setRequestDate(String requestDate) {
		this.requestDate = requestDate;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
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

	public int getStackPoint() {
		return stackPoint;
	}

	public void setStackPoint(int stackPoint) {
		this.stackPoint = stackPoint;
	}

	public int getPayMethod() {
		return payMethod;
	}

	public void setPayMethod(int payMethod) {
		this.payMethod = payMethod;
	}

	public String getRefundReason() {
		return refundReason;
	}

	public void setRefundReason(String refundReason) {
		this.refundReason = refundReason;
	}

	public String getRefundAccount() {
		return refundAccount;
	}

	public void setRefundAccount(String refundAccount) {
		this.refundAccount = refundAccount;
	}

	public String getBank() {
		return bank;
	}

	public void setBank(String bank) {
		this.bank = bank;
	}

	public String getRefundName() {
		return refundName;
	}

	public void setRefundName(String refundName) {
		this.refundName = refundName;
	}

	public String getInvoice() {
		return invoice;
	}

	public void setInvoice(String invoice) {
		this.invoice = invoice;
	}

	public String getExpressName() {
		return expressName;
	}

	public void setExpressName(String expressName) {
		this.expressName = expressName;
	}

	public String getExpressTel() {
		return expressTel;
	}

	public void setExpressTel(String expressTel) {
		this.expressTel = expressTel;
	}

}
