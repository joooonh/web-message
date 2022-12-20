<%@page import="com.semi.admin.vo.Position"%>
<%@page import="com.semi.admin.vo.Department"%>
<%@page import="java.util.List"%>
<%@page import="com.semi.admin.dao.PositionDao"%>
<%@page import="com.semi.admin.dao.DepartmentDao"%>
<%@page import="com.semi.admin.vo.Employee"%>
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
<div class="container my-3">
	<div class="row mb-3">
		<div class="col">
			<h1 class="heading">부서/직위 관리</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col">
			<div class="card">
				<div class="card-header">전체 부서 목록</div>
				<div class="card-body">
					<p>전체 부서목록을 확인하세요.</p>
<%
	DepartmentDao departmentDao = DepartmentDao.getInstance();
	PositionDao positionDao = PositionDao.getInstance();

	List<Department> departmentList = departmentDao.getAllDepartments();
	List<Position> positionList = positionDao.getAllPositions();
%>					
					<table class="table table-sm" id="table-department">
						<colgroup>
							<col width="15%">
							<col width="*">
							<col width="10%">
						</colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th>이름</th>
								<td></td>
							</tr>
						</thead>
						<tbody>
<%
					for (Department department : departmentList) {
%>						
							<tr id="row-department-<%=department.getNo() %>">
								<td><%=department.getNo() %></td>
								<td><%=department.getName() %></td>
								<td><button class="btn btn-outline-primary btn-xs" data-target-row="#row-department-<%=department.getNo() %>">수정</button></td>
							</tr>
<%
					}
%>
						</tbody>
					</table>
				</div>
				<div class="card-footer text-end">
					<button class="btn btn-primary btn-xs" data-bs-toggle="modal" data-bs-target="#modal-form-departments">신규 등록</button>
				</div>
			</div>
		</div>
<!-- 부서 등록시작 -->
<div class="modal" tabindex="-1" id="modal-form-departments">
	<div class="modal-dialog">
		<form id="form-add-department" class="border p-3 bg-light" method="post" action="registerDepartment.jsp">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">부서 생성폼</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
					<div class="row mb-2">
						<label class="col-sm-3 col-form-label col-form-label-sm">부서명</label>
						<div class="col-sm-9">
							<input type="text" class="form-control form-control-sm" name="departmentName" placeholder="부서명">
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
<!-- 부서 등록끝 -->
<!-- 부서정보 수정 시작 -->
<div class="modal" tabindex="-1" id="modal-modifyform-department">
	<div class="modal-dialog">
		<form  id="form-modify-department" class="border p-3 bg-light" method="post" action="modifyDepartment.jsp">
		<input type="hidden" name="departmentNo"  />
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">부서정보 수정폼</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
					<div class="row mb-2">
						<label class="col-sm-2 col-form-label col-form-label-sm">부서명</label>
						<div class="col-sm-10">
							<input type="text" class="form-control form-control-sm" name="departmentName" placeholder="부서명을 입력하세요">
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
<!-- 부서 수정끝 -->
		<div class="col">
			<div class="card">
				<div class="card-header">전체 직위 목록</div>
				<div class="card-body">
					<p>전체 직위목록을 확인하세요.</p>
					<table class="table table-sm" id="table-position">
						<colgroup>
							<col width="10%">
							<col width="15%">
							<col width="15%">
							<col width="*">
							<col width="10%">
						</colgroup>
						<thead>
							<tr>
								<th></th>
								<th>순서</th>
								<th>번호</th>
								<th>직위이름</th>
								<td></td>
							</tr>
						</thead>
						<tbody>
<%
					for (Position position : positionList) {
%>						
							<tr id="row-position-<%=position.getNo() %>" >
								<td><input type="checkbox" /></td>
								<td><%=position.getSeq() %></td>
								<td><%=position.getNo() %></td>
								<td><%=position.getName() %></td>
								<td><button class="btn btn-outline-primary btn-xs" data-target-row="#row-position-<%=position.getNo() %>">수정</button></td>
							</tr>
<%
					}	
%>
						</tbody>
					</table>
					<div>
						<button class="btn btn-outline-secondary btn-xs" id="top">맨 위로</button>
						<button class="btn btn-outline-secondary btn-xs" id="up">위로</button>
						<button class="btn btn-outline-secondary btn-xs" id="down">아래로</button>
						<button class="btn btn-outline-secondary btn-xs" id="bottom">맨 아래로</button>
					</div>
				</div>
				<div class="card-footer text-end">
					<button class="btn btn-primary btn-xs" data-bs-toggle="modal" data-bs-target="#modal-form-position">신규 등록</button>
				</div>
			</div>
		</div>
		
<!-- 직위 등록시작 -->
<div class="modal" tabindex="-1" id="modal-form-position">
	<div class="modal-dialog">
		<form id="form-add-position" class="border p-3 bg-light" method="post" action="registerPosition.jsp">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">직위 생성폼</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
					<div class="row mb-2">
						<label class="col-sm-3 col-form-label col-form-label-sm">순서</label>
						<div class="col-sm-9">
							<input type="text" class="form-control form-control-sm" name="seq" placeholder="순서">
						</div>
					</div>
					<div class="row mb-2">
						<label class="col-sm-3 col-form-label col-form-label-sm">직위명</label>
						<div class="col-sm-9">
							<input type="text" class="form-control form-control-sm" name="positionName" placeholder="직위명">
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
<!-- 직위 등록끝 -->			
<!-- 직위정보 수정 시작 -->
<div class="modal" tabindex="-1" id="modal-modifyform-position">
	<div class="modal-dialog">
		<form id="form-modify-position" class="border p-3 bg-light" method="post" action="modifyPosition.jsp">
		<input type="hidden" name="positionNo"/>
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">직위정보 수정폼</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="row mb-2">
					<label class="col-sm-10 col-form-label col-form-label-sm" >노출순위</label>
					<div class="col-sm-10">
						<input type="text" class="form-control form-control-sm" name="seq" placeholder="노출순위를 입력하세요">
					</div>
				</div>
				<div class="row mb-2">
					<label class="col-sm-10 col-form-label col-form-label-sm" >직위명</label>
					<div class="col-sm-10">
						<input type="text" class="form-control form-control-sm" name="positionName" placeholder="직위명을 입력하세요">
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
<!-- 직위 수정끝 -->
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
	// 부서등록
	$("#form-add-department").submit(function() {
		let departmentName = $(":input[name=departmentName]").val();
	
		if (departmentName === "") {
			alert("부서명은 필수입력값입니다.");
			return false;
		}
		
		return true;
	})
	
	// 직위등록 
	$("#form-add-position").submit(function() {
		let positionName = $(":input[name=positionName]").val();
	
		if (positionName === "") {
			alert("직위명은 필수입력값입니다.");
			return false;
		}
		
		return true;
	})
	
	let departmentModifyFormModal = new bootstrap.Modal("#modal-modifyform-department");
	let positionModifyFormModal = new bootstrap.Modal("#modal-modifyform-position");
	
	// 부서수정	
	$("#table-department .btn").click(function() {
		let targetRowId = $(this).attr("data-target-row");
		let $targetRow = $(targetRowId);
		
		let departmentNo = $targetRow.find("td:eq(0)").text();
		let departmentName = $targetRow.find("td:eq(1)").text();
		$("#form-modify-department :hidden[name=departmentNo]").val(departmentNo);
		$("#form-modify-department :input[name=departmentName]").val(departmentName);
		
		departmentModifyFormModal.show();
	});
	
	// 직위수정	
	$("#table-position .btn").click(function() {
		let targetRowId = $(this).attr("data-target-row");
		let $targetRow = $(targetRowId);
		let seq = $targetRow.find("td:eq(1)").text();
		let positionNo = $targetRow.find("td:eq(2)").text();
		let positionName = $targetRow.find("td:eq(3)").text();
		$("#form-modify-position :hidden[name=positionNo]").val(positionNo);
		$("#form-modify-position :input[name=positionName]").val(positionName);
		$("#form-modify-position :input[name=seq]").val(seq);
		
		positionModifyFormModal.show();
	});	
	
	// 맨위로이동
	$("#top").click(function() {
		var $checkedCheckbox = $("#table-position tbody :checkbox:checked");
		var $row = $checkedCheckbox.closest("tr");
		
		$row.insertBefore($row.parent().find('tr:first-child'));
	})
	
	// 위로이동
	$("#up").click(function() {
		var $checkedCheckbox = $("#table-position tbody :checkbox:checked");
		var $row = $checkedCheckbox.closest("tr");
		
		$row.prev().before($row);
	})	
	
	// 아래로이동
	$("#down").click(function() {
		var $checkedCheckbox = $("#table-position tbody :checkbox:checked");
		var $row = $checkedCheckbox.closest("tr");
		
		$row.next().after($row);
	})	

	// 맨아래로이동
	$("#bottom").click(function() {
		var $checkedCheckbox = $("#table-position tbody :checkbox:checked");
		var $row = $checkedCheckbox.closest("tr");
		
		$row.insertAfter($row.parent().find('tr:last-child'));
	})
	
	
});	
</script>
</body>
</html>