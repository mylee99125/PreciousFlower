<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
	pageContext.setAttribute("br", "<br/>");
	pageContext.setAttribute("cn", "\n");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Zay Shop - Notice Contents Page</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="shortcut icon" type="image/x-icon"
	href="resources/images/favicon.png">
<style type="text/css">
.content_area {
	margin-top: 40px;
	margin-bottom: 20px;
}

.hntable {
	width: 1200px;
	height: 250px;
	text-align: center;
	border: 2px solid;
	border-right: none;
	border-left: none;
}

#writer, #title, #n_num, #n_date, #n_view {
	width: 150px;
	height: 40px;
}

#n_date2 {
	width: 300px;
	text-align: left;
}

#title2{
	text-align: left;
}

.hnbtn1 {
	position:relative;
	left: 1380px;
	margin-top: 20px;
	border: none;
	outline: none;
	border-radius: 3px;
	width: 60px;
	height: 35px;
}

.hnbtn1:focus {
	border: none;
	outline: none;
}

.hnbtn1:hover {
	background-color: #6E6E6E;
	color: #fff;
	transition: background 0.3s ease-in-out;
}

#ncon {
	border: 2px solid;
	border-left: none;
	border-right: none;
	border-top: none;
	height: 500px;
	vertical-align: top;
	padding-top: 20px;
	padding-left: 25px;
	text-align: left;
}

#top {
	border: 1px solid;
	border-left: none;
	border-right: none;
	border-color: #DEDEDE;
}

#middle {
	border: 2px solid;
	border-left: none;
	border-right: none;
	border-top: none;
}
</style>
</head>
<body>
	<header>
		<jsp:include page="header.jsp"/>
	</header>
	
	<div class="content_area">
		<table class="hntable" align="center">
			<thead class="hnhead">
				<tr id="top">
					<td id="writer">작성자</td>
					<td id="writer">admin</td>
					<td id="title">글제목</td>
					<td colspan="3" id="title2">${notice.n_title}</td>
				</tr>
				<tr id="middle">
					<td id="n_num">글번호</td>
					<td id="n_num">${notice.n_num}</td>
					<td id="n_date">작성일자</td>
					<td id="n_date2"><fmt:formatDate value="${notice.n_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					<td id="n_view">조회수</td>
					<td id="n_view">${notice.n_views}</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td colspan="8" id="ncon">${fn:replace(notice.n_contents, cn, br)}</td>
				</tr>
			</tbody>
		</table>
			<button type="button" class="hnbtn1" onclick="hnbackbtn();">목록</button>
	</div>
	
	<footer>
		<jsp:include page="footer.jsp"/>
	</footer>
</body>
<script type="text/javascript">
function hnbackbtn(){
	var urlstr = "./hnlist?";
	var col = "${hnlist.hncolname}";
	var key = "${hnlist.hnkeyword}";
	
	if(col == null || col == ""){//검색을 안한 경우
		urlstr += "hnpageNum=${hnpageNum}";
	}
	else {//검색을 한 경우
		urlstr += "hncolname=${hnlist.hncolname}&hnkeyword=${hnlist.hnkeyword}"
				+ "&hnpageNum=${hnpageNum}";
	}
	console.log(urlstr);
	
	location.href = urlstr;
}
</script>
</html>