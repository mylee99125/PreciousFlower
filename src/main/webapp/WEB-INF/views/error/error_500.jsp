<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERROR_500</title>
<style type="text/css">
.content {
	border: 10px solid;
	border-color: #a7d2eb;
	margin-top: 10%;
	margin-left: 15%;
	text-align: left;
	width: 70%;
	height: 500px;
}

.content .top, .middle {
	padding-left: 20%;
}

.img {
	position: absolute;
	top: 32%;
	left: 60%;
}

#plant {
	width: 300px;
	height: 300px;
}

#title{
	font-size: 40px;
	font-weight: bold;
	margin-top: 9%;
	margin-bottom: 0px;
	color: #1f1f1f;
}

#sub_title {
	margin-top: 0px;
	color: #f05959;
}

#p1 {
	margin-top: 50px;
	margin-bottom: 5px;
}

#p2 {
	margin-top: 0px;
	margin-bottom: 50px;
}

.middle h3 {
	margin-bottom: 50px;
}

#back, #home {
	width: 120px;
	height: 40px;
	background-color: #a7d2eb;
	border: none;
	outline: none;
	border-radius: 3px;
	transition: background 0.3s ease-in-out;
	cursor: pointer;
}
#back:hover, #home:hover {
	background-color: #6bbded;
	color: #fff;
}
</style>
</head>
<body>
	<div class="content">
		<div class="top">
			<p id="title">500 Internal Server Error</p>
			<h1 id="sub_title">페이지가 작동하지 않습니다.</h1>
		</div>
		
		<div class="img">
			<img src="/resources/images/500.png" id="plant">
		</div>
		
		<div class="middle">
			<p id="p1">요청하신 서비스를 처리할 수 없습니다.</p>
			<p id="p2">관리자에게 문의하거나 잠시 후 다시 시도해주세요.</p>
			<input type="button" id="back" value="이전페이지로" onclick="history.go(-1)">
			<input type="button" id="home" value="메인페이지로" onclick="location.href='./'">
		</div>
	</div>
</body>
</html>