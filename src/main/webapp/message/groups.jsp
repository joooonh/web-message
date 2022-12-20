<%@page import="com.semi.message.vo.MessageGroup"%>
<%@page import="com.semi.message.dao.MessageGroupDao"%>
<%@page import="com.semi.util.StringUtils"%>
<%@page import="java.util.List"%>
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
<title>메세지 그룹 관리</title>
<style type="text/css">
.btn-xs {
	--bs-btn-padding-y: .20rem; 
	--bs-btn-padding-x: .5rem; 
	--bs-btn-font-size: .55rem;
}
</style>
</head>
<body>
<%
	int empNo = 1010;

	MessageGroupDao addMessageGroupDao = MessageGroupDao.getInstance();

	// 직원번호로 조회한 메세지그룹정보
	List<MessageGroup> addMessageGroupList = addMessageGroupDao.getMessageGroupsByEmpNo(empNo);
%>
<jsp:include page="../common/header.jsp">
	<jsp:param name="menu" value="home"/>
</jsp:include>
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
			<div class="row">
				<div class="col-12">
					<strong>메세지 그룹 관리</strong>
				</div>
			</div>
			<hr />
			<div class="row mb-2">
				<div class="col-6 ">
					<div class="border p-3">
						<div class="row mb-2">
							<div class="col-12">
								<button class="btn btn-outline-secondary btn-xs rounded-0" id="bt-checkAll" >전체 선택</button>
								<button class="btn btn-outline-secondary btn-xs rounded-0" id="bt-deleteAll"><i class="bi bi-trash"></i>삭제</button>
								<div class="btn-group" role="group" aria-label="Basic example">
									<button class="btn btn-outline-secondary btn-xs rounded-0" id="bt-top">맨 위로</button>
									<button class="btn btn-outline-secondary btn-xs rounded-0" id="bt-up">위로</button>
									<button class="btn btn-outline-secondary btn-xs rounded-0" id="bt-down">아래로</button>
									<button class="btn btn-outline-secondary btn-xs rounded-0" id="bt-bottom">맨 아래로</button>
								</div>
							</div>
						</div>
						<div class="row mb-2">
							<div class="col-12">
								<table class="table table-sm border-top" id="GroupListTable">
									<colgroup>
										<col width="5%">
										<col width="60%">
										<col width="10%">
									</colgroup>
									<thead>
												<%
				if (addMessageGroupList.isEmpty()) {
			%>
										<tr class="bg-light small">
											<th><input type="checkbox" id="checkbox-all" disabled></th>
											<th>그룹명</th>
											<th>수정/삭제</th>
										</tr>
			<%
				} else {
			%>
										<tr class="bg-light small">
											<th><input type="checkbox" id="checkbox-all"></th>
											<th>그룹명</th>
											<th>수정/삭제</th>
										</tr>
										<%
				}	
			%>
									</thead>
							<tbody>
			<%
				if (addMessageGroupList.isEmpty()) {
			%>
						<tr class="small">
							<td></td>
							<td>정보가 없습니다.</td>
							<td></td>
						</tr>
			<%
				} else {
					for (MessageGroup messageGroup : addMessageGroupList) {
			%>
						<tr class="small">
							<td><input type="checkbox" name="groupNo" value="100"></td>
							<td>
								<form id="form-<%=messageGroup.getGroupNo() %>" name="groupForm" method="post" action="updateMessageGroup.jsp">
									<span ><%=messageGroup.getGroupName()%></span>
									<input type="hidden" name="groupNo" value="<%=messageGroup.getGroupNo() %>" />
									<input type="text"  class="d-none" name="groupName" value="<%=messageGroup.getGroupName()%>"/>
								</form>
							</td>
							<td></td>
							<td>
								<a class="btn btn-outline-danger btn-xs rounded-0" data-group-no="<%=messageGroup.getGroupNo()%>" href="deleteMessageGroup.jsp?groupNo=<%=messageGroup.getGroupNo()%>" >삭제하기</a>
								<button type="button" class="btn btn-outline-warning btn-xs rounded-0" data-group-no="<%=messageGroup.getGroupNo()%>" data-target="#form-<%=messageGroup.getGroupNo()%>">수정하기</button>
							</td>
						</tr>
						
			<%
					}
				}	
			%>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
				<div class="col-6">
					<div class=" border p-3">
							<form id="form-add-groupName" method="post" action="insertMessageGroup.jsp">
							<div class="row mb-1">
								<label class="col-sm-3 col-form-label col-form-label-sm fw-bold">메세지 그룹</label>
								<div class="col-sm-4">
									<input type="text" class="form-control form-control-sm" placeholder="메세지 그룹을 추가하세요" name="groupName">
								</div>
								<label class="col-sm-2 col-form-label col-form-label-sm fw-bold">공유여부</label>
								<div class="col-sm-1">
									<input type="checkbox" name="shareable" value="Y">
								</div>
						 
								<div class="col-sm-2">
									<button type="submit" class="btn btn-success btn-xs" style="margin-top: 2px;">추가</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#checkbox-all").change(function(){
		var checkboxAllChecked = $(this).prop("checked");
		$(":checkbox[name=groupNo]").prop('checked',checkboxAllChecked);
	}); // 그룹명 옆에 체크박스 클릭시 체크박스 전체 체크
	
	$("#bt-checkAll").on("click", function(){
		$("[name=groupNo]").prop('checked',true);
	}); //전체선택 버튼 클릭시 체크박스 전체 체크
	
	$("#form-add-groupName").submit(function(event){
		var groupNameValue = $("#form-add-groupName [name=groupName]").val();
		
		
		if(groupNameValue.trim() ===""){
			alert("그룹명을 입력해주세요.");
			return false;
		}
		return true;
	});
	
	
	
	$('#GroupListTable button').click(function(){
		
		var groupNo = $(this).attr("data-group-no");
		var formId = $(this).attr("data-target");
		
		
		if ($(formId).find("span").hasClass("d-none")) {
			$(this).text("수정하기");
			var param = {
				no: groupNo,
				name : $(formId).find("[name=groupName]").val()
			}
			$.get("updateMessageGroup.jsp", param, function(response) {
				$(formId).find("span").text($(formId).find("[name=groupName]").val())
				alert("메세지 그룹명이 변경되었습니다.");
			})
			
		} else {
			$(this).text("수정완료");
		}
	
		$(formId).find("span").toggleClass("d-none");
		$(formId).find("[name=groupName]").toggleClass("d-none");
		
	}); //수정하기 버튼 적용
	
    $('#bt-top').click(function(){
    	var $checkedCheckbox = $("#GroupListTable tbody :checkbox:checked");
    	var $row = $checkedCheckbox.closest("tr");
    	
    	$row.insertBefore($row.parent().find('tr:first-child'));
    })//맨앞에 버튼 적용
    
    $('#bt-bottom').click(function(){
    	var $checkedCheckbox = $("#GroupListTable tbody :checkbox:checked");
    	var $row = $checkedCheckbox.closest("tr");
    	
    	$row.insertAfter($row.parent().find('tr:last-child'));
    })//맨뒤로 버튼 적용
    
    $('#bt-down').click(function(){
    	var $checkedCheckbox = $("#GroupListTable tbody :checkbox:checked");
    	var $row = $checkedCheckbox.closest("tr");
    	
    	$row.before($row.parent().find('tr:last-child'));
    })//아래로 버튼 적용
    
    $('#bt-up').click(function(){
    	var $checkedCheckbox = $("#GroupListTable tbody :checkbox:checked");
    	var $row = $checkedCheckbox.closest("tr");
    	
    	$row.after($row.parent().find('tr:first-child'));
    })//위로 버튼 적용
    

    

  
    
    
 
})

</script>
</body>
</html>