package com.semi.admin.dto;

import java.util.Date;

public class EmployeeDto {

	private int empNo;					
	private String password;			
	private String photo;				
	private String name;				
	private String email;				
	private String phone;				
	private int deptNo;					
	private int positionNo;				
	private String deleted;				
	private Date createdDate;			
	private Date updatedDate;			
	private Date deletedDate;			
	private String type;				
	private String departmentName;		
	private String positionName;		
	private int positionSeq;			
	
	public EmployeeDto() {}
	
	public int getEmpNo() {
		return empNo;
	}
	public void setEmpNo(int empNo) {
		this.empNo = empNo;
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
	public String getDepartmentName() {
		return departmentName;
	}
	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}
	public String getPositionName() {
		return positionName;
	}
	public void setPositionName(String positionName) {
		this.positionName = positionName;
	}
	public int getPositionSeq() {
		return positionSeq;
	}
	public void setPositionSeq(int positionSeq) {
		this.positionSeq = positionSeq;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}

	@Override
	public String toString() {
		return "EmployeeDto [empNo=" + empNo + ", password=" + password + ", photo=" + photo + ", name=" + name
				+ ", email=" + email + ", phone=" + phone + ", deptNo=" + deptNo + ", positionNo=" + positionNo
				+ ", deleted=" + deleted + ", createdDate=" + createdDate + ", updatedDate=" + updatedDate
				+ ", deletedDate=" + deletedDate + ", type=" + type + ", departmentName=" + departmentName
				+ ", positionName=" + positionName + ", positionSeq=" + positionSeq + ", getEmpNo()=" + getEmpNo()
				+ ", getPassword()=" + getPassword() + ", getPhoto()=" + getPhoto() + ", getName()=" + getName()
				+ ", getEmail()=" + getEmail() + ", getPhone()=" + getPhone() + ", getDeptNo()=" + getDeptNo()
				+ ", getPositionNo()=" + getPositionNo() + ", getDeleted()=" + getDeleted() + ", getCreatedDate()="
				+ getCreatedDate() + ", getUpdatedDate()=" + getUpdatedDate() + ", getDeletedDate()=" + getDeletedDate()
				+ ", getDepartmentName()=" + getDepartmentName() + ", getPositionName()=" + getPositionName()
				+ ", getPositionSeq()=" + getPositionSeq() + ", getType()=" + getType() + ", getClass()=" + getClass()
				+ ", hashCode()=" + hashCode() + ", toString()=" + super.toString() + "]";
	}
	
}
