<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.semi.util.Pagination"%>
<%@page import="com.semi.util.StringUtils"%>
<%@page import="com.semi.address.dto.AddressDto"%>
<%@page import="java.util.List"%>
<%@page import="com.semi.address.dao.AddressBookDao"%>
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
<style>
	.text-border{
		color: #fff !important;
	    text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black!important
    }
</style>
</head>
<body>
<jsp:include page="../common/header.jsp">
	<jsp:param name="menu" value="address"/>
</jsp:include>
<div class="container-fluid my-3">
<%
	// 로그인한 직원의 직원번호
	int empNo = 1002;
	
	String opt = StringUtils.nullToBlank(request.getParameter("opt"));
	String keyword = StringUtils.nullToBlank(request.getParameter("keyword"));

	AddressBookDao addressBookDao = new AddressBookDao();

	// 현재 페이지 번호를 저장한다.
	int currentPage = StringUtils.stringToInt(request.getParameter("page"), 1);
	// 직원번호에 해당하고 삭제여부가 'Y'인 주소록의 총 갯수
	int totalRows = addressBookDao.totalRows(empNo);
	
	// 페이징 10개목록 5개페이지
	Pagination pagination = new Pagination(currentPage, totalRows);
	
	Map<String, Object> param = new HashMap<>();
	if (!opt.isEmpty()){
		param.put("opt", opt);
	}
	if (!keyword.isEmpty()){
		param.put("keyword", keyword);
	} 
	param.put("empNo", empNo);
	param.put("begin", pagination.getBegin());
	param.put("end", pagination.getEnd());
	
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
						<i class="bi bi-star-fill text-success"></i>
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
				  				<li id="wastebasket" data-employee-no="<%=empNo %>"><span><i class="bi bi-trash me-2"></i>휴지통</span></li>
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
					<form id="deliverForm" class="row row-cols-lg-auto align-items-center me-3">
						<input type="hidden" name="opt" value="<%=opt %>">
						<input type="hidden" name="page" value="<%=currentPage %>">
					
						<div class="col-12">
							<input type="text" class="form-control form-control-sm" name="keyword" placeholder="연락처 검색"/>
						</div>
						<div class="col-12">
							<button type="button" onclick="submitForm(1);" class="btn btn-sm btn-outline-secondary">검색</button>
						</div>
						<small>
							<strong>내 주소록</strong> | <strong id="addressCount" class="text-success">1</strong>
						</small>
					</form>
				</div>
			</div>
			<hr/>
			<div class="row mb-2">
				<div class="col">
					<a href="javascript:void(0);" id="deleteBtn" class="btn btn-outline-danger btn-sm"><i class="bi bi-trash"></i> 삭제</a>
					<select id="addressSelect" name="opt" class="form-select form-select-sm d-inline" style="width: 100px;">
						<option value=""> 이동</option>
						<option value="friend" <%="friend".equals(opt) ? "selected" : "" %>> 친구</option>
						<option value="family" <%="family".equals(opt) ? "selected" : "" %>> 가족</option>
						<option value="company" <%="company".equals(opt) ? "selected" : "" %>> 회사</option>
						<option value="wastebasket" <%="wastebasket".equals(opt) ? "selected" : "" %>> 휴지통</option>
					</select>
				</div>
			</div>
			<div class="row mb-2">
				<div class="col">
					<table class="table table-sm border-top" id="addressList">
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
						
				<!-- 삭제여부가 'N'인 주소록 목록 -->
				<%
					List<AddressDto> dtoList = addressBookDao.getAddressByEmpNo(empNo);
					
					if (dtoList.isEmpty()) {
				%>
							<tr>
								<td colspan="8" class="text-center">연락처가 없습니다.</td>
							</tr>
				<%
					} else {
						for (AddressDto dto : dtoList) {
				%>
							<tr>
								<td><input type="checkbox" name="addressBookNo" value="<%=dto.getBookNo() %>"/></td>
								<td><i class="bi bi-star-fill text-success text-border"></i></td>
								<td><%=dto.getLastName()+dto.getFirstName() %></td>
								<td><%=dto.getTel() %></td>
								<td><%=dto.getEmail() %></td>
								<td><%=dto.getCompany() %></td>
								<td><%=dto.getDept() %></td>
								<td><%=dto.getPosition() %></td>
							</tr>
				<%
						}
					}
				%>
						</tbody>
					</table>
					
					<nav id="nav">
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
<script type="text/javascript">
	// 삭제버튼 클릭시 발생하는 이벤트
	$("#deleteBtn").click(function() {
		var addressBookNo = [];
		
		// 선택한 주소록을 각각 배열에 담는다. 
		$("input[name=addressBookNo]:checked").each(function(){
			 addressBookNo.push($(this).val());
		});
		
		// 삭제할 주소록을 deleteAddress.jsp에 보낸다.
		location.href = "deleteAddress.jsp?addressBookNo="+addressBookNo;
	});

	// select 선택 할 때 이벤트
	$("#addressSelect").change(function(){
		var opt = $(this).val();
		$("input[name=opt]").val(opt);

		// submitForm(1);
		
		if (opt == "wastebasket") {
			wastbasketList();
		};
		
	}); 
	
	// 페이지 번호 클릭했을때 발생하는 이벤트
	function changePage(event,page) {
		event.preventDefault();
		
		submitForm(page);
	}
	
	// form 태그 전송
	function submitForm(page) {
		$("input[name=page]").val(page);
		
		$("#deliverForm").submit();
	};

	// 휴지통 클릭했을 때 이벤트
	$("#wastebasket").click(function(){
		var employeeNo = $(this).attr("data-employee-no");
		
		wastbasketList();
	});
	
	/* // 중요 주소록 표시
	$("#addressList tbody").on('click', 'td i', function() {
		$(this).toggleClass("text-border");
	}) */
	
	// ajax사용해서 삭제한 주소록 목록 조회하는 함수
	function wastbasketList() {
		
		$.getJSON("wastebasket.jsp", {empNo:<%=empNo %>}, function(address){
			// 주소록 갯수를 조회해서 내 주소록의 갯수를 변경한다.
			var count = address.length;
			$("#addressCount").text(count);
			
			var html = "";
			var nav = "";

			// 삭제한 주소록이 없을때
			if (address.length < 1) {
				html += '<tr>';
				html += '<td colspan="8" class="text-center">휴지통이 비어있습니다.</td>'
				html += '</tr>';
				
				$("#addressList tbody").html(html);
				
				nav += "<ul style='display:none;'></ul>";
				$("#nav").html(nav);
				
				return;
			}
			
			// 삭제한 주소록 목록
			for (var i = 0; i < address.length; i++) {
				var addr = address[i];
				
				html += '<tr>';
				html += 	'<td class="text-center"><input type="checkbox" name="" value=""/></td>'
				html += 	'<td><i class="bi bi-star-fill text-success text-border"></i></td>'
				html += 	'<td>'+ addr.lastName+addr.firstName +'</td>'
				html += 	'<td>'+ addr.tel +'</td>'
				html += 	'<td>'+ addr.email +'</td>'
				html += 	'<td>'+ addr.company +'</td>'
				html += 	'<td>'+ addr.dept +'</td>'
				html += 	'<td>'+ addr.position +'</td>'
				html += '</tr>';
				
				$("#addressList tbody").html(html);
			}
			
			// 페이징 처리
			var nav = `
			<%
			
			if (totalRows >= 1) {
				
			%>
					<ul class="pagination pagination-sm justify-content-center">	
						<li class="page-item">
							<a class="page-link <%=pagination.isFirst()? "disabled" : "" %>" href="wastebasketList.jsp?page=<%=pagination.getPrevPage() %>">이전</a>
						</li>
				<%
					for (int number = pagination.getBeginPage(); number <= pagination.getEndPage(); number++) {
				%>
						<li class="page-item">
							<a class="page-link <%=currentPage == number? "active" : "" %>" href="wastebasketList.jsp?page=<%=number %>" onclick="changePage(event, <%=number %>);"><%=number %></a>
						</li>
				<%
					}
				%>	
						<li class="page-item">
							<a class="page-link <%=pagination.isLast()? "disabled" : "" %>" href="wastebasketList.jsp?page=<%=pagination.getNextPage() %>">다음</a>
						</li>
					</ul>
			<%
				} 
			%>			
			`;
			
			$("#nav").html(nav);
		});
	}
</script>
</body>
</html>