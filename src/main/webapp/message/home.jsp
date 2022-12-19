<%@page import="com.semi.admin.vo.Department"%>
<%@page import="com.semi.message.vo.MessageDepartment"%>
<%@page import="java.util.Date"%>
<%@page import="com.semi.message.vo.MessageReceiver"%>
<%@page import="com.semi.admin.vo.Employee"%>
<%@page import="com.semi.admin.dao.EmployeeDao"%>
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

	int empNo = 1000;	// logincheck.jsp로부터 가져와야 하는 값, employee.getNo();
	int deptNo = 105;	// logincheck.jsp로부터 가져와야 하는 값, employee.getDeptNo();
	String group = StringUtils.nullToValue(request.getParameter("group"), "receive");
	String keyword = StringUtils.nullToBlank(request.getParameter("keyword"));
	int currentPage = StringUtils.stringToInt(request.getParameter("pageNo"), 1);
	int rows = StringUtils.stringToInt(request.getParameter("rows"), 10);
	
	Map<String, Object> param = new HashMap<>();
	param.put("empNo", empNo);
	param.put("deptNo", deptNo);
	param.put("keyword", keyword);
	param.put("group", group);
	
	EmployeeDao employeeDao = new EmployeeDao();
	
	MessageDao messageDao = MessageDao.getInstance();
	int totalRows = messageDao.getTotalRows(param);
	
	Pagination pagination = new Pagination(currentPage, totalRows, rows);
	
	param.put("begin", pagination.getBegin());
	param.put("end", pagination.getEnd());
	
	List<Message> messageList = messageDao.getMessageList(param);
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
								<li id="message-inbox">
									<a href="home.jsp?group=all" class="caret caret-down text-decoration-none link-dark 
									<%="all".equals(group) ? "active bg-secondary" : "" %>">전체 쪽지</a>
									<ul class="nested active">
										<li>
						  					<a href="home.jsp?group=receive" class="caret caret-down text-decoration-none link-dark
						  					<%="receive".equals(group) ? "active bg-secondary" : "" %>">받은 쪽지함</a>
						    				<ul class="nested active">
												<li>개인쪽지</li>
												<li>부서쪽지</li>
											</ul>
										</li>
										<li><a href="home.jsp?group=me" class="caret caret-down text-decoration-none link-dark
										<%="me".equals(group) ? "active bg-secondary" : "" %>">내게 쓴 쪽지함</a></li>
						  				<li><a href="home.jsp?group=send" class="caret caret-down text-decoration-none link-dark
						  				<%="send".equals(group) ? "active bg-secondary" : "" %>">보낸 쪽지함</a></li>
						  				<li><a href="home.jsp?group=save" class="caret caret-down text-decoration-none link-dark
						  				<%="save".equals(group) ? "active bg-secondary" : "" %>">쪽지 보관함</a></li>
						  				<li><a href="home.jsp?group=sapm" class="caret caret-down text-decoration-none link-dark
						  				<%="spam".equals(group) ? "active bg-secondary" : "" %>">스팸 쪽지함</a></li>
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
					<!------------------------------------------------------ 검색 폼 시작 ------------------------------------------------------>
					<form class="row row-cols-lg-auto align-items-center me-3" method="post" action="home.jsp" id="search-form">
						<div class="col-12">
							<input type="hidden" name="pageNo" value="<%=currentPage %>">
							<select class="form-select form-select-sm" name="group">
								<option value="all" <%="all".equals(group) ? "selected" : "" %>> 전체쪽지</option>
								<option value="receive" <%="receive".equals(group) ? "selected" : "" %>> 받은쪽지</option>
								<option value="send" <%="send".equals(group) ? "selected" : "" %>> 보낸쪽지</option>
								<option value="save" <%="save".equals(group) ? "selected" : "" %>> 보관쪽지</option>
								<option value="me" <%="me".equals(group) ? "selected" : "" %>> 내게쓴쪽지</option>
							</select>
						</div>
						<div class="col-12">
							<input type="text" class="form-control form-control-sm" name="keyword" value="<%=keyword %>" placeholder="쪽지검색"/>
						</div>
						<div class="col-12">
							<button type="button" class="btn btn-sm btn-outline-secondary" onclick="submitForm(1)">검색</button>
						</div>
					</form>
					<!------------------------------------------------------ 검색 폼 끝 ------------------------------------------------------>
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
<!------------------------------------------------------------ 메세지 리스트 시작 ---------------------------------------------------->
			<form method="post" id="select-form">
			<div class="row mb-2">
				<div class="col">
					<input type="hidden" name="group" value="<%=group %>" >
					<button type="submit" class="btn btn-outline-danger btn-sm" formaction="deleteMessage.jsp">삭제</button>
					<button type="submit" class="btn btn-outline-secondary btn-sm" formaction="saveMessage.jsp">보관</button>
					<button type="submit" class="btn btn-outline-secondary btn-sm" formaction="">스팸신고</button>
					<button type="submit" class="btn btn-outline-secondary btn-sm" formaction="">답장</button>
					<button type="button" class="btn btn btn-danger btn-sm" formaction="clearMessage.jsp?group=<%=group %>" id="clear-btn">전체 삭제</button>
				</div>
			</div>
			<div class="row mb-2" >
				<div class="col" >
					<table class="table table-sm table-bordered" >
<!------------------------------------------------------ 전체 쪽지함 시작 ------------------------------------------------------------>
<%
						if ("all".equals(group)) { 		
%>
							<colgroup>
								<col width="5%">
								<col width="10%">
								<col width="10%">
								<col width="10%">
								<col width="*">
								<col width="15%">
								<col width="15%">
							</colgroup>
							<thead>
								<tr class="table-light">
									<th class="text-center"><input type="checkbox" id="checkbox-all-toggle" /></th>
									<th>쪽지 유형</th>
									<th>보낸 사람</th>
									<th>받는 사람</th>
									<th>내용</th>
									<th>보낸 날짜</th>
									<th>수신 날짜</th>
								</tr>
							</thead>
							<tbody>
<%
							if (messageList.isEmpty()) {
%>
								<tr>
									<td colspan="6" class="text-center">쪽지가 없습니다.</td>
								</tr>
<%
							}
							for (Message message : messageList) {
								// 수신 메세지의 보낸 사람 조회
								int senderNo = message.getMessageSendEmpNo();
								Employee sender = employeeDao.getEmployeeByNo(senderNo);
								String senderName = sender.getName();
								
								
								// 발신 메세지의 받는 사람 조회
								int messageNo = message.getMessageNo();
								String messageType = message.getMessageType();
								String sendDate = StringUtils.dateToText(message.getMessageSendDate());

								if ("E".equals(messageType)) {
									MessageReceiver messageReceiver = messageDao.getEmpReceiverByMessageNo(messageNo);
									
									int receiverEmpNo = messageReceiver.getEmpNo();
									String receiverEmpName = messageReceiver.getEmpName();
									String receiveDate = StringUtils.dateToText(messageReceiver.getMessageReceiveDate());
%>
								<tr>
									<td class="text-center"><input type="checkbox" name="messageNo" value=<%=messageNo%> /></td>
									<td>개인 쪽지</td>
									<td data-empno="<%=senderNo %>"><%=senderNo == empNo ? "나" : senderName%></td> <!-- 수신 메세지의 보낸 사람 -->
									<td><%=receiverEmpNo == empNo ? "나" : receiverEmpName %></td> <!-- 발신 메세지의 받는 사람 -->
									<td><%=message.getMessageContent()%></td>
									<td><%=sendDate %></td>
									<td><%=receiveDate.isEmpty() ? "미수신" : receiveDate %></td>
								</tr>								
<%
								} else if ("D".equals(messageType)) {
									MessageDepartment messageDepartment = messageDao.getDeptReceiverByMessageNo(messageNo);
									
									int receiverDeptNo = messageDepartment.getDeptNo();
									String receiverDeptName = messageDepartment.getDeptName();
%>
								<tr>
									<td class="text-center"><input type="checkbox" name="messageNo" value=<%=messageNo%> /></td>
									<td>부서 쪽지</td>
									<td data-empno="<%=senderNo%>"><%=senderNo == empNo ? "나" : senderName%></td> <!-- 수신 메세지의 보낸 사람 -->
									<td><%=receiverDeptNo == deptNo ? "내 소속부서" : receiverDeptName%></td> <!-- 발신 메세지의 받는 사람 -->
									<td><%=message.getMessageContent()%></td>
									<td><%=sendDate %></td>
									<td>-</td>
								</tr>								
<%
								}
%>
							</tbody>
<!------------------------------------------------------ 전체 쪽지함 끝 ------------------------------------------------------------>
	
<!------------------------------------------------------ 받은 쪽지함 시작 ---------------------------------------------------------->	
<%
								}
						} else if ("receive".equals(group)) {
	%>
							<colgroup>
								<col width="5%">
								<col width="10%">
								<col width="10%">
								<col width="*">
								<col width="15%">
							</colgroup>
							<thead>
								<tr class="table-light">
									<th class="text-center"><input type="checkbox" id="checkbox-all-toggle" /></th>
									<th>쪽지 유형</th>
									<th>보낸 사람</th>
									<th>내용</th>
									<th>받은 날짜</th>
								</tr>
							</thead>
							<tbody>
<%
							if (messageList.isEmpty()) {
%>
								<tr>
									<td colspan="4" class="text-center">쪽지가 없습니다.</td>
								</tr>
<%
							}
							for (Message message : messageList) {
								int messageNo = message.getMessageNo();
								Employee employee = employeeDao.getEmployeeByNo(message.getMessageSendEmpNo());
								String messageType = message.getMessageType();
%>
									<tr>
										<td class="text-center"><input type="checkbox" name="messageNo" value=<%=messageNo%> /></td>
										<td><%="E".equals(messageType) ? "개인 쪽지" : "부서 쪽지" %></td>
										<td data-empno="<%=message.getMessageSendEmpNo()%>"><%=employee.getName()%></td>
										<td><%=message.getMessageContent()%></td>
										<td><%=StringUtils.dateToText(message.getMessageSendDate())%></td>
									</tr>
							</tbody>
<!------------------------------------------------------ 받은 쪽지함 끝 ---------------------------------------------------------->

<!------------------------------------------------------ 내게 쓴 쪽지함 시작 ------------------------------------------------------->
<%
							}
						} else if ("me".equals(group)) {
%>
							<colgroup>
								<col width="5%">
								<col width="10%">
								<col width="*">
								<col width="15%">
							</colgroup>						
							<thead>
								<tr class="table-light">
									<th class="text-center"><input type="checkbox" id="checkbox-all-toggle" /></th>
									<th>받는 사람(나)</th>
									<th>내용</th>
									<th>보낸 날짜</th>
								</tr>
							</thead>
							<tbody>
<%
							if (messageList.isEmpty()) {
%>
								<tr>
									<td colspan="4" class="text-center">쪽지가 없습니다.</td>
								</tr>
<%
							}
							for (Message message : messageList) {
								int messageNo = message.getMessageNo();
%>
								<tr>
									<td class="text-center"><input type="checkbox" name="messageNo" value=<%=messageNo%> /></td>
									<td data-empno="<%=message.getMessageSendEmpNo()%>">나</td>
									<td><%=message.getMessageContent()%></td>
									<td><%=StringUtils.dateToText(message.getMessageSendDate())%></td>
								</tr>
							</tbody>
<!------------------------------------------------------ 내게 쓴 쪽지함 끝 ------------------------------------------------------->
						
<!------------------------------------------------------ 보낸 쪽지함 시작 ------------------------------------------------------->
<%
							}
						} else if ("send".equals(group)) {
%>
							<colgroup>
								<col width="5%">
								<col width="10%">
								<col width="10%">
								<col width="*">
								<col width="15%">
								<col width="15%">
							</colgroup>							
							<thead>
								<tr class="table-light">
									<th class="text-center"><input type="checkbox" id="checkbox-all-toggle" /></th>						
									<th>쪽지 유형</th>
									<th>받는 사람</th>
									<th>내용</th>
									<th>보낸 날짜</th>
									<th>수신 날짜</th>	
								</tr>
							</thead>
							<tbody>
<%
							if (messageList.isEmpty()) {
%>
								<tr>
									<td colspan="5" class="text-center">쪽지가 없습니다.</td>
								</tr>
<%
							}
							for (Message message : messageList) {
								int messageNo = message.getMessageNo();
								String messageType = message.getMessageType();
								String sendDate = StringUtils.dateToText(message.getMessageSendDate());
								
								if ("E".equals(messageType)) {
									MessageReceiver messageReceiver = messageDao.getEmpReceiverByMessageNo(messageNo);
									String receiveDate = StringUtils.dateToText(messageReceiver.getMessageReceiveDate());
%>
								<tr>
									<td class="text-center"><input type="checkbox" name="messageNo" value=<%=messageNo %> /></td>
									<td>개인 쪽지</td>
									<td data-empno="<%=messageReceiver.getEmpNo() %>"><%=messageReceiver.getEmpName() %></td>
									<td><%=message.getMessageContent() %></td>
									<td><%=sendDate %></td>
									<td><%=receiveDate.isEmpty() ? "미수신" : receiveDate %></td>
								</tr>
<%
								} else if ("D".equals(messageType)) {
									MessageDepartment messageDepartment = messageDao.getDeptReceiverByMessageNo(messageNo);
%>
								<tr>
									<td class="text-center"><input type="checkbox" name="messageNo" value=<%=messageNo %> /></td>
									<td>부서 쪽지</td>
									<td data-empno="<%=messageDepartment.getDeptNo() %>"><%=messageDepartment.getDeptName() %></td>
									<td><%=message.getMessageContent() %></td>
									<td><%=sendDate %></td>
									<td>-</td>
								</tr>
							</tbody>
<%
								}
%>
<!------------------------------------------------------ 보낸 쪽지함 끝 ------------------------------------------------------->
<%
							}
						}
%>
					</table>
<!----------------------------------------------------- 메세지 리스트 끝 ------------------------------------------------------->
				</div>
			</div>
			</form>
<!---------------------------------------------------- 페이지 내비게이션 시작 ---------------------------------------------------->
<%
			if (totalRows >= 1) {
				int beginPage = pagination.getBeginPage();
				int endPage = pagination.getEndPage();
				boolean isFirst = pagination.isFirst();
				boolean isLast = pagination.isLast();
				int prevPage = pagination.getPrevPage();
				int nextPage = pagination.getNextPage();
%>
			<div aria-label="navigation" id="page-navigation">
				<ul class="pagination justify-content-center">
					<li class="page-item">
						<a class="page-link <%=isFirst ? "disabled" : "" %>" 
				 		href="list.jsp?pageNo=<%=prevPage %>"
						onclick="changePage(event, <%=prevPage %>)"> 이전</a>
					</li>
<%
				for (int number = beginPage; number <= endPage; number++) {
%>
					<li class="page-item">
						<a class="page-link <%=currentPage == number ? "active" : "" %>"  
						href="list.jsp?pageNo=<%=number %>" 
						onclick="changePage(event, <%=number %>)"> <%=number %></a>
					</li>
<%
				}
%>
					<li class="page-item">
						<a class="page-link <%=isLast ? "disabled" : "" %>" 
						href="list.jsp?pageNo=<%=nextPage %>"
						onclick="changePage(event, <%=nextPage %>)"> 다음</a>
					</li>
				</ul>
			</div>
<%
			}
%>
<!---------------------------------------------------- 페이지 내비게이션 끝 ---------------------------------------------------->
		</div>
	</div>
</div>
<!--------------------------------------------------- 쪽지 보내기 모달창 시작 --------------------------------------------------->
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
						</div>
					</div>
					<div class="row mb-2">
						<label class="col-sm-2 col-form-label col-form-label-sm">수신자</label>
						<div class="col-sm-8">
							<input type="text" class="form-control form-control-sm" name="name">
						</div>
						<div id="hidden-box-receiver">
						</div>
						<div class="col-sm-2">
							<button type="button" name="address" class="btn btn-secondary btn-xs mt-0" id="btn-open-receiver-modal">선택하기</button>
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
<!--------------------------------------------------- 쪽지 보내기 모달창 끝 --------------------------------------------------->

<!--------------------------------------------------- 수신자 선택 모달창 시작 --------------------------------------------------->
<div class="modal" style="margin-top: 233px; margin-left: -90px;" tabindex="-1" id="modal-employee-list">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">직원 목록</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body " style="height: 200px; overflow-y: scroll;">
				<ul class="list-group" id="list-group-employees" >
<%
					List<Employee> empList = messageDao.getEmpList();
				
					for (Employee employee : empList) {
%>
					<li class="list-group-item" id="">
						<input class="form-check-input me-1" type="checkbox" name="empNo" value="<%=employee.getNo() %>" data-empname="<%=employee.getName() %>">
						<label class="form-check-label small"><%=employee.getName() %></label>
					</li>
<%		
					}
%>
				</ul>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary btn-xs" data-bs-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-secondary btn-xs" data-bs-dismiss="modal" id="btn-select-emp">선택하기</button>
			</div>
		</div>
	</div>
</div>
<div class="modal" style="margin-top: 233px; margin-left: -90px;"  tabindex="-1" id="modal-dept-list">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">부서 목록</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body " style="height: 200px; overflow-y: scroll;">
				<ul class="list-group" id="list-group-depts" >
<%
					List<Department> deptList = messageDao.getDeptList();
				
					for (Department department : deptList) {
%>
					<li class="list-group-item">
						<input class="form-check-input me-1" type="checkbox" name="deptNo" value="<%=department.getNo() %>" >
						<label class="form-check-label small"><%=department.getName() %></label>
					</li>
<%		
					}
%>
				</ul>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary btn-xs" data-bs-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-secondary btn-xs" data-bs-dismiss="modal" id="btn-select-dept">선택하기</button>
			</div>
		</div>
	</div>
</div>
<!--------------------------------------------------- 수신자 선택 모달창 끝 --------------------------------------------------->

<!--------------------------------------------------- 쪽지 전체삭제 모달창 시작 --------------------------------------------------->
<div class="modal" tabindex="-1" id="modal-form-clear">
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">쪽지 전체삭제</h5>
			</div>
			<div class="modal-body">
				<div class="alert alert-danger" role="alert">
  					<strong>현재 보관함의 모든 쪽지가 삭제됩니다. 삭제하시겠습니까?</strong>
				</div>
			<div class="modal-footer">	
				<button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">닫기</button>
				<a href="clearMessage.jsp?group=<%=group %>" type="button" class="btn btn-danger btn-sm">삭제</a>
			</div>	
			</div>	
		</div>
	</div>
</div>
<!--------------------------------------------------- 쪽지 전체삭제 모달창 끝 --------------------------------------------------->

<!------------------------------------------------------ 쪽지 상세보기 모달창 시작 ------------------------------------------------------>


<!------------------------------------------------------ 쪽지 상세보기 모달창 끝 ------------------------------------------------------>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
	
	var checkedCheckboxList = $("#modal-employee-list [nmae=empNo]:checked");
	var checkedCheckboxLength = checkedCheckboxList.length;
	
	
	$("#btn-select-emp").click(function() {
		console.log(checkedCheckboxList)
		console.log(checkedCheckboxLength)
		
		for (var index = 0; index < checkedCheckboxLength; index++) {
			var checkedCheckbox = checkedCheckboxList[index];
			
			var empNo = $(checkedCheckbox).val();
			var empName = $(checkedCheckbox).attr("data-empname");
			
			var html = `<input type="hidden" name="empNo" value="${empNo}" >`
			$("#hidden-box-receiver").append(html);
			
			$("#modal-form-message [name=name]").val($("#modal-form-message [name=name]").val() + ", " + empName);
		}
	})
	
	
	
	
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
	
	// 함수 정의 	
	function checkedMe() {
		$(":input[name=sentBox]").prop("checked", false)
		$("#send-me-comment1").hide()
		$("#send-me-comment2").show()
		
		$(":radio[name=type]").prop("disabled", true)
		$(":radio[name=type][value=E]").prop("checked", true);
		
		$(":input[name=receiver]").prop("disabled", true)
		$(":input[name=receiver]").val(1000)	// 사용자 이름(사용자 직원번호)
		
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
	function submitForm(page) {
		$("#search-form :input[name=pageNo]").val(page)
		
		$("#search-form").submit();
		
	}
	
	function changePage(event, page) {
		event.preventDefault();
		
		submitForm(page);
	}
	
	var checkboxAll = document.querySelector('#checkbox-all-toggle');								// 전체선택 체크박스
	var checkboxList = document.querySelectorAll('#select-form [name="messageNo"]');				// 개별선택 체크박스 리스트
	var checkedCheckboxList = document.querySelectorAll('#select-form [name="messageNo"]:checked');	// 체크된 개별선택 체크박스 리스트
	var checkboxLength = checkboxList.length;														// 개별선택 체크박수 개수
	var checkedCheckboxLength = checkedCheckboxList.length;											// 체크된 개별선택 체크박스 개수
	
	// 전체선택 체크박스 이벤트 바인딩
	checkboxAll.addEventListener("change", function() {
		var currentChecked = checkboxAll.checked;
		
		for (var index = 0; index < checkboxLength; index++) {
			var checkbox = checkboxList[index];
			checkbox.checked = currentChecked;
		}
	})
	
	// 개별선택 체크박스 이벤트 바인딩
	for (var index = 0; index < checkboxLength; index++) {
		var checkbox = checkboxList[index];
		
		checkbox.addEventListener("change", function() {
			if (checkboxLength == checkedCheckboxLength) {
				checkboxAll.checked = true;
			} else {
				checkboxAll.checked = false;
			}
		})
	}
	
	// ###### 질문 ########## 변수 cnt가 이벤트 리스너 바깥에서 선언되면 왜 적용이 안되는지?? ############################################
	// ###### 질문 ########## event.preventDefault는 이벤트 실행을 정상적으로 막는데 return false는 왜 그렇지 않은지? ###################
	// 삭제, 보관, 스팸, 답장 버튼 유효성 검사
	var selectForm = document.querySelector('#select-form');
	
	selectForm.addEventListener("submit", function(event) {
		var cnt = document.querySelectorAll('#select-form [name="messageNo"]:checked').length;
		
		if (cnt == 0) {
			event.preventDefault();
			alert("한 개 이상 선택하세요.")
		}
	})
	// ###### 질문 ########## 변수 cnt가 이벤트 리스너 바깥에서 선언되면 왜 적용이 안되는지?? ############################################
	// ###### 질문 ########## event.preventDefault는 이벤트 실행을 정상적으로 막는데 return false는 왜 그렇지 않은지? ###################
	
	var clearFormModal = new bootstrap.Modal("#modal-form-clear");
	var clearButton = document.querySelector("#clear-btn");
	
	clearButton.addEventListener("click", function() {
		clearFormModal.show();
	})
	
	
	// 메세지 보내기 모달에서 수신자 목록 선택
	var employeeListModal = new bootstrap.Modal("#modal-employee-list");
	var deptListModal = new bootstrap.Modal("#modal-dept-list");
	
	var btnOpenReceiverModal = document.querySelector("#btn-open-receiver-modal");
	
	btnOpenReceiverModal.addEventListener("click", function() {
		var checkedMessageType = document.querySelector("#message-form [name=type]:checked").value;
		
		if (checkedMessageType == "E") {
			employeeListModal.show();
		} else if (checkedMessageType == "D") {
			deptListModal.show();
		}
	});
	
	// 직원 리스트에서 체크된 값 메세지 보내기 모달폼으로 전달하기
	/*
	var checkedCheckboxList = document.querySelectorAll("#list-group-item [name=empNo]:checked");
	var checkedCheckboxLength = checkedCheckboxList.length;
	var hiddenBoxReceiver = document.querySelector("#hidden-box-receiver");
	
	var btnSelectEmp = document.querySelector("#btn-select-emp");
	btnSelectEmp.addEventListener("click", function() {
		
		for (var index = 0; index < checkedCheckboxLength; index++) {
			var checkedCheckbox = checkedCheckboxList[index];
			
			var empNo = checkedCheckbox.value;
			var empName = checkedCheckbox.attr("data-empname");
			
			var html = `<input type="hidden" name="empNo" value="${empNo}" >`
			hiddenBoxReceiver.insertAdjacentHTML(beforeend, html);
			
			var name = document.querySelector("#modal-form-message [name=name]").value
			document.querySelector("#modal-form-message [name=name]").value = name + ", " + empName;
		}
	})
	*/
	
	
	/*
	<input type="hidden" name="empNo" value="1000">
	<input type="hidden" name="deptNo" value="100">
	.insertAdjacentHTML()
	*/
	
	

	
</script>
</body>
</html>