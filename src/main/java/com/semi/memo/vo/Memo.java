package com.semi.memo.vo;

import java.util.Date;

public class Memo {
		
	    private int no;
		private int folderNo;
		private int empNo;
		private String important;
		private String content;
		private String deleted;
		private Date createdDate;
		private Date updatedDate;
		private Date deletedDate;
		
		public int getNo() {
			return no;
		}
		
		public void setNo(int no) {
			this.no = no;
		}
		public int getFolderNo() {
			return folderNo;
		}
		public void setFolderNo(int folderNo) {
			this.folderNo = folderNo;
		}
		public int getEmpNo() {
			return empNo;
		}
		public void setEmpNo(int empNo) {
			this.empNo = empNo;
		}
		public String getImportant() {
			return important;
		}
		public void setImportant(String important) {
			this.important = important;
		}
		public String getContent() {
			return content;
		}
		public void setContent(String content) {
			this.content = content;
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

		@Override
		public String toString() {
			return "Memo [no=" + no + ", folderNo=" + folderNo + ", empNo=" + empNo + ", important=" + important
					+ ", content=" + content + ", deleted=" + deleted + ", createdDate=" + createdDate
					+ ", updatedDate=" + updatedDate + ", deletedDate=" + deletedDate + "]";
		}
		
}
		