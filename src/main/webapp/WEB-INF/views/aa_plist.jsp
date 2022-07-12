<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자-상품목록</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="short icon" href="#">
<link rel="stylesheet" href="resources/css/adminStyle.css">
<script type="text/javascript">
$(function(){
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
	
	//검색
	$("#psearch").click(function(){
		var apkeyword = $("#apkeyword").val();
		if(apkeyword == ""){
			alert("검색어를 입력하세요.");
			return;
		}
		var select = $("#psel").val();
		console.log(select, apkeyword);
		location.href="./aa_plist?apcolname=" + select
				+ "&apkeyword=" + apkeyword
				+ "&appageNum=1";
	});
});
</script>
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
			<button class="btn btn_tab act" onclick="location.href='./aa_plist'">상품관리</button>
			<button class="btn btn_tab" onclick="location.href='./aa_notice'">게시글관리</button>
		</div>
		<div class="content_area">
			<h3>[상품 목록]</h3>
			<div class="search-area">
				<select id="psel">
					<option value="p_code" selected>상품코드</option>
					<option value="p_name">상품명</option>
				</select> <input type="text" id="apkeyword" placeholder="Search">
				<button id="psearch">검색</button>
			</div>
			<br>
			<table id="plist" width="100%">
				<tr id="ltr">
					<th id="lth">상품코드</th>
					<th id="lth">카테고리</th>
					<th id="lth" colspan="2">상품명</th>
					<th id="lth">가격</th>
					<th id="lth">상세정보</th>
				</tr>
				<c:if test="${empty pList}">
				<tr id="ltr">
					<td id="ltd" colspan="6" align="center">
					등록된 상품이 없습니다.</td>
				</tr>
				</c:if>
				<c:if test="${!empty pList}">
				<c:forEach var="pitem" items="${pList}">
				<tr id="ltr">
					<td id="ltd" width="10%">${pitem.p_code}</td>
					<td id="ltd" width="10%">
						<c:set var="code" value="${pitem.p_code}"/>
						<c:choose>
							<c:when test="${fn:contains(code,'BO')}">꽃다발</c:when>
							<c:when test="${fn:contains(code,'BA')}">꽃바구니</c:when>
							<c:otherwise>화분</c:otherwise>
						</c:choose>
					</td>
					<!-- 상품명 -->
					<td id="ltd" width="1%">
						<!-- 상품이미지 출력 -->
						<img src="resources/upload/${pitem.pf_sysname}"
							style="width:50px; vertical-align:middle;">
					</td>
					<td id="ltd" width="15%">
						<!-- 상품명 출력(업데이트 링크) -->
						<a href="./aa_pupdate?p_code=${pitem.p_code}">${pitem.p_name}</a>
					</td>
					<td id="ltd" width="10%">
						<fmt:formatNumber value="${pitem.p_price}" pattern="###,###"/>
					</td>
					<td id="ltd" width="40%">${pitem.p_detail}</td>
				</tr>
				</c:forEach>
				</c:if>
			</table>
			<div class="paging">
				${appaging}
				<button type="button" class="pibtn" onclick="location.href='./aa_pinsert'">상품등록</button>
			</div>
		</div>
	</div>
</body>
</html>