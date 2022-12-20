<%@page import="com.semi.message.dao.MessageDao"%>
<%@page import="com.semi.message.dto.MessageDeleteDto"%>
<%@page import="com.semi.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="../logincheck.jsp" %>
<%
	int empNo = loginEmployee.getNo();
	int messageNo = StringUtils.stringToInt(request.getParameter("messageNo"));
	
	MessageDeleteDto messageDeleteDto = new MessageDeleteDto();
	messageDeleteDto.setEmpNo(empNo);
	messageDeleteDto.setMessageNo(messageNo);
	
	MessageDao messageDao = MessageDao.getInstance();
	messageDao.cancelMessage(messageDeleteDto);
%>