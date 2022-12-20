<%@page import="com.semi.admin.vo.Department"%>
<%@page import="com.semi.admin.dao.DepartmentDao"%>
<%@page import="com.semi.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%
	int departmentNo = StringUtils.stringToInt(request.getParameter("departmentNo"));
	String departmentName = request.getParameter("departmentName");
	
	DepartmentDao departmentDao = DepartmentDao.getInstance();
	
	Department department = departmentDao.getDepartmentByNo(departmentNo);
	
	department.setName(departmentName);
	departmentDao.updatedDeparment(department);
	
	response.sendRedirect("depts.jsp");
%>