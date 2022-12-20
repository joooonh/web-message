<%@page import="com.semi.admin.dao.DepartmentDao"%>
<%@page import="com.semi.admin.vo.Department"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%
	String departmentName = request.getParameter("departmentName");
	
	Department department = new Department();
	department.setName(departmentName);
	
	DepartmentDao departmentDao = DepartmentDao.getInstance();
	departmentDao.insertDepartment(department);
	
	response.sendRedirect("depts.jsp");

%>