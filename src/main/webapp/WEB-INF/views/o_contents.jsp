<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Precious Flower - Order Contents</title>
<link rel="shortcut icon" type="image/x-icon"
	href="resources/images/favicon.png">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
});
</script>
<style>
#o_title {
	text-align: center;
	margin-top: 50px;
	margin-bottom: 30px;
	font-weight: bold;
}
#o_li {
	border: 1px solid;
	border-color: gray;
	margin: auto;
	margin-bottom: 10px;
	padding: 4px;
}
#o_li>td {
	border: 1px solid;
}
#o_totalli {
	border: none;
	margin: auto;
	margin-top: 30px;
	margin-bottom: 10px;
	padding: 3px;
	width: 1000px;
	background-color: #FAFAFA;
	text-align: center;
	border: 2px solid;
	border-color: #e6e6e6;
	border-radius: 5px;
}

#o_picture {
	width: 100px;
	height: 100px;
	border: 1px dashed;
	border-color: #e7caca;
	text-align: center;
}
#o_product, #o_product2 {
	width: 500px;
	height: 50px;
	text-align: left;
	padding-left: 20px;
}
#o_product {
	font-weight: bold;
}
#o_total {
	width: 300px;
	text-align: center;
}
#o_status{
	padding-left: 20px;
}
.foot {
	margin-top: 100px;
}
.o_price{
	margin: auto;
}
#to_price1 {
	height: 50px;
	width: 350px;
	text-align: center;
	font-weight: bold;
}
#to_cancle {
	height: 40px;
	width: 70px;
}
#to_refund {
	height: 40px;
	width: 70px;
}

#to_btn1 {
	height: 40px;
	width: 90px;
	border: none;
	outline: none;
	border-radius: 3px;
}

#to_btn2 {
	height: 40px;
	width: 70px;
	border: none;
	outline: none;
	border-radius: 3px;
}
#to_btn:hover {
	background-color: #6e6e6e;
	color: white;
}
#s_btn {
	border: none;
	outline: none;
	border-radius: 3px;
	width: 100px;
	height: 40px;
	font-weight: bold;
	color: #418bfa;
}
#s_btn:hover {
	background-color: #418bfa;
	color: white;
}
.oc_botton {
	text-align: right;
	padding-right: 345px;
}
#o_check {
	vertical-align: top;
}
#oc_check {
	margin-right: 4px;
}
#back_btn {
	border: none;
	outline: none;
	height: 40px;
	width: 110px;
	margin-top: 10px;
	border-radius: 3px;
}
#rebtn {
	border: none;
	outline: none;
	height: 40px;
	width: 110px;
	border-radius: 3px;
}
#back_btn:hover {
	background-color: #6e6e6e;
	color: white;
}
#select_all {
	margin-left: 27px;
}
.rf_product {
	overflow: auto;
	width: 1000px;
	height: 800px;
	margin: auto;
	background-color: #FAFAFA;
	padding-top: 30px;
	border: 2px solid;
	border-color: #e6e6e6;
	border-radius: 5px;
	margin-bottom: 20px;
}
.rf_product::-webkit-scrollbar {
    width: 15px;  /* 스크롤바의 너비 */
}

.rf_product::-webkit-scrollbar-thumb {
    height: 10%; /* 스크롤바의 길이 */
    background: #95a0ad; /* 스크롤바의 색상 */
}

.rf_product::-webkit-scrollbar-track {
    background: #e4e8ed;  /*스크롤바 뒷 배경 색상*/
}
#rf_prod {
	border: 1px solid;
	border-color: gray;
	margin: auto;
	padding: 4px;
	width: 900px;
	text-align: center;
}
#rf_prod th {
	text-align: center;
	background-color: lightgray;
	height: 30px;
}
#rf_prod td {
	height: 120px;
}
#rf_prod2 {
	border: 1px solid;
	border-color: gray;
	margin: auto;
	padding: 4px;
	width: 900px;
	text-align: center;
}
#rf_prod2 th {
	text-align: center;
	background-color: lightgray;
	height: 30px;
}
#rf_prod2 td {
	height: 50px;
}
</style>
</head>
<body>
	<header>
		<jsp:include page="header.jsp"/>
	</header>
	
	<h1 id="o_title">주문 상세 내역</h1>
		<div class="rf_product">
			<p style="text-align: center;">주문번호 : ${odDet.o_num}, 주문일시 : ${odDet.o_date}</p>
			<table id="rf_prod">
				<tr>
					<th colspan=2 width="7%">주문상품</th>
					<th width="5%">판매가</th>
					<th width="5%">주문수량</th>
					<th width="5%">주문금액</th>
					<th></th>
				</tr>
				<c:set var="sum" value="0"/>
				<c:forEach var="od" items="${odCon}">
				<tr>
					<td width="2%">
						<!-- 상품이미지 출력 -->
						<img src="resources/upload/${od.pf_sysname}"
							style="width:100px; vertical-align:middle;">
					</td>
					<td width="5%"><!-- 상품명 출력 -->${od.od_pname}</td>
					<td width="5%"><fmt:formatNumber value="${od.p_price}" pattern="###,###"/></td> 
					<td width="5%">${od.od_count}</td>
					<td width="5%">
						<fmt:formatNumber value="${od.od_price}" pattern="###,###"/>
					</td>
					<td width="1%">
						<c:set var="ostatus" value="${odDet.o_status}"/>
						<c:if test="${ostatus eq '거래완료'}">
							<button id="rebtn" onclick="location.href='./review?p_code=${od.od_pcode}'">리뷰 작성</button>
						</c:if>
					</td>
				</tr>
				<c:set var="sum" value="${sum + od.od_price}"/>
				</c:forEach>
			</table>
			<br>
			<p style="text-align: center;">주문정보</p>
			<table id="rf_prod2">
				<tr>
					<th width="5%">수령인</th>
					<th width="10%">전화번호</th>
					<th width="10%">수령일자</th>
					<th width="20%">주소</th>
				</tr>
				<tr>
					<c:set var="rdate" value="${odDet.o_rdate}"/>
					<c:if test="${empty odDet.o_addr1}">
						<td colspan="4">
							픽업 수령일자 : ${fn:substring(rdate,0,10)} ${fn:substring(rdate,11,16)}
						</td>
					</c:if>
					<c:if test="${!empty odDet.o_addr1}">
						<td width="5%">${odDet.o_rec}</td>
						<td width="10%">${odDet.o_phone}</td>
						<td width="10%">${fn:substring(rdate,0,10)} ${fn:substring(rdate,11,16)}</td>
						<td width="20%">(${odDet.o_addr1}) ${odDet.o_addr2} ${odDet.o_addr3}</td>
					</c:if>
				</tr>
			</table>
			<br>
			<p style="text-align: center;">배달정보</p>
			<table id="rf_prod2">
				<tr>
					<th width="5%">라이더</th>
					<th width="5%">전화번호</th>
					<th width="5%">보험</th>
				</tr>
				<tr>
					<c:set var="type" value="${odDet.o_type}"/>
					<c:choose>
					<c:when test="${fn:contains(type,'픽업')}">
						<td id="ltd" colspan="4">
							픽업 주문 건입니다!
						</td>
					</c:when>
					<c:otherwise>
					<c:if test="${empty odDet.r_name}">
						<td colspan="4">
							라이더가 배달 접수 전입니다!
							<img src="resources/images/rider.png" style="width:30px; vertical-align:middle;">
						</td>
					</c:if>
					<c:if test="${!empty odDet.r_name}">
						<td width="5%">
							${odDet.r_name} (Rider 사번 : ${odDet.o_rnum})
						</td>
						<td width="5%">${odDet.r_phone}</td>
						<td width="5%">${odDet.r_insurance}</td>
					</c:if>
					</c:otherwise>
					</c:choose>
				</tr>
			</table>
		</div>
	
	<div class="o_price">
		<table id="o_totalli">
			<tr>
				<td id="to_price1">총 결제금액 : &#8361; <fmt:formatNumber value="${sum}" pattern="###,###"/>원 (${odDet.o_pay})</td>
			</tr>
		</table>
	</div>
	
	<div class="oc_botton">
		<button id="back_btn" onclick="history.back(-1);">뒤로가기</button>
	</div>
	
	<footer class="foot">
		<jsp:include page="footer.jsp"/>
	</footer>
	
</body>
</html>