<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 작성</title>
<link rel="stylesheet" href="resources/css/adminStyle.css">
<style type="text/css">
table {
	border: 2px solid;
	border-left: none;
	border-right: none;
	border-color: #6e6e6e;
	border-collapse: collapse;
	width: 100%;
}

th {
	height: 50px;
	background-color: #d2d2d2;
	border-bottom: 2px solid;
	border-bottom-color: #6e6e6e;
}

tr {
	text-align: center;
	border-bottom: 1px solid;
	border-bottom-color: #d2d2d2;
}

#title {
	width: 200px;
	height: 50px;
	border-right: 1px solid;
	border-right-color: #d2d2d2;
}

#id {
	height: 50px;
	border-right: 1px solid;
	border-right-color: #d2d2d2;
}

#contents {
	height: 400px;
	border-right: 1px solid;
	border-right-color: #d2d2d2;
}

#t-data {
	height: 40px;
	width: 1125px;
	border: none;
	outline: none;
}

#i-data {
	height: 40px;
	width: 1125px;
}

#c-data {
	height: 350px;
	width: 1125px;
	border: none;
	text-align: left;
	vertical-align: top;
	outline: none;
}

.anbtn1 {
	float: right;
	margin: 10px;
	margin-top: 5px;
	width: 50px;
	height: 30px;
	border: none;
	outline: none;
	border-radius: 3px;
}

.anbtn1:hover {
	background-color: #6e6e6e;
	color: white;
}
</style>
</head>
<body>
	<header>
		<jsp:include page="aa_aheader.jsp"/>
	</header>
	<div class="tab_wrap tab_area">
		<div class="btn_area clearfix">
			<button class="btn btn_tab" onclick="location.href='./aa_main'">Home</button>
			<button class="btn btn_tab" onclick="location.href='./aa_mlist'">회원관리</button>
			<button class="btn btn_tab" onclick="location.href='./aa_olist'">주문관리</button>
			<button class="btn btn_tab" onclick="location.href='./aa_plist'">상품관리</button>
			<button class="btn btn_tab act" onclick="location.href='./aa_notice'">게시글관리</button>
		</div>
		<div class="content_area">
			<form action="./noticeInsert" class="write-form" method="post">
				<table>
		 			<th colspan="2">공지사항 작성</th>
		 			<tr>
		 				<td id="title">제목</td>
		 				<td><input type="text" id="t-data" name="n_title" autofocus="autofocus" placeholder="제목을 적어주세요."></td>
			 		</tr>
			 		<tr>
			 			<td id="id">아이디</td>
						<td><input type="text" id="t-data" name="n_aid" value="admin" readonly></td>
			 		</tr>
		 			<tr>
		 				<td id="contents">내용</td>
		 				<td><textarea style= "resize: none;" name="n_contents" id="c-data" placeholder="내용을 적어주세요."></textarea></td>
		 			</tr>
				</table>
				<input type="button" class="anbtn1" onclick="location.href='aa_notice'" value="취소">
				<input type="submit" class="anbtn1" value="작성">
			</form>
		</div>
	</div>
</body>
</html>