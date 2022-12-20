<%@page import="com.semi.admin.dto.EmployeeDto"%>
<%@page import="com.semi.util.Pagination"%>
<%@page import="com.semi.admin.dao.EmployeeDao"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.semi.util.StringUtils"%>
<%@page import="com.semi.admin.vo.Employee"%>
<%@page import="com.semi.admin.vo.Position"%>
<%@page import="com.semi.admin.dao.PositionDao"%>
<%@page import="com.semi.admin.vo.Department"%>
<%@page import="java.util.List"%>
<%@page import="com.semi.admin.dao.DepartmentDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../logincheck.jsp" %>
    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css">
<link href="/web-message/resources/css/style.css" rel="stylesheet">
<title>사내 커뮤니티</title>
</head>
<body>
<jsp:include page="../common/header.jsp">
	<jsp:param name="menu" value="admin"/>
</jsp:include>
<%
	int currentPage = StringUtils.stringToInt(request.getParameter("page"), 1);

	Map<String, Object> param = new HashMap<>();
	
	EmployeeDao employeeDao = EmployeeDao.getInstance();
	DepartmentDao departmentDao = DepartmentDao.getInstance();
	PositionDao positionDao = PositionDao.getInstance();
	
	int totalRows = employeeDao.getTotalRows(param);
	
	Pagination pagination = new Pagination(currentPage, totalRows);
	param.put("begin", pagination.getBegin());
	param.put("end", pagination.getEnd());

	List<EmployeeDto> employeeList = employeeDao.getEmployees(param);
	List<Department> departmentList = departmentDao.getAllDepartments();
	List<Position> positionList = positionDao.getAllPositions();
	
	String error = request.getParameter("error");
%>
<div class="container my-3">
	<div class="row mb-3">
		<div class="col">
			<h1 class="heading">직원 관리</h1>
		</div>
	</div>
	<div class="row mb-3">
<%
	if ("fail".equals(error)) {
%>
	<div class="alert alert-danger" style="font-size: 14px;">
		<strong>등록 실패</strong> 이미 존재하는 이메일입니다.
	</div>
<%
	}
%>
		<div class="col">
			<div class="card">
				<div class="card-header">직원 리스트</div>
				<div class="card-body">
					<p>직원 목록을 확인하세요.</p>
					<table class="table table-sm" id="table-employees">
						<colgroup>
							<col width="10%">
							<col width="15%">
							<col width="15%">
							<col width="15%">
							<col width="15%">
							<col width="15%">
							<col width="15%">
						</colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th>이름</th>
								<th>부서명</th>
								<th>직위</th>
								<th>연락처</th>
								<th>이메일</th>								
								<th></th>
							</tr>
						</thead>
						<tbody>
<%
	for (EmployeeDto empDto : employeeList) {
%>
							<tr>
								<td><%=empDto.getEmpNo() %></td>
								<td><%=empDto.getName() %></td>
								<td><%=empDto.getDepartmentName() %></td>
								<td><%=empDto.getPositionName() %></td>
								<td><%=empDto.getPhone() %></td>
								<td><%=empDto.getEmail() %></td>
								<td>
									<button class="btn btn-outline-primary btn-xs" data-emp-no="<%=empDto.getEmpNo() %>">상세정보</button>
									<a href="employees-delete.jsp?empNo=<%=empDto.getEmpNo() %>" class="btn btn-danger btn-xs <%=empDto.getDeleted().equals("Y") ? "disabled" : "" %>">삭제</a>
								</td>
							</tr>
<%
	}
%>
						</tbody>
					</table>
					<nav>
<%
	int beginPage = pagination.getBeginPage();
	int endPage = pagination.getEndPage();
	int prevPage = pagination.getPrevPage();
	int nextPage = pagination.getNextPage();
	boolean isFirst = pagination.isFirst();
	boolean isLast = pagination.isLast();
%>
						<ul class="pagination pagination-sm justify-content-center">
							<li class="page-item <%=isFirst ? "disabled" : ""%>">
								<a class="page-link" href="employees.jsp?page=<%=prevPage %>" data-page-no="<%=prevPage %>">이전</a>
							</li>
<%
	for (int number = beginPage; number <= endPage; number++) {
%>
							<li class="page-item">
								<a class="page-link <%=number == currentPage ? "active" : ""%>" href="employees.jsp?page=<%=number %>" data-page-no="<%=number %>"><%=number %></a>
							</li>
<%
	}
%>							
							<li class="page-item <%=isLast ? "disabled" : ""%>">
								<a class="page-link" href="employees.jsp?page=<%=nextPage %>" data-page-no="<%=nextPage %>">다음</a>
							</li>
						</ul>
					</nav>
				</div>
				<div class="card-footer text-end">
					<button class="btn btn-primary btn-xs" data-bs-toggle="modal" data-bs-target="#modal-form-employees">신규 등록</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-------------------------------------------------------직원 정보 등록폼 ------------------------------------------------------------------------>
<div class="modal" tabindex="-1" id="modal-form-employees">
	<div class="modal-dialog">
		<form id="form-add-employee" class="border p-3 bg-light" method="post" action="registerEmployee.jsp">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">직원 정보 등록폼</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
					<div class="row mb-2">
						<label class="col-sm-3 col-form-label col-form-label-sm">이름</label>
						<div class="col-sm-9">
							<input type="text" class="form-control form-control-sm" name="name" placeholder="직원이름">
						</div>
					</div>
					<div class="row mb-2">
						<label class="col-sm-3 col-form-label col-form-label-sm">소속부서</label>
						<div class="col-sm-6">
							<select class="form-select form-select-sm" name="deptNo">
								<!-- comm_employees 테이블에 저장된 내용을 출력하세요 -->
<%
	for (Department dept : departmentList) {
%>
								<option value="<%=dept.getNo() %>"> <%=dept.getName() %></option>
<%
	}
%>
							</select>
						</div>
					</div>
					<div class="row mb-2">
						<label class="col-sm-3 col-form-label col-form-label-sm">직위</label>
						<div class="col-sm-6">
							<select class="form-select form-select-sm" name="positionNo">
								<!-- comm_postions 테이블에 저장된 내용을 출력하세요 -->
<%
	for (Position position : positionList) {
%>
								<option value="<%=position.getNo() %>"> <%=position.getName() %></option>
<%
	}
%>
							</select>
						</div>
					</div>
					<div class="row mb-2">
						<label class="col-sm-3 col-form-label col-form-label-sm">이메일</label>
						<div class="col-sm-9">
							<input type="text" class="form-control form-control-sm" name="email" placeholder="이메일">
						</div>
					</div>
					<div class="row mb-2">
						<label class="col-sm-3 col-form-label col-form-label-sm">전화번호</label>
						<div class="col-sm-6">
							<input type="text" class="form-control form-control-sm" name="phone" placeholder="전화번호">
						</div>
					</div>
					<div class="row mb-2">
						<label class="col-sm-3 col-form-label col-form-label-sm">직원타입</label>
						<div class="col-sm-6">
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="type" value="사용자" checked>
								<label class="form-check-label">사용자</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="type" value="관리자" >
								<label class="form-check-label">관리자</label>
							</div>
						</div>
					</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary btn-xs" data-bs-dismiss="modal">닫기</button>
				<button type="submit" class="btn btn-primary btn-xs">등록</button>
			</div>
		</div>
	</form>
	</div>
</div>
<!-------------------------------------------- 직원상세정보 -------------------------------------------------->
<div class="modal" tabindex="-1" id="modal-detailform-employees">
	<div class="modal-dialog">
	<form class="border p-3 bg-light" method="post" action="employees-modify.jsp">
		<input type="hidden" name="no" />
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">직원 상세 정보</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="row mb-2">
					<label class="col-sm-3 col-form-label col-form-label-sm">이름</label>
					<div class="col-sm-9">
						<input type="text" class="form-control form-control-sm" name="name" placeholder="직원이름" />
					</div>
				</div>
				<div class="row mb-2">
					<label class="col-sm-3 col-form-label col-form-label-sm">소속부사</label>
					<div class="col-sm-6">
						<select class="form-select form-select-sm" name="deptNo">
<%
	for (Department dept : departmentList) {
%>
							<option value="<%=dept.getNo() %>"> <%=dept.getName() %></option>
<%
	}
%>
						</select>
					</div>
				</div>
				<div class="row mb-2">
					<label class="col-sm-3 col-form-label col-form-label-sm">직위</label>
					<div class="col-sm-6">
						<select class="form-select form-select-sm" name="positionNo">
<%
	for (Position position : positionList) {
%>
							<option value="<%=position.getNo() %>"> <%=position.getName() %></option>
<%
	}
%>
						</select>
					</div>
				</div>
				<div class="row mb-2">
					<label class="col-sm-3 col-form-label col-form-label-sm">이메일</label>
					<div class="col-sm-9">
						<input type="text" class="form-control form-control-sm" name="email" placeholder="이메일" />
					</div>
				</div>
				<div class="row mb-2">
					<label class="col-sm-3 col-form-label col-form-label-sm">전화번호</label>
					<div class="col-sm-6">
						<input type="text" class="form-control form-control-sm" name="phone" placeholder="전화번호" />
					</div>
				</div>
				<div class="row mb-2">
					<label class="col-sm-3 col-form-label col-form-label-sm">직원타입</label>
					<div class="col-sm-6">
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="type" value="사용자" />
							<label class="form-check-label">사용자</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="type" value="관리자" />
							<label class="form-check-label">관리자</label>
						</div>
					</div>
				</div>
				<div class="row mb-2">
					<label class="col-sm-3 col-form-label col-form-label-sm">삭제여부</label>
					<div class="col-sm-6">
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="deleted" value="N" />
							<label class="form-check-label">삭제되지 않음</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="deleted" value="Y" />
							<label class="form-check-label">삭제됨</label>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary btn-xs" data-bs-dismiss="modal">닫기</button>
				<button type="submit" class="btn btn-primary btn-xs">수정</button>
			</div>
		</div>
	</form>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
	
	// 직원등록
	$("#form-add-employee").submit(function() {
		let name = $(":input[name=name]").val();
		let email = $(":input[name=email]").val();
		let phone = $(":input[name=phone]").val();
		
		if (name === "") {
			alert("이름은 필수입력값입니다.");
			return false;
		}
		
		if (email === "") {
			alert("이메일은 필수입력값입니다.");
			return false;
		}
		
		if (phone === "") {
			alert("전화번호는 필수입력값입니다.");
			return false;
		}
		
		return true;
	})
	
	// 직원상세정보
	let employeeDetailModal = new bootstrap.Modal("#modal-detailform-employees");
	
	$("#table-employees tbody .btn").click(function() {
		let empNo = $(this).attr("data-emp-no");
		
		$.getJSON("employees-detail-json.jsp", {empNo: empNo}, function(employee) {
			$("#modal-detailform-employees [name=no]").val(employee.no);
			$("#modal-detailform-employees [name=name]").val(employee.name);
			$("#modal-detailform-employees [name=deptNo]").val(employee.deptNo);
			$("#modal-detailform-employees [name=positionNo]").val(employee.positionNo);
			$("#modal-detailform-employees [name=phone]").val(employee.phone);
			$("#modal-detailform-employees [name=email]").val(employee.email);
			$("#modal-detailform-employees [name=type][value="+employee.type+"]").prop("checked", true);
			$("#modal-detailform-employees [name=deleted][value="+employee.deleted+"]").prop("checked", true);
			
			employeeDetailModal.show();
		})
	});
});	
</script>
</body>
</html>