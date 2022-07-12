<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Precious Flower - Cart</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="apple-touch-icon" href="resources/img/apple-icon.png">
<link rel="shortcut icon" type="image/x-icon"
	href="resources/images/favicon.png">

<link rel="stylesheet" href="resources/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/css/templatemo.css">
<link rel="stylesheet" href="resources/css/custom.css">

<!-- Load fonts style after rendering the layout styles -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;200;300;400;500;700;900&display=swap">
<link rel="stylesheet" href="resources/css/fontawesome.min.css">

<!-- Slick -->
<link rel="stylesheet" type="text/css"
	href="resources/css/slick.min.css">
<link rel="stylesheet" type="text/css"
	href="resources/css/slick-theme.css">
<script type="text/javascript">
$(function(){
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
});
</script>

<style type="text/css">
#n-title {
	text-align: center;
	margin-top: 50px;
	margin-bottom: 20px;
}
#cartcontainer {
	position: relative;
}
#cartsum {
	height: 50px;
	width: 500px;
	background-color: lightgray;
	border-radius: 30px;
	margin-bottom: 10px;
	padding: 13px;
	text-align: center;
	position: absolute;
	left: 35%;
}
#btns {
	text-align: center;
	margin-bottom: 100px;
}
.cartbtn {
	background-color: #59ab6e;
	width: 150px;
	height: 40px;
	cursor: pointer;
	border: none;
	border-radius: 5px;
}
.cartdel {
	cursor: pointer;
}
#cth {
	height: 20px;
	background-color: #212934;
	color: white;
	border: 2px solid;
	border-left: none;
	border-right: none;
}
#ctr {
	border: 1px solid;
	border-color: #DEDEDE;
	border-left: none;
	border-right: none;
	height: 63px;
}
#catable {
	width: 1500px;
	text-align: center;
	border: 2px solid;
	border-left: none;
	border-right: none;
	border-top: none;
	margin-bottom: 30px;
}

#catable th {
	height: 63px;
}

#emptycart {
	text-align: center;
	width: 100%;
	padding: 20px;
}
.btn {
	background-image: linear-gradient(-225deg, #FFFEFF 0%, #D7FFFE 100%);
	width: 150px;
	height: 50px;
	border: none;
	font-size: 15px;
}
.btn:hover {
	background-image: linear-gradient(-225deg, #E3FDF5 0%, #FFE6FA 100%);
}
</style>
</head>
<body>
	<header>
	<jsp:include page="header.jsp"/>
	</header>
	
	<h1 id="n-title">장바구니</h1><hr>
	<div>
	<form action="" method="get" class="modal-content modal-body border-0 p-0">
	<div id="emptycart">
		<c:if test="${empty cartList}">
					<img src="resources/images/cart.png" style="width:100px; vertical-align:middle;"><br><br>
					장바구니에 추가된 상품이 없습니다.
		</c:if>
	</div>
	<c:if test="${!empty cartList}">
	<table id="catable" align="center">
		<tr id="ctr">
			<th id="cth"></th>
			<th id="cth" colspan="2" align="center">상품정보</th>
			<th id="cth">수량</th>
			<th id="cth">상품금액</th>
			<th id="cth">합계금액</th>
		</tr>
		<c:set var="count" value="0"/>
		<c:set var="sum" value="0"/>
		<c:forEach var="c" items="${cartList}">
		<tr id="ctr">
			<td width="10%" height="80">
				<a href="./delCart?c_num=${c.c_num}">
					<img src="resources/images/letter-x.png"
						style="width:20px; vertical-align:middle;">
				</a>
			</td>
			<td width="3%">
				<img src="resources/upload/${c.pf_sysname}"
					style="width:70px; vertical-align:middle;">
			</td>
			<td width="10%"><a>${c.c_pname} (${c.c_pcode})</a></td>
			<td width="10%">${c.c_count}개</td>	
			<td width="10%">
				<fmt:formatNumber value="${c.p_price}" pattern="###,###"/>원
			</td>	
			<td width="10%">
				<fmt:formatNumber value="${c.c_pprice}" pattern="###,###"/>원
			</td>	
		</tr>
		<c:set var="count" value="${count + c.c_count}"/>
		<c:set var="sum" value="${sum + c.c_pprice}"/>
		</c:forEach>
	</table>
	</c:if>
		<c:if test="${!empty cartList}">
			<div id="cartcontainer">
				<div id="cartsum">
					총 ${count}개의 상품금액 <fmt:formatNumber value="${sum}" pattern="###,###"/>원
				</div>
			</div>
		</c:if><br><br>
	<div id="btns">
		<button type="button" class="btn" onclick="location.href='./f_product';"
			value="return">계속 쇼핑하기</button>
		<button type="submit" class="btn" name="submit" value="order" formaction="/Order">주문하기</button>
	</div>
	</form>
	</div>
	<footer>
	<jsp:include page="footer.jsp"/>
	</footer>

    <!-- Start Script -->
    <script src="resources/js/jquery-1.11.0.min.js"></script>
    <script src="resources/js/jquery-migrate-1.2.1.min.js"></script>
    <script src="resources/js/bootstrap.bundle.min.js"></script>
    <script src="resources/js/templatemo.js"></script>
    <script src="resources/js/custom.js"></script>
    <!-- End Script -->
</body>
</html>












