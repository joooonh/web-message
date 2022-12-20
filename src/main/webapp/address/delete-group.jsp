<%@page import="com.semi.address.dao.AddressGroupDao"%>
<%@page import="com.semi.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="../logincheck.jsp" %>
<%
	int groupNo = StringUtils.stringToInt(request.getParameter("groupNo"));

	AddressGroupDao addrGroupDao = new AddressGroupDao();
	
	addrGroupDao.deleteAddrGroup(groupNo);
	
	response.sendRedirect("control.jsp");
%>