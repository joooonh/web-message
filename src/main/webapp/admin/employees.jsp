<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css">
<link href="/web-community/resources/css/style.css" rel="stylesheet">
<title>사내 커뮤니티</title>
</head>
<body>
<jsp:include page="../common/header.jsp">
	<jsp:param name="menu" value="admin"/>
</jsp:include>
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
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">직원 정보 등록폼</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form class="border p-3 bg-light">
					<div class="row mb-2">
						<label class="col-sm-3 col-form-label col-form-label-sm">이름</label>
						<div class="col-sm-9">
							<input type="text" class="form-control form-control-sm" placeholder="직원이름">
						</div>
					</div>
					<div class="row mb-2">
						<label class="col-sm-3 col-form-label col-form-label-sm">소속부사</label>
						<div class="col-sm-6">
							<select class="form-select form-select-sm">
								<!-- comm_employees 테이블에 저장된 내용을 출력하세요 -->
								<option value="100"> 개발1팀</option>
								<option value="100"> 개발1팀</option>
								<option value="100"> 개발1팀</option>
								<option value="100"> 개발1팀</option>
								<option value="100"> 개발1팀</option>
							</select>
						</div>
					</div>
					<div class="row mb-2">
						<label class="col-sm-3 col-form-label col-form-label-sm">직위</label>
						<div class="col-sm-6">
							<select class="form-select form-select-sm">
								<!-- comm_postions 테이블에 저장된 내용을 출력하세요 -->
								<option value="100"> 사장</option>
								<option value="100"> 사장</option>
								<option value="100"> 사장</option>
								<option value="100"> 사장</option>
								<option value="100"> 사장</option>
							</select>
						</div>
					</div>
					<div class="row mb-2">
						<label class="col-sm-3 col-form-label col-form-label-sm">이메일</label>
						<div class="col-sm-9">
							<input type="text" class="form-control form-control-sm" placeholder="이메일">
						</div>
					</div>
					<div class="row mb-2">
						<label class="col-sm-3 col-form-label col-form-label-sm">전화번호</label>
						<div class="col-sm-6">
							<input type="text" class="form-control form-control-sm" placeholder="전화번호">
						</div>
					</div>
					<div class="row mb-2">
						<label class="col-sm-3 col-form-label col-form-label-sm">직원타입</label>
						<div class="col-sm-6">
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="" value="사용자" checked>
								<label class="form-check-label">사용자</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="" value="관리자" >
								<label class="form-check-label">관리자</label>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary btn-xs" data-bs-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary btn-xs">등록</button>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
</html>