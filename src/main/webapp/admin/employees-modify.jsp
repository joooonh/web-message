<%@page import="com.semi.admin.dao.EmployeeDao"%>
<%@page import="com.semi.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="../logincheck.jsp" %>
<%
	int empNo = StringUtils.stringToInt(request.getParameter("no"));
	String name = request.getParameter("name");
	int deptNo = StringUtils.stringToInt(request.getParameter("deptNo"));
	int positionNo = StringUtils.stringToInt(request.getParameter("positionNo"));
	String email = request.getParameter("email");
	String phone = request.getParameter("phone");
	String type = request.getParameter("type");
	String deleted = request.getParameter("deleted");
	
	EmployeeDao employeeDao = EmployeeDao.getInstance();
	
	// 직원번호로 직원정보 조회
	Employee employee = employeeDao.getEmployeeByNo(empNo);
	employee.setName(name);
	employee.setDeptNo(deptNo);
	employee.setPositionNo(positionNo);
	employee.setEmail(email);
	employee.setPhone(phone);
	employee.setType(type);
	employee.setDeleted(deleted);
	
	// 변경사항 테이블에 반영
	employeeDao.updateEmployee(employee);
	
	response.sendRedirect("employees.jsp");
	
%>