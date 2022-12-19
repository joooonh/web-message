<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.semi.address.vo.Book"%>
<%@page import="com.semi.address.dao.BookDao"%>
<%@page import="com.semi.util.StringUtils"%>
<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%

	// 주소록 번호, important(Y, N)받기
	int bookNo = StringUtils.stringToInt(request.getParameter("bookNo"));
	
	BookDao bookDao = BookDao.getInstance();
	Book book = bookDao.getBookByBookNo(bookNo);

	Gson gson = new GsonBuilder()
					.serializeNulls()
					.create();
	
	 if("Y".equals(book.getImportant())){
		book.setImportant("N"); 
		bookDao.updateImportant(book); 
	} else {
		book.setImportant("Y");
		bookDao.updateImportant(book); 
	} 
	String json = gson.toJson(book);
	out.write(json);
	 
%>