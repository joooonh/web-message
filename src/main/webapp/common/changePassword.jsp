<%@page import="com.semi.admin.dao.EmployeeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="../logincheck.jsp" %>
<%
/*
	비밀번호 변경
*/
	String prevPassword = request.getParameter("prevPassword");
	String password = request.getParameter("password");
	int empNo = loginEmployee.getNo();

	//loginEmployee.setPassword(password);
	
	EmployeeDao empDao = EmployeeDao.getInstance();
	
	Employee employee = empDao.getEmployeeByNo(empNo);
	// 현재 비밀번호 일치여부 확인
	if (!employee.getPassword().equals(prevPassword)) {
		response.sendRedirect("passwordform.jsp?error=fail");
		return;
	}
	
	employee.setPassword(password);
	empDao.updateEmployee(employee);
	
	response.sendRedirect("../home.jsp");
%>