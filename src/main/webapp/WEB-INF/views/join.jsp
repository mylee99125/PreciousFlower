<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Precious Flower - Join</title>

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
var element = $('#square');

//when mouseover execute the animation
element.mouseover(function(){
// the animation starts
element.toggleClass('tada animated');
// do something when animation ends
element.one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(e){
// trick to execute the animation again
 $(e.target).removeClass('tada animated');
});

});
</script>
<style type="text/css">
.locontent {
	width: 80%;
	height: 500px;
	text-align: center;
	padding-top: 80px;
	padding-bottom: 500px;
	padding-left: 400px;
	display: inline-block;
}
#jbtn {
	width: 40%;
	height: 300px;
	background-image: linear-gradient(to top, #96fbc4 0%, #f9f586 100%);
	border: none;
	border-radius: 5px;
	box-sizing: border-box;
	margin: 20px;
}
/*base code*/
.animated {
  -webkit-animation-duration: 1s;
  animation-duration: 1s;
  -webkit-animation-fill-mode: both;
  animation-fill-mode: both;
}
.animated.infinite {
  -webkit-animation-iteration-count: infinite;
  animation-iteration-count: infinite;
}
.animated.hinge {
  -webkit-animation-duration: 2s;
  animation-duration: 2s;
}
/*the animation definition*/
@-webkit-keyframes tada {
  0% {
    -webkit-transform: scale3d(1, 1, 1);
    transform: scale3d(1, 1, 1)
  }
  10%,
  20% {
    -webkit-transform: scale3d(.9, .9, .9) rotate3d(0, 0, 1, -3deg);
    transform: scale3d(.9, .9, .9) rotate3d(0, 0, 1, -3deg)
  }
  30%,
  50%,
  70%,
  90% {
    -webkit-transform: scale3d(1.1, 1.1, 1.1) rotate3d(0, 0, 1, 3deg);
    transform: scale3d(1.1, 1.1, 1.1) rotate3d(0, 0, 1, 3deg)
  }
  40%,
  60%,
  80% {
    -webkit-transform: scale3d(1.1, 1.1, 1.1) rotate3d(0, 0, 1, -3deg);
    transform: scale3d(1.1, 1.1, 1.1) rotate3d(0, 0, 1, -3deg)
  }
  100% {
    -webkit-transform: scale3d(1, 1, 1);
    transform: scale3d(1, 1, 1)
  }
}
@keyframes tada {
  0% {
    -webkit-transform: scale3d(1, 1, 1);
    -ms-transform: scale3d(1, 1, 1);
    transform: scale3d(1, 1, 1)
  }
  10%,
  20% {
    -webkit-transform: scale3d(.9, .9, .9) rotate3d(0, 0, 1, -3deg);
    -ms-transform: scale3d(.9, .9, .9) rotate3d(0, 0, 1, -3deg);
    transform: scale3d(.9, .9, .9) rotate3d(0, 0, 1, -3deg)
  }
  30%,
  50%,
  70%,
  90% {
    -webkit-transform: scale3d(1.1, 1.1, 1.1) rotate3d(0, 0, 1, 3deg);
    -ms-transform: scale3d(1.1, 1.1, 1.1) rotate3d(0, 0, 1, 3deg);
    transform: scale3d(1.1, 1.1, 1.1) rotate3d(0, 0, 1, 3deg)
  }
  40%,
  60%,
  80% {
    -webkit-transform: scale3d(1.1, 1.1, 1.1) rotate3d(0, 0, 1, -3deg);
    -ms-transform: scale3d(1.1, 1.1, 1.1) rotate3d(0, 0, 1, -3deg);
    transform: scale3d(1.1, 1.1, 1.1) rotate3d(0, 0, 1, -3deg)
  }
  100% {
    -webkit-transform: scale3d(1, 1, 1);
    -ms-transform: scale3d(1, 1, 1);
    transform: scale3d(1, 1, 1)
  }
}
.tada {
  -webkit-animation-name: tada;
  animation-name: tada
}
</style>
</head>
<body>
	<header>
	<jsp:include page="header.jsp"/>
	</header>

  	<div class="locontent">
  	<h5>Welcome to Precious Flower</h5>
  	<h4>회원가입 후 다양한 혜택을 누려보세요!</h4>
  	<div>
  		<button type="button" id="jbtn"  class="tada animated" onclick="location.href='./m_joinFrm'">
  			<img src="resources/images/member.png" style="width:110px;"><br><br><h3>MEMBER  JOIN</h3></button>
  		<button type="button" id="jbtn" class="tada animated"  onclick="location.href='./r_joinFrm'">
  			<img src="resources/images/rider.png" style="width:110px;"><br><br><h3>RIDER  JOIN</h3></button>
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