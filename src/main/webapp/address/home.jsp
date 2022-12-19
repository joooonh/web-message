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
	BookDao bookDao = new BookDao();
	int totalRows = bookDao.getTotalRows(); 
	
	ContactDao contactDao = new ContactDao();
	EmailDao emailDao = new EmailDao();
	
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
				  				<li id="wastebasket"><span><i class="bi bi-trash me-2"></i>휴지통</span></li>
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
					<a href="javascript:void(0);" id="compleetDeleteBtn" class="btn btn-outline-danger btn-sm d-none"><i class="bi bi-trash"></i> 완전삭제</a>
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
			
			// 하나의 주소록번호에 contact, email 여러개
			// 기본주소록만 목록에 표시
			Contact contact = contactDao.getDefaultContactByBookNo(bookNo);
			// bookNo에 해당하는 이메일 정보 출력
			Email email = emailDao.getDefaultEmailByBookNo(bookNo); 
%>
							<tr>

								<td class="text-center"><input type="checkbox" name="bookNo" value="<%=bookNo %>"/></td>
								<td><i class="bi bi-star text-success" ></i></td>
								<td>
									<a href="" class="text-decoration-none" data-address-book-no="<%=book.getBookNo() %>"><%=book.getFirstName() + book.getLastName()  %></a>
								</td>
								<td><%=contact != null ? contact.getTel() : "" %></td>
								<td><%=email != null ? email.getAddr() : "" %></td> 
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
<!-- 연락처 상세, 수정 모달 -->
<div class="modal" tabindex="-1" id="modal-detail-address">
   <div class="modal-dialog modal-lg">
      <div class="modal-content">
         <div class="modal-header">
            <h5 class="modal-title">연락처 상세 정보</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
         </div>
         <div class="modal-body">
            <p>연락처 정보를 확인하세요</p>
            <form id="updateForm" class="border p-3 bg-light" method="post" action="updateAddress.jsp">
               <!-- 주소록번호를 전달 -->
               <input type="hidden" name="addressBookNo" value="" />
               <div class="row mb-3">
                  <label class="col-sm-2 col-form-label">이름</label>
                  <div class="col-sm-3">
                     <input type="text" class="form-control form-control-sm" name="firstName" value="홍">
                  </div>
                  <div class="col-sm-3">
                     <input type="text" class="form-control form-control-sm" name="lastName" value="길동">
                  </div>
               </div>
               <div id="box-contact" class="mb-3">
                  <!-- 연락처가 추가되는 곳 -->
                  <div class="row mb-1">
                     <label class="col-sm-2 col-form-label">전화번호 <input type="radio" name="" value="Y" checked class="float-end mt-1"></label>
                     <div class="col-sm-2">
                        <select class="form-select form-select-sm" name="contactType">
                           <option value="휴대폰"> 휴대폰</option>
                           <option value="회사" selected> 회사</option>
                           <option value="집"> 집</option>
                           <option value="기타"> 기타</option>
                        </select>
                     </div>
                     <div class="col-sm-6">
                        <input type="text" class="form-control form-control-sm" name="contactTel" value="020-1234-5678">
                     </div>
                     <div class="col-sm-2 d-flex justify-content-end">
                        <button type="button" class="btn btn-sm"><i class="bi bi-plus-circle"></i></button>
                        <button type="button" class="btn btn-sm"><i class="bi bi-dash-circle"></i></button>
                     </div>
                  </div>
                  <div class="row mb-1">
                     <label class="col-sm-2 col-form-label">전화번호 <input type="radio" name="" value="N" class="float-end mt-1"></label>
                     <div class="col-sm-2">
                        <select class="form-select form-select-sm" name="contactType">
                           <option value="휴대폰"> 휴대폰</option>
                           <option value="회사" selected> 회사</option>
                           <option value="집"> 집</option>
                           <option value="기타"> 기타</option>
                        </select>
                     </div>
                     <div class="col-sm-6">
                        <input type="text" class="form-control form-control-sm" name="contactTel" value="020-1234-5678">
                     </div>
                     <div class="col-sm-2 d-flex justify-content-end">
                        <button type="button" class="btn btn-sm"><i class="bi bi-plus-circle"></i></button>
                        <button type="button" class="btn btn-sm"><i class="bi bi-dash-circle"></i></button>
                     </div>
                  </div>
               </div>
               <div id="box-email" class="mb-3">
                  <!-- 이메일이 추가되는 곳 -->
                  <div class="row mb-1">
                     <label class="col-sm-2 col-form-label">이메일 <input type="radio" name="" value="Y" checked class="float-end mt-1"></label>
                     <div class="col-sm-8">
                        <input type="text" class="form-control form-control-sm" name="emailAddr" value="hong@gmail.com">
                     </div>
                     <div class="col-sm-2 d-flex justify-content-end">
                        <button type="button" class="btn btn-sm"><i class="bi bi-plus-circle"></i></button>
                        <button type="button" class="btn btn-sm"><i class="bi bi-dash-circle"></i></button>
                     </div>
                  </div>
                  <div class="row mb-1">
                     <label class="col-sm-2 col-form-label">이메일 <input type="radio" name="" value="N" class="float-end mt-1"></label>
                     <div class="col-sm-8">
                        <input type="text" class="form-control form-control-sm" name="emailAddr" value="hong@gmail.com">
                     </div>
                     <div class="col-sm-2 d-flex justify-content-end">
                        <button type="button" class="btn btn-sm"><i class="bi bi-plus-circle"></i></button>
                        <button type="button" class="btn btn-sm"><i class="bi bi-dash-circle"></i></button>
                     </div>
                  </div>
               </div>
               <div class="row mb-3">
                  <label class="col-sm-2 col-form-label">그룹</label>
                  <div class="col-sm-5">
                     <select class="form-select form-select-sm" name="groupNo">
                        <option value="100"> 친구</option>
                        <option value="102"> 회사</option>
                        <option value="103" selected> 가족</option>
                        <option value="104"> 모인</option>
                     </select>
                  </div>
               </div>
               <div class="row mb-3">
                  <label class="col-sm-2 col-form-label">회사</label>
                  <div class="col-sm-4">
                     <input type="text" class="form-control form-control-sm" name="company" value="한국주식회사" placeholder="회사명">
                  </div>
                  <div class="col-sm-3">
                     <input type="text" class="form-control form-control-sm" name="dept" value="개발1팀" pattern="부서명">
                  </div>
                  <div class="col-sm-3">
                     <input type="text" class="form-control form-control-sm" name="position" value="사원" placeholder="직위">
                  </div>
               </div>
               <div id="box-address" class="mb-3">
                  <!-- 주소가 추가되는 곳 -->
                  <div class="row mb-1">
                     <label class="col-sm-2 col-form-label">주소 <input type="radio" name="" value="Y" checked class="float-end mt-1"></label>
                     <div class="col-sm-3">
                        <select class="form-select form-select-sm" name="addressType">
                           <option value="회사" selected> 회사</option>
                           <option value="집"> 집</option>
                           <option value="기타"> 기타</option>
                        </select>
                     </div>
                     <div class="col-sm-3">
                        <input type="text" class="form-control form-control-sm" name="zipcode" value="1234" placeholder="우편번호">
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
                        <input type="text" class="form-control form-control-sm" name="basic" value="서울특별시 종로구" placeholder="기본주소">
                     </div>
                  </div>
                  <div class="row mb-1">
                     <div class="col-sm-10  offset-sm-2">
                        <input type="text" class="form-control form-control-sm" name="detail" value="502호" placeholder="기본주소">
                     </div>
                  </div>
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
            <button type="button" id="updateBtn" class="btn btn-dark btn-sm">수정</button>
         </div>
      </div>
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
 
 /* 주소록 상세보기, 수정 폼 */
$(function() {
	   let addressDetailModal = new bootstrap.Modal("#modal-detail-address");
	   
	   $("#table-address-list tbody a").click(function(event) {
	      event.preventDefault();
	      // 클릭한 주소록의 주소록번호를 저장 
	      var addressBookNo = $(this).attr("data-address-book-no");
		  $("#updateBtn").click(function() {
			  $("#updateForm input[name='addressBookNo']").val(addressBookNo);
			  $("#updateForm").submit();
		  });      
	    	  
	      addressDetailModal.show();
	   })
});
 
	// 삭제버튼 클릭시 발생하는 이벤트
	$("#deleteBtn").click(function() {
		var addressBookNo = [];
		
		if ($("input[name=bookNo]:checked").length == 0) {
			alert("삭제할 주소록을 선택하세요");
			return false;
		};
		
		// 선택한 주소록을 각각 배열에 담는다. 
		$("input[name=bookNo]:checked").each(function(){
			 addressBookNo.push($(this).val());
		});
		// 삭제할 주소록을 deleteAddress.jsp에 보낸다.
		location.href = "deleteAddress.jsp?addressBookNo="+addressBookNo;
	});
	
	// 완전삭제 버튼 클릭시 발생하는 이벤트
	$("#compleetDeleteBtn").click(function() {
		var addressBookNo = [];
		
		if (addressBookNo == "") {
			alert("완전삭제할 주소록을 선택하세요");
			return false;
		};
		
		// 선택한 주소록을 각각 배열에 담는다. 
		$("input[name=bookNo]:checked").each(function(){
			 addressBookNo.push($(this).val());
		});
		
		// 삭제할 주소록을 deleteAddress.jsp에 보낸다.
		location.href = "completeDeleteAddress.jsp?addressBookNo="+addressBookNo;
	})
	
	// form 태그 전송
	function submitForm(page) {
		$("input[name=page]").val(page);
		
		$("#deliverForm").submit();
	};

	// 휴지통 클릭했을 때 이벤트
	$("#wastebasket").click(function(){
		$("#deleteBtn").addClass("d-none");
		$("#compleetDeleteBtn").removeClass("d-none");
		
		wastbasketList();
	});

	// ajax사용해서 삭제한 주소록 목록 조회하는 함수
	function wastbasketList() {
		
		$.getJSON("wastebasket.jsp", {empNo:<%=empNo %>}, function(result){
			// 주소록 갯수를 조회해서 내 주소록의 갯수를 변경한다.
			var addressList = result.addressList;
			var count = addressList.length;
			$("#addressCount").text(count);
			
			var html = "";
			var nav = "";

			// 삭제한 주소록이 없을때
			if (addressList.length < 1) {
				html += '<tr>';
				html += '<td colspan="8" class="text-center">휴지통이 비어있습니다.</td>'
				html += '</tr>';
				
				$("#book-table tbody").html(html);
				
				nav += "<ul style='display:none;'></ul>";
				$("#nav").html(nav);
				
				return;
			}
			
			// 삭제한 주소록 목록
			for (var i = 0; i < addressList.length; i++) {
				var addr = addressList[i];
				
				html += '<tr>';
				html += 	'<td class="text-center"><input type="checkbox" name="bookNo" value="'+ addr.bookNo +'"/></td>'
				html += 	'<td><i class="bi bi-star-fill text-success text-border"></i></td>'
				html += 	'<td>'+ addr.lastName+addr.firstName +'</td>'
				html += 	'<td>'+ addr.tel +'</td>'
				html += 	'<td>'+ addr.addr +'</td>'
				html += 	'<td>'+ addr.company +'</td>'
				html += 	'<td>'+ addr.dept +'</td>'
				html += 	'<td>'+ addr.position +'</td>'
				html += '</tr>';
				
				$("#book-table tbody").html(html);
			}
			
			// 페이징 처리
			var paging = result.paging;
		 	var nav = `
					<ul class="pagination pagination-sm justify-content-center">	
						<li class="page-item">
							<a class="page-link \${result.isFirst ? 'disabled' : ''}" href="home.jsp?page=\${result.prevPage}">이전</a>
						</li>`
			
					for (let number = result.beginPage; number <= result.endPage; number++) {
						
						nav += `<li class="page-item">
							       <a class="page-link \${result.currentPage == number ? 'active' : ''}" href="home.jsp?page=\${number}" data-page-no="\${number}">\${number}</a>
								</li>`
					}
				
				nav += `<li class="page-item">
							<a class="page-link \${paging.isLast ? 'disabled' : ''}" href="home.jsp?page=\${result.nextPage}">다음</a>
						</li>
					</ul>
					
			`;
			
			$("#nav").html(nav); 
		});
	};
	/* $("#nav .pagination").on('click', '.page-link', function(event){
		event.preventdefault();
		
		var pageNo = $(this).attr("data-page-no");
		console.log(pageNo);
	}); */
	
	$("#nav .pagination .page-link").click(function(event){
		event.preventDefault();
		
		var page = $(this).attr("data-page-no");
		console.log(page);
		
		$.getJSON("wastebasket.jsp", {empNo:<%=empNo %>, pageNo:page}, function(result){
			// 주소록 갯수를 조회해서 내 주소록의 갯수를 변경한다.
			var addressList = result.addressList;
			var count = addressList.length;
			$("#addressCount").text(count);
			
			var html = "";
			var nav = "";

			// 삭제한 주소록이 없을때
			if (addressList.length < 1) {
				html += '<tr>';
				html += '<td colspan="8" class="text-center">휴지통이 비어있습니다.</td>'
				html += '</tr>';
				
				$("#book-table tbody").html(html);
				
				nav += "<ul style='display:none;'></ul>";
				$("#nav").html(nav);
				
				return;
			}
			
			// 삭제한 주소록 목록
			for (var i = 0; i < addressList.length; i++) {
				var addr = addressList[i];
				
				html += '<tr>';
				html += 	'<td class="text-center"><input type="checkbox" name="bookNo" value="'+ addr.bookNo +'"/></td>'
				html += 	'<td><i class="bi bi-star-fill text-success text-border"></i></td>'
				html += 	'<td>'+ addr.lastName+addr.firstName +'</td>'
				html += 	'<td>'+ addr.tel +'</td>'
				html += 	'<td>'+ addr.addr +'</td>'
				html += 	'<td>'+ addr.company +'</td>'
				html += 	'<td>'+ addr.dept +'</td>'
				html += 	'<td>'+ addr.position +'</td>'
				html += '</tr>';
				
				$("#book-table tbody").html(html);
			}
		});
	}); 
</script>
</body>
</html>