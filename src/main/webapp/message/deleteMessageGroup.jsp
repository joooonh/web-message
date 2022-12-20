<%@page import="com.semi.message.vo.MessageGroup"%>
<%@page import="com.semi.message.dao.MessageGroupDao"%>
<%@page import="com.semi.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<% 
	// 그룹 번호 조회
	int empNo = 1010;

	String[] MessageGroupArray = request.getParameterValues("groupNo");
	   
	MessageGroupDao messageGroupDao = MessageGroupDao.getInstance();
	   for (String str : MessageGroupArray) {
	   		int groupNo = Integer.parseInt(str);
	   		messageGroupDao.deleteMessageGroup(groupNo);
	   }
	  
	// 재요청URL
	response.sendRedirect("groups.jsp");

%>

