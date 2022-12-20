<%@page import="com.semi.message.vo.MessageGroup"%>
<%@page import="com.semi.message.dao.MessageGroupDao"%>
<%@page import="com.semi.util.StringUtils"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@ page language="java" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	// 요청파라미터값을 조회한다.
	int groupNo = StringUtils.stringToInt(request.getParameter("no"));
	String groupName = request.getParameter("name");

	MessageGroupDao messageGroupDao = MessageGroupDao.getInstance();
	// 직원정보를 조회한다.
	MessageGroup messageGroup = messageGroupDao.getMessageGroupsByGroupNo(groupNo);
	messageGroup.setGroupName(groupName);
	
	messageGroupDao.updateMessageGroup(messageGroup);

	out.write("success");
%>