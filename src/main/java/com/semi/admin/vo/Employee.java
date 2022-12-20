package com.semi.admin.vo;

import java.util.Date;

public class Employee {

	private int no;			// 직원번호
	private String password;	// 직원비밀번호
	private String photo;		// 직원사진
	private String name;		// 직원이름
	private String email;		// 이메일
	private String phone;		// 전화번호
	private int deptNo;			// 소속부서번호
	private int positionNo;		// 직위번호
	private String deleted;		// 직원정보 삭제여부
	private Date createdDate;	// 등록일
	private Date updatedDate;	// 수정일
	private Date deletedDate;	// 삭제일
	private String type;		// 직원타입
	
	public Employee() {}
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
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
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public int getDeptNo() {
		return deptNo;
	}
	public void setDeptNo(int deptNo) {
		this.deptNo = deptNo;
	}
	public int getPositionNo() {
		return positionNo;
	}
	public void setPositionNo(int positionNo) {
		this.positionNo = positionNo;
	}
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	public Date getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}
	public Date getUpdatedDate() {
		return updatedDate;
	}
	public void setUpdatedDate(Date updatedDate) {
		this.updatedDate = updatedDate;
	}
	public Date getDeletedDate() {
		return deletedDate;
	}
	public void setDeletedDate(Date deletedDate) {
		this.deletedDate = deletedDate;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}

	@Override
	public String toString() {
		return "Employee [no=" + no + ", password=" + password + ", photo=" + photo + ", name=" + name + ", email="
				+ email + ", phone=" + phone + ", deptNo=" + deptNo + ", positionNo=" + positionNo + ", deleted="
				+ deleted + ", createdDate=" + createdDate + ", updatedDate=" + updatedDate + ", deletedDate="
				+ deletedDate + ", type=" + type + "]";
	}
	
}
