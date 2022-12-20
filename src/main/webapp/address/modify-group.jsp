<%@page import="com.semi.address.vo.Group"%>
<%@page import="com.semi.address.dao.AddressGroupDao"%>
<%@page import="com.semi.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="../logincheck.jsp" %>
<%
	int groupNo = StringUtils.stringToInt(request.getParameter("groupNo"));
	String name = request.getParameter("groupName");
	
	AddressGroupDao addrGroupDao = new AddressGroupDao();
	Group group = addrGroupDao.getAddressGroupByNo(groupNo);
	group.setName(name);
	
	addrGroupDao.updateAddressGroup(group);
	
	response.sendRedirect("control.jsp");
%>