<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Precious Flower - Join</title>

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
	height: 500px;
	text-align: center;
	padding-top: 100px;
	padding-bottom: 250px;
	padding-left: 400px;
	display: inline-block;
}
.jbtn {
	width: 40%;
	height: 300px;
	background-color: #B4F0B4;
	border: none;
	border-radius: 5px;
	box-sizing: border-box;
}
</style>
</head>
<body>
	<header>
	<jsp:include page="header.jsp"/>
	</header>

  	<div class="locontent">
  	<div>
  		<button type="button" class="jbtn" onclick="location.href='./m_joinFrm'">
  			<img src="resources/images/member.png" style="width:150px;"><br><br><h3>MEMBER  JOIN</h3></button>
  		<button type="button" class="jbtn" onclick="location.href='./r_joinFrm'">
  			<img src="resources/images/rider.png" style="width:150px;"><br><br><h3>RIDER  JOIN</h3></button>
  	</div>
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