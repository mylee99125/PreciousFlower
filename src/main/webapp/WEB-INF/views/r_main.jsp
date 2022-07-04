<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>배송 리스트</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="resources/css/riderStyle.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2cfb9b397d35123ced4bbaaee9d33325"></script>
</head>
<script type="text/javascript">
	$(function() {
		$("#search").click(
				function() {
					var keyword = $("#keyword").val();
					if (keyword == "") {
						alert("검색할 내용을 입력해주세요.");
						return;
					}

					var select = $("#sel").val();
					console.log(select, keyword);
					location.href = "./rlist?colname=" + select + "&keyword="
							+ keyword + "&pageNum=1";
				});
	});
</script>
<style type="text/css">
table {
	border: 2px solid;
	border-left: none;
	border-right: none;
	border-color: #6e6e6e;
	border-collapse: collapse;
	margin-top: 10px;
	margin-bottom: 30px;
}

th {
	width: 600px;
	background-color: #d9f9dc;
	border-bottom: 2px solid;
	border-bottom-color: #6e6e6e;
}

tr {
	text-align: center;
	border-bottom: 1px solid;
	border-bottom-color: #d2d2d2;
}

td {
	height: 50px;
}

th, td {
	padding: 8px;
}

#ono {
	width: 200px;
}

#pcode {
	width: 200px;
}

#ordate {
	width: 10%;
}

#ocount {
	width: 200px;
}

#oaddress {
	width: 30%;
}

#aview {
	width: 200px;
}

.bottom {
	margin-left: 10px;
	margin-top: 15px;
}

.search-area {
	margin-top: 20px;
	position: relative;
	right: 320px;
}

.content_area {
	text-align: center;
}

.content_area>h2 {
	margin-top: 40px;
}

#map {
	margin: auto;
	margin-top: 50px;
	border: 2px solid;
	border-color: gray;
}

.paging {
	position: static;
}

#sel {
	height: 33px;
	width: 100px;
}

#keyword {
	height: 33px;
}

#search {
	border: none;
	border-radius: 3px;
	outline: none;
	height: 33px;
	width: 60px;
}

#search:hover {
	background-color: #d9f9dc;
}
#rmtable {
	margin-top: 15px;
}
</style>

<body>
	<header>
		<jsp:include page="r_header.jsp" />
	</header>
	<div class="tab_wrap tab_area">
		<div class="btn_area clearfix">
			<button class="btn btn_tab act" onclick="location.href='./r_main'">배송관리</button>
			<button class="btn btn_tab" onclick="location.href='./r_dList'">배송이력</button>
			<button class="btn btn_tab" onclick="location.href='./r_modify'">마이페이지</button>
		</div>

		<!-- 배송 요청 리스트 -->

		<div class="content_area">
			<h2>배송 리스트</h2>
			
			<!-- 우측 상단 검색창 -->
			<div class="search-area">
				<select id="sel">
					<option value="o_addr2" selected>주소</option>
					<option value="o_pcode">상품코드</option>
				</select> <input type="text" id="keyword" placeholder="Search">
				<button id="search">검색</button>
			</div>
			<table id="rmtable">
				<tr>
					<th id="ono">주문번호</th>
					<th id="ordate">수령일자</th>
					<th id="pcode">수령인</th>
					<th id="ocount">수령인 전화번호</th>
					<th id="oaddress">수령인 주소</th>
					<!-- 시간 넣을지 고려 -->
				</tr>
				<!-- 임시데이터 
				<tr>
					<td><a href="./r_contents">202206231734</a></td>
					<td>PL001</td>
					<td>1</td>
					<td><a href="./r_contents">22554 인천 동구 미추홀구 참외전로326, 한아름아파트 102동 203호</a></td>
				</tr> -->
				<c:if test="${empty rList}">
					<tr>
						<td colspan="5"><label style="width: 100%">현재 배달 주문이 없습니다.</label></td>
					</tr>
				</c:if>
				<c:if test="${!empty rList}">
					<c:forEach var="ritem" items="${rList}">
					<c:set var="rdate" value="${ritem.o_rdate}"/>
						<tr>
							<td><a href="./r_contents?onum=${ritem.o_num}">${ritem.o_num}</a></td>
							<td>${fn:substring(rdate,0,10)} ${fn:substring(rdate,11,16)}</td>
							<td>${ritem.o_rec}</td>
							<td>${ritem.o_phone}</td>
							<td>${ritem.o_addr1} ${ritem.o_addr2} ${ritem.o_addr3} </td>
						</tr>
					</c:forEach>
				</c:if>
			</table>

			<!-- 페이징 처리 버튼 -->
			<div class="paging" style="text-align: center;">${ridingpaging}</div>

			<!-- 지도 작성 -->
			<div id="map" style="width: 1100px; height: 600px;"></div>

			<br> <br>
		</div>
	</div>
</body>
<script type="text/javascript">
<!-- 지도 작성 api -->
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = {
		center : new kakao.maps.LatLng(37.4388938204128, 126.675113024566), // 지도의 중심좌표
		level : 3
	// 지도의 확대 레벨
	};

	//지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption);

	//주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();

	//주소로 좌표를 검색합니다
	geocoder
			.addressSearch(
					'인천광역시 미추홀구 매소홀로488번길 6-32',
					function(result, status) {

						// 정상적으로 검색이 완료됐으면 
						if (status === kakao.maps.services.Status.OK) {

							var coords = new kakao.maps.LatLng(result[0].y,
									result[0].x);

							// 결과값으로 받은 위치를 마커로 표시합니다
							var marker = new kakao.maps.Marker({
								map : map,
								position : coords
							});

							// 인포윈도우로 장소에 대한 설명을 표시합니다
							var infowindow = new kakao.maps.InfoWindow(
									{
										content : '<div style="width:150px;text-align:center;padding:6px 0;">우리가게</div>'
									});
							infowindow.open(map, marker);

							// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
							map.setCenter(coords);
						}
					});
</script>
</html>



