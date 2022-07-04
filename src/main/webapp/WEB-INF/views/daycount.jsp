<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Zay Shop - DayCount Page</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="shortcut icon" type="image/x-icon" href="resources/img/favicon.ico">
</head>
<style>
#dayform {
	width: 1000px;
	height: 900px;
	padding: 20px 20px 50px 20px;
	text-align: center;
	margin: auto;
	margin-top: 20px;
	margin-bottom: 70px;
	border-radius: 10px;
}
#day-top {
	text-align: center;
}

#t_btn {
	border: 3px solid;
	border-radius: 8px;
	border-color: #fed0d1;
	background-color: transparent;
	outline: none;
	width: 200px;
	height: 40px;
}
#t_btn:hover {
	background: linear-gradient(#fff 40%, #fed0d1);
	color: #000;
	border: none;
}

#startDay {
	color: #ad2d4b;
}
#today {
	color: #ad2d4b;
	margin-bottom: 40px;
}

.days {
	display: inline-block;
	width: 120px;
	font-size: 2em;
	font-weight: bold;
	padding-left: 10px;
	line-height: 70px;
}

.days2 {
	display: inline-block;
	width: 250px;
	padding-left: 80px;
	text-align: center;
	line-height: 20px;
}

#top_day {
	border: 4px solid;
	border-radius: 10px;
	border-color: #fcdcdc;
	background: url("/resources/images/day_back4.png");
	width: 700px;
	height: 100px;
	margin: auto;
	margin-top: 30px;
	margin-bottom: 20px;
	text-align: center;
	padding-top: 25px;
}

#day_middle {
	border: 4px solid;
	border-radius: 10px;
	border-color: #fcdcdc;
	background: url("/resources/images/day_back3.png");
	width: 700px;
	height: 550px;
	margin: auto;
	margin-bottom: 20px;
	text-align: center;
	padding-top: 40px;
}

#top_day>input {
	margin-top: 10px;
	text-align: center;
	border-radius: 4px;
	outline: none;
	height: 40px;
}

#top_day h3 {
	background-color: rgb(250, 250, 250, 0.5);
}

input::placeholder {
	color: #5b9c56;
}

#inputday {
	border: 1px solid;
	border-color: #5b9c56;		
}

#input_btn {
	border: none;
	outline: none;
	background-color: #93d98d;
	width: 70px;
	height: 40px;
}

#input_btn:hover {
	background-color: #5b9c56;
	color: #ffffff;
}

#day_middle>ul {
	list-style: none;
	padding-left: 0px;
	margin-top: 16px;
}


#day_middle li {
	padding: 10px;
	background-color: rgb(250, 250, 250, 0.3);
	border-radius: 7px;
	vertical-align: middle;
}

#day_middle>h3 {
	margin: 4px;
	margin-bottom: 10px;
}
</style>

<body>
	<header>
	<jsp:include page="header.jsp"/>
	</header>
	
	<div id="dayform">
		<div id="day_top">
			<h2>D-DAY 계산기</h2>
			<div id="top_day">
				<button id="t_btn" type="button" onclick="getNowdate();">오늘 날짜 확인하기</button>
			</div>
		</div>
		<div id="day_middle">	
			<div id="startDay"></div>
			<div id="today"></div>
			<ul>
				<li>
					<span class="days">100일</span>
					<span class="days2">
						<div id="dday100"></div>
					</span>
				</li>
				<li>
					<span class="days">200일</span>
					<span class="days2">
						<div id="dday200"></div>
					</span>
				</li>
				<li>
					<span class="days">300일</span>
					<span class="days2">
						<div id="dday300"></div>
					</span>
				</li>
				<li>
					<span class="days">1년</span>
					<span class="days2">
						<div id="dday365"></div>
					</span>
				</li>
			</ul>
		</div>
	</div>
	
	<footer>
		<jsp:include page="footer.jsp"/>
	</footer>
	
<script type="text/javascript">
function getNowdate() {
	var date = new Date(); //현재 날짜,시각
	console.log(date);
	
	var year = date.getFullYear(); //년
	var month = date.getMonth() + 1; //월
	var day = date.getDate(); //일
	
	var today = "오늘 날짜는 " + year + "년 " + month + "월 " + day + "일 입니다.";
	
	var str = document.getElementById("top_day");
	str.innerHTML = "<h3>" + today + "</h3>";

};
</script>
<script src="${path}/resources/js/dday.js"></script>
</body>
</html>