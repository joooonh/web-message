<%@page import="com.semi.memo.vo.Memo"%>
<%@page import="com.semi.memo.dao.MemoDao"%>
<%@page import="com.semi.util.StringUtils"%>
<%@page import="com.semi.admin.vo.Employee"%>
<%@page import="com.semi.admin.dao.EmployeeDao"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<title>웹 애플리케이션</title>
</head>
<body>
<div class="container">

<%
   //TODO session에서 로그인된 직원번호 조회
   int empNo = 1006;
  //int empNo = loginEmployee.getNo();
  
   int memoNo = Integer.parseInt(request.getParameter("memoNo"));
   String important= request.getParameter("important");
   
   MemoDao memoDao = new MemoDao();
  
  Memo memo = memoDao.getMemoByNo(memoNo);
  if ("Y".equals(important)) {
	  memo.setImportant("N");
  } else {
	  memo.setImportant("Y");
  }
  memoDao.updateMemo(memo);
	     

  
   response.sendRedirect("home.jsp");
%>

   
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
</html>