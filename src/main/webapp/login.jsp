<%@page import="com.semi.admin.vo.Employee"%>
<%@page import="com.semi.admin.dao.EmployeeDao"%>
<%@page import="com.semi.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	int empNo = StringUtils.stringToInt(request.getParameter("no"));
	String password = request.getParameter("password");
	
	EmployeeDao employeeDao = EmployeeDao.getInstance();
	
	Employee employee = employeeDao.getEmployeeByNo(empNo);
	if (employee == null) {
		response.sendRedirect("home.jsp?error=fail");
		return;
	}
	if (!employee.getPassword().equals(password)) {
		response.sendRedirect("home.jsp?error=fail");
		return;
	}
	if (employee.getDeleted().equals("Y")) {
		response.sendRedirect("home.jsp?error=fail");
		return;
	}
	
	session.setAttribute("login_employee", employee);
	
	response.sendRedirect("loginHome.jsp");
	
%>