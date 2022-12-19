<%@page import="com.semi.admin.vo.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	String menu = request.getParameter("menu");

	Employee loginEmployee = (Employee) session.getAttribute("login_employee");
	
%>
<nav class="navbar navbar-expand-sm navbar-dark" style="background-color: #019a30;">
	<div class="container">
<%
	if (loginEmployee == null) {
%>
		<a class="navbar-brand" href="/web-message/home.jsp">메세지 애플리케이션</a>
<%		
	}
%>			
<%
	if (loginEmployee != null) {
%>
		<a class="navbar-brand" href="/web-message/loginHome.jsp">메세지 애플리케이션</a>
<%
	}
%>		
		<ul class="navbar-nav me-auto mb-2 mb-lg-0">
<%
	if (loginEmployee == null) {
%>
			<li class="nav-item"><a class="nav-link active" aria-current="page" href="/web-message/home.jsp">홈</a></li>
<%		
	}
%>			
<%
	if (loginEmployee != null) {
%>
			<li class="nav-item"><a class="nav-link active" aria-current="page" href="/web-message/loginHome.jsp">홈</a></li>
			<li class="nav-item"><a class="nav-link" href="/web-message/address/home.jsp">주소록</a></li>
			<li class="nav-item"><a class="nav-link" href="/web-message/message/home.jsp">쪽지</a></li>
			<li class="nav-item"><a class="nav-link" href="/web-message/note/home.jsp">노트</a></li>
			
<%
	if ("관리자".equals(loginEmployee.getType())) {
%>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
					관리자
          		</a>
				<ul class="dropdown-menu">
					<li><a class="dropdown-item" href="/web-message/admin/depts.jsp">부서/직위 관리</a></li>
					<li><a class="dropdown-item" href="/web-message/admin/employees.jsp">직원관리</a></li>
				</ul>
			</li> 
<%
		}
	}
%>
		</ul>
<%
	if (loginEmployee != null) {
%>
		<p class="navbar-text"><strong><%=loginEmployee.getName() %></strong>님 환영합니다.</p>
<%
	}
%>
	</div>
</nav>