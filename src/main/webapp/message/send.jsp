<%@page import="org.apache.catalina.ha.backend.Sender"%>
<%@page import="com.semi.message.vo.MessageReceivers"%>
<%@page import="com.semi.message.dao.MessageDao"%>
<%@page import="com.semi.message.vo.Message"%>
<%@page import="com.semi.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<!-- logincheck.jsp 삽입 필요 -->
<%
	// TODO logincheck.jsp로부터 empNo를 받아와야 함, 1000은 임의로 생성한 값임.
	// 메세지 송신자의 직원번호 저장.
	int empNo = 1000;
	int messageSendEmpNo = empNo;
	
	String messageMe = StringUtils.nullToValue(request.getParameter("me"), "N");
	String messageSentBox = StringUtils.nullToValue(request.getParameter("sentBox"), "N");
	String messageType = StringUtils.nullToValue(request.getParameter("type"), "E");
	String messageContent = request.getParameter("content");
	
	Message message = new Message();
	message.setMessageSendEmpNo(messageSendEmpNo);
	message.setMessageMe(messageMe);
	message.setMessageSentBox(messageSentBox);
	message.setMessageType(messageType);
	message.setMessageContent(messageContent);
	// 메세지 그룹 번호는 브라우저에서 어떻게 받아와야하는지?
	message.setGroupNo(100);
	
	MessageDao messageDao = MessageDao.getInstance();
	int messageNo = messageDao.getMessageNo();
	message.setMessageNo(messageNo);
	messageDao.sendMessage(message);

	
	// TODO 수신자 입력폼으로부터 주소록 번호 혹은 주소록 그룹 번호를 받아서 수신자 직원 번호를 조회한 후, 메세지 수신자 정보 테이블에 저장.
	// 수신자 입력폼이 null인 경우, 내게 쓰기임.
	int messageReceiverNo = StringUtils.stringToInt(request.getParameter("receiver"), empNo);
	
	MessageReceivers messageReceivers = new MessageReceivers();
	messageReceivers.setMessageReceiveEmpNo(messageReceiverNo);
	messageReceivers.setMessageNo(messageNo);
	messageDao.receiveMessageEmployee(messageReceivers);
	
	response.sendRedirect("home.jsp");
%>