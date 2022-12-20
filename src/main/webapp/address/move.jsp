<%@page import="com.semi.address.vo.AddressBook"%>
<%@page import="com.semi.address.dao.AddressBookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	String bookNo1 = request.getParameter("bookNo");
	String[] bookNoList = bookNo1.split(",");
	int groupNo = Integer.parseInt(request.getParameter("groupNo"));
	
	AddressBookDao addressBookDao = AddressBookDao.getInstance();
	
	for (String values : bookNoList) {
		int bookNo = Integer.parseInt(values);
		// 주소록번호에 해당하는 AddressBook객체
		AddressBook addressBook = addressBookDao.getAddressBookByBookNo(bookNo);
		// 이동할 그룹의 번호를 저장
		addressBook.setGroupNo(groupNo);
		addressBook.setDeleted("N");
		
		addressBookDao.updateAddressBook(addressBook);
	}
	
	response.sendRedirect("home.jsp");
%>