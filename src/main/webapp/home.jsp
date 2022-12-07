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
<jsp:include page="common/header.jsp">
	<jsp:param name="menu" value="home"/>
</jsp:include>
<div class="container my-3">
	<div class="row">
		<div class="col-9">
			<div class="row mb-3">
				<div class="col">
					<div class="border p-3 bg-light">
						<h1 class="mb-4">사내 메세지  애플리케이션</h1>
						<p class="mb-1">구성원이 사용할 수 있는 다양한 편의 기능을 제공합니다.</p>
						<p class="mb-1">주소록관리, 메세지 관리, 노트 관리 기능을 사용해서 업무의 효율성을 향상시켜보세요</p>
						<p class="">모든 서비스는 로그인 후 이용가능합니다.</p>
		            </div>
		        </div>
		    </div>
		</div>
		<div class="col-3">
			<jsp:include page="common/loginform.jsp" />
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
</html>