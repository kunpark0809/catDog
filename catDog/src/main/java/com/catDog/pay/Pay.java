package com.catDog.pay;

public class Pay {
	private long num; // 고객번호
	private String userId, name;
	private String email, email1, email2;
	private String tel, tel1, tel2, tel3;
	private String addr, addr1, addr2;
	private String zip;
	private int mileage; // 보유 포인트
	
	private String deliverAddr1;
	private String deliverAddr2;
	private String deliverZip;
	private String deliverTel;
	private String deliverTel1;
	private String deliverTel2;
	private String deliverTel3;
	private String deliverName;
	
	private String memo; // 배송메모
	private String requestNum; // 주문번호
	private String requestDate; // 주문날짜
	private int total; // 총결제금액 (배송비포함)
	private int status; // 진행상태
	
	private String requestDetailNum; // 주문 상세번호
	private int productCount; // 주문수량
	private int productSum; // 단일품목총액 (가격*주문수량)
	
	private String payMethod; // 결제수단
	private int usePoint; // 사용 포인트
	private int point; // 적립 포인트
	private int purchase; // 결제금액
	
	private String cartNum; // 장바구니 번호
	private String productName; // 용품 이름 (db - name)
	private String productNum; // 용품번호
	private String refundAccount; // 환불계좌
	private String bank; // 환불은행
	private int price; // 용품 단품 가격
	private String imageFileName;
	
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getEmail1() {
		return email1;
	}
	public void setEmail1(String email1) {
		this.email1 = email1;
	}
	public String getEmail2() {
		return email2;
	}
	public void setEmail2(String email2) {
		this.email2 = email2;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getTel1() {
		return tel1;
	}
	public void setTel1(String tel1) {
		this.tel1 = tel1;
	}
	public String getTel2() {
		return tel2;
	}
	public void setTel2(String tel2) {
		this.tel2 = tel2;
	}
	public String getTel3() {
		return tel3;
	}
	public void setTel3(String tel3) {
		this.tel3 = tel3;
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
	public String getDeliverAddr1() {
		return deliverAddr1;
	}
	public void setDeliverAddr1(String deliverAddr1) {
		this.deliverAddr1 = deliverAddr1;
	}
	public String getDeliverAddr2() {
		return deliverAddr2;
	}
	public void setDeliverAddr2(String deliverAddr2) {
		this.deliverAddr2 = deliverAddr2;
	}
	public String getDeliverZip() {
		return deliverZip;
	}
	public void setDeliverZip(String deliverZip) {
		this.deliverZip = deliverZip;
	}
	public String getDeliverTel() {
		return deliverTel;
	}
	public void setDeliverTel(String deliverTel) {
		this.deliverTel = deliverTel;
	}
	public String getDeliverName() {
		return deliverName;
	}
	public void setDeliverName(String deliverName) {
		this.deliverName = deliverName;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getRequestDate() {
		return requestDate;
	}
	public void setRequestDate(String requestDate) {
		this.requestDate = requestDate;
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
	public String getRequestDetailNum() {
		return requestDetailNum;
	}
	public void setRequestDetailNum(String requestDetailNum) {
		this.requestDetailNum = requestDetailNum;
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
	public String getPayMethod() {
		return payMethod;
	}
	public void setPayMethod(String payMethod) {
		this.payMethod = payMethod;
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
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
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

	public String getDeliverTel1() {
		return deliverTel1;
	}
	public void setDeliverTel1(String deliverTel1) {
		this.deliverTel1 = deliverTel1;
	}
	public String getDeliverTel2() {
		return deliverTel2;
	}
	public void setDeliverTel2(String deliverTel2) {
		this.deliverTel2 = deliverTel2;
	}
	public String getDeliverTel3() {
		return deliverTel3;
	}
	public void setDeliverTel3(String deliverTel3) {
		this.deliverTel3 = deliverTel3;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getImageFileName() {
		return imageFileName;
	}
	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}
	public String getRequestNum() {
		return requestNum;
	}
	public void setRequestNum(String requestNum) {
		this.requestNum = requestNum;
	}
	public String getProductNum() {
		return productNum;
	}
	public void setProductNum(String productNum) {
		this.productNum = productNum;
	}
	public int getUsePoint() {
		return usePoint;
	}
	public void setUsePoint(int usePoint) {
		this.usePoint = usePoint;
	}
	public int getMileage() {
		return mileage;
	}
	public void setMileage(int mileage) {
		this.mileage = mileage;
	}
	public String getZip() {
		return zip;
	}
	public void setZip(String zip) {
		this.zip = zip;
	}
	public String getCartNum() {
		return cartNum;
	}
	public void setCartNum(String cartNum) {
		this.cartNum = cartNum;
	}


	
}
