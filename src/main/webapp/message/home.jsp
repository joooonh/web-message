<%@page import="com.semi.message.vo.Message"%>
<%@page import="java.util.List"%>
<%@page import="com.semi.util.Pagination"%>
<%@page import="com.semi.message.dao.MessageDao"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.semi.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- logincheck.jsp 삽입 필요 -->
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
	int userEmpNo = 1000;	// logincheck.jsp로부터 가져와야 하는 값, 1000은 임의의 값임.
	String group = StringUtils.nullToBlank(request.getParameter("group"));
	String keyword = StringUtils.nullToBlank(request.getParameter("keyword"));
	int currentPage = StringUtils.stringToInt(request.getParameter("pageNo"), 1);
	int rows = StringUtils.stringToInt(request.getParameter("rows"), 10);
	
	Map<String, Object> param = new HashMap<>();
	
	MessageDao messageDao = MessageDao.getInstance();
%>
<div class="container-fluid my-3">
	<div class="row">
		<div class="col-2">
			<div class="row mb-3">
				<div class="col text-center">
					<div class="btn-group" role="group">
						<button class="btn btn-success px-4" id="btn-open-modal-1">쪽지쓰기</button>
						<button class="btn btn-success px-4" id="btn-open-modal-2">내게쓰기</button>
					</div>
				</div>
			</div>
			<div class="row mb-3">
				<div class="col">
					<div class="card">
						<div class="card-body">
							<ul class="tree">
								<li>
									<span class="caret caret-down">전체 쪽지</span>
									<ul class="nested active">
										<li>
						  					<span class="caret caret-down" id="receive-message">받은 쪽지함</span>
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
					<!------------------------------ 검색 폼 시작 ------------------------------>
					<form class="row row-cols-lg-auto align-items-center me-3">
						<div class="col-12">
							<input type="hidden" name="userEmpNo" value="<%=userEmpNo %>">
							<input type="hidden" name="pageNo" value="<%=currentPage %>">
							<select class="form-select form-select-sm" name="group">
								<option value=""> 전체쪽지</option>
								<option value="receive" <%="receive".equals(group) ? "selected" : "" %>> 받은쪽지</option>
								<option value="send" <%="send".equals(group) ? "selected" : "" %>> 보낸쪽지</option>
								<option value="save" <%="save".equals(group) ? "selected" : "" %>> 보관쪽지</option>
								<option value="toMe" <%="toMe".equals(group) ? "selected" : "" %>> 내게쓴쪽지</option>
							</select>
						</div>
						<div class="col-12">
							<input type="text" class="form-control form-control-sm" name="keyword" value="<%=keyword %>" placeholder="쪽지검색"/>
						</div>
						<div class="col-12">
							<button type="submit" class="btn btn-sm btn-outline-secondary">검색</button>
						</div>
					</form>
					<!------------------------------ 검색 폼 끝 ------------------------------>
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
<!--------------------------- 모달창 시작 --------------------------->
<div class="modal" tabindex="-1" id="modal-form-message">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">메세지 작성폼</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form class="border p-3 bg-light" method="post" action="send.jsp" id="message-form">
					<div class="row mb-2">
						<div class="col-sm-8 offset-sm-2">
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="checkbox" name="me" value="Y">
								<label class="form-check-label">나에게 쓰는 메세지</label>
							</div>
						</div>
					</div>
					<div class="row mb-2">
						<div class="col-sm-8 offset-sm-2">
							<div class="form-check form-check-inline " id="send-me-comment1">
								<input class="form-check-input" type="checkbox" name="sentBox" value="Y" checked="checked">
								<label class="form-check-label">보낸 메세지함 저장 여부</label>
							</div>
							<p class="form-check-label" id="send-me-comment2"><strong>내게 쓴 쪽지는 내게 쓴 쪽지함에만 저장됩니다.</strong></p>
						</div>
					</div>
					<div class="row mb-2">
						<label class="col-sm-2 col-form-label col-form-label-sm">메세지 종류</label>
						<div class="col-sm-8">
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="type" value="E" checked>
								<label class="form-check-label">일반 메세지</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="type" value="D">
								<label class="form-check-label">부서 메세지</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="type" value="S">
								<label class="form-check-label">공유 메세지</label>
							</div>
						</div>
					</div>
					<div class="row mb-2">
						<label class="col-sm-2 col-form-label col-form-label-sm">수신자</label>
						<div class="col-sm-8">
							<!--
						 	주소록 팝업창에서 수신자를 선택해야 함.
						 	주소록 그룹이름 혹은 직원이름을 서버로 전달한 뒤 직원번호를 조회해야함.
						 	테스트를 위해 임시로 type="number" 지정했음. 원래는 type="text".
						 	동명이인 어떻게 처리? -> 이름으로 선택하고 서버로 전달되는 값은 직원번호?
						 	개인쪽지로 여러명에게 보낼 때는 어떻게 처리?
						 	-->
							<input type="number" class="form-control form-control-sm" name="receiver">
						</div>
						<div class="col-sm-2">
							<button type="button" name="address" class="btn btn-secondary btn-xs mt-0">선택하기</button>
						</div>
					</div>
					<div class="row mb-2">
						<label class="col-sm-2 col-form-label col-form-label-sm">내용</label>
						<div class="col-sm-10">
							<textarea rows="5" class="form-control" name="content"></textarea>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary btn-xs" data-bs-dismiss="modal">닫기</button>
						<button type="submit" class="btn btn-primary btn-xs">보내기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!--------------------------- 모달창 끝 --------------------------->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
	var messageFormModal = new bootstrap.Modal("#modal-form-message");
	
	// 유효성 검사 및 비활성화 데이터 전송
	$("#message-form").submit(function() {
		var $messageReceiver = $(":input[name=receiver]").val()
		var $messageContent = $(":input[name=content]").val()
		
		if ($messageReceiver === "") {
			alert("수신자를 입력하세요.")
			return false;
		}
		if ($messageContent === "") {
			alert("쪽지내용을 입력하세요")
			return false;
		}
			
		return true;
	})
	
	// 내게쓰기 체크하면 수신자 입력칸, 메세지 타입, 보관함 저장여부 비활성화
	$(":checkbox[name=me]").click(function(){
		var $isChecked = $(this).prop("checked")
		if ($isChecked) {
			checkedMe()
		} else {
			unCheckedMe()
		}
	})
	
	$("#btn-open-modal-1").click(function() {
		$(":checkbox[name=me]").prop("checked", false);
		unCheckedMe()
		messageFormModal.show();
	});
	
	$("#btn-open-modal-2").click(function() {
		$(":checkbox[name=me]").prop("checked", true);
		checkedMe()
		messageFormModal.show();
	});
	
	$("#receive-message").click(function() {
		
	})
// 함수 정의 	
	function checkedMe() {
		$(":input[name=sentBox]").prop("checked", false)
		$("#send-me-comment1").hide()
		$("#send-me-comment2").show()
		
		$(":radio[name=type]").prop("disabled", true)
		$(":radio[name=type][value=E]").prop("checked", true);
		
		$(":input[name=receiver]").prop("disabled", true)
		$(":input[name=receiver]").val(1000)	// "사용자 이름(사용자 직원번호)"는 logincheck에서 가져온 값임.
		
		$(":button[name=address]").prop("disabled", true)
	}
	
	function unCheckedMe() {
		$(":input[name=sentBox]").prop("checked", true)
		$("#send-me-comment1").show()
		$("#send-me-comment2").hide()
		
		$(":radio[name=type]").prop("disabled", false)
		
		$(":input[name=receiver]").prop("disabled", false)
		$(":input[name=receiver]").val("")
		
		$(":button[name=address]").prop("disabled", false)
	}
})
</script>
</body>
</html>