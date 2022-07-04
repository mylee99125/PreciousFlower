<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Zay Shop - Notice Page</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="shortcut icon" type="image/x-icon" href="resources/img/favicon.ico">
<link rel="stylesheet" href="resources/css/paging-style.css">
<script type="text/javascript">
$(function(){
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
	
	$("#hnsearch").click(function(){
		var hnkeyword = $("#hnkeyword").val();
		if(hnkeyword == ""){
			alert("검색할 내용을 입력해주세요.");
			return;
		}
		
		var select = $("#hnsel").val();
		console.log(select, hnkeyword);
		location.href="./hnlist?hncolname=" + select 
				+ "&hnkeyword=" + hnkeyword
				+ "&hnpageNum=1";
	});
});
</script>
<style type="text/css">
#n-title {
	text-align: center;
	margin-top: 50px;
	margin-bottom: 20px;
}

.paging {
	margin-top: 30px;
	margin-bottom: 60px;
}

.search-area {
	text-align: right;
	margin-right: 220px;
	margin-bottom: 20px;
}

#hnsel {
	height: 33px;
}

#hnsearch {
	border: none;
	outline: none;
	border-radius: 3px;
	width: 60px;
	height: 33px;
}

#hnsearch:hover {
	background-color: #6E6E6E;
	color: #fff;
	transition: background 0.3s ease-in-out;
}

#table {
	width: 1500px;
	height: 100px;
	text-align: center;
	border: 2px solid;
	border-left: none;
	border-right: none;
	border-top: none;
	margin-bottom: 30px;
}

th {
	height: 50px;
	background-color: #212934;
	color: white;
	border: 2px solid;
	border-left: none;
	border-right: none;
}

#t_num {
	width: 150px;
}

#t_write, #t_date, #t_view {
	width: 160px;
}

#hncon {
	border: 1px solid;
	border-color: #DEDEDE;
	border-left: none;
	border-right: none;
	height: 60px;
}

#hncon a {
	text-decoration: none;
	color: #212529;
}
</style>
</head>
<body>
	<header>
		<jsp:include page="header.jsp"/>
	</header>
	
		<h1 id="n-title">공지사항</h1>
		<!-- 우측 상단 검색창 -->
		<div class="search-area">
			<select id="hnsel">
				<option value="n_title" selected>제목</option>
				<option value="n_contents">내용</option>
			</select>
			<input type="text" id="hnkeyword" placeholder="Search">
			<button id="hnsearch">검색</button>
		</div>
			
		<table id="table" align="center">
			<th id="t_num">글번호</th>
			<th id="t_write">작성자</th>
			<th id="t_title">제목</th>
			<th id="t_date">작성일자</th>
			<th id="t_view">조회수</th>
			<c:if test="${empty hnList}">
				<tr>
					<td colspan="5" style="text-align: center">
						<label style="width: 100%">작성된 글이 없습니다.</label>
					</td>
				</tr>
			</c:if>
			<c:if test="${!empty hnList}">
				<c:forEach var="hn" items="${hnList}">
					<tr id="hncon">
						<td>${hn.n_num}</td>
						<td>${hn.n_aid}</td>
						<td><a href="./hnContents?n_num=${hn.n_num}">${hn.n_title}</a></td>
						<td><fmt:formatDate value="${hn.n_date}" pattern="yyyy-MM-dd"/></td>
						<td>${hn.n_views}</td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
		
		<!-- 페이징 처리 버튼 -->
		<div class="paging" style="text-align: center;">${hnpaging}</div>
	
	<footer>
		<jsp:include page="footer.jsp"/>
	</footer>

</body>
</html>