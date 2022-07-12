<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">

<head>
    <title>Precious Flower - About Us</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="apple-touch-icon" href="resources/img/apple-icon.png">
    <link rel="shortcut icon" type="image/x-icon"
	href="resources/images/favicon.png">

    <link rel="stylesheet" href="resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/templatemo.css">
    <link rel="stylesheet" href="resources/css/custom.css">

    <!-- Load fonts style after rendering the layout styles -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;200;300;400;500;700;900&display=swap">
    <link rel="stylesheet" href="resources/css/fontawesome.min.css">
    
<style type="text/css">
.h1about {
	padding-top: 80px;
	margin-bottom: 10px;
	text-align:center;
}
.h1p {
	text-align:center;
	margin-bottom: 30px;
}
.pabout {
	color: white;
	text-align: center;
}
.abgimage{
    background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.55)),url("/resources/images/gardening.jpg");
    background-size: 100%;
    width: 100%;
    height: 500px;
}
.abcon {
	align: center;
	padding-top: 100px;
}
#map {
	margin-left: 150px;
}
#mapd {
	height: 100px;
}
#aboutdiv {
	background-image: linear-gradient(to top, #d5dee7 0%, #ffafbd 0%, #c9ffbf 100%);
}
</style>
</head>

<body>
 	<header>
	<jsp:include page="header.jsp"/>
	</header>

    <!-- Modal -->
    <div class="modal fade bg-white" id="templatemo_search" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="w-100 pt-1 mb-5 text-right">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="" method="get" class="modal-content modal-body border-0 p-0">
                <div class="input-group mb-2">
                    <input type="text" class="form-control" id="inputModalSearch" name="q" placeholder="Search ...">
                    <button type="submit" class="input-group-text bg-success text-light">
                        <i class="fa fa-fw fa-search text-white"></i>
                    </button>
                </div>
            </form>
        </div>
    </div>


	<!-- Start Banner -->
  	<div class="abgimage">
        <div class="container">
                <div class="abcon">
                    <h1 class="pabout">Who We Are</h1>
                    <h4 class="pabout">
                        우리 모두가, 세상에서 가장 귀하고 소중한 꽃이 되었으면 좋겠습니다.
                    </h4><br>
                    <p class="pabout"><img src="resources/images/leaf.png" style="width:50px;">&nbsp;&nbsp;획일화된 꽃 가격과 구성을 탈피하여, 다양한 만족과 행복으로 보답하겠습니다.</p>
                    <p class="pabout"><img src="resources/images/leaf.png" style="width:50px;">&nbsp;&nbsp;꽃을 처음 접하는 고객에게도 어렵지 않고, 보기 쉬운 사이트를 구성하겠습니다.</p>
                    <p class="pabout"><img src="resources/images/leaf.png" style="width:50px;">&nbsp;&nbsp;내부 배달 시스템 구축을 통해, 보다 저렴한 가격으로 다가가겠습니다.</p>
                </div>
        </div>
    </div>
    <!-- Close Banner -->
    
    <!-- Map start -->
    <div id="aboutdiv">
   	<h1 class="h1about">Shop Locations</h1><br>
    <div class="mapd">
    	<div id="map" style="width:40%;height:360px;display:inline-block;"></div>
    	<div id="location" style="display:inline-block;margin-left:40px;">
	    	<p>주소 : 인천광역시 미추홀구 매소홀로488번길 6-32 4층 404호</p><br>
    		<h4>오시는 길</h4>
    		<p>
    			<img src="resources/images/bus.png" style="width:50px;padding-right:10px;padding-bottom:10px;">영남아파트(4, 5), 신동아3차아파트(65, 65-1, 58)<br>
    			<img src="resources/images/train.png" style="width:50px;padding-right:10px;padding-bottom:5px;">문학경기장역(인천1호선), 주안역(1호선, 인천2호선)
    		</p><br>
    		<h4>근처 맛집 추천</h4>
    		<p>
    			<img src="resources/images/meat.png" style="width:50px;padding-right:10px;padding-bottom:5px;">육심 학익점<br>
    			14시 이전에 2인 이상 가면, 인당 8천원에 맛있는 고기와 공기밥, 된장찌개를 먹을 수 있어요!
    		</p>
    	</div>
	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f7679f2adf74d1f1df693ed5797ec776&libraries=services"></script>
	<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  
	
	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	
	// 주소로 좌표를 검색합니다
	geocoder.addressSearch('인천광역시 미추홀구 매소홀로488번길 6-32', 
	function(result, status) {
	
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
	            content: '<div style="width:150px;text-align:center;padding:6px 0;">Precious Flower</div>'
	        });
	        infowindow.open(map, marker);
	
	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	    } 
	});    
	</script>
	</div>
	<!-- Map end -->

    <!-- Start Section -->
    <section class="container py-5">
        <div class="row text-center pt-5 pb-3">
            <div class="col-lg-6 m-auto">
                <h1 class="h1ser">Our Services</h1>
            </div>
        </div>
        <div class="row">

            <div class="col-md-6 col-lg-3 pb-5">
                <div class="h-100 py-5 services-icon-wap shadow">
                    <div class="h1 text-success text-center"><i class="fa fa-truck fa-lg"></i></div>
                    <h2 class="h5 mt-4 text-center">배달 서비스</h2>
                </div>
            </div>

            <div class="col-md-6 col-lg-3 pb-5">
                <div class="h-100 py-5 services-icon-wap shadow">
                    <div class="h1 text-success text-center"><i class="fas fa-exchange-alt"></i></div>
                    <h2 class="h5 mt-4 text-center">유연한 고객과의 소통</h2>
                </div>
            </div>

            <div class="col-md-6 col-lg-3 pb-5">
                <div class="h-100 py-5 services-icon-wap shadow">
                    <div class="h1 text-success text-center"><i class="fa fa-percent"></i></div>
                    <h2 class="h5 mt-4 text-center">프로모션(진행예정)</h2>
                </div>
            </div>

            <div class="col-md-6 col-lg-3 pb-5">
                <div class="h-100 py-5 services-icon-wap shadow">
                    <div class="h1 text-success text-center"><i class="fa fa-user"></i></div>
                    <h2 class="h5 mt-4 text-center">24시간 문의 가능</h2>
                </div>
            </div>
        </div>
    </section>
    </div>
    <!-- End Section -->

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