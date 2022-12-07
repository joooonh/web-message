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
						<br/>
						<small>중요</small>
					</button>
				</div>
			</div>
			<div class="row mb-3">
				<div class="col">
					<div class="card">
						<div class="card-body">
							<ul class="tree">
				  				<li>
				  					<span><i class="bi bi-person-lines-fill me-2"></i><mark>전체 연락처</mark></span>
				    				<ul class="nested active">
										<li>친구</li>
										<li>가족</li>
										<li>회사</li>
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
			<div class="row mb-2">
				<div class="col d-flex justify-content-between me-2">
					<form class="row row-cols-lg-auto align-items-center me-3">
						<div class="col-12">
							<input type="text" class="form-control form-control-sm" name="keyword" placeholder="연락처 검색"/>
						</div>
						<div class="col-12">
							<button type="submit" class="btn btn-sm btn-outline-secondary">검색</button>
						</div>
						<small>
							<strong>내 주소록</strong> | <strong class="text-success">1</strong>
						</small>
					</form>
				</div>
			</div>
			<hr/>
			<div class="row mb-2">
				<div class="col">
					<a href="" class="btn btn-outline-danger btn-sm"><i class="bi bi-trash"></i> 삭제</a>
					<select class="form-select form-select-sm d-inline" style="width: 100px;">
						<option value=""> 이동</option>
						<option value="1"> 친구</option>
						<option value="2"> 가족</option>
						<option value="3"> 회사</option>
						<option value="4"> 휴지통</option>
					</select>
				</div>
			</div>
			<div class="row mb-2">
				<div class="col">
					<table class="table table-sm border-top">
						<colgroup>
							<col width="5%">
							<col width="5%">
							<col width="15%">
							<col width="15%">
							<col width="15%">
							<col width="15%">
							<col width="15%">
							<col width="15%">
						</colgroup>
						<thead>
							<tr class="table-light">
								<th class="text-center"><input type="checkbox" /></th>
								<th><i class="bi bi-star-fill text-success"></i></th>
								<th>이름</th>
								<th>전화번호</th>
								<th>이메일</th>
								<th>소속회사</th>
								<th>부서명</th>
								<th>직책</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td colspan="8" class="text-center">연락처가 없습니다.</td>
							</tr>
							<tr>
								<td><input type="checkbox" name="" value=""/></td>
								<td><i class="bi bi-star-fill text-success"></i></td>
								<td>홍길동</td>
								<td>010-1234-5678</td>
								<td>hong@gmail.com</td>
								<td>샘플 주식회사</td>
								<td>영업팀</td>
								<td>과장</td>
							</tr>
							<tr>
								<td><input type="checkbox" name="" value=""/></td>
								<td><i class="bi bi-star text-secondary"></i></td>
								<td>홍길동</td>
								<td>010-1234-5678</td>
								<td>hong@gmail.com</td>
								<td>샘플 주식회사</td>
								<td>영업팀</td>
								<td>과장</td>
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
			</div>
		</div>
	</div>
</div>
<div class="modal" tabindex="-1" id="modal-form-address-group">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">연락처 그룹 추가</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<p>그룹명을 입력하세요.</p>
				<form>
					<input type="text" class="form-control"/>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary btn-sm" >등록</button>
			</div>
		</div>
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
</body>
</html>