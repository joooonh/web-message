<%@page import="com.semi.message.vo.MessageDepartment"%>
<%@page import="org.apache.catalina.ha.backend.Sender"%>
<%@page import="com.semi.message.vo.MessageReceiver"%>
<%@page import="com.semi.message.dao.MessageDao"%>
<%@page import="com.semi.message.vo.Message"%>
<%@page import="com.semi.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<!-- logincheck.jsp 삽입 필요 -->
<%
int empNo = 1000; // logincheck.jsp로부터 empNo를 받아와야 함, 1000은 임의로 생성한 값임.
	MessageDao messageDao = MessageDao.getInstance();
	int messageNo = messageDao.getMessageNo();
	
	String messageMe = StringUtils.nullToValue(request.getParameter("me"), "N");
	String messageSentBox = StringUtils.nullToValue(request.getParameter("sentBox"), "N");
	String messageType = StringUtils.nullToValue(request.getParameter("type"), "E");
	String messageContent = request.getParameter("content");
	
	Message message = new Message();
	message.setMessageNo(messageNo);
	message.setMessageSendEmpNo(empNo);
	message.setMessageMe(messageMe);
	message.setMessageSentBox(messageSentBox);
	message.setMessageType(messageType);
	message.setMessageContent(messageContent);
	message.setGroupNo(100);		// 메세지 그룹 번호는 브라우저에서 어떻게 받아와야하는지?
	
	messageDao.sendMessage(message);

	
	// TODO 수신자 입력폼으로부터 주소록 번호 혹은 주소록 그룹 번호를 받아서 수신자 직원 번호를 조회한 후, 메세지 수신자 정보 테이블에 저장.
	// 메세지 타입(개인 or 부서)에 따라 DAO메서드(메세지 수신자 정보 or 메세지 수신부서 정보)가 달라짐
	int receiver = StringUtils.stringToInt(request.getParameter("receiver"), empNo);
	
	if ("E".equals(messageType)) {
		MessageReceiver messageReceiver = new MessageReceiver();
		messageReceiver.setEmpNo(receiver);
		messageReceiver.setMessageNo(messageNo);
		
		messageDao.receiveMessageEmployee(messageReceiver);
	} else if ("D".equals(messageType)) {
		MessageDepartment messageDepartment = new MessageDepartment();
		messageDepartment.setDeptNo(receiver);
		messageDepartment.setMessageNo(messageNo);
		
		messageDao.receiveMessageDepartment(messageDepartment);
	}
	
	response.sendRedirect("home.jsp");
%>