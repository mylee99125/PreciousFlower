<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>배송 리스트</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="resources/css/riderStyle.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<script type="text/javascript">
	$(function() {
		var msg = "${msg}";
		if (msg != "") {
			alert(msg);
		}

		$("#rosearch").click(
				function() {
					var rokeyword = $("#rokeyword").val();
					if (rokeyword == "") {
						alert("검색할 내용을 입력해주세요.");
						return;
					}

					var select = $("#rosel").val();
					console.log(select, rokeyword);
					location.href = "./rolist?rocolname=" + select
							+ "&rokeyword=" + rokeyword + "&ropageNum=1";
				});

		$("#rsel").on("change", function() {
			console.log("변경~~");
			var elm = $(this).next();
			var v = $(this).val();
			elm.val(v);
		});

		var b = $("#rbtn");
		console.log(b);
		$(document).on(
				"click",
				"#rbtn",
				function() {
					var idx = $(this).attr("r_data");
					//console.log(idx);
					var numValue = $("#num" + idx).text();
					console.log(numValue);
					var selValue = $("#rsel" + idx).val();
					console.log(selValue);
					if (selValue == "") {
						alert("상태변경 값을 선택하세요.");
						return;
					}

					location.href = "./rupdate?o_num=" + numValue
							+ "&o_status=" + selValue;
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
	width: 100%;
}

th {
	width: 600px;
	background-color: #d9f9dc;
	border-bottom: 2px solid;
	border-bottom-color: #6e6e6e;
	padding: 8px;
}

td {
	height: 10px;
	padding: 8px;
}

tr {
	text-align: center;
	border-bottom: 1px solid;
	border-bottom-color: #d2d2d2;
}

#o_no, #o_phone, #d_status {
	width: 150px;
}

#p_name, #o_date {
	width: 120px;
}

#o_rec {
	width: 100px;
}

#o_addr {
	width: 500px;
}

#d_status2 {
	width: 300px;
	padding-left: -8px;
}

.rsel_btn {
	width: 70px;
	height: 30px;
	border: none;
	outline: none;
	border-radius: 3px;
}
.rsel_btn:hover {
	background-color: #d9f9dc;
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
}
#rosel {
	height: 33px;
}

#rokeyword {
	height: 33px;
	padding-left: 10px;
}

#rosearch {
	border: none;
	border-radius: 3px;
	outline: none;
	height: 33px;
	width: 70px;
}

#rosearch:hover {
	background-color: #d9f9dc;
}

.content_area {
	text-align: center;
}

.content_area>h2 {
	margin-top: 40px;
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
		
		<!-- 배송 요청 리스트 -->
		<div class="content_area">
			<h2>배송 이력</h2>
			
			<!-- 우측 상단 검색창 -->
			<div class="search-area">
				<select id="rosel">
					<option value="o_rec" selected>수령인 이름</option>
					<option value="o_phone">수령인 전화번호</option>
				</select>
				<input type="text" id="rokeyword" placeholder="Search">
				<button id="rosearch">검색</button>
			</div>
			
			<form action="/rupdate" method="post">
				<table>
					<tr>
						<th id="o_no">주문 번호</th>
						<th id="o_date">배송확인 시간</th>
						<th id="o_rec">수령인 이름</th>
						<th id="o_phone">수령인 전화번호</th>
						<th id="o_addr">수령인 주소</th>
						<th id="d_status">배송 상태</th>
						<th id="d_status2">상태 변경</th>
						<!-- 시간 넣을지 고려 -->
					</tr>
					
										
					<c:if test="${empty roList}">
						<tr>
							<td colspan="8">
							<label style="width: 100%">배송이력이 없습니다.</label></td>
						</tr>
					</c:if>
					<c:if test="${!empty roList}">
						<c:forEach var="ro" items="${roList}" varStatus="status">
							<tr>
								<td width="10%"><a href="./r_lcontents?onum=${ro.o_num}"><span id="num${status.index}">${ro.o_num}</span></a></td>
								<td width="15%">${ro.ro_date}</td>
								<td width="8%">${ro.o_rec}</td>
								<td width="8%">${ro.o_phone}</td>
								<td width="20%">(${ro.o_addr1}) ${ro.o_addr2} ${ro.o_addr3}</td>
								<td width="10%">${ro.o_status}</td>
								<td width="15%"> 상태 변경 :
									<select id="rsel${status.index}" name="r_status">
										<option value="">======</option>
										<option value="픽업완료">픽업완료</option>
										<option value="배송중">배송중</option>
										<option value="배송완료">배송완료</option>
									</select>
									<button class="rsel_btn" id="rbtn" r_data="${status.index}" type="button" class="pibtn">저장</button>
								</td>
							</tr>
						</c:forEach>
					</c:if>
				</table>
				<!-- 페이징 처리 버튼 -->
				<div class="paging" style="text-align: center;">${RidingOpaging}</div>
			</form>
		</div>
	</div>
</body>
</html>