<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Precious Flower - Order Success</title>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script type="text/javascript" src="./resources/js/jquery-sakura.js"></script>
<link rel="apple-touch-icon" href="assets/img/apple-icon.png">
<link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.ico">
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<link rel="stylesheet" href="./resources/css/templatemo.css">
<link rel="stylesheet" href="./resources/css/custom.css">
<link rel="stylesheet" href="./resources/css/jquery-sakura.css">
<style type="text/css">
.oscontent {
	width: 80%;
	text-align: center;
	padding-top: 100px;
	padding-bottom: 300px;
	padding-left: 400px;
}
.sucform {
	padding-top: 10px;
}
</style>
<script>
var $js = jQuery.noConflict();

$js(window).load(function () {
    $js('body').sakura();
});
</script>
</head>
<body>
	<header>
	<jsp:include page="header.jsp"/>
	</header>
  	<div class="oscontent">
		<h2>Order Success!</h2><br>
			<div class="sucform">
				감사합니다. 고객님의 주문이 정상적으로 완료되었습니다!
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