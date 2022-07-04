<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자-주문상세</title>
<link rel="stylesheet" href="resources/css/adminStyle.css">
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
			<h3>[주문 정보]</h3><br>
			<a style="margin-top:15px; background-color:#bebebe;">주문번호 : ${oCon.o_num}, 주문일시 : ${oCon.o_date}</a>
			<table id="olist" width="50%">
				<tr id="ltr">
					<th id="lth" colspan=2>주문상품</th>
					<th id="lth">판매가</th>
					<th id="lth">주문수량</th>
					<th id="lth">주문금액</th>
				</tr>
				<c:if test="${!empty od}">
				<c:forEach var="od" items="${od}">
				<tr id="ltr">
					<td id="ltd" width="1%">
						<!-- 상품이미지 출력 -->
						<img src="resources/upload/${od.pf_sysname}"
							style="width:50px; vertical-align:middle;">
					</td>
					<td id="ltd" width="5%"><!-- 상품명 출력 -->${od.od_pname}</td>
					<td id="ltd" width="5%"><fmt:formatNumber value="${od.p_price}" pattern="###,###"/></td> 
					<td id="ltd" width="5%">${od.od_count}</td>
					<td id="ltd" width="5%">
						<fmt:formatNumber value="${od.od_price}" pattern="###,###"/>
					</td>
				</tr>
				</c:forEach>
				</c:if>
			</table>
			<p style="margin-top:10px;">결제방식 : ${oCon.o_pay}, 결제금액 : <fmt:formatNumber value="${oCon.o_price}" pattern="###,###"/></p>
			<br>
			<a style="margin-top:15px; background-color:#bebebe;">주문정보</a>
			<table id="olist" width="50%">
				<tr id="ltr">
					<th id="lth">수령인</th>
					<th id="lth">전화번호</th>
					<th id="lth">수령일자</th>
					<th id="lth">주소</th>
				</tr>
				<tr id="ltr">
					<c:set var="type" value="${oCon.o_type}"/>
					<c:set var="rdate" value="${oCon.o_rdate}"/>
					<c:choose>
					<c:when test="${fn:contains(type,'픽업')}">
						<td id="ltd" colspan="4">
							픽업 수령일자 : ${fn:substring(rdate,0,10)} ${fn:substring(rdate,11,16)}<br>
							주문자 상세보기 : <a href="./aa_mcontents?m_id=${oCon.o_mid}">${oCon.o_mid}</a>
						</td>
					</c:when>
					<c:otherwise>
						<td id="ltd" width="5%">${oCon.o_rec}</td>
						<td id="ltd" width="10%">${oCon.o_phone}</td>
						<td id="ltd" width="5%">${fn:substring(rdate,0,10)} ${fn:substring(rdate,11,16)}</td>
						<td id="ltd" width="15%">
								${oCon.o_addr1} ${oCon.o_addr2} ${oCon.o_addr3}
						</td>
					</c:otherwise>
					</c:choose>
				</tr>
			</table>
			<br>
			<a style="margin-top:15px; background-color:#bebebe;">배달정보</a>
			<table id="olist" width="50%">
				<tr id="ltr">
					<th id="lth">라이더</th>
					<th id="lth">전화번호</th>
					<th id="lth">보험</th>
					<th id="lth">주소</th>
				</tr>
				<tr id="ltr">
					<c:choose>
					<c:when test="${fn:contains(type,'픽업')}">
						<td id="ltd" colspan="4">
							픽업 주문 건입니다!
						</td>
					</c:when>
					<c:otherwise>
					<c:if test="${empty oCon.r_name}">
						<td id="ltd" colspan="4">
							라이더가 배달 접수 전입니다!
							<img src="resources/images/rider.png" style="width:30px; vertical-align:middle;">
						</td>
					</c:if>
					<c:if test="${!empty oCon.r_name}">
						<td id="ltd" width="5%">
							${oCon.r_name} (${oCon.o_rnum})
						</td>
						<td id="ltd" width="10%">${oCon.r_phone}</td>
						<td id="ltd" width="5%">${oCon.r_insurance}</td>
						<td id="ltd" width="15%">
							${oCon.r_addr1} ${oCon.r_addr2} ${oCon.r_addr3}
						</td>
					</c:if>
					</c:otherwise>
					</c:choose>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>