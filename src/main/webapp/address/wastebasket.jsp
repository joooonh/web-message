<%@page import="com.semi.address.dto.AddressDto"%>
<%@page import="java.util.List"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.semi.address.dao.AddressBookDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	// 직원번호를 저장한다.
	int empNo = Integer.parseInt(request.getParameter("empNo"));
	
	// 직원번호로 삭제여부가 'Y'인 게시글을 addressList에 담는다.
	AddressBookDao addressDao = new AddressBookDao();
	List<AddressDto> addressList = addressDao.getAddressByEmpNoFindY(empNo);
	
	Gson gson = new GsonBuilder().serializeNulls().setDateFormat("yyyy년 M월 d일").create();
	String json = gson.toJson(addressList);
	
	out.write(json);
%>