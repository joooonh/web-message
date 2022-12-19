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
	DepartmentDao departmentDao = DepartmentDao.getInstance();
	PositionDao positionDao = PositionDao.getInstance();

	List<Department> departmentList = departmentDao.getAllDepartments();
	List<Position> positionList = positionDao.getAllPositions();
%>
<div class="container my-3">
	<div class="row mb-3">
		<div class="col">
			<h1 class="heading">직원 관리</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col">
			<div class="card">
				<div class="card-header">직원 리스트</div>
				<div class="card-body">
					<p>직원 목록을 확인하세요.</p>
					<table class="table table-sm">
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
								<td>부서명</td>
								<td>직위</td>
								<td>연락처</td>
								<td>이메일</td>								
								<td></td>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>100</td>
								<td>홍길동</td>
								<td>영업부</td>
								<td>과장</td>
								<td>010-1111-1234</td>
								<td>hong@gmail.com</td>
								<td>
									<button class="btn btn-outline-primary btn-xs">수정</button>
									<button class="btn btn-outline-secondary btn-xs">삭제</button>
								</td>
							</tr>
							<tr>
								<td>100</td>
								<td>홍길동</td>
								<td>영업부</td>
								<td>과장</td>
								<td>010-1111-1234</td>
								<td>hong@gmail.com</td>
								<td>
									<button class="btn btn-outline-primary btn-xs">수정</button>
									<button class="btn btn-outline-secondary btn-xs">삭제</button>
								</td>
							</tr>
							<tr>
								<td>100</td>
								<td>홍길동</td>
								<td>영업부</td>
								<td>과장</td>
								<td>010-1111-1234</td>
								<td>hong@gmail.com</td>
								<td>
									<button class="btn btn-outline-primary btn-xs">수정</button>
									<button class="btn btn-outline-secondary btn-xs">삭제</button>
								</td>
							</tr>
							<tr>
								<td>100</td>
								<td>홍길동</td>
								<td>영업부</td>
								<td>과장</td>
								<td>010-1111-1234</td>
								<td>hong@gmail.com</td>
								<td>
									<button class="btn btn-outline-primary btn-xs">수정</button>
									<button class="btn btn-outline-secondary btn-xs">삭제</button>
								</td>
							</tr>
							<tr>
								<td>100</td>
								<td>홍길동</td>
								<td>영업부</td>
								<td>과장</td>
								<td>010-1111-1234</td>
								<td>hong@gmail.com</td>
								<td>
									<button class="btn btn-outline-primary btn-xs">수정</button>
									<button class="btn btn-outline-secondary btn-xs">삭제</button>
								</td>
							</tr>
							<tr>
								<td>100</td>
								<td>홍길동</td>
								<td>영업부</td>
								<td>과장</td>
								<td>010-1111-1234</td>
								<td>hong@gmail.com</td>
								<td>
									<button class="btn btn-outline-primary btn-xs">수정</button>
									<button class="btn btn-outline-secondary btn-xs">삭제</button>
								</td>
							</tr>
							<tr>
								<td>100</td>
								<td>홍길동</td>
								<td>영업부</td>
								<td>과장</td>
								<td>010-1111-1234</td>
								<td>hong@gmail.com</td>
								<td>
									<button class="btn btn-outline-primary btn-xs">수정</button>
									<button class="btn btn-outline-secondary btn-xs">삭제</button>
								</td>
							</tr>
							<tr>
								<td>100</td>
								<td>홍길동</td>
								<td>영업부</td>
								<td>과장</td>
								<td>010-1111-1234</td>
								<td>hong@gmail.com</td>
								<td>
									<button class="btn btn-outline-primary btn-xs">수정</button>
									<button class="btn btn-outline-secondary btn-xs">삭제</button>
								</td>
							</tr>
							<tr>
								<td>100</td>
								<td>홍길동</td>
								<td>영업부</td>
								<td>과장</td>
								<td>010-1111-1234</td>
								<td>hong@gmail.com</td>
								<td>
									<button class="btn btn-outline-primary btn-xs">수정</button>
									<button class="btn btn-outline-secondary btn-xs">삭제</button>
								</td>
							</tr>
							<tr>
								<td>100</td>
								<td>홍길동</td>
								<td>영업부</td>
								<td>과장</td>
								<td>010-1111-1234</td>
								<td>hong@gmail.com</td>
								<td>
									<button class="btn btn-outline-primary btn-xs">수정</button>
									<button class="btn btn-outline-secondary btn-xs">삭제</button>
								</td>
							</tr>
						</tbody>
					</table>
					<nav>
						<ul class="pagination pagination-sm justify-content-center">
							<li class="page-item disabled">
								<a class="page-link">이전</a>
							</li>
							<li class="page-item"><a class="page-link active" href="#">1</a></li>
							<li class="page-item"><a class="page-link" href="#">2</a></li>
 							<li class="page-item"><a class="page-link" href="#">3</a></li>
							<li class="page-item">
								<a class="page-link" href="#">다음</a>
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
	
});
</script>
</body>
</html>