<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order_List</title>
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
a {
	text-decoration: none;
}
.o_list {
	overflow: auto;
	width: 1000px;
	height: 500px;
	margin: auto;
	background-color: #FAFAFA;
	padding-top: 30px;
	border: 2px solid;
	border-color: #e6e6e6;
	border-radius: 5px;
}
.o_list::-webkit-scrollbar {
    width: 15px;  /* 스크롤바의 너비 */
}

.o_list::-webkit-scrollbar-thumb {
    height: 10%; /* 스크롤바의 길이 */
    background: #95a0ad; /* 스크롤바의 색상 */
}

.o_list::-webkit-scrollbar-track {
    background: #e4e8ed;  /*스크롤바 뒷 배경 색상*/
}
#o_title {
	text-align: center;
	margin-top: 50px;
	margin-bottom: 30px;
	font-weight: bold;
}
#o_li {
	border: 1px solid;
	border-color: gray;
	margin: 10px;
	padding: 4px;
	text-align: center;
}
#o_li th {
	text-align: center;
	background-color: lightgray;
	height: 30px;
}
#o_totalli {
	border: none;
	margin: auto;
	margin-top: 30px;
	margin-bottom: 10px;
	padding: 3px;
	width: 1000px;
	background-color: #FAFAFA;
	border: 2px solid;
	border-color: #e6e6e6;
	border-radius: 5px;
}
#o_product {
	height: 50px;
}
.foot {
	margin-top: 50px;
}
.o_price{
	margin: auto;
}
#to_price1 {
	height: 50px;
	width: 400px;
	text-align: center;
	font-weight: bold;
}
#s_btn {
	border: none;
	outline: none;
	border-radius: 3px;
	width: 100px;
	height: 40px;
	pointer-events: none;
	font-weight: bold;
	color: black;
}
#refbtn {
	border: none;
	outline: none;
	border-radius: 3px;
	width: 100px;
	height: 40px;
	font-weight: bold;
	color: black;
	cursor: pointer;
	background-color: #FFB6C1;
}
</style>
</head>
<body>
	<header>
		<jsp:include page="header.jsp"/>
	</header>
	
	<h1 id="o_title">주문 내역</h1>
	<div class="o_list">
		<table id="o_li">
			<tr>
				<th width="5%">주문구분</th>
				<th width="5%">주문번호</th>
				<th width="10%">주문일자</th>
				<th width="5%">주문금액</th>
				<th colspan="2" width="4%">주문상태</th>
			</tr>
			<c:if test="${empty moList}">
				<tr>
					<td colspan="6">아직 주문을 하지 않으셨습니다.</td>
				</tr>
			</c:if>
		
			<c:if test="${!empty moList}">
			<c:set var="sum" value="0"/>
			<c:forEach var="mo" items="${moList}">
			<tr>
				<td width="5%">${mo.o_type}</td>
				<td id="o_product" width="5%"><a href="./o_contents?od_onum=${mo.o_num}">${mo.o_num}</a></td>
				<td id="o_date" width="10%">${mo.o_date}</td>
				<td id="o_total" width="5%">&#8361; <fmt:formatNumber value="${mo.o_price}" pattern="###,###"/></td>
				<td id="o_status" width="2%"><button id="s_btn">${mo.o_status}</button></td>
				<td width="2%"><button id="refbtn" onclick="location.href='./refund?od_mid=${mo.o_mid}&od_onum=${mo.o_num}'">환불신청</button></td>
			</tr>
			<c:set var="sum" value="${sum + mo.o_price}"/>
			</c:forEach>
			</c:if>
		</table>
	</div>		
	<div class="o_price">
		<table id="o_totalli">
			<tr>
				<td id="to_price1">총 결제금액 : &#8361; <fmt:formatNumber value="${sum}" pattern="###,###"/>원</td>
			</tr>
			
			
		</table>
	</div>
	
	
	<footer class="foot">
		<jsp:include page="footer.jsp"/>
	</footer>
</body>
</html>