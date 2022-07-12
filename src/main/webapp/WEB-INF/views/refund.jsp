<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Precious Flower - Refund</title>
<link rel="shortcut icon" type="image/x-icon"
	href="resources/images/favicon.png">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		var msg = "${msg}";
		if (msg != "") {
			alert(msg);
		}
	});
</script>
<style>
.refund {
	text-align: center;
}

#rf_title {
	text-align: center;
	margin-top: 50px;
	margin-bottom: 30px;
	font-weight: bold;
}

.rf_product {
	overflow: auto;
	width: 1000px;
	height: 500px;
	margin: auto;
	background-color: #FAFAFA;
	padding-top: 30px;
	border: 2px solid;
	border-color: #e6e6e6;
	border-radius: 5px;
	margin-bottom: 20px;
}

.rf_product::-webkit-scrollbar {
	width: 15px; /* 스크롤바의 너비 */
}

.rf_product::-webkit-scrollbar-thumb {
	height: 10%; /* 스크롤바의 길이 */
	background: #95a0ad; /* 스크롤바의 색상 */
}

.rf_product::-webkit-scrollbar-track {
	background: #e4e8ed; /*스크롤바 뒷 배경 색상*/
}

#rf_prod {
	border: 1px solid;
	border-color: gray;
	margin: auto;
	padding: 4px;
	width: 900px;
}
#rf_prod th {
	text-align: center;
	background-color: lightgray;
	height: 30px;
}
#rf_prod td {
	height: 120px;
}
#o_picture {
	width: 100px;
	height: 100px;
	border: 1px dashed;
	border-color: #e7caca;
	text-align: center;
}

#o_product, #o_product2, #o_total {
	width: 375px;
	text-align: left;
	padding-left: 40px;
}
#o_product {
	font-weight: bold;
}

.rf_info {
	width: 1000px;
	margin: auto;
	background-color: #FAFAFA;
	padding-top: 10px;
	padding-bottom: 10px;
	border: 2px solid;
	border-color: #e6e6e6;
	border-radius: 5px;
}

#rf_infoc {
	border-color: gray;
	margin: auto;
	margin-bottom: 10px;
	padding: 4px;
	width: 900px;
	border-spacing: 0 20px;
	vertical-align: middle;
	text-align: right;
}

#rf_val {
	width: 400px;
	padding-right: 30px;
}

#bank {
	width: 144px;
	height: 33px;
}

#rf_in {
	width: 500px;
	text-align: left;
}

#rf_in #Date {
	height: 33px;
}

#rf_in #text {
	margin-left: 10px;
}

.rf_cinfo {
	width: 1000px;
	margin: auto;
	background-color: #FAFAFA;
	padding-top: 10px;
	padding-bottom: 10px;
	border: 2px solid;
	border-color: #e6e6e6;
	border-radius: 5px;
	margin-bottom: 20px;
}

#rf_cinfoc {
	border-color: gray;
	margin: auto;
	padding: 4px;
	width: 900px;
	border-spacing: 0 20px;
	vertical-align: middle;
	text-align: center;
}

#rf_addr2, #rf_addr3 {
	width: 450px;
}

.rf_bottom {
	width: 1000px;
	margin: auto;
	background-color: #FAFAFA;
	padding-top: 10px;
	padding-bottom: 10px;
	border: 2px solid;
	border-color: #e6e6e6;
	border-radius: 5px;
	margin-bottom: 20px;
}

#rf_button {
	margin: auto;
	width: 900px;
}

#a1 {
	text-align: left;
	width: 130px;
	font-weight: bold;
}

#a3 {
	width: 700px;
	text-align: left;
}

#rf {
	width: 200px;
	text-align: right;
}

#rf_btn {
	height: 40px;
	width: 70px;
	border: none;
	outline: none;
	border-radius: 3px;
}

#rf_btn:hover {
	background-color: #6e6e6e;
	color: white;
}

.foot {
	margin-top: 100px;
}
</style>
</head>
<body>
	<header>
		<jsp:include page="header.jsp" />
	</header>
	<form action="" method="post">
	<div class="refund">
		<h1 id="rf_title">환불</h1>
		<p>최종 환불은 관리자의 검토 완료 후 1~2일 소요됩니다.</p>
		<div class="rf_cinfo">
			<table id="rf_cinfoc">
				<tr>
					<td id="rfname">이름 :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${minfo.m_name}</td>
				</tr>
				<tr>
					<td id="rfname">전화번호 :&nbsp;&nbsp;${minfo.m_phone}</td>
				</tr>
			</table>
		</div>

		<div class="rf_product">
			<table id="rf_prod">
				<tr>
					<th colspan=2>주문상품</th>
					<th>판매가</th>
					<th>주문수량</th>
					<th>주문금액</th>
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
				</tr>
				<c:set var="sum" value="${sum + od.od_price}"/>
				<c:set var="onum" value="${od.od_onum}"/>
				</c:forEach>
			</table>
		</div>
		<!--  
		<div class="rf_info">
			<table id="rf_infoc">
				<tr>
					<td id="rf_val">상품 회수 날짜</td>
					<td id="rf_in" colspan="2"><input id="Date" type="date"></td>
				</tr>
				<tr>
					<td id="rf_val">환불계좌번호</td>
					<td id="rf_sel"><select id="bank">
							<option disabled selected>은행선택</option>
							<option>KEB하나은행</option>
							<option>SC제일은행</option>
							<option>KB국민은행</option>
							<option>신한은행</option>
							<option>외환은행</option>
							<option>우리은행</option>
							<option>한국시티은행</option>
					</select></td>
					<td id="rf_in"><input id="text" type="text"></td>
				</tr>
			</table>
		</div>
		-->

		<div class="rf_bottom">
			<table id="rf_button">
				<tr>
					<td id="a1">환불예정 금액 &#8361;<fmt:formatNumber value="${sum}" pattern="###,###"/></td>
				</tr>
				<tr>
					<td id="a3">위의 모든 내용을 확인하였으며, 환불 신청을 진행합니다.</td>
					<td id="rf">
						<input type="hidden" name="o_num" value="${onum}">
						<button type="submit" id="rf_btn" onclick="javascript: form.action='/refsubmit';">확인</button>
						<button type="button" id="rf_btn" onclick="location.href='./orderList'">취소</button>
					</td>
				</tr>
			</table>
		</div>
	</div>
	</form>

	<footer class="foot">
		<jsp:include page="footer.jsp" />
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