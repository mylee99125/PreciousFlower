<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="resources/css/riderStyle.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style type="text/css">
.top-left {
	float: left;
	margin-left: 10px;
}
</style>

<!-- Header -->
<div class="top-left">
	<h4><a href="./" target="_blank" style="color:black;">Home</a></h4>
</div>

<div class="top-bar">
<c:if test="${!empty rb.r_name}">
<a>
	<c:choose>
	<c:when test="${rb.g_name == '씨앗'}"><img src="resources/images/grade1.png" style="width:20px;"></c:when>
	<c:when test="${rb.g_name == '새싹'}"><img src="resources/images/grade2.png" style="width:20px;"></c:when>
	<c:when test="${rb.g_name == '꽃'}"><img src="resources/images/grade3.png" style="width:20px;"></c:when>
	<c:when test="${rb.g_name == '열매'}"><img src="resources/images/grade4.png" style="width:20px;"></c:when>
	<c:otherwise>&nbsp;</c:otherwise>
	</c:choose>
</a>
	<a>${rb.r_name}</a>라이더님 환영합니다! |
	 <a href="./rlogout" style="color:black;">[LOGOUT]</a>
</c:if>	 
</div>
<!-- Close Header -->
