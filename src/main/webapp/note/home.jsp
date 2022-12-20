<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.semi.memo.vo.Memo"%>
<%@page import="com.semi.memo.vo.Folder"%>
<%@page import="com.semi.memo.dao.MemoDao"%>
<%@page import="com.semi.memo.dao.FolderDao"%>
<%@page import="com.semi.admin.vo.Employee"%>
<%@page import="com.semi.admin.dao.EmployeeDao"%>

<%@page import="java.util.List"%>
<%@page import="com.semi.util.StringUtils"%>
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
	//int empNo = 1006; 
    int empNo = loginEmployee.getNo();
	
    MemoDao memoDao= new MemoDao();
	int totalRows = memoDao.getTotalRows();
	
	int folderNo = StringUtils.stringToInt(request.getParameter("folderNo"));
	String important = request.getParameter("important");
	String keyword = request.getParameter("keyword");
	
	Map<String, Object> param = new HashMap<>(); 
	//param.put("empNo", empNo);
	param.put("empNo", loginEmployee.getNo());
	if (folderNo != 0) {
		param.put("folderNo", folderNo);
	}
	if (important != null) {
		param.put("important", important);
	}
	
	if (keyword != null) {
		param.put("keyword", keyword);
	}
	
	
 	List<Memo> memoList= memoDao.getMemos(param);

%>
<div class="container-fluid my-3">
	<div class="row">
		<div class="col-2">
			<div class="row mb-3">
				<div class="col text-center">
					<div class="btn-group" role="group">
					</div>
				</div>
			</div>
			<div class="row mb-3">
				<div class="col">
					<div class="card">
						<div class="card-body">
							<ul class="tree">
				  				<li><span><a href="home.jsp" class="caret caret-down text-decoration-none <%=folderNo == 0 && important == null ? "text-white bg-dark" : "text-dark"%>">전체 메모</a></span>
				    				<ul class="nested active">
										<li><a href="home.jsp?folderNo=100" class="text-decoration-none <%=folderNo == 100 ? "text-white bg-dark" : "text-dark" %>">내 메모(기본)</a></li>
										<li><a href="home.jsp?important=Y" class="text-decoration-none <%="Y".equals(important) ? "text-white bg-dark" : "text-dark"%>">중요 메모</a></li>
										<li><a href="home.jsp?folderNo=200" class="text-decoration-none <%=folderNo == 200 ? "text-white bg-dark" : "text-dark" %>">할일</a></li>
										<li><a href="home.jsp?folderNo=300" class="text-decoration-none <%=folderNo == 300 ? "text-white bg-dark" : "text-dark" %>">스크랩</a></li>
										<li><a href="home.jsp?folderNo=400" class="text-decoration-none <%=folderNo == 400 ? "text-white bg-dark" : "text-dark" %>">아이디어</a></li>
										<li><a href="home.jsp?folderNo=500" class="text-decoration-none <%=folderNo == 500 ? "text-white bg-dark" : "text-dark" %>">쇼핑</a></li>
									</ul>
								</li>
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
							<input type="text" class="form-control form-control-sm" name="keyword" value="<%=keyword != null ? keyword : "" %>" placeholder="메모 검색"/>
						</div>
						<div class="col-12">
							<button type="submit" class="btn btn-sm btn-outline-secondary">검색</button>
						</div>
					</form>
					<div class="pt-1">
					<small>
							<strong>전체 메모</strong>
							<strong class="text-success"><%=totalRows %>개</strong>
						</small>
					</div>
				</div>
			</div>
			<hr/>
			<div class="row mb-2">
				<div class="col">
					<button class="btn btn-outline-danger btn-xs" id="btn-delete-memo">삭제</button>
					<button class="btn btn-primary btn-xs" id="btn-register-memo">등록</button>
					<select class="form-select form-select-xs w-150" name="folder">
						<option value=""> 폴더 이동</option>						
						<option value="100"> 내 메모</option>
						<option value="200"> 할일</option>
						<option value="300"> 스크랩</option>
						<option value="400"> 아이디어</option>
						<option value="500"> 쇼핑</option>
					</select>
				</div>
			</div>
			<div class="row mb-2">
				<div class="col p-3">
				<form id="form-register-memo" action="register.jsp">
					<input type="hidden" name="folderNo" value="100" />
					<textarea rows="" cols="" name="content" class="d-none"></textarea>
				</form>
				<form id="form-memo" class="d-inline" method="get" action="delete.jsp">
					<div class="border bg-light p-3" >
						<div class="row" style="height:600px; overflow: auto;">
                        
                         <!--  -->
							<div class="col-3 mb-3">
								<div class="card">
									<div class="card-header">
										간단한 메모는 여기에
									</div>
									<!--  -->
						
									<div class="card-body" style="height:150px;">
										<textarea rows="" class="form-control h-100 border-0" id="content">메모를 입력하세요.</textarea>
									</div>
								</div>
							</div>
<%
	if (!memoList.isEmpty()) {
		for (Memo memo :memoList) {
%>	

							<div class="col-3 mb-3">
								<div class="card">
									<div class="card-header">
										<input type="checkbox" name="memoNo" value="<%=memo.getNo() %>">
										<small class="text-muted"><%=StringUtils.dateToText(memo.getCreatedDate())  %></small>
										<small class="float-end">
										    <a href=><i class="bi bi-pencil-fill"></i></a>
											<a href="important.jsp?memoNo=<%=memo.getNo() %>&important=<%=memo.getImportant()%>"><i class="bi <%=memo.getImportant().equals("Y") ? "bi-star-fill" : "bi-star"%>"></i></a>
										</small>
									</div>
									<div class="card-body" style="height:150px;">
										<p class="card-text"><%=memo.getContent() %></p>
									</div>
								</div>
							</div>
<%
		}
	}
%>
						</div>
					</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>



<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">


// 등록
$("#btn-register-memo").click(function() {
	var content = $("#content").val();
	if (content == "") {
		alert("메모 내용을 입력하세요");
		return;
	}

	$("#form-register-memo [name=content]").val(content);
	$("#form-register-memo").trigger("submit")
});

//체크 삭제
$("#btn-delete-memo").click(function() {
	
    var checkboxLength = $(":checkbox[name=memoNo]:checked").length;
    if (checkboxLength == 0) {
    	alert("체크박스를 하나이상 체크하세요");
    	return false;
    }
    
    
   $("#form-memo").trigger("submit");
	
});

//폴더 이동
$("select[name=folder]").change(function() {
	var fno= $(this).val();
	var mno= $(":checkbox[name=memoNo]:checked").val()

	$.get("move.jsp", {folderNo:fno, memoNo:mno}, function(response) {
		if (response == "success") {
			$(":checkbox[name=memoNo]:checked").closest(".col-3").remove();
			alert("폴더가 변경되었습니다.");
		}
	})
});


</script>
</body>
</html>