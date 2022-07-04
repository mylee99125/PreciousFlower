<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>라이더 목록</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="resources/css/adminStyle.css">
<script type="text/javascript">
$(function(){
	//메세지 출력
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
	
	//검색
	$("#rmsearch").click(function(){
		var rmkeyword = $("#rmkeyword").val();
		if(rmkeyword == ""){
			alert("검색할 내용을 입력해주세요.");
			return;
		}
		
		var select = $("#rmsel").val();
		console.log(select, rmkeyword);
		location.href="./rmlist?rmcolname=" + select
				+ "&rmkeyword=" + rmkeyword
				+ "&rmpageNum=1";
	});
});
</script>
<style type="text/css">
table {
	border: 2px solid;
	border-left: none;
	border-right: none;
	border-color: #6e6e6e;
	border-collapse: collapse;
}

th {
	width: 1%;
	background-color: #d2d2d2;
	border-bottom: 2px solid;
	border-bottom-color: #6e6e6e;
}

tr {
	text-align:center;
	border-bottom: 1px solid;
	border-bottom-color: #d2d2d2;
}

th, td {
	padding: 8px;
}

.rmbtn {
	background-color: #d2d2d2;
	border: none;
	border-radius: 3px;
	width: 100px;
	height: 38px;
	cursor: pointer;
}

.rmbtn:hover {
	background-color: #6e6e6e;
	color: white;
}

.search-area {
	margin-left: 10px;
	margin-top: 15px;	
}

#rmsel, #rmkeyword, #rmsearch {
	height: 30px;
}

#rmsearch {
	width: 50px;
	border: none;
	outline: none;
	border-radius: 3px;
}

#rmsearch:hover {
	background-color: #6e6e6e;
	color: white;
}

.paging {
	text-align: center;
}

.side_menu {
	margin-bottom: 10px;
	margin-left: 10px;
}

#smbtn1 {
	width: 80px;
	height: 30px;
	border: none;
	border-radius: 3px;
	cursor: pointer;
}

#smbtn1:hover {
	background-color: #6e6e6e;
	color: white;
}

#smbtn2 {
	width: 80px;
	height: 30px;
	border: none;
	border-radius: 3px;
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
			<button class="btn btn_tab act" onclick="location.href='./aa_mlist'">회원관리</button>
			<button class="btn btn_tab" onclick="location.href='./aa_olist'">주문관리</button>
			<button class="btn btn_tab" onclick="location.href='./aa_plist'">상품관리</button>
			<button class="btn btn_tab" onclick="location.href='./aa_notice'">게시글관리</button>
		</div>
		
			
		<div class="content_area">
			<h3>[회원 목록]</h3><br>
			<div class="side_menu">
				<div class="search-area">
					<select id="rmsel">
						<option value="r_id" selected>아이디</option>
						<option value="r_name">이름</option>
						<option value="g_name">등급</option>
					</select>
						<input type="text" id="rmkeyword" placeholder="Search">
						<button id="rmsearch">검색</button>
				</div>
				<button id="smbtn1" type="button" onclick="location.href='./aa_mlist'">일반 회원</button>
				<button id="smbtn2" type="button" onclick="location.href='./aa_rmlist'">라이더 회원</button>
			</div>
			<table id="plist" width="100%">
				<tr id="ltr">
					<th id="lth">아이디</th>
					<th id="lth">이름</th>
					<th id="lth">등급</th>
					<th id="lth">회원관리</th>
				</tr>
				<c:if test="${empty rmList}">
					<tr id="ltr">
						<td colspan="4">
							<label style="width: 100%">가입된 회원이 없습니다.</label>
						</td>
					</tr>
				</c:if>
				<c:if test="${!empty rmList}">
					<c:forEach var="rm" items="${rmList}">
						<tr id="ltr">
							<td id="ltd">${rm.r_id}</td>
							<td id="ltd">${rm.r_name}</td>
							<td id="ltd">${rm.g_name}</td>
							<td id="ltd"><button type="button" class="rmbtn" onclick="location.href='./aa_rmcontents?r_id=${rm.r_id}'">상세 보기</button></td>
						</tr>
					</c:forEach>
				</c:if>
			</table>
			
			<!-- 페이징 처리 버튼 -->
			<div class="paging">${rmpaging}</div>
		</div>
	</div>
</body>
</html>