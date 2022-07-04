<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>라이더 회원탈퇴</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="resources/css/riderStyle.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
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
	<jsp:include page="r_header.jsp"/>
	</header>
	
	<div class="tab_wrap tab_area">
		<div class="btn_area clearfix">
			<button class="btn btn_tab" onclick="location.href='./r_main'">배송관리</button>
			<button class="btn btn_tab" onclick="location.href='./r_dList'">배송이력</button>
			<button class="btn btn_tab" onclick="location.href='./r_myPage'">마이페이지</button>
			<button class="btn btn_tab act" onclick="location.href='./r_delete'">회원탈퇴</button>
		</div>
		
		<div class="content_area">
			<h2>회원 탈퇴</h2>
			<div class="table_area">
				<form class="validation-form" name="r_delete" action="./rdelete" method="post" novalidate>
					<table id="rm_del">
						<tr>
							<td id="category">아이디</td>
							<td>
								<input type="text" id="r_id" name="r_id"  value="${rb.r_id}" readonly> 
								<div class="invalid-feedback">아이디를 입력해주세요.</div>
							</td>
						</tr>
						<tr>
							<td id="category">비밀번호</td>
							<td>
								<input type="password" id="rpassword" name="r_pwd" required>
								<div class="invalid-feedback">비밀번호를 입력해주세요.</div>
							</td>
						</tr>
					</table>
					<input id="pisert" type="submit" class="btn2" value="탈퇴"> 
				</form>
			</div>
		</div>
	</div>
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