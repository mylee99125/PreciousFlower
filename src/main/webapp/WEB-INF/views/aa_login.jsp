<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Login</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style type="text/css">
* {
	box-sizing: border-box;
	font-family: 'GowunDodum-Regular';
	margin: 0 auto;
	padding: 0 auto;
}
@font-face {
    font-family: 'GowunDodum-Regular';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2108@1.1/GowunDodum-Regular.woff') format('woff');
    font-weight: bold;
    font-style: normal;
}
body {
	background: linear-gradient(rgba(0, 0, 0, 0.1), rgba(0, 0, 0, 0.1)),url("/resources/images/backimg.jpg");
}
h2 {
	text-align: center;
	margin-bottom: 10px;
	color: white;
}
#aid, #apw {
	width: 300px;
	height: 50px;
	border-radius: 50px;
	border: none;
	margin: 5px;
	font-size: 15px;
}
.loginbtn {
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
.loginbtn:hover {
	background-color: #bebebe;
}
#aalofrm {
	text-align: center;
}
#logindiv {
	background-image: linear-gradient(to top, #09203f 0%, #537895 100%);
	opacity: 0.8;
	width: 500px;
	height: 300px;
	border-radius: 10px;
	padding-top: 35px;
	margin-top: 80px;
}
</style>
<script type="text/javascript">
$(function(){
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
});
</script>
</head>
<body>
	<div id="logindiv">
	<h2>ADMIN LOGIN</h2>
	<form action="./loginProc" id="aalofrm" method="post">
		<table>
			<tr>
				<td>
					<img src="resources/images/user.png" style="width:25px;vertical-align:middle;">
					<input type="text" id="aid" name="a_id" placeholder="   ID" autofocus required>
				</td>
			</tr>
			<tr>
				<td>
					<img src="resources/images/lock.png" style="width:25px;vertical-align:middle;">
					<input type="password" id="apw" name="a_pwd" placeholder="   PASSWORD" required>
				</td>
			</tr>
		</table>
		<input type="submit" class="loginbtn" value="LOGIN">
	</form>
	</div>
</body>
</html>