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
					<button class="btn btn-primary btn-xs">신규 등록</button>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
</html>