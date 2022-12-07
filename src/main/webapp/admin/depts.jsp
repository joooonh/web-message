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
			<h1 class="heading">부서/직위 관리</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col">
			<div class="card">
				<div class="card-header">전체 부서 목록</div>
				<div class="card-body">
					<p>전체 부서목록을 확인하세요.</p>
					<table class="table table-sm">
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
							<tr>
								<td>1</td>
								<td>영업부</td>
								<td><button class="btn btn-outline-primary btn-xs">수정</button></td>
							</tr>
							<tr>
								<td>1</td>
								<td>영업부</td>
								<td><button class="btn btn-outline-primary btn-xs">수정</button></td>
							</tr>
							<tr>
								<td>1</td>
								<td>영업부</td>
								<td><button class="btn btn-outline-primary btn-xs">수정</button></td>
							</tr>
							<tr>
								<td>1</td>
								<td>영업부</td>
								<td><button class="btn btn-outline-primary btn-xs">수정</button></td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="card-footer text-end">
					<button class="btn btn-primary btn-xs">신규 등록</button>
				</div>
			</div>
		</div>
		<div class="col">
			<div class="card">
				<div class="card-header">전체 직위 목록</div>
				<div class="card-body">
					<p>전체 직위목록을 확인하세요.</p>
					<table class="table table-sm">
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
								<th>번호</th>
								<th>순서</th>
								<th>직위이름</th>
								<td></td>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><input type="checkbox" /></td>
								<td>100</td>
								<td>1</td>
								<td>영업부</td>
								<td><button class="btn btn-outline-primary btn-xs">수정</button></td>
							</tr>
							<tr>
								<td><input type="checkbox" /></td>
								<td>100</td>
								<td>2</td>
								<td>영업부</td>
								<td><button class="btn btn-outline-primary btn-xs">수정</button></td>
							</tr>
							<tr>
								<td><input type="checkbox" /></td>
								<td>100</td>
								<td>3</td>
								<td>영업부</td>
								<td><button class="btn btn-outline-primary btn-xs">수정</button></td>
							</tr>
							<tr>
								<td><input type="checkbox" /></td>
								<td>100</td>
								<td>4</td>
								<td>영업부</td>
								<td><button class="btn btn-outline-primary btn-xs">수정</button></td>
							</tr>
						</tbody>
					</table>
					<div>
						<button class="btn btn-outline-secondary btn-xs">맨 위로</button>
						<button class="btn btn-outline-secondary btn-xs">위로</button>
						<button class="btn btn-outline-secondary btn-xs">아래로</button>
						<button class="btn btn-outline-secondary btn-xs">맨 아래로</button>
					</div>
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