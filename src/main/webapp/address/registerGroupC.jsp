<%@page import="com.semi.address.dao.AddressGroupDao"%>
<%@page import="com.semi.address.vo.Group"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	// TODO session에서 로그인된 직원번호 조회
	int empNo = 1000;

	String name = request.getParameter("name");

	Group group = new Group();
	group.setName(name);
	group.setEmpNo(empNo);
	
	AddressGroupDao groupDao = new AddressGroupDao();
	groupDao.insertAddressGroup(group);
	
	
	response.sendRedirect("control.jsp");
%>