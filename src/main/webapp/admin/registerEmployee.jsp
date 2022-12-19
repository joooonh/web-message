<%@page import="java.util.List"%>
<%@page import="com.semi.admin.vo.Employee"%>
<%@page import="com.semi.admin.dao.EmployeeDao"%>
<%@page import="com.semi.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
/*
	- 직원 신규등록
	- 직원번호, 이름, 비밀번호, 소속부서, 직위, 이메일, 전화번호, 직원타입 not null
*/
	String name = request.getParameter("name");
	int deptNo = StringUtils.stringToInt(request.getParameter("deptNo"));
	int positionNo = StringUtils.stringToInt(request.getParameter("positionNo"));
	String email = request.getParameter("email");
	String phone = request.getParameter("phone");
	String type = request.getParameter("type");
	
	EmployeeDao employeeDao = EmployeeDao.getInstance();
	
	List<Employee> empList = employeeDao.getAllEmployees();
	for (Employee employee : empList) {
		if (employee.getEmail().equals(email)) {
			response.sendRedirect("employees.jsp?error=fail");
			return;
		}
		if (employee.getPhone().equals(phone)) {
			response.sendRedirect("employees.jsp?error=fail");
			return;
		}
	}
	
	Employee employee = new Employee();
	employee.setName(name);
	employee.setPassword("1234");
	employee.setDeptNo(deptNo);
	employee.setPositionNo(positionNo);
	employee.setEmail(email);
	employee.setPhone(phone);
	employee.setType(type);
	
	employeeDao.insertEmployee(employee);
	
	response.sendRedirect("employees.jsp");
	
%>