package com.semi.message.vo;

import java.util.Date;

//	컬럼이름					데이터 타입				null허용		기본값
//  MESSAGE_NO				NUMBER(6,0)			No	
//  MESSAGE_ME				CHAR(1 BYTE)		Yes			'N'
//  MESSAGE_SENT_BOX		CHAR(1 BYTE)		Yes			'Y'
//  MESSAGE_SAVE_BOX		CHAR(1 BYTE)		Yes			'N'
//  MESSAGE_READING			CHAR(1 BYTE)		Yes			'N'
//  MESSAGE_CANCEL			CHAR(1 BYTE)		Yes			'N'
//  MESSAGE_DELETED			CHAR(1 BYTE)		Yes	
//  MESSAGE_SPAM			CHAR(1 BYTE)		Yes	
//  MESSAGE_CONTENT			VARCHAR2(2000 BYTE)	No	
//  MESSAGE_SEND_EMP_NO		NUMBER(4,0)			No	
//  MESSAGE_SEND_DATE		DATE				Yes			SYSDATE
//  MESSAGE_RECEIVE_DATE	DATE				Yes			SYSDATE
//  MESSAGE_DELETED_DATE	DATE				Yes	
//  GROUP_NO				NUMBER(3,0)			Yes	
//  MESSAGE_TYPE			CHAR(1 BYTE)		Yes			'E' /* 메세지 종류 */

public class Message {
	
	private int messageNo;
	private String messageMe;
	private String messageSentBox;
	private String messageSaveBox;
	private String messageReading;
	private String messageCancel;
	private String messageDeleted;
	private String messageSpam;
	private String messageContent;
	private int messageSendEmpNo;
	private Date messageSendDate;
	private Date messageReceiveDate;
	private Date messageDeletedDate;
	private int groupNo;
	private String messageType;
	
	public int getMessageNo() {
		return messageNo;
	}
	public void setMessageNo(int messageNo) {
		this.messageNo = messageNo;
	}
	public String getMessageMe() {
		return messageMe;
	}
	public void setMessageMe(String messageMe) {
		this.messageMe = messageMe;
	}
	public String getMessageSentBox() {
		return messageSentBox;
	}
	public void setMessageSentBox(String messageSentBox) {
		this.messageSentBox = messageSentBox;
	}
	public String getMessageSaveBox() {
		return messageSaveBox;
	}
	public void setMessageSaveBox(String messageSaveBox) {
		this.messageSaveBox = messageSaveBox;
	}
	public String getMessageReading() {
		return messageReading;
	}
	public void setMessageReading(String messageReading) {
		this.messageReading = messageReading;
	}
	public String getMessageCancel() {
		return messageCancel;
	}
	public void setMessageCancel(String messageCancel) {
		this.messageCancel = messageCancel;
	}
	public String getMessageDeleted() {
		return messageDeleted;
	}
	public void setMessageDeleted(String messageDeleted) {
		this.messageDeleted = messageDeleted;
	}
	public String getMessageSpam() {
		return messageSpam;
	}
	public void setMessageSpam(String messageSpam) {
		this.messageSpam = messageSpam;
	}
	public String getMessageContent() {
		return messageContent;
	}
	public void setMessageContent(String messageContent) {
		this.messageContent = messageContent;
	}
	public int getMessageSendEmpNo() {
		return messageSendEmpNo;
	}
	public void setMessageSendEmpNo(int messageSendEmpNo) {
		this.messageSendEmpNo = messageSendEmpNo;
	}
	public Date getMessageSendDate() {
		return messageSendDate;
	}
	public void setMessageSendDate(Date messageSendDate) {
		this.messageSendDate = messageSendDate;
	}
	public Date getMessageReceiveDate() {
		return messageReceiveDate;
	}
	public void setMessageReceiveDate(Date messageReceiveDate) {
		this.messageReceiveDate = messageReceiveDate;
	}
	public Date getMessageDeletedDate() {
		return messageDeletedDate;
	}
	public void setMessageDeletedDate(Date messageDeletedDate) {
		this.messageDeletedDate = messageDeletedDate;
	}
	public int getGroupNo() {
		return groupNo;
	}
	public void setGroupNo(int groupNo) {
		this.groupNo = groupNo;
	}
	public String getMessageType() {
		return messageType;
	}
	public void setMessageType(String messageType) {
		this.messageType = messageType;
	}
}
