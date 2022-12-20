<%@page import="java.util.List"%>
<%@page import="com.semi.address.dao.AddressGroupDao"%>
<%@page import="com.semi.address.vo.Group"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="../logincheck.jsp" %>
<%
	// TODO session에서 로그인된 직원번호 조회
	int empNo = loginEmployee.getNo();
	
	String name = request.getParameter("name");
	
	AddressGroupDao groupDao = new AddressGroupDao();
	List<Group> addGroupList = groupDao.getAddGroupsByEmpNo(empNo);
	for (Group group : addGroupList) {
		if (group.getName().equals(name)) {
			response.sendRedirect("control.jsp?error=fail");
			return;
		}
	}
	
	Group group = new Group();
	group.setName(name);
	group.setEmpNo(empNo);
	
	groupDao.insertAddressGroup(group);
	
	
	response.sendRedirect("control.jsp");
%>