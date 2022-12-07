<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css">
<link href="/web-message/resources/css/style.css" rel="stylesheet">
<title>사내 메세지 애플리케이션</title>
</head>
<body>
<jsp:include page="../common/header.jsp">
	<jsp:param name="menu" value="home"/>
</jsp:include>
<div class="container-fluid my-3">
	<div class="row">
		<div class="col-2">
			<div class="row mb-3">
				<div class="col text-center">
					<div class="btn-group" role="group">
						<button class="btn btn-success px-4">쪽지쓰기</button>
						<button class="btn btn-success px-4">내게쓰기</button>
					</div>
				</div>
			</div>
			<div class="row mb-3">
				<div class="col">
					<div class="card">
						<div class="card-body">
							<ul class="tree">
				  				<li>
				  					<span class="caret caret-down">받은 쪽지함</span>
				    				<ul class="nested active">
										<li>개인쪽지</li>
										<li>부서쪽지</li>
									</ul>
								</li>
				  				<li><span class="caret">내게 쓴 쪽지함</span></li>
				  				<li><span class="caret">보낸 쪽지함</span></li>
				  				<li><span class="caret">쪽지 보관함</span></li>
				  				<li><span class="caret">스팸 쪽지함</span></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-10">
			<div class="row mb-2">
				<div class="col d-flex justify-content-between me-2">
					<form class="row row-cols-lg-auto align-items-center me-3">
						<div class="col-12">
							<select class="form-select form-select-sm" name="messgeType">
								<option value=""> 전체쪽지</option>
								<option value=""> 받은쪽지</option>
								<option value=""> 보낸쪽지</option>
								<option value=""> 보관쪽지</option>
								<option value=""> 내게쓴쪽지</option>
							</select>
						</div>
						<div class="col-12">
							<input type="text" class="form-control form-control-sm" name="keyword" placeholder="쪽지검색"/>
						</div>
						<div class="col-12">
							<button type="submit" class="btn btn-sm btn-outline-secondary">검색</button>
						</div>
					</form>
					<div class="pt-1">
						<small>
							<strong>받은쪽지함</strong>
							<strong class="text-success">0</strong>/<strong>0</strong>
							<a href="" class="text-muted ms-3 text-decoration-none">안 읽은 쪽지 삭제</a>
						</small>
					</div>
				</div>
			</div>
			<hr/>
			<div class="row mb-2">
				<div class="col">
					<a href="" class="btn btn-outline-danger btn-sm">삭제</a>
					<a href="" class="btn btn-outline-secondary btn-sm">보관</a>
					<a href="" class="btn btn-outline-secondary btn-sm">스팸신고</a>
					<a href="" class="btn btn-outline-secondary btn-sm">답장</a>
				</div>
			</div>
			<div class="row mb-2">
				<div class="col">
					<table class="table table-sm table-bordered">
						<colgroup>
							<col width="5%">
							<col width="15%">
							<col width="*">
							<col width="15%">
						</colgroup>
						<thead>
							<tr class="table-light">
								<th class="text-center"><input type="checkbox" /></th>
								<th>보낸사람</th>
								<th>내용</th>
								<th>날짜</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td colspan="4" class="text-center">쪽지가 없습니다.</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
</html>