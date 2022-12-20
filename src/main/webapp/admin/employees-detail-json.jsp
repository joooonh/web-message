<%@page import="com.semi.util.StringUtils"%>
<%@page import="com.semi.admin.vo.Employee"%>
<%@page import="com.semi.admin.dao.EmployeeDao"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%--
	요청 방식
		GET
	요청 URL
		http://localhost/community/admin/employees-detail-json.jsp?empNo=1000
	요청 파라미터
		empNo		직원번호
	요청 처리 내용
		요청파라미터로 전달받은 직원번호에 해당하는 직원정보를 조회해서 JSON 형식의 응답데이터를 보낸다.
--%>
<%
	// 요청파라미터값을 조회한다.
	int empNo = StringUtils.stringToInt(request.getParameter("empNo"));

	EmployeeDao employeeDao = EmployeeDao.getInstance();
	// 직원정보를 조회한다.
	Employee employee = employeeDao.getEmployeeByNo(empNo);
	
	Gson gson = new GsonBuilder()
		.serializeNulls()
		.setDateFormat("yyyy년 M월 d일")
		.create();
	String jsonText = gson.toJson(employee);
	
	out.write(jsonText);
%>