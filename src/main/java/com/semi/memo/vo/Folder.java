package com.semi.memo.vo;

public class Folder {

		private int folderNo;
		private String folderName;
		private String folderSeq;
		
		public int getFolderNo() {
			return folderNo;
		}
		public void setFolderNo(int folderNo) {
			this.folderNo = folderNo;
		}
		public String getFolderName() {
			return folderName;
		}
		public void setFolderName(String folderName) {
			this.folderName = folderName;
		}
		public String getFolderSeq() {
			return folderSeq;
		}
		public void setFolderSeq(String folderSeq) {
			this.folderSeq = folderSeq;
		}
		
		@Override
		public String toString() {
			return "Folder [folderNo=" + folderNo + ", folderName=" + folderName + ", folderSeq=" + folderSeq + "]";
		}
		
		

}
