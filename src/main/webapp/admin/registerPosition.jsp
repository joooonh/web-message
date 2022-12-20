<%@page import="com.semi.admin.dao.PositionDao"%>
<%@page import="com.semi.admin.vo.Position"%>
<%@page import="com.semi.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%
	int seq = StringUtils.stringToInt(request.getParameter("seq"));
	String positionName = request.getParameter("positionName");
	
	Position position = new Position();
	position.setSeq(seq);
	position.setName(positionName);
	
	PositionDao positionDao = PositionDao.getInstance();
	positionDao.insertPosition(position);
	
	response.sendRedirect("depts.jsp");
	
%>