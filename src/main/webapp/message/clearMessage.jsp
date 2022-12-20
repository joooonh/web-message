<%@page import="com.semi.message.dao.MessageDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	int empNo = 1000; // logincheck.jsp로부터 가져온 값
	MessageDao messageDao = MessageDao.getInstance();
	
	String group = request.getParameter("group");
	
	if ("all".equals(group) || "me".equals(group)) {
		messageDao.clearReceiveMessage(empNo);
		messageDao.clearSendMessage(empNo);
	} else if ("receive".equals(group)) {
		messageDao.clearReceiveMessage(empNo);
	} else if ("send".equals(group)) {
		messageDao.clearSendMessage(empNo);
	}
	
	response.sendRedirect("home.jsp?group=" + group);
%>