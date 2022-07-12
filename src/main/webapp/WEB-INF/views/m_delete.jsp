<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Precious Flower - Member Delete</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="resources/css/riderStyle.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link rel="shortcut icon" type="image/x-icon"
	href="resources/images/favicon.png">
</head>
<script type="text/javascript">
$(function(){
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
});
</script>
<style>
.content_area {
	text-align: center;
}

.content_area>h2 {
	margin-top: 40px;
	margin-bottom: 40px;
}

.table_area {
	width: 800px;
	height: 240px;
	margin: auto;
	background-color: #fafafa;
	padding-top: 10px;
	padding-bottom: 10px;
	border: 2px solid;
	border-color: #e6e6e6;
	border-radius: 5px;
	margin-bottom: 40px;
}

#rm_del {
	border-collapse: separate;
	border-spacing: 0 10px;
	margin-top: 40px;
}

#rm_del td {
	text-align: left;
}

#rm_del input {
	width: 200px;
	height: 33px;
	padding-left: 10px;
}

#category {
	text-align: right;
	padding-right: 20px;
}

.btn2 {
	width: 100px;
	height: 33px;
	border: none;
	border-radius: 3px;
	outline: none;
	margin-top: 20px;
}

.btn2:hover {
	background-color: #d9f9dc;
}

footer {
	margin-top: 60px;
}
</style>
<body>
	<header>
	<jsp:include page="header.jsp"/>
	</header>
	
		
		<div class="content_area">
			<h2>회원 탈퇴</h2>
			<div class="table_area">
				<form class="validation-form" name="m_delete" action="./mdelete" method="post" novalidate>
					<table id="rm_del">
						<tr>
							<td id="category">아이디</td>
							<td>
								<input type="text" id="m_id" name="m_id"  value="${mb.m_id}" readonly> 
								<div class="invalid-feedback">아이디를 입력해주세요.</div>
							</td>
						</tr>
						<tr>
							<td id="category">비밀번호</td>
							<td>
								<input type="password" id="mpassword" name="m_pwd" required>
								<div class="invalid-feedback">비밀번호를 입력해주세요.</div>
							</td>
						</tr>
					</table>
					<input id="pisert" type="submit" class="btn2" value="탈퇴"> 
				</form>
			</div>
		</div>
	</div>
	
	<footer>
		<jsp:include page="footer.jsp"/>
	</footer>
</body>
<script>
<!-- 유효성 검사  -->
    window.addEventListener('load', () => {
      const forms = document.getElementsByClassName('validation-form');

      Array.prototype.filter.call(forms, (form) => {
        form.addEventListener('submit', function (event) {
          if (form.checkValidity() === false) {
            event.preventDefault();
            event.stopPropagation();
          }

          form.classList.add('was-validated');
        }, false);
      });
    }, false);
<!-- 유효성 검사  END-->
</script>
</html>