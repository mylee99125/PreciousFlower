<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Precious Flower - Login</title>

<link rel="apple-touch-icon" href="assets/img/apple-icon.png">
<link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.ico">

<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<link rel="stylesheet" href="./resources/css/templatemo.css">
<link rel="stylesheet" href="./resources/css/custom.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
});
</script>
<style type="text/css">
.locontent {
	width: 80%;
	display: flex;
	text-align: center;
	padding-top: 100px;
	padding-bottom: 200px;
	padding-left: 400px;
}
.lform {
	width: 40%;
	flex: 1;
	box-sizing: border-box;
}
.rlform {
	width: 40%;
	flex: 1;
	box-sizing: border-box;
}
.lobtn {
	width: 150px;
	height: 30px;
	background-color: #B4F0B4;
	border: none;
	border-radius: 5px;
}
</style>
</head>
<body>
	<header>
	<jsp:include page="header.jsp"/>
	</header>

  	<div class="locontent">
		<form class="lform" action="./mloginProc" method="post">
			<h3 class="login-header">회원 로그인</h3><br>
			ID : &nbsp;&nbsp;<input type="text" class="login-input" name="m_id" autofocus required placeholder="아이디"><br><br>
			PW : <input type="password" class="login-input" name="m_pwd" placeholder="비밀번호" required><br><br>
			<input type="submit" class="lobtn" value="로그인">
		</form>
		<form class="rlform" action="./rloginProc" method="post">
			<h3 class="login-header">라이더 로그인</h3><br>
			ID : &nbsp;&nbsp;<input type="text" class="login-input" name="r_id" autofocus required placeholder="아이디"><br><br>
			PW : <input type="password" class="login-input" name="r_pwd" placeholder="비밀번호" required><br><br>
			<input type="submit" class="lobtn" value="로그인">
		</form>
 	</div>
	
	<footer>
	<jsp:include page="footer.jsp"/>
	</footer>

	<!-- Start Script -->
	<script src="./resources/js/jquery-1.11.0.min.js"></script>
	<script src="./resources/js/jquery-migrate-1.2.1.min.js"></script>
	<script src="./resources/js/bootstrap.bundle.min.js"></script>
	<script src="./resources/js/templatemo.js"></script>
	<script src="./resources/js/custom.js"></script>
	<!-- End Script -->
	
</body>
</html>