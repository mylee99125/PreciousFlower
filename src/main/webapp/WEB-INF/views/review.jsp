<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PF_Review</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style>
.write_re {
	text-align: center;
}

#re_title{
	text-align: center;
	margin-top: 50px;
	margin-bottom: 30px;
	font-weight: bold;
}

.re_product {
	width: 1000px;
	height: 180px;
	margin: auto;
	background-color: #FAFAFA;
	padding-top: 30px;
	border: 2px solid;
	border-color: #e6e6e6;
	border-radius: 5px;
	margin-bottom: 20px;
}

#re_prod {
	border: 1px solid;
	border-color: gray;
	margin: auto;
	margin-bottom: 30px;
	padding: 4px;
	width: 900px;
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

.write_form {
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

#myform fieldset{
    display: inline-block; /* 하위 별점 이미지들이 있는 영역만 자리를 차지함.*/
    direction: rtl;
    border: 0; /* 필드셋 테두리 제거 */
}
#myform fieldset legend{
    text-align: center;
}
#myform input[type=radio]{
    display: none; /* 라디오박스 감춤 */
}
#myform label{
    font-size: 10%; /* 이모지 크기 */
    color: transparent; /* 기존 이모지 컬러 제거 */
    text-shadow: 0 0 0 #dcdcdc; /* 새 이모지 색상 부여 */
}

#myform label:hover{
    text-shadow: 0 0 0 #fad037; /* 마우스 호버 */
}
#myform label:hover ~ label{
    text-shadow: 0 0 0 #fad037; /* 마우스 호버 뒤에오는 이모지들 */
}
#myform input[type=radio]:checked ~ label{
    text-shadow: 0 0 0 #fad037; /* 마우스 클릭 체크 */
}

#text_frm {
	height: 330px;
	width: 900px;
	resize: none;
	margin-top: 30px;
	padding-top: 20px;
	padding-left: 20px;
}

.re_bottom {
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

#re_button {
	margin: auto;
	width: 900px;
}
#blank {
	width: 700px;
}

#c, #write {
	width: 100px;
}

#re_btn {
	height: 40px;
	width: 70px;
	border: none;
	outline: none;
	border-radius: 3px;
}

#re_btn:hover {
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

	<div class="write_re">
		<h1 id="re_title">리뷰 작성</h1>
		
		<div class="re_product">
			<table id="re_prod">
				<tr>
					<td rowspan="2" id="o_picture"><img src="resources/upload/${fCon.pf_sysname}" style="width:120px;"></td>
					<td id="o_product">${fCon.p_name}</td>
					<td id="o_total">&#8361; <fmt:formatNumber value="${fCon.p_price}" pattern="###,###"/>원 </td>
				</tr>
				<tr>
					<td colspan="2" id="o_product2">${fCon.p_detail}</td>
				</tr>
			</table>
		</div>
		<form name="reivewform" id="myform" method="post" action="reviewWrite">
		<div class="write_form">
			
				<fieldset>
					<legend>별점 주기</legend>
						<input type="radio" name="re_score" value="5" id="rate5"><label for="rate5">⭐</label>
						<input type="radio" name="re_score" value="4" id="rate4"><label for="rate4">⭐</label>
						<input type="radio" name="re_score" value="3" id="rate3"><label for="rate3">⭐</label>
						<input type="radio" name="re_score" value="2" id="rate2"><label for="rate2">⭐</label>
						<input type="radio" name="re_score" value="1" id="rate1"><label for="rate1">⭐</label>
				</fieldset>
			
		
			<textarea id="text_frm" name="re_contents" placeholder="내용을 입력해 주세요."></textarea>
			
			<input type="hidden" name="re_pcode" value="${fCon.p_code}" >
			<input type="hidden" name="re_mid" value="${mb.m_id}" >
			
		</div>
		
		<div class="re_bottom">
			<table id="re_button">
				<tr>
					<td id="blank"></td>
					<td id="c"><button type="button" id="re_btn" onclick="location.href='./o_contents?od_onum=${mo.o_num}'">취소</button></td>
					<td id="write"><button type="submit" id="re_btn">작성</button></td>
				</tr>
			</table>
		</div>
		</form>
	</div>
	
	<footer class="foot">
		<jsp:include page="footer.jsp" />
	</footer>
</body>

</html>