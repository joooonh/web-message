package com.semi.message.vo;
/*
MESSAGE_NO				NUMBER(6,0)		No					1	메세지번호
EMP_NO					NUMBER(4,0)		No					2	직원번호
MESSAGE_RECEIVE_DATE	DATE			Yes		SYSDATE		3	메세지 수신날짜
MESSAGE_DELETED			CHAR(1 BYTE)	Yes					4	메세지 삭제여부
*/

import java.util.Date;

public class MessageReceivers {

	private int messageNo;
	private int messageReceiveEmpNo;
	private Date messageReceiveDate;
	private String messageDeleted;
	
	public int getMessageNo() {
		return messageNo;
	}
	
	public void setMessageNo(int messageNo) {
		this.messageNo = messageNo;
	}
	
	public int getMessageReceiveEmpNo() {
		return messageReceiveEmpNo;
	}
	
	public void setMessageReceiveEmpNo(int empNo) {
		this.messageReceiveEmpNo = empNo;
	}
	
	public Date getMessageReceiveDate() {
		return messageReceiveDate;
	}
	
	public void setMessageReceiveDate(Date messageReceiveDate) {
		this.messageReceiveDate = messageReceiveDate;
	}
	
	public String getMessageDeleted() {
		return messageDeleted;
	}
	
	public void setMessageDeleted(String messageDeleted) {
		this.messageDeleted = messageDeleted;
	}
}
