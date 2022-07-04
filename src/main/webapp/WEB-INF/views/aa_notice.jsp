<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자-게시글목록</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="resources/css/adminStyle.css">
<script type="text/javascript">
$(function(){
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
	
	$("#nsearch").click(function(){
		var nkeyword = $("#nkeyword").val();
		if(nkeyword == ""){
			alert("검색할 내용을 입력해주세요.");
			return;
		}
		
		var select = $("#nsel").val();
		console.log(select, nkeyword);
		location.href="./nlist?ncolname=" + select 
				+ "&nkeyword=" + nkeyword
				+ "&npageNum=1";
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
	width: 600px;
	background-color: #d2d2d2;
	border-bottom: 2px solid;
	border-bottom-color: #6e6e6e;
}

tr {
	text-align: center;
	border-bottom: 1px solid;
	border-bottom-color: #d2d2d2;
}

#ano {
	width: 200px;
}

#awriter {
	width: 300px;
}

#atitle {
	width: 70%;
}

#adate {
	width: 400px;
}

#aview {
	width: 200px;
}

td {
	height: 50px;
}

th, td {
	padding: 8px;
}

.bottom {
	margin-left: 10px;
	margin-top: 15px;
}
.search-area {
	margin-left: 10px;
	margin-top: 15px;	
}

.anbtn1 {
	float: right;
	margin-right: 10px;
	width: 60px;
	height: 30px;
	border: none;
	outline: none;
	border-radius: 3px;
}
.anbtn1:hover {
	background-color: #6e6e6e;
	color: white;
}

#nsel, #nkeyword, #nsearch {
	height: 30px;
}

#nsearch {
	width: 50px;
	border: none;
	outline: none;
	border-radius: 3px;
}

#nsearch:hover {
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
			<h3>[게시글 목록]</h3>
			<!-- 검색창 -->
			<div class="search-area">
				<select id="nsel">
					<option value="n_title" selected>제목</option>
					<option value="n_contents">내용</option>
				</select>
				<input type="text" id="nkeyword" placeholder="Search">
				<button id="nsearch">검색</button>
			</div>
			<br>
			<table id="plist" width="100%">
				<tr id="ltr">
					<th id="lth">글번호</th>
					<th id="lth">작성자</th>
					<th id="lth">제목</th>
					<th id="lth">작성일자</th>
					<th id="lth">조회수</th>
				</tr>
				<c:if test="${empty nList}">
					<tr id="ltr">
						<td id="ltd" colspan="5">
							<label style="width: 100%">작성된 글이 없습니다.</label>
					</td>
					</tr>
				</c:if>
				<c:if test="${!empty nList}">
					<c:forEach var="n" items="${nList}">
						<tr id="ltr">
							<td id="ltd" width="10%">${n.n_num}</td>
							<td id="ltd" width="10%">${n.n_aid}</td>
							<td id="ltd" width="40%"><a href="./noticeContents?n_num=${n.n_num}">${n.n_title}</a></td>
							<td id="ltd" width="10%"><fmt:formatDate value="${n.n_date}" pattern="yyyy-MM-dd"/></td>
							<td id="ltd" width="10%">${n.n_views}</td>
						</tr>
					</c:forEach>
				</c:if>
			</table>

			<!-- 페이징 처리 버튼 -->
			<div class="paging" style="text-align: center;">
				${npaging}
				<button type="button" class="anbtn1" onclick="location.href='/aa_ninsert'">글작성</button>
			</div>

		</div>
	</div>
</body>
</html>