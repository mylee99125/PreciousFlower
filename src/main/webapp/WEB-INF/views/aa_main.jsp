<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자-메인</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<link rel="short icon" href="#">
<link rel="stylesheet" href="resources/css/adminStyle.css">
<script type="text/javascript">
$(function(){
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
	
	//Date 생성
	var now = moment().format('YYYY-MM-DD');
	var oDayAgo = moment().subtract(1, 'day').format('YYYY-MM-DD');
	var tDayAgo = moment().subtract(2, 'day').format('YYYY-MM-DD');
	var thDayAgo = moment().subtract(3, 'day').format('YYYY-MM-DD');
	var fDayAgo = moment().subtract(4, 'day').format('YYYY-MM-DD');
	var fiDayAgo = moment().subtract(5, 'day').format('YYYY-MM-DD');
	
	//chart
	var larr = [fiDayAgo, fDayAgo, thDayAgo, tDayAgo, oDayAgo, now];
	var varr = [${fibdTotal}, ${fbdTotal}, ${thbdTotal}, ${tbdTotal}, ${obdTotal}, ${tTotal}];
	new Chart(document.getElementById("bar-chart"), {
	    type: 'bar',
	    data: {
	      labels: larr,
	      datasets: [
	        {
	          label: "월별 판매량",
	          backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850","#ff0000"],
	          data: varr
	        }
	      ]
	    },
	    options: {
	      responsive: false,
	      legend: { display: false },
	      title: {
	        display: true,
	        text: '매출현황 (최근 6일)'
	      }
	    }
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
			<button class="btn btn_tab act" onclick="location.href='./aa_main'">Home</button>
			<button class="btn btn_tab" onclick="location.href='./aa_mlist'">회원관리</button>
			<button class="btn btn_tab" onclick="location.href='./aa_olist'">주문관리</button>
			<button class="btn btn_tab" onclick="location.href='./aa_plist'">상품관리</button>
			<button class="btn btn_tab" onclick="location.href='./aa_notice'">게시글관리</button>
		</div>
		<div class="content_area">
			<h3>[Dashboard]</h3>
			<p>전체 방문자 수 : ${vTotal}</p>
			<canvas id="bar-chart" width="1000" height="650"></canvas>
		</div>
	</div>
</body>
</html>