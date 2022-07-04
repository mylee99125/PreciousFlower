<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 수정</title>
<link rel="stylesheet" href="resources/css/adminStyle.css">
<script type="text/javascript">
$(function(){
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
});
</script>
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
	height: 30px;
	background-color: #d2d2d2;
	border-bottom: 2px solid;
	border-bottom-color: #6e6e6e;
}

tr {
	text-align: center;
	border-bottom: 1px solid;
	border-bottom-color: #d2d2d2;
}

#number {
	border-right: 1px solid;
	border-right-color: #d2d2d2;
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
	height: 450px;
	border-right: 1px solid;
	border-right-color: #d2d2d2;
}

#n-data {
	height: 40px;
	width: 1125px;
	border: none;
	outline: none;
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
	border: none;
	outline: none;
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
	margin-top: 15px;
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
			<form action="/noticeUpdate" class="update-form" method="Post">
				<table>
		 			<th colspan="2">공지사항 수정</th>
		 				<input type="hidden" id="n-data" name="n_num" value="${notice.n_num}">
						<input type="hidden" id="i-data" name="n_aid" value="admin">
		 			<tr>
		 				<td id="title">제목</td>
		 				<td><input type="text" id="t-data" name="n_title" autofocus="autofocus" value="${notice.n_title}"></td>
		 			</tr>
		 			<tr>
		 				<td id="contents">내용</td>
		 				<td><textarea style= "resize: none;" name="n_contents" id="c-data">${notice.n_contents}</textarea></td>
		 			</tr>
				 </table>
				 <input class="anbtn1" type="button" onclick="location.href='./nlist?npageNum=1'" value="취소">
				 <input class="anbtn1" type="submit" value="작성">
			</form>
		</div>
	</div>
</body>
</html>