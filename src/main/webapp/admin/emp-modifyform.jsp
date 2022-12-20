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
				<div class="card-header">직원 정보 수정폼</div>
				<div class="card-body">
					<p>직원정보를 수정하세요.</p>
					<form class="">
						<table class="table table-borderless">
							<colgroup>
								<col width="10%">
								<col width="40%">
								<col width="10%">
								<col width="40%">
							</colgroup>
							<tbody>
								<tr>
									<th class="text-end">직원번호</th>
									<td><input type="text" class="form-control form-control-sm" value="100" readonly="readonly"/></td>
									<th class="text-end">직원이름</th>
									<td><input type="text" class="form-control form-control-sm" value="홍길동" readonly="readonly"/></td>
								</tr>
								<tr>
									<th class="text-end">이메일</th>
									<td><input type="text" class="form-control form-control-sm" value="hong@gmail.com"/></td>
									<th class="text-end">전화번호</th>
									<td><input type="text" class="form-control form-control-sm" value="010-1111-1111" /></td>
								</tr>
								<tr>
									<th class="text-end">소속부서</th>
									<td>
										<select class="form-select form-select-sm">
											<option value="100"> 기획팀</option>
											<option value="100"> 기획팀</option>
											<option value="100" selected> 기획팀</option>
											<option value="100"> 기획팀</option>
											<option value="100"> 기획팀</option>
											<option value="100"> 기획팀</option>
											<option value="100"> 기획팀</option>
										</select>
									</td>
									<th class="text-end">직위</th>
									<td>
										<select class="form-select form-select-sm">
											<option value="100"> 대표이사</option>
											<option value="100"> 전무</option>
											<option value="100" selected> 상무</option>
											<option value="100"> 부장</option>
											<option value="100"> 차장</option>
											<option value="100"> 과장</option>
											<option value="100"> 대리</option>
											<option value="100"> 사원</option>
										</select>
									</td>
								</tr>
							</tbody>
						</table>
						<div class="text-end">
							<a href="" class="btn btn-secondary btn-sm">취소</a>
							<button type="submit" class="btn btn-primary btn-sm">수정</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
</html>