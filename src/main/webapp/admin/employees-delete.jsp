<%@page import="com.semi.admin.vo.Employee"%>
<%@page import="com.semi.admin.dao.EmployeeDao"%>
<%@page import="com.semi.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	int empNo = StringUtils.stringToInt(request.getParameter("empNo"));

	EmployeeDao employeeDao = EmployeeDao.getInstance();
	
	Employee employee = employeeDao.getEmployeeByNo(empNo);
	employee.setDeleted("Y");
	
	employeeDao.updateEmployee(employee);
	
	response.sendRedirect("employees.jsp");
%>