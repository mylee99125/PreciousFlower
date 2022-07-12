<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Precious Flower - Login</title>

<link rel="apple-touch-icon" href="assets/img/apple-icon.png">
<link rel="shortcut icon" type="image/x-icon"
	href="resources/images/favicon.png">

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
	background: linear-gradient(rgba(0, 0, 0, 0.1), rgba(0, 0, 0, 0.1)),url("/resources/images/backimg.jpg");
	width: 100%;
	height: 800px;
	display: flex;
	text-align: center;
	padding-top: 150px;
	padding-bottom: 200px;
	padding-left: 100px;
}
.lform {
	margin-left: 300px;
	padding-top: 20px;
	flex: 1;
	box-sizing: border-box;
	background-color: #dcdcdc;
	opacity: 0.8;
	width: 150px;
	height: 320px;
	border-radius: 10px;
	margin-right: 50px;
}
.rlform {
	margin-right: 330px;
	padding-top: 20px;
	flex: 1;
	box-sizing: border-box;
	background-color: #dcdcdc;
	opacity: 0.8;
	width: 150px;
	height: 320px;
	border-radius: 10px;
}
.lobtn {
	width: 150px;
	height: 40px;
	text-align: center;
	border-radius: 50px;
	border: none;
	background-color: lightgray;
	font-size: 18px;
	margin-top: 10px;
	cursor: pointer;
}
.lobtn:hover {
	background-color: #bebebe;
}
#aid, #apw {
	width: 250px;
	height: 50px;
	border-radius: 50px;
	border: none;
	margin: 5px;
	font-size: 15px;
}
#loh3 {
	margin-bottom: 20px;
	margin-top: 5px;
}
</style>
</head>
<body>
	<header>
	<jsp:include page="header.jsp"/>
	</header>

  	<div class="locontent">
		<form class="lform" action="./mloginProc" method="post">
			<img src="resources/images/member.png" style="width:50px;vertical-align:middle;">
			<h3 id="loh3" class="login-header">회원 로그인</h3>
			<img src="resources/images/user.png" style="width:25px;vertical-align:middle;">
			&nbsp;<input type="text" class="login-input" id="aid" name="m_id" autofocus required placeholder="  아이디"><br>
			<img src="resources/images/lock.png" style="width:25px;vertical-align:middle;">
			<input type="password" class="login-input" id="apw" name="m_pwd" placeholder="  비밀번호" required><br>
			<input type="submit" class="lobtn" value="로그인">
		</form>
		<form class="rlform" action="./rloginProc" method="post">
			<img src="resources/images/rider.png" style="width:50px;vertical-align:middle;">
			<h3 id="loh3" class="login-header">라이더 로그인</h3>
			<img src="resources/images/user.png" style="width:25px;vertical-align:middle;">
			&nbsp;<input type="text" class="login-input" id="aid" name="r_id" autofocus required placeholder="  아이디"><br>
			<img src="resources/images/lock.png" style="width:25px;vertical-align:middle;">
			<input type="password" class="login-input" id="apw" name="r_pwd" placeholder="  비밀번호" required><br>
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