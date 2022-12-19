<%@page import="com.semi.admin.vo.Employee"%>
<%@ page language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	Employee loginEmployee = (Employee) session.getAttribute("login_employee");
	if (loginEmployee == null) {
		response.sendRedirect("../home.jsp");
		return;
	}
%>