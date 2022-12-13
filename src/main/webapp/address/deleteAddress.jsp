<%@page import="com.semi.address.dto.AddressDto"%>
<%@page import="com.semi.address.vo.AddressBook"%>
<%@page import="com.semi.address.dao.AddressBookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	// 삭제할 주소록이 여러개인 경우 배열로 값을 저장한다.
	String[] values = request.getParameterValues("addressBookNo");

	AddressBookDao addressDao = new AddressBookDao();
	
	// 배열에 담긴 주소록번호를 삭제하는 수행문을 반복한다.
	for (String value : values) {
		int addressBookNo = Integer.parseInt(value);
		
		// 주소록번호로 addressDto객체를 획득한다.
		AddressDto addressDto = addressDao.getAddressByBookNo(addressBookNo);
		// 주소록번호에 해당하는 주소록의 삭제여부를 Y로 변경한다.
		addressDto.setDeleted("Y");
		
		addressDao.updateAddressBook(addressDto);
	}
	
	response.sendRedirect("home.jsp");
%>