<%@page import="com.semi.util.StringUtils"%>
<%@page import="com.semi.message.dao.MessageDao"%>
<%@page import="com.semi.message.dto.MessageDeleteDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	int empNo = 1000; // logincheck.jsp로부터 가져온 값
	MessageDao messageDao = MessageDao.getInstance();
	
	MessageDeleteDto messageDeleteDto = new MessageDeleteDto();
	messageDeleteDto.setEmpNo(empNo);
	
	String[] values = request.getParameterValues("messageNo");
	String group = request.getParameter("group");

	if ("all".equals(group) || "me".equals(group)) {
		for (String value : values) {
			int messageNo = StringUtils.stringToInt(value);
			messageDeleteDto.setMessageNo(messageNo);
			
			messageDao.deleteReceiveMessage(messageDeleteDto);
			messageDao.deleteSendMessage(messageDeleteDto);
		}
	} else if ("receive".equals(group)) {
		for (String value : values) {
			int messageNo = StringUtils.stringToInt(value);
			messageDeleteDto.setMessageNo(messageNo);
			
			messageDao.deleteReceiveMessage(messageDeleteDto);
		}
	} else if ("send".equals(group)) {
		for (String value : values) {
			int messageNo = StringUtils.stringToInt(value);
			messageDeleteDto.setMessageNo(messageNo);
			
			messageDao.deleteSendMessage(messageDeleteDto);
		}
	}
	
	response.sendRedirect("home.jsp?group=" + group);
%>