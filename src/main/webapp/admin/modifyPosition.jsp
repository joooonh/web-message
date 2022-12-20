<%@page import="com.semi.admin.vo.Position"%>
<%@page import="com.semi.admin.dao.PositionDao"%>
<%@page import="com.semi.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%
	int positionNo = StringUtils.stringToInt(request.getParameter("positionNo"));
	String positionName = request.getParameter("positionName");
	int seq = StringUtils.stringToInt(request.getParameter("seq"));
	
	PositionDao positionDao = PositionDao.getInstance();
	
	Position position = positionDao.getPositionByNo(positionNo);
	
	position.setName(positionName);
	position.setSeq(seq);
	positionDao.updatePosition(position);
	
	response.sendRedirect("depts.jsp");
%>