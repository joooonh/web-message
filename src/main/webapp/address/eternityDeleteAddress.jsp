<%@page import="com.semi.address.dao.AddressBookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	// 완전 삭제할 주소록이 여러개인 경우 배열로 값을 저장한다.
	String[] values = request.getParameterValues("addressBookNo");

	AddressBookDao addressDao = new AddressBookDao();
	// 배열에 담긴 주소록번호를 삭제하는 수행문을 반복한다.
	for (String value : values) {
		int addressBookNo = Integer.parseInt(value);
		
		// 주소록번호를 완전 삭제한다.
		addressDao.deleteAddress(addressBookNo);
	}
	
	response.sendRedirect("home.jsp");
%>