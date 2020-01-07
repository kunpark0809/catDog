package com.catDog.shop;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Shop {
	private String smallSortNum;
	private String sortName;
	private String bigSortNum;
	
	private int productNum;
	private String name;
	private int price;
	private String content;
	private String created;
	
	
	private int productPicNum;
	private String imageFileName;
	private MultipartFile main;
	private List<MultipartFile> upload;
	
	private long num;
	private String productReviewNum;
	private String productDetailNum;
	private int rate;
	private String nickName;
	
	public String getSmallSortNum() {
		return smallSortNum;
	}
	public void setSmallSortNum(String smallSortNum) {
		this.smallSortNum = smallSortNum;
	}
	public String getSortName() {
		return sortName;
	}
	public void setSortName(String sortName) {
		this.sortName = sortName;
	}
	public String getBigSortNum() {
		return bigSortNum;
	}
	public void setBigSortNum(String bigSortNum) {
		this.bigSortNum = bigSortNum;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
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

	public int getProductPicNum() {
		return productPicNum;
	}
	public void setProductPicNum(int productPicNum) {
		this.productPicNum = productPicNum;
	}
	public String getImageFileName() {
		return imageFileName;
	}
	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}

	public int getProductNum() {
		return productNum;
	}
	public void setProductNum(int productNum) {
		this.productNum = productNum;
	}
	public List<MultipartFile> getUpload() {
		return upload;
	}
	public void setUpload(List<MultipartFile> upload) {
		this.upload = upload;
	}
	public MultipartFile getMain() {
		return main;
	}
	public void setMain(MultipartFile main) {
		this.main = main;
	}
	public String getProductReviewNum() {
		return productReviewNum;
	}
	public void setProductReviewNum(String productReviewNum) {
		this.productReviewNum = productReviewNum;
	}
	public int getRate() {
		return rate;
	}
	public void setRate(int rate) {
		this.rate = rate;
	}
	public long getNum() {
		return num;
	}
	public void setNum(long num) {
		this.num = num;
	}
	public String getProductDetailNum() {
		return productDetailNum;
	}
	public void setProductDetailNum(String productDetailNum) {
		this.productDetailNum = productDetailNum;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	
}
