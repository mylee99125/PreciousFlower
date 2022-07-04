<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>라이더 회원 정보</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="resources/css/adminStyle.css">
<script type="text/javascript">
$(function(){
	//메시지 출력 부분
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
});
</script>
<style type="text/css">
table{
	border-spacing: 0 15px;
	text-align: center;
}
.armc2{
	margin-top: 15px;
}

.armbtn1 {
	margin: 10px;
	float: right;
	border: none;
	outline: none;
	border-radius: 3px;
	width: 110px;
	height: 40px;
	cursor: pointer;
}

.armbtn1:hover {
	background-color: #6e6e6e;
	color: white;
}

th {
	background-color: #d2d2d2;
	border-radius: 5px;
}

td {
	border-spacing: 50px;
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

input {
	width: 250px;
	text-align: center;
}

ul {
	list-style: none;
}
.rminfo_title, .dl_title {
	margin-top: 15px;
}
</style>
</head>
<body>
	<header>
		<jsp:include page="aa_aheader.jsp"/>
	</header>
	
	<div class="tab_wrap tab_area">
		<div class="btn_area clearfix">
			<button class="btn btn_tab" onclick="location.href='./aa_main'">Home</button>
			<button class="btn btn_tab act" onclick="location.href='./aa_mlist'">회원관리</button>
			<button class="btn btn_tab" onclick="location.href='./aa_olist'">주문관리</button>
			<button class="btn btn_tab" onclick="location.href='./aa_plist'">상품관리</button>
			<button class="btn btn_tab" onclick="location.href='./aa_notice'">게시글관리</button>
		</div>
		
		<div class="content_area">
			<div class="rminfo_title">
				<h3>[라이더 회원 상세 정보]</h3>
			</div>
			<table class="armc1">
	   	 		<tr>
	   	 			<td>아이디&nbsp;</td>
	   	 			<td><input type="text" value="${rmember.r_id}" disabled></td>
	   	 			<td id="spacetd"></td>
	   	 			<td>우편번호&nbsp;</td>
	   	 			<td><input type="text" value="${rmember.r_addr1}" disabled></td>
	   	 		</tr>
	   	 		<tr>
	   	 			<td>성명&nbsp;</td>
	   	 			<td><input type="text" value="${rmember.r_name}" disabled></td>
	   	 			<td></td>
	   	 			<td>주소&nbsp;</td>
	   	 			<td><input type="text" value="${rmember.r_addr2}" disabled></td>
	   	 		</tr>
	   	 		<tr>
					<td>생년월일&nbsp;</td>
					<td><input type="date" value="${rmember.r_birth}" disabled></td>
					<td></td>
					<td>상세주소&nbsp;</td>
					<td><input type="text" value="${rmember.r_addr3}" disabled></td>
				</tr>
				<tr>			
					<td>전화번호&nbsp;</td>
					<td><input type="text" value="${rmember.r_phone}" disabled></td>
					<td></td>
					<td>이메일&nbsp;</td>
					<td><input type="text" value="${rmember.r_email}" disabled></td>
				</tr>
				<tr>
					<td>보험&nbsp;</td>
					<td><input type="text" value="${rmember.r_insurance}" disabled></td>
					<td></td>
					<td>등급</td>
					<td><input type="text" value="${rmember.g_name}" disabled></td>
				</tr>
			</table>
			<div class="dl_title">
				<h3>[라이더 배송 이력]</h3>
			</div>
			<table class="armc2" >
	    		<c:if test="${empty oList}">
					<tr id="ltr">
						<td colspan="4">
							<label style="width: 100%">배송 이력이 없습니다.</label>
						</td>
					</tr>
				</c:if>
				<c:if test="${!empty oList}">
					<c:forEach var="o" items="${oList}">
						<tr id="ltr">
							<td>주문번호&nbsp;</td>
							<td align="center" width="250"><a href="./aa_ocontents?o_num=${o.o_num}"> ${o.o_num} </a></td>
							<td id="spacetd"></td>
							<td>주문일자&nbsp; <input type="text" value="${o.o_date}" disabled></td>
						</tr>
					</c:forEach>
				</c:if>
			</table>
		</div>
		<button class=armbtn1 type="button" onclick="rmbackbtn();">목록</button>
		<button class=armbtn1 id="rmdel" onclick="rmemDelete('${rmember.r_id}')">회원정보 삭제</button>
	</div>
		
</body>
<script type="text/javascript">
function rmemDelete(r_id){
	var conf = confirm("'${rmember.r_name}'회원을 삭제하시겠습니까?");
	
	if(conf == true){
		location.href="./rmemberDelete?r_id=" + r_id;
		alert("'${rmember.r_name}'회원이 삭제되었습니다.");
	}
}


function rmbackbtn(){
	var urlstr = "./rmlist?";
	var col = "${rmlist.rmcolname}";
	var key = "${rmlist.rmkeyword}";
	
	if(col == null || col == ""){ //검색 x
		urlstr += "rmpageNum=${rmpageNum}";
	}
	else { //검색 o
		urlstr += "rmcolname=${rmlist.rmcolname}&rmkeyword=${rmlist.rmkeyword}"
				+ "&rmpageNum=${rmpageNum}";
	}
	console.log(urlstr);
	
	location.href = urlstr;
}
</script>
</html>