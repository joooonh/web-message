package com.semi.address.vo;

public class Address {

	private String type;
	private String defaultYN;
	private String zipcode;
	private String basic; 
	private String detail; 
	private int bookNo;
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getDefaultYN() {
		return defaultYN;
	}
	public void setDefaultYN(String defaultYN) {
		this.defaultYN = defaultYN;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getBasic() {
		return basic;
	}
	public void setBasic(String basic) {
		this.basic = basic;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	public int getBookNo() {
		return bookNo;
	}
	public void setBookNo(int bookNo) {
		this.bookNo = bookNo;
	}
}
