<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Login</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="./resources/css/adminStyle.css">
<style type="text/css">
fieldset {
	width: 50%;
	margin: 0 auto;
	text-align: center;
}
h2 {
	text-align: center;
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
	<div id="content">
	<br><h2>Admin Login</h2><br>
	<fieldset>
	<form action="./loginProc" method="post">
		<table>
			<tr><th>ID: </th><td><input type="text" name="a_id" placeholder="id" 
				autofocus required></td></tr>
			<tr><th>PW: </th><td><input type="password" name="a_pwd" placeholder="password" required></td></tr>
		</table><br>
			<input type="submit" class="btn2" value="LOGIN">
			<input type="reset" class="btn2" value="RESET">
	</form>
	</fieldset>
	</div>
</body>
</html>