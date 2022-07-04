<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배송요청 상세보기 및 확인</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="resources/css/adminStyle2.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2cfb9b397d35123ced4bbaaee9d33325&libraries=services"></script>
</head>
<script type="text/javascript">
	$(function() {
		//메시지 출력 부분
		var msg = "${msg}";
		if (msg != "") {
			alert(msg);
		}

	});
</script>

<style type="text/css">
.table_area {
	width: 840px;
	height: 500px;
	margin: auto;
	background-color: #FAFAFA;
	padding-top: 20px;
	padding-bottom: 20px;
	border: 2px solid;
	border-color: #e6e6e6;
	border-radius: 5px;
	margin-bottom: 40px;
}
.content_area {
	text-align: center;
}
.content_area h2 {
	margin-top: 40px;
	margin-bottom: 40px;
}
table {
	border-spacing: 0 15px;
	text-align: center;
}

.amc1 {
	border-collapse: separate;
	border-spacing: 0 20px;
}

.amc2 {
	margin-top: 15px;
}

.ambtn1 {
	margin: 10px;
	float: right;
}

th {
	background-color: #d2d2d2;
	border-radius: 5px;
}

td {
	border-spacing: 50px;
	border: none;
	outline: none;
}

#spacetd {
	width: 200px;
}

hr {
	width: 46%;
	margin-top: 20px;
	margin-bottom: 20px;
	color: #dcdcdc;
}

.category {
	text-align: right;
	padding-right: 20px;
}

input[type=text] {
	width: 250px;
	text-align: center;
	border: none;
	outline: none;
	background-color: #f0f0f0;
	border-radius: 5px;
	text-align: left;
	padding-left: 10px;
}

.category_1 {
	padding-left: 8px;
}

#addr {
	width: 610px;
}

ul {
	list-style: none;
}

#map {
	margin: auto;
	margin-top: 30px;
	margin-bottom: 30px;
	border: 2px solid;
	border-color: gray;
}

.dc_btn {
	margin-top: 40px;
	margin-bottom: 30px;
}

.btn2 {
	width: 100px;
	height: 40px;
	border: none;
	outline: none;
	border-radius: 3px;
	margin-right: 10px;
}
.btn2:hover {
	background-color: #d9f9dc;
}

#p_img {
	height: 72px;
}
footer {
	margin-top: 60px;
}
</style>
<body>
	<header>
		<jsp:include page="r_header.jsp" />
	</header>

	<div class="tab_wrap tab_area">
		<div class="btn_area clearfix">
			<button class="btn btn_tab" onclick="location.href='./r_main'">배송관리</button>
			<button class="btn btn_tab act" onclick="location.href='./r_dList'">배송이력</button>
			<button class="btn btn_tab" onclick="location.href='./r_modify'">마이페이지</button>
		</div>
		
		<div class="content_area">
			
				<h2>배달 상세 정보</h2>
				<div class="table_area">
					<table class="amc1">
						<tr>
							<td class="category">주문번호&nbsp;</td>
							<td><input type="text" name="o_onum" value="${olist.o_num}" readonly>
							<td class="category">주문일자&nbsp;</td>
							<td><input type="text" value="${olist.o_date}" readonly></td>
						</tr>
						<tr>
							<td class="category">전화번호&nbsp;</td>
							<td><input type="text" value="${olist.o_phone}" readonly></td>
							<td class="category">수령인이름&nbsp;</td>
							<td><input type="text" value="${olist.o_rec}" readonly></td>
						</tr>
						<tr>
							<td class="category">주소&nbsp;</td>
							<td class="category_1" colspan="3"><input type="text" id="addr" value="${olist.o_addr1}&nbsp; ${olist.o_addr2}&nbsp; ${olist.o_addr3}" readonly></td>
						</tr>
						<c:forEach var="odlist" items="${odlist}">
						<tr>
							<td rowspan="2" class="category">상품이름&nbsp;</td>
							<td rowspan="2">
								<img src="resources/upload/${odlist.pf_sysname}" style="width:69px; vertical-align:middle;">
								<input id="p_img" type="text" value="${odlist.od_pname}" readonly>
							</td>
							<td class="category">상품가격&nbsp;</td>
							<td><input id="p_price" type="text" value="<fmt:formatNumber value="${odlist.od_price}" pattern="###,###"/>" readonly></td>
						</tr>
						<tr>
							<td class="category">주문수량&nbsp;</td>
							<td colspan="3"><input type="text" value="${odlist.od_count}" readonly></td>
							
						</tr>
						</c:forEach>
					</table>
				</div>
				<div class="dc_btn">
					<input class="btn2" type="button" value="뒤로가기" onclick="history.back(-1);">
				</div>
			<div id="map" style="width:1000px;height:400px;"></div>
		</div>
	</div>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.4388938204128, 126.675113024566), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

var gaddr = "${olist.o_addr2}"

// 주소로 좌표를 검색합니다
geocoder.addressSearch(gaddr, function(result, status) {

    // 정상적으로 검색이 완료됐으면 
     if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;">여기에요!</div>'
        });
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    } 
});    
</script>
</body>
</html>