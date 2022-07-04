<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자-주문목록</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="resources/css/adminStyle.css">
<script type="text/javascript">
$(function(){
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
	//검색
	$("#osearch").click(function(){
		var okeyword = $("#okeyword").val();
		if(okeyword == ""){
			alert("검색어를 입력하세요.");
			return;
		}
		var select = $("#osel").val();
		console.log(select, okeyword);
		location.href="./aa_olist?ocolname=" + select
				+ "&okeyword=" + okeyword
				+ "&opageNum=1";
	});
	
	$("#ossel").on("change", function(){
		console.log("변경~~");
		var elm = $(this).next();
		var v = $(this).val();
		elm.val(v);
	});
	
	var b = $("#sabtn");
	console.log(b);
	$(document).on("click", "#sabtn", function(){
		var idx = $(this).attr("t_data");
		//console.log(idx);
		var numValue = $("#num"+idx).text();
		console.log(numValue);
		var selValue = $("#ossel"+idx).val();
		console.log(selValue);
		if(selValue == ""){
			alert("상태변경 값을 선택하세요.");
			return;
		}
		
		location.href="./oupdate?o_num="+numValue+"&o_status="+selValue;
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
			<button class="btn btn_tab act" onclick="location.href='./aa_olist'">주문관리</button>
			<button class="btn btn_tab" onclick="location.href='./aa_plist'">상품관리</button>
			<button class="btn btn_tab" onclick="location.href='./aa_notice'">게시글관리</button>
		</div>
		<div class="content_area">
		<form action="/oupdate" method="post">
			<h3>[주문 목록]</h3>
			<div class="search-area">
				<select id="osel">
					<option value="o_num" selected>주문번호</option>
					<option value="o_mid">주문자ID</option>
				</select> 
				<input type="text" id="okeyword" placeholder="Search">
				<button id="osearch">검색</button>
			</div>
			<p>
				전체 : ${ototal}건, 
				매출액 : <fmt:formatNumber value="${ordersum}" pattern="###,###"/>원
			</p>
			<hr>
			<table id="olist" width="100%">
				<tr id="ltr">
					<th id="lth">주문구분</th>
					<th id="lth">주문번호</th>
					<th id="lth">주문날짜</th>
					<th id="lth">주문자ID</th>
					<th id="lth">결제방법</th>
					<th id="lth">결제금액</th>
					<th id="lth">주문상태</th>
					<th id="lth"></th>
				</tr>
				<c:if test="${empty oList}">
				<tr id="ltr">
					<td id="ltd" colspan="8" align="center">
					등록된 주문이 없습니다.</td>
				</tr>
				</c:if>
				<c:if test="${!empty oList}">
				<c:forEach var="o" items="${oList}" varStatus="status">
				<tr id="ltr">
					<td id="ltd" width="10%">${o.o_type}</td>
					<td id="ltd" width="10%">
						<a href="./aa_ocontents?o_num=${o.o_num}">
							<span id="num${status.index}">${o.o_num}</span>
						</a>
					</td>
					<td id="ltd" width="10%">${o.o_date}</td>
					<td id="ltd" width="10%">${o.o_mid}</td>
					<td id="ltd" width="10%">${o.o_pay}</td>
					<td id="ltd" width="10%">
						<fmt:formatNumber value="${o.o_price}" pattern="###,###"/>
					</td>
					<td id="ltd" width="15%">
						<h3>${o.o_status}</h3>
						<p>상태 변경 : 
						<select id="ossel${status.index}" name="t_status">
							<option value="">======</option>
							<option value="주문접수">주문접수</option>
							<option value="픽업완료">픽업완료</option>
							<option value="배송중">배송중</option>
							<option value="배송완료">배송완료</option>
							<option value="거래완료">거래완료</option>
							<option value="환불접수">환불접수</option>
							<option value="환불완료">환불완료</option>
						</select>
						</p>
					</td>
					<td id="ltd" width="5%"><button id="sabtn" t_data="${status.index}" type="button" class="pibtn">저장</button></td>
				</tr>
				</c:forEach>
				</c:if>
			</table>
			<div class="paging">
				${opaging}
			</div>
		</form>
		</div>
	</div>
</body>
</html>