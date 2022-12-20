package com.semi.message.vo;

import java.util.Date;

public class MessageGroup {
	
	private int groupNo;
	private String groupName;
	private String deleted;
	private Date createdDate;
	private Date updatedDate;
	private Date deletedDate;
	private String shareable;
	private int empNo;
	
	
	
	
	public MessageGroup() {

	}




	public int getGroupNo() {
		return groupNo;
	}




	public void setGroupNo(int groupNo) {
		this.groupNo = groupNo;
	}




	public String getGroupName() {
		return groupName;
	}




	public void setGroupName(String groupName) {
		this.groupName = groupName;
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




	public String getShareable() {
		return shareable;
	}
	
	public void setShareable(String shareable) {
		this.shareable = shareable;
	}


	public int getEmpNo() {
		return empNo;
	}




	public void setEmpNo(int empNo) {
		this.empNo = empNo;
	}




	@Override
	public String toString() {
		return "MessageGroup [groupNo=" + groupNo + ", groupName=" + groupName + ", deleted=" + deleted
				+ ", createdDate=" + createdDate + ", updatedDate=" + updatedDate + ", deletedDate=" + deletedDate
				+ ", shareable=" + shareable + ", empNo=" + empNo + "]";
	}


	
	

	
	
	
}
