<%@page import="com.semi.util.StringUtils"%>
<%@page import="com.semi.address.vo.Group"%>
<%@page import="java.util.List"%>
<%@page import="com.semi.address.dao.AddressGroupDao"%>
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
<title>사내 메세지 애플리케이션</title>
<style type="text/css">
.btn-xs {
	--bs-btn-padding-y: .20rem; 
	--bs-btn-padding-x: .5rem; 
	--bs-btn-font-size: .55rem;
}
</style>
</head>
<body>
<jsp:include page="../common/header.jsp">
	<jsp:param name="menu" value="home"/>
</jsp:include>
<%
	
	AddressGroupDao addGroupDao = new AddressGroupDao();
	// 직원번호로 조회한 그룹정보
	List<Group> addGroupList = addGroupDao.getAddGroupsByEmpNo(loginEmployee.getNo());
	
	String error = request.getParameter("error");
%>
<div class="container-fluid my-3">
<%
	if ("fail".equals(error)) {
%>
	<div class="alert alert-danger" style="font-size: 14px;">
		<strong>등록 실패</strong> 이미 존재하는 그룹명입니다.
	</div>
<%
	}
%>
	<div class="row">
		<div class="col-2">
			<div class="row mb-3">
				<div class="col-12 text-center mb-3">
					<div class="btn-group" role="group">
						<button class="btn btn-success px-4" data-bs-toggle="modal" data-bs-target="#modal-form-address">연락처 추가</button>
						<button class="btn btn-success px-4" data-bs-toggle="modal" data-bs-target="#modal-form-address-group">그룹 추가</button>
					</div>
				</div>
				<div class="col-12 d-flex justify-content-around">
					<button class="btn">
						<i class="bi bi-clock-fill text-success"></i><br/>
						<small>최근등록</small>
					</button>
					<button class="btn">
						<i class="bi bi-star-fill text-success"></i><br/>
						<small>중요</small>
					</button>
				</div>
			</div>
			<div class="row mb-3">
				<div class="col">
					<div class="card">
						<div class="card-body">
							<ul class="tree" style="cursor:pointer;">
				  				<li>
				  					<span>
				  						<a href="home.jsp" class="text-decoration-none text-dark"><i class="bi bi-person-lines-fill me-2"></i>전체 연락처</a>
				  						<a href="control.jsp" class="text-decoration-none text-dark float-end"><i class="bi bi-gear-fill"></i></a>
				  					</span>
				    				<ul class="nested active">
		<%
			if (!addGroupList.isEmpty()) {
				for (Group group : addGroupList) {
		%>
										<li><a href="detailGroup.jsp?groupNo=<%=group.getNo() %>" style="text-decoration:none;color:black;"><%=group.getName() %></a></li>
		<%
				}
			}
		%>
									</ul>
								</li>
				  				<li><span><i class="bi bi-trash me-2"></i>휴지통</span></li>
				  				<li><span><i class="bi bi-question-square-fill me-2"></i>이름없는 연락처</span></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-10">
			<div class="row">
				<strong>환경설정</strong>
			</div>
			<hr />
			<div class="row mb-2">
				<div class="col">
					<form id="form-add-addrGroup" method="post" action="registerGroupC.jsp">
						<div class="row mb-1">
							<label class="col-sm-1 col-form-label col-form-label-sm fw-bold">그룹 추가</label>
							<div class="col-sm-4">
								<input type="text" class="form-control form-control-sm" placeholder="연락처그룹을 추가하세요" name="name">
							</div>
							<div class="col-sm-1">
								<button type="submit" class="btn btn-success btn-xs" style="margin-top: 2px;">추가</button>
							</div>
						</div>
					</form>
				</div>
			</div>
			<hr/>
			<div class="row mb-2">
				<div class="col">
					<button class="btn btn-outline-secondary btn-xs rounded-0">전체 선택</button>
					<button class="btn btn-outline-secondary btn-xs rounded-0"><i class="bi bi-trash"></i> 삭제</button>
					
					<div class="btn-group" role="group" aria-label="Basic example">
						<button class="btn btn-outline-secondary btn-xs rounded-0">맨 위로</button>
						<button class="btn btn-outline-secondary btn-xs rounded-0">위로</button>
						<button class="btn btn-outline-secondary btn-xs rounded-0">아래로</button>
						<button class="btn btn-outline-secondary btn-xs rounded-0">맨 아래로</button>
					</div>
				</div>
			</div>
			<div class="row mb-2">
				<table class="table table-sm border-top" id="table-groups">
					<colgroup>
						<col width="5%">
						<col width="20%">
						<col width="*">
						<col width="10%">
					</colgroup>
					<thead>
						<tr class="bg-light small">
							<th><input type="checkbox" id="checkbox-all"/></th>
							<th>그룹명</th>
							<th>그룹설명</th>
							<th>수정/삭제</th>
						</tr>
					</thead>
					<tbody>
			<%
				if (addGroupList.isEmpty()) {
			%>
						<tr class="small">
				<td></td>
						</tr>
			<%
				} else {
					for (Group group : addGroupList) {
			%>
						<tr class="small">
							<td><input type="checkbox" name="groupNo" value="<%=group.getNo() %>"></td>
							<td><%=group.getName()%></td>
							<td></td>
							<td>
								<a href="delete-group.jsp?groupNo=<%=group.getNo() %>"><button class="btn btn-outline-danger btn-xs rounded-0" data-group-no="<%=group.getNo() %>">삭제</button></a>
								<button class="btn btn-outline-warning btn-xs rounded-0" data-group-no="<%=group.getNo() %>" data-group-name="<%=group.getName()%>" >수정</button>
							</td>
						</tr>
			<%
					}
				}	
			%>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
<!--------------------------- 그룹 수정 ------------------------------>
<div class="modal" tabindex="-1" id="modal-modifyform-address-group">
	<div class="modal-dialog modal-sm">
	<form id="form-change-groupName" method="post" action="modify-group.jsp">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">연락처 그룹  수정</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<p>그룹명을 입력하세요.</p>
					<input type="hidden" name="groupNo" value="" />
					<input type="text" class="form-control" name="groupName" value=""/>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">닫기</button>
				<button type="submit" class="btn btn-primary btn-sm" >수정</button>
			</div>
		</div>
	</form>
	</div>
</div>
<!--------------------------- 그룹 등록 ------------------------->
<div class="modal" tabindex="-1" id="modal-form-address-group">
	<div class="modal-dialog modal-sm">
		<form id="from-register-addrGroup" method="post" action="registerGroupC.jsp">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">연락처 그룹 추가</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<p>그룹명을 입력하세요.</p>
					<input type="text" class="form-control" name="name"/>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">닫기</button>
				<button type="submit" class="btn btn-primary btn-sm" >등록</button>
			</div>
		</div>
		</form>
	</div>
</div>
<div class="modal" tabindex="-1" id="modal-form-address">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">연락처 추가</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<p>연락처 정보를 입력하세요.</p>
				<form class="border p-3 bg-light">
					<div class="row mb-1">
						<label class="col-sm-2 col-form-label">전화번호</label>
						<div class="col-sm-3">
							<select class="form-select form-select-sm">
								<option value="휴대폰"> 휴대폰</option>
								<option value="회사"> 회사</option>
								<option value="집"> 집</option>
								<option value="기타"> 기타</option>
							</select>
						</div>
						<div class="col-sm-6">
							<input type="text" class="form-control form-control-sm" name="">
						</div>
						<div class="col-sm-1">
							<button type="button" class="btn btn-sm"><i class="bi bi-plus-circle"></i></button>
						</div>
					</div>
					<div class="row mb-1">
						<label class="col-sm-2 col-form-label">이메일</label>
						<div class="col-sm-9">
							<input type="text" class="form-control form-control-sm" name="">
						</div>
						<div class="col-sm-1">
							<button type="button" class="btn btn-sm "><i class="bi bi-plus-circle fw-bold"></i></button>
						</div>
					</div>
					<div class="row mb-1">
						<label class="col-sm-2 col-form-label">그룹</label>
						<div class="col-sm-5">
							<select class="form-select form-select-sm">
								<option value="" selected disabled> 그룹을 설정하세요</option>
								<option value="100"> 친구</option>
								<option value="102"> 회사</option>
								<option value="103"> 가족</option>
								<option value="104"> 모인</option>
							</select>
						</div>
					</div>
					<div class="row mb-1">
						<label class="col-sm-2 col-form-label">회사</label>
						<div class="col-sm-4">
							<input type="text" class="form-control form-control-sm" name="" placeholder="회사명">
						</div>
						<div class="col-sm-3">
							<input type="text" class="form-control form-control-sm" name="" pattern="부서명">
						</div>
						<div class="col-sm-3">
							<input type="text" class="form-control form-control-sm" name="" placeholder="직위">
						</div>
					</div>
					<div class="row mb-1">
						<label class="col-sm-2 col-form-label">주소</label>
						<div class="col-sm-3">
							<select class="form-select form-select-sm">
								<option value="회사"> 회사</option>
								<option value="집"> 집</option>
								<option value="기타"> 기타</option>
							</select>
						</div>
						<div class="col-sm-3">
							<input type="text" class="form-control form-control-sm" name="" placeholder="우편번호">
						</div>
						<div class="col-sm-3">
							<button type="button" class="btn btn-outline-secondary btn-xs">우편번호 검색</button>
						</div>
						<div class="col-sm-1">
							<button type="button" class="btn btn-sm"><i class="bi bi-plus-circle"></i></button>
						</div>
					</div>
					<div class="row mb-1">
						<div class="col-sm-10 offset-sm-2">
							<input type="text" class="form-control form-control-sm" name="" placeholder="기본주소">
						</div>
					</div>
					<div class="row mb-1">
						<div class="col-sm-10  offset-sm-2">
							<input type="text" class="form-control form-control-sm" name="" placeholder="기본주소">
						</div>
					</div>
					<div class="row mb-1">
						<label class="col-sm-2 col-form-label">메모</label>
						<div class="col-sm-10">
							<textarea class="form-control" rows="3" name="" placeholder="메모"></textarea>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary btn-sm" >등록</button>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
	
	// 그룹 수정
	var addressGroupModifyFormModal = new bootstrap.Modal("#modal-modifyform-address-group");
	
	$("#table-groups .btn-outline-warning").click(function() {
		var groupNo = $(this).attr("data-group-no");
		var groupName = $(this).attr("data-group-name");
		
		$("#modal-modifyform-address-group :input[name=groupNo]").val(groupNo);
		$("#modal-modifyform-address-group :input[name=groupName]").val(groupName);
		
		addressGroupModifyFormModal.show();
	})
	
	$("#form-change-groupName").submit(function() {
		if ($("#form-change-groupName :input[name=groupName]").val() === "") {
			alert("그룹이름은 필수입력값입니다.");
			return false;
		}
		return true;
	})
	
	// 그룹 삭제
	
	// 그룹명 선택/해제
	$("#checkbox-all").change(function() {
		var checkboxAllChecked = $(this).prop("checked");
		$(":checkbox[name=groupNo]").prop('checked', checkboxAllChecked);
		
		toggleSelectedButton();
	});
	
	$(":checkbox[name=groupNo]").change(function() {
		toggleCheckboxAll();
		toggleSelectedButton();
	});
	
	function toggleCheckboxAll() {
		
		var checkboxLength = $(":checkbox[name=groupNo]").length;
		
		var checkedCheckboxLength = $(":checkbox[name=groupNo]:checked").length;
		
		$("#checkbox-all").prop("checked", checkboxLength == checkedCheckboxLength);
	}
	
	//그룹 등록
	$("#from-register-addrGroup").submit(function() {
		if ($("#from-register-addrGroup :input[name=name]").val() === "") {
			alert("그룹이름은 필수입력값입니다.");
			return false;
		}
		return true;
	})
	
	$("#form-add-addrGroup").submit(function() {
		let groupName = $(":input[name=name]").val();
		
		if (groupName === "") {
			alert("그룹명은 필수입력 값입니다.");
			return false;
		}
		
		return true;
	})
	
});
</script>
</body>
</html>