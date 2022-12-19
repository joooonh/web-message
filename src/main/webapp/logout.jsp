<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	//로그아웃은 기존 세션객체를 무효화시킨다.
	session.invalidate();

	response.sendRedirect("home.jsp");
%>