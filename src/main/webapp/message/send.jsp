<%@page import="com.semi.message.vo.MessageDepartment"%>
<%@page import="org.apache.catalina.ha.backend.Sender"%>
<%@page import="com.semi.message.vo.MessageReceiver"%>
<%@page import="com.semi.message.dao.MessageDao"%>
<%@page import="com.semi.message.vo.Message"%>
<%@page import="com.semi.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="../logincheck.jsp" %>
<!DOCTYPE html>
<%
	int loginEmpNo = loginEmployee.getNo();
	MessageDao messageDao = MessageDao.getInstance();
	String[] receiverList = request.getParameterValues("receiverNo");
	
	for (String value : receiverList) {
		int receiverNo = StringUtils.stringToInt(value);	
		int messageNo = messageDao.getMessageNo();
		
		String messageMe = StringUtils.nullToValue(request.getParameter("me"), "N");
		String messageSentBox = StringUtils.nullToValue(request.getParameter("sentBox"), "N");
		String messageType = StringUtils.nullToValue(request.getParameter("type"), "E");
		String messageContent = request.getParameter("content");
		
		if (receiverNo == loginEmpNo) {
			messageMe = "Y";
		}
		
		Message message = new Message();
		message.setMessageNo(messageNo);
		message.setMessageSendEmpNo(loginEmpNo);
		message.setMessageMe(messageMe);
		message.setMessageSentBox(messageSentBox);
		message.setMessageType(messageType);
		message.setMessageContent(messageContent);
		message.setGroupNo(100);		// 메세지 그룹 번호는 브라우저에서 어떻게 받아와야하는지?
		
		messageDao.sendMessage(message);
		
		// 수신자 입력폼으로부터 수신자 번호를 메세지 수신자 정보 테이블에 저장.
		// 메세지 타입(개인 or 부서)에 따라 DAO메서드(메세지 수신자 정보 or 메세지 수신부서 정보)가 달라짐
		
		if ("E".equals(messageType)) {
			MessageReceiver messageReceiver = new MessageReceiver();
			messageReceiver.setEmpNo(receiverNo);
			messageReceiver.setMessageNo(messageNo);
			
			messageDao.receiveMessageEmployee(messageReceiver);
		} else if ("D".equals(messageType)) {
			MessageDepartment messageDepartment = new MessageDepartment();
			messageDepartment.setDeptNo(receiverNo);
			messageDepartment.setMessageNo(messageNo);
			
			messageDao.receiveMessageDepartment(messageDepartment);
		}
	}
	
	response.sendRedirect("home.jsp?group=send");
%>