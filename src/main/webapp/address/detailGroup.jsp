<%@page import="com.semi.admin.vo.Employee"%>
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
<%@ include file="../logincheck.jsp" %>

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

	int groupNo = StringUtils.stringToInt(request.getParameter("groupNo"));
	int empNo = loginEmployee.getNo();
	
	// 현재 페이지 
	int currentPage = StringUtils.stringToInt(request.getParameter("page"), 1);
	String opt = StringUtils.nullToBlank(request.getParameter("opt"));
	String keyword = StringUtils.nullToBlank(request.getParameter("keyword"));
	
	// 전체 페이지
	Map<String, Object> map = new HashMap<>();
	map.put("empNo", empNo);
	map.put("groupNo", groupNo);
	BookDao bookDao = BookDao.getInstance();
	int totalRows = bookDao.getTotalRowsByGroupNo(map); 
	
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
	param.put("groupNo", groupNo);
	
	param.put("begin", pagination.getBegin()); 
	param.put("end", pagination.getEnd()); 
	
	List<Book> bookList = bookDao.getBooksByGroupNo(param); 

	AddressGroupDao addGroupDao = new AddressGroupDao();
	List<Group> addGroupList = addGroupDao.getAddGroupsByEmpNo(empNo);
	
	String error = request.getParameter("error");
%>
<div class="container-fluid my-3">
<%
	if ("fail".equals(error)) {
%>
	<div class="alert alert-danger" style="font-size: 14px;">
		<strong>등록 실패</strong> 이미 존재하는 그룹명입니다.
	</div>
<%
	}
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
					<a href="recentAdd.jsp" class="text-decoration-none text-dark" >
						<button class="btn">
							<i class="bi bi-clock-fill text-success"></i><br/>
							<small>최근등록</small>
						</button>
					</a>
					<a href="important.jsp" class="text-decoration-none text-dark" >
						<button class="btn">
							<i class="bi bi-star-fill text-success"></i><br/>
							<small>중요</small>
						</button>
					</a>
				</div>
			</div>
			<div class="row mb-3">
				<div class="col">
					<div class="card">
						<div class="card-body">
							<ul class="tree" style="cursor:pointer;">
				  				<li>
				  					<span>
				  						<a href="home.jsp" class="text-decoration-none text-dark"><i class="bi bi-person-lines-fill me-2"></i>전체 연락처</a>
				  						<a href="control.jsp" class="text-decoration-none text-dark float-end"><i class="bi bi-gear-fill"></i></a>
				  					</span>
				    				<ul class="nested active">
		<%
			// 그룹리스트
			if (!addGroupList.isEmpty()) {
				for (Group group : addGroupList) {
		%>
										<li>
											<a href="detailGroup.jsp?groupNo=<%=group.getNo() %>" style="text-decoration:none;color:black;">
		<%
					if (group.getNo() == groupNo) {
		%>
												<mark><%=group.getName() %></mark>
		<%
					} else {
		%>		
												<%=group.getName() %>
		<%
					}
		%>
											
											</a>
										</li>
		<%
				}
			}
		%>
									</ul>
								</li>
				  				<li id="wastebasket" data-employee-no="<%=loginEmployee.getNo() %>"><span><i class="bi bi-trash me-2"></i>휴지통</span></li>
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
			
			// 기본 전화번호, 이메일만 목록에 표시
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
<!-------------------------------------- 그룹 등록폼 ------------------------------>
<div class="modal" tabindex="-1" id="modal-form-address-group">
	<div class="modal-dialog modal-sm">
		<form id="from-add-addrGroup" method="post" action="registerGroupH.jsp">
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
$(function() {
	// 주소록 그룹 이동
	$("#btn-move-addr").click(function () {
		var groupNo = $("#select-groups").val()
		if (groupNo == "") {
			alert("이동할 그룹을 선택하세요.")
			return false;
		}
		
		var checkedCheckboxLength = $("#table-address-books :checkbox[name=bookNo]:checked").length
		if(checkedCheckboxLength == 0) {
			alert("이동할 주소록을 하나 이상 선택하세요.")
			return false;
		}
		
		$("#form-book").trigger("submit");
	})
	
	$("#from-add-addrGroup").submit(function() {
		if ($("#from-add-addrGroup :input[name=name]").val() === "") {
			alert("그룹이름은 필수입력값입니다.");
			return false;
		}
		return true;
	}); 
	
});
</script>
</body>
</html>