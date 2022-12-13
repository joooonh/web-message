
<%@page import="com.semi.address.vo.Contact"%>
<%@page import="com.semi.address.vo.Email"%>
<%@page import="com.semi.address.dao.EmailDao"%>
<%@page import="com.semi.address.dao.ContactDao"%>
<%@page import="com.semi.address.vo.Book"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.semi.util.Pagination"%>
<%@page import="com.semi.address.dao.BookDao"%>
<%@page import="com.semi.util.StringUtils"%>
<%@page import="com.semi.address.vo.Group"%>
<%@page import="java.util.List"%>
<%@page import="com.semi.address.dao.AddressGroupDao"%>
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
<%
	// 유저아이디 (로그인한 유저의 주소록)
	// String loginUserId = (String) session.getAttribute("login_user_id"); 
	
	// 현재 페이지 
	int currentPage = StringUtils.stringToInt(request.getParameter("page"), 1);

	// 전체 페이지 (이름 기준)
	BookDao bookDao = new BookDao();
	int totalRows = bookDao.getTotalRows(); 
	
	ContactDao contactDao = new ContactDao();
	EmailDao emailDao = new EmailDao();
	
	// 10행 5페이지씩
	Pagination pagination = new Pagination(currentPage, totalRows);
	
	Map<String, Object> param = new HashMap<>(); 
	// param.put("userId", loginUserId)
	param.put("begin", pagination.getBegin()); 
	param.put("end", pagination.getEnd()); 
	
	List<Book> bookList = bookDao.getBooks(param); 
%>
<div class="container-fluid my-3">
<%
	int empNo = 1000;

	AddressGroupDao addGroupDao = new AddressGroupDao();
	List<Group> addGroupList = addGroupDao.getAddGroupsByEmpNo(empNo);
	
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
				  						<i class="bi bi-person-lines-fill me-2"></i><mark>전체 연락처</mark>
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
							<strong>내 주소록</strong> | <strong class="text-success"><%=totalRows %></strong>
						</small>
					</form>
				</div>
			</div>
			<hr/>
			<div class="row mb-2">

			<form id="form-book" method="get" action="move.jsp">
				<div class="col-12 mn-3">
					<a href="" class="btn btn-outline-danger btn-sm"><i class="bi bi-trash"></i> 삭제</a>
					<select class="form-select form-select-sm d-inline" name="groupNo" style="width: 200px;" id="select-groups">
						<option value=""> 이동할 그룹 선택</option>
		<%
			if (!addGroupList.isEmpty()) {
				for (Group group : addGroupList) {
		%>
						<option value="<%=group.getNo() %>"> <%=group.getName() %></option>
		<%
				}
			}
		%>

					</select>
					<button class="btn btn-outline-secondary btn-xs d-inline" id="btn-move-addr">이동</button>
				</div>
			</div>
			<div class="row mb-2">
				<div class="col" id="book-table">
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
								<th class="text-center"><input type="checkbox" id="checkbox-all" /></th>
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
<%
	if(bookList.isEmpty()){
%>
							<tr>
								<td colspan="8" class="text-center">연락처가 없습니다.</td>
							</tr>
<% 
	} else { 
		for(Book book : bookList){
			// book의 각 주소록번호에 해당하는 contact, email 리스트 얻기
			int bookNo = book.getBookNo();
			
			// 하나의 주소록번호에 contact, email 여러개
			// 기본주소록만 목록에 표시
			Contact contact = contactDao.getDefaultContactByBookNo(bookNo);
			Email email = emailDao.getEmailsByBookNo(bookNo); 
%>
							<tr>

								<td><input type="checkbox" name="bookNo" value="<%=bookNo %>"/></td>
								<td><i class="bi bi-star text-success" ></i></td>
								<td><%=book.getFirstName()%><%=book.getLastName() %></td>
								<td><%=contact.getTel() %></td>
								<td><%=email.getAddr() %></td>
								<td><%=StringUtils.nullToBlank(book.getCompany()) %></td>
								<td><%=StringUtils.nullToBlank(book.getDept()) %></td>
								<td><%=StringUtils.nullToBlank(book.getPosition()) %></td>

							</tr>
<%
		}
	}
%>
						</tbody>
					</table>
<%
	if(totalRows >= 1){ 
%>

					<nav>
						<ul class="pagination pagination-sm justify-content-center">
							<li class="page-item">
								<a class="page-link <%=pagination.isFirst() ? "disabled" : "" %>"
									href="home.jsp?page=<%=pagination.getPrevPage() %>"
									onclick="changePage(event, <%=pagination.getPrevPage() %>)" >이전</a>
							</li>
<%
	for(int number = pagination.getBeginPage(); number <= pagination.getEndPage(); number++){
%>
							<li class="page-item">
								<a class="page-link <%=currentPage == number ? "active" : "" %>" 
									href="home.jsp?page=<%=number%>"
									onclick="changePage(event, <%=number%>)"><%=number %></a>
							</li>
<% 
	}
%>
							<li class="page-item">
								<a class="page-link <%=pagination.isLast() ? "disabled" : "" %>"
									href="home.jsp?page=<%=pagination.getNextPage() %>"
									onclick="changePage(event, <%=pagination.getNextPage() %>)" >다음</a>
							</li>
						</ul>
					</nav>
<%
	}
%>
				</div>
				</form>
			</div>
		</div>
	</div>
</div>
<div class="modal" tabindex="-1" id="modal-form-address-group">
	<div class="modal-dialog modal-sm">
		<form method="post" action="registerGroupH.jsp">
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
				<button type="submit" class="btn btn-primary btn-sm">등록</button>
			</div>
		</div>
		</form>
	</div>
</div>
<!--  
		ajax 동일한 전화번호 등록 불가 
 -->
<div class="modal" tabindex="-1" id="modal-form-address">
	<div class="modal-dialog modal-lg">
	<form class="border p-3 bg-light" method="post" action="addAddress.jsp">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">연락처 추가</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<p>연락처 정보를 입력하세요.</p>
				<div class="row mb-1">
					<label class="col-sm-2 col-form-label">이름</label>
					<div class="col-sm-3">
						<input type="text" class="form-control form-control-sm" name="firstName" placeholder="성">
					</div>
					<div class="col-sm-6">
						<input type="text" class="form-control form-control-sm" name="lastName" placeholder="이름">
					</div>
				</div>
				<div id="tel-box">
					<div class="row mb-1">
						<label class="col-sm-2 col-form-label">전화번호</label>
						<div class="col-sm-3">
							<select class="form-select form-select-sm" name="contactType">
								<option value="휴대폰"> 휴대폰</option>
								<option value="회사"> 회사</option>
								<option value="집"> 집</option>
								<option value="기타"> 기타</option>
							</select>
						</div>
						<div class="col-sm-6">
							<input type="text" class="form-control form-control-sm" name="tel">
							
						</div>
						<div class="col-sm-1">
							<button type="button" class="btn btn-sm"><i class="bi bi-plus-circle"></i></button>
						</div>
					</div>
				</div>
				<div id="email-box">
					<div class="row mb-1">
						<label class="col-sm-2 col-form-label">이메일</label>
						<div class="col-sm-9">
							<input type="text" class="form-control form-control-sm" name="email">
						</div>
						<div class="col-sm-1">
							<button type="button" class="btn btn-sm"><i class="bi bi-plus-circle fw-bold"></i></button>
						</div>
					</div>
				</div>
				<div class="row mb-1">
					<label class="col-sm-2 col-form-label">그룹</label>
					<div class="col-sm-5">
						<select class="form-select form-select-sm" name="groupNo">
							<option value="" selected disabled> 그룹을 설정하세요</option>
							<option value="100"> 회사</option>
							<option value="101"> 동창</option>
							<option value="102"> 사랑하는 우리 가족</option>
							<option value="103"> 동호회</option>
						</select>
					</div>
				</div>
				<div class="row mb-1">
					<label class="col-sm-2 col-form-label">회사</label>
					<div class="col-sm-4">
						<input type="text" class="form-control form-control-sm" name="companyName" placeholder="회사명">
					</div>
					<div class="col-sm-3">
						<input type="text" class="form-control form-control-sm" name="deptName" placeholder="부서명">
					</div>
					<div class="col-sm-3">
						<input type="text" class="form-control form-control-sm" name="positionName" placeholder="직위">
					</div>
				</div>
				<div id="address-box">
					<div class="row mb-2" >
						<label class="col-sm-2 col-form-label">주소</label>
						<div class="col-sm-3">
							<select class="form-select form-select-sm" name="addrType">
								<option value="회사"> 회사</option>
								<option value="집"> 집</option>
								<option value="기타"> 기타</option>
							</select>
						</div>
						<div class="col-sm-3">
							<input type="text" class="form-control form-control-sm" name="zipcode" placeholder="우편번호">
						</div>
						<div class="col-sm-3">
							<button type="button" class="btn btn-outline-secondary btn-xs">우편번호 검색</button>
						</div>
						<div class="col-sm-1">
							<button type="button" class="btn btn-sm"><i class="bi bi-plus-circle"></i></button>
						</div>
						<div class="mb-1 col-sm-10 offset-sm-2">
							<input type="text" class="form-control form-control-sm" name="addr1" placeholder="기본주소">
						</div>
						<div class="mb-2 col-sm-10  offset-sm-2">
							<input type="text" class="form-control form-control-sm" name="addr2" placeholder="상세주소">
						</div>
					</div>
				</div>
				<div class="row mb-1">
					<label class="col-sm-2 col-form-label">메모</label>
					<div class="col-sm-10">
						<textarea class="form-control" rows="3" name="memo" placeholder="메모"></textarea>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">닫기</button>
				<button type="submit" class="btn btn-primary btn-sm" >등록</button>
			</div>
		</div>
	</form>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
$(function(){
	
	$("#book-table").on('click', '.bi', function(){
		if($(this).hasClass("bi-star")){
			$(this).removeClass("bi-star").addClass("bi-star-fill");
		} else if($(this).hasClass("bi-star-fill")) {
			$(this).removeClass("bi-star-fill").addClass("bi-star");
		}
	})
	
	$("#checkbox-all").change(function(){
		
		var checkboxAllChecked = $(this).prop("checked");
		
		$(":checkbox[name=bookNo]").prop("checked", checkboxAllChecked);
		
		toggleDelete()
	})
	
	$(":checkbox[name=bookNo]").change(function(){
		toggleCheckBoxAll();
		toggleDelete()
	})
	
	function toggleCheckBoxAll(){
		var checkboxLength = $(":checkbox[name=bookNo]").length; 
		var checkedCheckboxLength = $(":checkbox[name=bookNo]:checked").length;
		
		$("#checkbox-all").prop("checked", checkboxLength == checkedCheckboxLength);
	}
	
	function toggleDelete(){
		var checkedCheckboxLength = $(":checkbox[name=bookNo]:checked").length;
		
		if(checkedCheckboxLength == 0){
			$("#deleteBook").addClass("disabled");
		} else {
			$("#deleteBook").removeClass("disabled");
		}
	}
	
	$("#modal-form-address").submit(function(){
		
		var firstName = $(":input[name=firstName]").val();
		var lastName = $(":input[name=lastName]").val();
		var groupNo = $(":input[name=groupNo]").val();
		var tel = $(":input[name=tel]").val();
		var email = $(":input[name=email]").val();
		var zipcode = $(":input[name=zipcode]").val();
		var addr1 = $(":input[name=addr1]").val();
		var addr2 = $(":input[name=addr2]").val();
		
		if(firstName === ""){
			alert("성은 필수입력값입니다.");
			return false;
		}
		if(lastName === ""){
			alert("이름은 필수입력값입니다.");
			return false;
		}
		if(groupNo === null){
			alert("그룹은 필수입력값입니다.");
			return false;
		}
		if(tel === ""){
			alert("전화번호는 필수입력값입니다.");
			return false;
		}
		if(email === ""){
			alert("이메일은 필수입력값입니다.");
			return false;
		}
		if(zipcode === ""){
			alert("우편번호는 필수입력값입니다.");
			return false;
		}
		if(addr1 === ""){
			alert("기본주소는 필수입력값입니다.");
			return false;
		}
		if(addr2 === ""){
			alert("상세주소는 필수입력값입니다.");
			return false;
		}
		
		return true;
		
	})
	
	$("#address-box").on('click', '.btn-outline-secondary', function() {
		var $btn = $(this);
		new daum.Postcode({
		       oncomplete: function(data) {	
		    	   
		           $btn.closest(".row").find(":input[name=zipcode]").val(data.zonecode);	// data.zonecode : 우편번호 값 
		           $btn.closest(".row").find(":input[name=addr1]").val(data.roadAddress);	// data.roadAddress : 도로명주소 값
		       }
		   }).open();
	})
	
	$("#tel-box").on('click', '.bi-plus-circle', function(){

		var telFieldLength = $("#tel-box :input[name=tel]").length;
		if(telFieldLength >= 4){
			alert("전화번호 입력필드는 최대 4개까지만 추가할 수 있습니다.");
			return;
		}
			
		var htmlContent = `
		<div class="row mb-1">
			<label class="col-sm-2 col-form-label"></label>
			<div class="col-sm-3">
				<select class="form-select form-select-sm" name="contactType">
					<option value="휴대폰"> 휴대폰</option>
					<option value="회사"> 회사</option>
					<option value="집"> 집</option>
					<option value="기타"> 기타</option>
				</select>
			</div>
			<div class="col-sm-5">
				<input type="text" class="form-control form-control-sm" name="tel">
			</div>
			<div class="col-sm-1">
				<button type="button" class="btn btn-sm"><i class="bi bi-dash-circle"></i></button>
			</div>
			<div class="col-sm-1">
				<button type="button" class="btn btn-sm"><i class="bi bi-plus-circle"></i></button>
			</div>
		</div>
		`;
		
		$("#tel-box").append(htmlContent);
	
	})
	
	$("#tel-box").on('click', '.bi-dash-circle', function(){
		$(this).closest(".row").remove();
	})
	
	$("#email-box").on('click', '.bi-plus-circle', function(){

		var emailFieldLength = $("#email-box :input[name=email]").length;
		if(emailFieldLength >= 3){
			alert("이메일 입력필드는 최대 3개까지만 추가할 수 있습니다.");
			return;
		}
		
		var htmlContent = `
		<div class="row mb-1">
			<label class="col-sm-2 col-form-label"></label>
			<div class="col-sm-8">
				<input type="text" class="form-control form-control-sm" name="email">
			</div>
			<div class="col-sm-1">
				<button type="button" class="btn btn-sm"><i class="bi bi-dash-circle fw-bold"></i></button>
			</div>
			<div class="col-sm-1">
				<button type="button" class="btn btn-sm"><i class="bi bi-plus-circle fw-bold"></i></button>
			</div>
		</div>
		`;
		
		$("#email-box").append(htmlContent);
	
	})
	
	$("#email-box").on('click', '.bi-dash-circle', function(){
		$(this).closest(".row").remove();
	})
	
	$("#address-box").on('click', '.bi-plus-circle', function(){

		var addressFieldLength = $("#address-box :input[name=zipcode]").length;
		if(addressFieldLength >= 3){
			alert("주소 입력필드는 최대 3개까지만 추가할 수 있습니다.");
			return;
		}
		
		var htmlContent = `
		<div class="row mb-2" >
			<label class="col-sm-2 col-form-label">주소</label>
			<div class="col-sm-3">
				<select class="form-select form-select-sm" name="addrType">
					<option value="회사"> 회사</option>
					<option value="집"> 집</option>
					<option value="기타"> 기타</option>
				</select>
			</div>
			<div class="col-sm-2">
				<input type="text" class="form-control form-control-sm" name="zipcode" placeholder="우편번호">
			</div>
			<div class="col-sm-3">
				<button type="button" class="btn btn-outline-secondary btn-xs">우편번호 검색</button>
			</div>
			<div class="col-sm-1">
				<button type="button" class="btn btn-sm"><i class="bi bi-dash-circle"></i></button>
			</div>
			<div class="col-sm-1">
				<button type="button" class="btn btn-sm"><i class="bi bi-plus-circle"></i></button>
			</div>
			<div class="mb-1 col-sm-10 offset-sm-2">
				<input type="text" class="form-control form-control-sm" name="addr1" placeholder="기본주소">
			</div>
			<div class="mb-2 col-sm-10  offset-sm-2">
				<input type="text" class="form-control form-control-sm" name="addr2" placeholder="상세주소">
			</div>
		</div>
		`;
		
		$("#address-box").append(htmlContent);
	
	})
	
	$("#address-box").on('click', '.bi-dash-circle', function(){
		$(this).closest(".row").remove();
	})
	
})
<script type="text/javascript">
$(function() {
	$("#btn-move-addr").click(function () {
		var groupNo = $("#select-groups").val()
		if (groupNo == "") {
			alert("이동할 그룹을 선택하세요.")
			return false;
		}
		
		var checkedCheckboxLength = $("#table-address-books :checkbox[name=bookNo]:checked").length
		if (checkedCheckboxLength == 0) {
			alert("이동할 주소록을 하나 이상 선택하세요.")
			return false;
		}
		
		$("#form-book").trigger("submit");
	});
});

</script>
</body>
</html>