<%@page import="com.semi.address.dto.AddressDto"%>
<%@page import="com.semi.address.dao.AddressBookDao"%>

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
<%
	int empNo = 1002;
	// 유저아이디 (로그인한 유저의 주소록)
	// String loginUserId = (String) session.getAttribute("login_user_id"); 
	
	// 현재 페이지 
	int currentPage = StringUtils.stringToInt(request.getParameter("page"), 1);
	String opt = StringUtils.nullToBlank(request.getParameter("opt"));
	String keyword = StringUtils.nullToBlank(request.getParameter("keyword"));

	// 전체 페이지 (이름 기준)
	BookDao bookDao = BookDao.getInstance();
	int totalRows = bookDao.getTotalRows(); 
	
	ContactDao contactDao = ContactDao.getInstance();
	EmailDao emailDao = EmailDao.getInstance();
	
	// 10행 5페이지씩
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
	
	List<Book> bookList = bookDao.getBooks(param); 
	
	AddressGroupDao addGroupDao = new AddressGroupDao();
	List<Group> addGroupList = addGroupDao.getAddGroupsByEmpNo(empNo);
%>
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
						<a href="important.jsp" class="text-decoration-none text-dark" >
						<i class="bi bi-star-fill text-success"></i><br/>
						<small>중요</small>
						</a>
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
							<strong>내 주소록</strong> | <strong class="text-success"><%=totalRows %></strong>
						</small>
					</form>
				</div>
			</div>
			<hr/>
			<div class="row mb-2">
			<form id="form-book" method="get" action="move.jsp">
				<div class="col-12 mn-3">
					<a href="javascript:void(0);" id="deleteBtn" class="btn btn-outline-danger btn-sm"><i class="bi bi-trash"></i> 삭제</a>
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
			</form>
			</div>
			<div class="row mb-2">
				<div class="col">
					<table class="table table-sm border-top" id="table-address-list">
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
			
			// 기본주소록만 목록에 표시
			Contact contact = contactDao.getDefaultContactByBookNo(bookNo);
			Email email = emailDao.getDefaultEmailByBookNo(bookNo); 
%>
							<tr>

								<td><input type="checkbox" name="bookNo" value="<%=bookNo %>"/></td>
								<td><i class="bi <%=book.getImportant().equals("Y") ? "bi-star-fill" : "bi-star" %> text-success" data-important="<%=book.getImportant()%>" data-book-no="<%=bookNo %>"></i></td>
								<td>
									<a href="" class="text-decoration-none" data-address-book-no="<%=bookNo %>">
										<%=book.getFirstName()%><%=book.getLastName() %>
									</a>
								</td>
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

					<nav id="nav">
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
		연락처 등록 모달폼
 -->
<div class="modal" tabindex="-1" id="modal-form-address">
	<div class="modal-dialog modal-lg">
	<form class="border p-3 bg-light" method="post" action="addAddress.jsp">
	<input type="hidden" name="contact-index" value="" >	<!-- 기본전화번호가 될 row의 index번호 저장 -> addAddress로 넘김 -->
	<input type="hidden" name="email-index" value="" >	
	<input type="hidden" name="address-index" value="" >
	<input type="hidden" name="important" value="N" >
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">연락처 추가</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<p>연락처 정보를 입력하세요.</p>
				<div class="row mb-1">
					<label class="col-sm-2 col-form-label">이름
						<i class="bi bi-star text-success float-end mt-1" id="important-address" ></i>
					</label>
					<div class="col-sm-3">
						<input type="text" class="form-control form-control-sm" name="firstName" placeholder="성">
					</div>
					<div class="col-sm-6">
						<input type="text" class="form-control form-control-sm" name="lastName" placeholder="이름">
					</div>
				</div>
				<!-- 전화번호 필드 -->
				<div id="tel-box">
					<div class="row mb-1">
						<label class="col-sm-2 col-form-label">전화번호 <input type="radio" name="contact-default-radio" value="Y" checked class="float-end mt-1"></label>
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
				<!-- 이메일 필드 -->
				<div id="email-box">
					<div class="row mb-1">
						<label class="col-sm-2 col-form-label">이메일 <input type="radio" name="email-default-radio" value="Y" checked class="float-end mt-1"></label>
						<div class="col-sm-9">
							<input type="text" class="form-control form-control-sm" name="email">
						</div>
						<div class="col-sm-1">
							<button type="button" class="btn btn-sm"><i class="bi bi-plus-circle fw-bold"></i></button>
						</div>
					</div>
				</div>
				<!-- 그룹 필드 -->
				<div class="row mb-1">
					<label class="col-sm-2 col-form-label">그룹</label>
					<div class="col-sm-5">
						<select class="form-select form-select-sm" name="groupNo" id="register-group">
							<option value="" selected disabled> 그룹을 설정하세요</option>
<%
	if (!addGroupList.isEmpty()) {
		for (Group group : addGroupList) {
%>
                        	<option value="<%=group.getNo() %>" > <%=group.getName() %></option>
<%
		}
	}
%>
						</select>
					</div>
				</div>
				<!-- 직장 필드 -->
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
				<!-- 주소 필드 -->
				<div id="address-box">
					<div class="row mb-2" >
						<label class="col-sm-2 col-form-label">주소 <input type="radio" name="address-default-radio" value="Y" checked class="float-end mt-1"></label>
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
				<!-- 메모 필드 -->
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
<!-- 연락처 상세보기 모달폼 -->
<div class="modal" tabindex="-1" id="modal-detail-address">
   <div class="modal-dialog modal-lg">
      <div class="modal-content">
         <div class="modal-header">
            <h5 class="modal-title">연락처 상세 정보</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
         </div>
         <div class="modal-body">
            <p>연락처 정보를 확인하세요</p>
            <form class="border p-3 bg-light">
            <input type="hidden" name="detail-bookNo" value="" >
               <div class="row mb-3">
                  <label class="col-sm-2 col-form-label">이름</label>
                  <div class="col-sm-3">
                     <input type="text" class="form-control form-control-sm" name="firstName" value="홍">
                  </div>
                  <div class="col-sm-6">
                     <input type="text" class="form-control form-control-sm" name="lastName" value="길동">
                  </div>
               </div>
               <div id="box-contact" class="mb-3">
                  <!-- 연락처가 추가되는 곳 -->
               </div>
               <div id="box-email" class="mb-3">
                  <!-- 이메일이 추가되는 곳 -->
                  
               </div>
               <div class="row mb-3" id="box-group">
                  <label class="col-sm-2 col-form-label">그룹</label>
                  <div class="col-sm-5">
                     <select class="form-select form-select-sm" name="groupNo">
<%
	if (!addGroupList.isEmpty()) {
		for (Group group : addGroupList) {
%>
                        <option value="<%=group.getNo() %>" selected> <%=group.getName() %></option>
<%
		}
	}
%>
                     </select>
                  </div>
               </div>
               <div class="row mb-3">
                  <label class="col-sm-2 col-form-label">회사</label>
                  <div class="col-sm-4">
                     <input type="text" class="form-control form-control-sm" name="company" value="한국주식회사" placeholder="회사명">
                  </div>
                  <div class="col-sm-3">
                     <input type="text" class="form-control form-control-sm" name="dept" value="개발1팀" placeholder="부서명">
                  </div>
                  <div class="col-sm-3">
                     <input type="text" class="form-control form-control-sm" name="position" value="사원" placeholder="직위">
                  </div>
               </div>
               <div id="box-address" class="mb-3">
                  <!-- 주소가 추가되는 곳 -->
                  
               </div>
               <div class="row mb-1">
                  <label class="col-sm-2 col-form-label">메모</label>
                  <div class="col-sm-10">
                     <textarea class="form-control" rows="3" name="memo" placeholder="메모">메모입니다.</textarea>
                  </div>
               </div>
            </form>
         </div>
         <div class="modal-footer">
            <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">확인</button>
            <button type="button" class="btn btn-dark btn-sm">수정</button>
         </div>
      </div>
   </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
$(function(){
		
	// 이름 클릭시 해당 주소록 번호의 연락처 상세보기 모달폼 
	let addressDetailModal = new bootstrap.Modal("#modal-detail-address");
	
	$("#table-address-list tbody").on('click', 'a', function(event) {
	   event.preventDefault();
	   
	   let clickedBookNo = $(this).attr('data-address-book-no'); //클릭한 주소록의 주소록번호
	   
	   $("#box-contact").empty(); 
	   $("#box-email").empty(); 
	   $("#box-address").empty(); 
	   
	   // 주소록번호에 해당하는 book, contact, email, address 객체 받기 -> map
	   $.getJSON('home-response.jsp', {bookNo: clickedBookNo}, function(map){
		   
		  // book 주소록 정보 넣기
		  let bookNo = map.book.bookNo;
		  let firstName = map.book.firstName;
		  let lastName = map.book.lastName;
		  let groupNo = map.book.groupNo; 
		  let company = map.book.company;
		  let dept = map.book.dept;
		  let position = map.book.position; 
		  let memo = map.book.memo; 
		  
	 	  $("#modal-detail-address :input[name=detail-bookNo]").val(bookNo);
	 	  $("#modal-detail-address :input[name=firstName]").val(firstName);
	 	  $("#modal-detail-address :input[name=lastName]").val(lastName);
	 	  $("#modal-detail-address :input[name=groupNo]").val(groupNo);
	 	  $("#modal-detail-address :input[name=company]").val(company);
	 	  $("#modal-detail-address :input[name=dept]").val(dept);
	 	  $("#modal-detail-address :input[name=position]").val(position);
	 	  $("#modal-detail-address :input[name=memo]").val(memo);
	 	  
	 	  // contact 연락처 정보 넣기 
		  let contactList = map.contactList;
		  for(let index in contactList){
			  let contact = contactList[index];
			  let contactType = contact.type;
			  let contactTel = contact.tel;
			  let defaultYN = contact.defaultYN;
			  
			  let content = `
			   <div class="row mb-1">
                  <label class="col-sm-2 col-form-label">전화번호 <input type="radio" name="contact-default-radio" value="Y" \${defaultYN == "Y" ? "checked" : ""} class="float-end mt-1"></label>
                  <div class="col-sm-3">
                     <select class="form-select form-select-sm" name="contactType">
                        <option value="휴대폰" \${contactType == "휴대폰" ? "selected" : ""}> 휴대폰</option>
                        <option value="회사" \${contactType == "회사" ? "selected" : ""}> 회사</option>
                        <option value="집" \${contactType == "집" ? "selected" : ""}> 집</option>
                        <option value="기타" \${contactType == "기타" ? "selected" : ""}> 기타</option>
                     </select>
                  </div>
                  <div class="col-sm-5">
                     <input type="text" class="form-control form-control-sm" name="contactTel" value="\${contactTel}">
                  </div>
                  <div class="col-sm-2 d-flex justify-content-end">
                     <button type="button" class="btn btn-sm"><i class="bi bi-plus-circle"></i></button>
                     <button type="button" class="btn btn-sm"><i class="bi bi-dash-circle"></i></button>
                  </div>
               </div>
			  `
			  $("#box-contact").append(content);
		  }
		  
		  // email 이메일 정보 넣기 
		  let emailList = map.emailList;
		  for(let index in emailList){
			  let email = emailList[index];
			  let emailAddr = email.addr;
			  let defaultYN = email.defaultYN;
			  
			  let content = `
				<div class="row mb-1">
                  <label class="col-sm-2 col-form-label">이메일 <input type="radio" name="email-default-radio" value="Y" \${defaultYN == "Y" ? "checked" : ""} class="float-end mt-1"></label>
                  <div class="col-sm-8">
                     <input type="text" class="form-control form-control-sm" name="emailAddr" value="\${emailAddr}">
                  </div>
                  <div class="col-sm-2 d-flex justify-content-end">
                     <button type="button" class="btn btn-sm"><i class="bi bi-plus-circle"></i></button>
                     <button type="button" class="btn btn-sm"><i class="bi bi-dash-circle"></i></button>
                  </div>
               </div>
			  `
			  $("#box-email").append(content); 
		  }
		  
		  // address 주소 정보 넣기 
		  let addressList = map.addressList;
		  for(let index in addressList){
			  let address = addressList[index];
			  let addressType = address.type; 
			  let defaultYN = address.defaultYN;
			  let zipcode = address.zipcode;
			  let basic = address.basic;
			  let detail = address.detail;
			  
			  let content = `
				<div class="row mb-1">
                  <label class="col-sm-2 col-form-label">주소 <input type="radio" name="address-default-radio" value="Y" \${defaultYN == "Y" ? "checked" : ""} class="float-end mt-1"></label>
                  <div class="col-sm-3">
                     <select class="form-select form-select-sm" name="addressType">
                        <option value="회사" \${addressType == "회사" ? "selected" : ""}> 회사</option>
                        <option value="집" \${addressType == "집" ? "selected" : ""}> 집</option>
                        <option value="기타" \${addressType == "기타" ? "selected" : ""}> 기타</option>
                     </select>
                  </div>
                  <div class="col-sm-3">
                     <input type="text" class="form-control form-control-sm" name="zipcode" value="\${zipcode}" placeholder="우편번호">
                  </div>
                  <div class="col-sm-2">
                     <button type="button" class="btn btn-outline-secondary btn-xs">우편번호 검색</button>
                  </div>
                  <div class="col-sm-2 d-flex justify-content-end">
                     <button type="button" class="btn btn-sm"><i class="bi bi-plus-circle"></i></button>
                     <button type="button" class="btn btn-sm"><i class="bi bi-dash-circle"></i></button>
                  </div>
               </div>
               <div class="row mb-1">
                  <div class="col-sm-10 offset-sm-2">
                     <input type="text" class="form-control form-control-sm" name="basic" value="\${basic}" placeholder="기본주소">
                  </div>
               </div>
               <div class="row mb-1">
                  <div class="col-sm-10  offset-sm-2">
                     <input type="text" class="form-control form-control-sm" name="detail" value="\${detail}" placeholder="상세주소">
                  </div>
               </div>
			  `
			  $("#box-address").append(content);
			  
		  }     	 
	   })
	   addressDetailModal.show();
	   
	})

   // 연락처 추가시 중요 주소록(별 아이콘) 등록 (setImportant="Y")
   $("#important-address").click(function(){
	   if($(this).hasClass("bi-star")){
			$(this).removeClass("bi-star").addClass("bi-star-fill");
			$("#modal-form-address :hidden[name=important]").val("Y");
			
		} else if($(this).hasClass("bi-star-fill")) {
			$(this).removeClass("bi-star-fill").addClass("bi-star");
			$("#modal-form-address :hidden[name=important]").val("N");
		}

   })
	
	// 테이블에서 중요 주소록(별 아이콘) 표시
	$("#table-address-list").on('click', '.bi', function(){
		
		var bookNo = $(this).attr("data-book-no");

		if($(this).hasClass("bi-star")){
			$(this).removeClass("bi-star").addClass("bi-star-fill");
			$.getJSON('important-response.jsp', {bookNo: bookNo}, function(book){
				
			})
			
		} else if($(this).hasClass("bi-star-fill")) {
			$(this).removeClass("bi-star-fill").addClass("bi-star");
			$.getJSON('important-response.jsp', {bookNo: bookNo}, function(book){
				
			})
		}
		
		//important = (important == "Y" ? "N" : "Y");
		//location.href= "important.jsp?bookNo=" + bookNo + "&important=" + important;
	})
	
	
	// 전체 체크박스 클릭시 모든 체크박스 체크 표시 
	$("#checkbox-all").change(function(){
		
		var checkboxAllChecked = $(this).prop("checked");
		
		$(":checkbox[name=bookNo]").prop("checked", checkboxAllChecked);
		
		toggleDelete()
	})
	
	// 각 체크박스의 change 이벤트  
	$(":checkbox[name=bookNo]").change(function(){
		toggleCheckBoxAll();
		toggleDelete()
	})
	
	// 모든 체크박스가 체크상태일 때, 전체체크박스도 체크상태
	function toggleCheckBoxAll(){
		var checkboxLength = $(":checkbox[name=bookNo]").length; 
		var checkedCheckboxLength = $(":checkbox[name=bookNo]:checked").length;
		
		$("#checkbox-all").prop("checked", checkboxLength == checkedCheckboxLength);
	}
	
	// 체크된 체크박스가 없을 때 삭제버튼 비활성화 
	function toggleDelete(){
		var checkedCheckboxLength = $(":checkbox[name=bookNo]:checked").length;
		
		if(checkedCheckboxLength == 0){
			$("#deleteBook").addClass("disabled");
		} else {
			$("#deleteBook").removeClass("disabled");
		}
	}
	
	// 연락처추가 모달폼 유효성 체크
	$("#modal-form-address").submit(function(){
		
		var firstName = $(":input[name=firstName]").val();
		var lastName = $(":input[name=lastName]").val();
		var tel = $(":input[name=tel]").val();
		var email = $(":input[name=email]").val();
		var groupNo = $("#register-group").val();
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
		if(tel === ""){
			alert("전화번호는 필수입력값입니다.");
			return false;
		}
		if(email === ""){
			alert("이메일은 필수입력값입니다.");
			return false;
		}
		if(groupNo === null){
			alert("그룹은 필수입력값입니다.");
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
	
	// 다음 우편번호 API
	$("#address-box").on('click', '.btn-outline-secondary', function() {
		var $btn = $(this);
		new daum.Postcode({
		       oncomplete: function(data) {	
		    	   
		           $btn.closest(".row").find(":input[name=zipcode]").val(data.zonecode);	// data.zonecode : 우편번호 값 
		           $btn.closest(".row").find(":input[name=addr1]").val(data.roadAddress);	// data.roadAddress : 도로명주소 값
		       }
		   }).open();
	})
	$("#box-address").on('click', '.btn-outline-secondary', function(){
		var $btn = $(this);
		new daum.Postcode({
		       oncomplete: function(data) {	
		    	   
		           $btn.closest(".row").find(":input[name=zipcode]").val(data.zonecode);	// data.zonecode : 우편번호 값 
		           $btn.closest(".row").find(":input[name=basic]").val(data.roadAddress);	// data.roadAddress : 도로명주소 값
		       }
		   }).open();
	})

	// 연락처 추가 - 전화번호 입력필드 추가, 삭제 
	$("#tel-box").on('click', '.bi-plus-circle', function(){

		var telFieldLength = $("#tel-box :input[name=tel]").length;
		if(telFieldLength >= 4){
			alert("전화번호 입력필드는 최대 4개까지만 추가할 수 있습니다.");
			return;
		}
			
		var htmlContent = `
		<div class="row mb-1">
			<label class="col-sm-2 col-form-label"> <input type="radio" name="contact-default-radio" value="N" class="float-end mt-1"></label>
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
	
	// 연락처 추가 - 이메일 입력필드 추가, 삭제 
	$("#email-box").on('click', '.bi-plus-circle', function(){

		var emailFieldLength = $("#email-box :input[name=email]").length;
		if(emailFieldLength >= 3){
			alert("이메일 입력필드는 최대 3개까지만 추가할 수 있습니다.");
			return;
		}
		
		var htmlContent = `
		<div class="row mb-1">
			<label class="col-sm-2 col-form-label"> <input type="radio" name="email-default-radio" value="N" class="float-end mt-1"></label>
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
	
	// 연락처 추가 - 주소 입력필드 추가, 삭제 
	$("#address-box").on('click', '.bi-plus-circle', function(){

		var addressFieldLength = $("#address-box :input[name=zipcode]").length;
		if(addressFieldLength >= 3){
			alert("주소 입력필드는 최대 3개까지만 추가할 수 있습니다.");
			return;
		}
		
		var htmlContent = `
		<div class="row mb-2" >
			<label class="col-sm-2 col-form-label">주소 <input type="radio" name="address-default-radio" value="N" class="float-end mt-1"></label>
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

	// 연락처 상세보기 - 전화번호 입력필드 추가, 삭제
	$("#box-contact").on('click', '.bi-plus-circle', function(){

		var telFieldLength = $("#box-contact :input[name=contactType]").length;
		if(telFieldLength >= 4){
			alert("전화번호 입력필드는 최대 4개까지만 추가할 수 있습니다.");
			return;
		}
			
		var htmlContent = `
		<div class="row mb-1">
			<label class="col-sm-2 col-form-label">전화번호 <input type="radio" name="contact-default-radio" value="N" class="float-end mt-1"></label>
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
			<div class="col-sm-2 d-flex justify-content-end">
	            <button type="button" class="btn btn-sm"><i class="bi bi-plus-circle"></i></button>
	            <button type="button" class="btn btn-sm"><i class="bi bi-dash-circle"></i></button>
         	</div>
		</div>
		`;
		
		$("#box-contact").append(htmlContent);
	})
	$("#box-contact").on('click', '.bi-dash-circle', function(){
		var telFieldLength = $("#box-contact :input[name=contactType]").length;
		if(telFieldLength <= 1 ){
			alert("전화번호 입력필드는 최소 1개 이상이어야 합니다."); 
			return;
		}
		$(this).closest(".row").remove();
	})	
	
	// 연락처 상세보기 - 이메일 입력필드 추가, 삭제 
	$("#box-email").on('click', '.bi-plus-circle', function(){

		var emailFieldLength = $("#box-email :input[name=emailAddr]").length;
		if(emailFieldLength >= 3){
			alert("이메일 입력필드는 최대 3개까지만 추가할 수 있습니다.");
			return;
		}
		
		var htmlContent = `
		<div class="row mb-1">
			<label class="col-sm-2 col-form-label">이메일 <input type="radio" name="email-default-radio" value="N" class="float-end mt-1"></label>
			<div class="col-sm-8">
				<input type="text" class="form-control form-control-sm" name="emailAddr">
			</div>
			<div class="col-sm-2 d-flex justify-content-end">
	            <button type="button" class="btn btn-sm"><i class="bi bi-plus-circle"></i></button>
	            <button type="button" class="btn btn-sm"><i class="bi bi-dash-circle"></i></button>
     		</div>
		</div>
		`;
		
		$("#box-email").append(htmlContent);
	})
	$("#box-email").on('click', '.bi-dash-circle', function(){
		var emailFieldLength = $("#box-email :input[name=emailAddr]").length;
		if(emailFieldLength <= 1){
			alert("이메일 입력필드는 최소 1개 이상이어야 합니다.");
			return;
		}
		$(this).closest(".row").remove();
	})
	
	// 연락처 상세보기 - 주소 입력필드 추가, 삭제 
	$("#box-address").on('click', '.bi-plus-circle', function(){

		var addressFieldLength = $("#address-box :input[name=zipcode]").length;
		if(addressFieldLength >= 3){
			alert("주소 입력필드는 최대 3개까지만 추가할 수 있습니다.");
			return;
		}
		
		var htmlContent = `
		<div class="row mb-2" >
			<label class="col-sm-2 col-form-label">주소 <input type="radio" name="address-default-radio" value="N" class="float-end mt-1"></label>
			<div class="col-sm-3">
				<select class="form-select form-select-sm" name="addressType">
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
		var addressFieldLength = $("#address-box :input[name=zipcode]").length;
		if(addressFieldLength >= 3){
			alert("주소 입력필드는 최대 3개까지만 추가할 수 있습니다.");
			return;
		}
		$(this).closest(".row").remove();
	})
		
	// 연락처 추가 - 기본 전화번호 설정
	$("#tel-box").on('change', ':radio[name=contact-default-radio]', function(){
		let index = $(this).closest(".row").index();
		$(":hidden[name=contact-index]").val(index); 	
	})
	
	// 연락처 추가 - 기본 이메일 설정
	$("#email-box").on('change', ':radio[name=email-default-radio]', function(){
		let index = $(this).closest(".row").index();
		$(":hidden[name=email-index]").val(index); 
	})
	
	// 연락처 추가 - 기본 주소 설정
	$("#address-box").on('change', ':radio[name=address-default-radio]', function(){
		let index = $(this).closest(".row").index();
		$(":hidden[name=address-index]").val(index); 
	})
	
	// 그룹
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
				
				$("#book-table tbody").html(html);
				
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
				
				$("#book-table tbody").html(html);
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

})
</script>
</body>
</html>