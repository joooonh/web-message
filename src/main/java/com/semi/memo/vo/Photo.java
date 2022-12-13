package com.semi.memo.vo;

public class Photo {

		private int no;
		private String photoFileName;
		
		public int getNo() {
			return no;
		}
		public void setNo(int no) {
			this.no = no;
		}
		public String getPhotoFileName() {
			return photoFileName;
		}
		public void setPhotoFileName(String photoFileName) {
			this.photoFileName = photoFileName;
		}
		
		@Override
		public String toString() {
			return "Photo [no=" + no + ", photoFileName=" + photoFileName + "]";
		}
		
		
		
}