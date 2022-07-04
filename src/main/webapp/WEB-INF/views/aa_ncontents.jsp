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
<title>공지사항 상세</title>
<link rel="stylesheet" href="resources/css/adminStyle.css">
<style type="text/css">
table {
	border: 2px solid;
	border-left: none;
	border-right: none;
	border-color: #6e6e6e;
	border-collapse: collapse;
}

th {
	width: 700px;
	background-color: #dcdcdc;
	border-bottom-color: #6e6e6e;
}

#top {
	text-align:center;
	border-bottom: 1px solid;
	border-bottom-color: #b4b4b4;
}

#middle {
	text-align: center;
	border-bottom: 2px solid;
	border-bottom-color: #6e6e6e;	
}

td {
	text-align: left;
}

th, td {
	padding: 8px;
}

#ncon {
	height: 450px;
	vertical-align: top;
	padding-top: 20px;
	padding-left: 25px;
}

.anbtn1 {
	float: right;
	width: 50px;
	height: 30px;
	margin: 10px;
	border: none;
	outline: none;
	border-radius: 3px;
}

.anbtn2 {
	margin: 10px;
	width: 50px;
	height: 30px;
	border: none;
	outline: none;
	border-radius: 3px;
}
.anbtn1:hover, .anbtn2:hover {
	background-color: #6e6e6e;
	color: white;
}

#middle {
	width: 200px;
}

#title {
	text-align: left;
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
			<table>
				<thead>
					<tr id="top">
						<th>글제목</th>
						<th colspan="7" id="title">${notice.n_title}</th>
					</tr>
					<tr id="middle">
						<th>글번호</th>
						<th align="left">${notice.n_num}</th>
						<th></th>
						<th>작성일자</th>
						<th align="left"><fmt:formatDate value="${notice.n_date}"
								pattern="yyyy-MM-dd HH:mm:ss"/></th>
						<th></th>
						<th>조회수</th>
						<th align="left">${notice.n_views}</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td colspan="8" id="ncon">${fn:replace(notice.n_contents, cn, br)}</td>
					</tr>
				</tbody>
			</table>
				<button type="button" class="anbtn2" onclick="nbackbtn();">목록</button>
				<button type="button" class="anbtn1" onclick="nDelete('${notice.n_num}')">삭제</button>
				<button class="anbtn1" margin-right="10" onclick="location.href='./aa_nupdate?n_num=${notice.n_num}'">수정</button>
		</div>
	</div>
</body>
<script type="text/javascript">
function nDelete(n_num){
	var conf = confirm("삭제하겠습니까?");
	
	if(conf == true){
		location.href="./ndelete?n_num=" + n_num;
	}
}
function nbackbtn(){
	var urlstr = "./nlist?";
	var col = "${nlist.ncolname}";
	var key = "${nlist.nkeyword}";
	
	if(col == null || col == ""){//검색을 안한 경우
		urlstr += "npageNum=${npageNum}";
	}
	else {//검색을 한 경우
		urlstr += "ncolname=${nlist.ncolname}&nkeyword=${nlist.nkeyword}"
				+ "&npageNum=${npageNum}";
	}
	console.log(urlstr);
	
	location.href = urlstr;
}
</script>
</html>