<%@page import="com.semi.address.vo.Address"%>
<%@page import="com.semi.address.dao.AddressDao"%>
<%@page import="com.semi.util.StringUtils"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.semi.address.vo.Email"%>
<%@page import="com.semi.address.dao.EmailDao"%>
<%@page import="com.semi.address.vo.Contact"%>
<%@page import="java.util.List"%>
<%@page import="com.semi.address.dao.ContactDao"%>
<%@page import="com.semi.address.vo.Book"%>
<%@page import="com.semi.address.dao.BookDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	// 주소록 번호 받기
	int bookNo = StringUtils.stringToInt(request.getParameter("bookNo"));
	
	// 주소록 번호에 해당하는 주소록 객체
	BookDao bookDao = BookDao.getInstance();
	Book book = bookDao.getBookByBookNo(bookNo);
	
	// 주소록 번호에 해당하는 전화번호 리스트
	ContactDao contactDao = ContactDao.getInstance();
	List<Contact> contactList = contactDao.getContactsByBookNo(bookNo);
	
	// 주소록 번호에 해당하는 이메일 리스트
	EmailDao emailDao = EmailDao.getInstance();
	List<Email> emailList = emailDao.getEmailsByBookNo(bookNo);
	
	// 주소록 번호에 해당하는 주소 리스트
	AddressDao addressDao = AddressDao.getInstance();
	List<Address> addressList = addressDao.getAddressesByBookNo(bookNo);
	
	// map에 담기
	Map<String, Object> map = new HashMap<>();
	map.put("book", book);
	map.put("contactList", contactList);
	map.put("emailList", emailList);
	map.put("addressList", addressList);
	
	// 응답보내기
	Gson gson = new GsonBuilder()
					.serializeNulls()
					.create();
	
	String json = gson.toJson(map);
	
	out.write(json);
	
%>

