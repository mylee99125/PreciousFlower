<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="ko">

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="apple-touch-icon" href="./resources/img/apple-icon.png">
<link rel="shortcut icon" type="image/x-icon" href="resources/images/logo.png">

<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<link rel="stylesheet" href="./resources/css/templatemo.css">
<link rel="stylesheet" href="./resources/css/custom.css">

<!-- Load fonts style after rendering the layout styles -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;200;300;400;500;700;900&display=swap">
<link rel="stylesheet" href="./resources/css/fontawesome.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style type="text/css">
.hmenu:link {
	color: white;
}
.hmenu:visited {
	color: white;
}
</style>

	<!-- Start Top Nav -->
	<nav
		class="navbar navbar-expand-lg bg-dark navbar-light d-none d-lg-block"
		id="templatemo_nav_top">
		<div class="container text-light">
			<div class="w-100 d-flex justify-content-between">
				<div class="lheader">
					<i class="fa fa-envelope mx-2"></i> <a
						class="navbar-sm-brand text-light text-decoration-none"
						href="mailto:info@preciousflower.com">info@preciousflower.com</a> <i
						class="fa fa-phone mx-2"></i> <a
						class="navbar-sm-brand text-light text-decoration-none"
						href="tel:010-1111-2222">010-1111-2222</a>
				</div>
				<div class="rheader">
					<c:if test="${empty mb.m_name}">
						<a class="hmenu" href="./login">LOGIN</a> | 
						<a class="hmenu" href="./join">JOIN</a>
					</c:if>
					<c:if test="${!empty mb.m_name}">
					<a>
						<c:choose>
						<c:when test="${mb.g_name == '씨앗'}"><img src="resources/images/grade1.png" style="width:20px;"></c:when>
						<c:when test="${mb.g_name == '새싹'}"><img src="resources/images/grade2.png" style="width:20px;"></c:when>
						<c:when test="${mb.g_name == '꽃'}"><img src="resources/images/grade3.png" style="width:20px;"></c:when>
						<c:when test="${mb.g_name == '열매'}"><img src="resources/images/grade4.png" style="width:20px;"></c:when>
						<c:otherwise>&nbsp;</c:otherwise>
						</c:choose>
					</a>
					<a>${mb.m_name}님</a> | 
					<a class="hmenu" href="./logout">LOGOUT</a>
					</c:if>
				</div>
			</div>
		</div>
	</nav>
	<!-- Close Top Nav -->


	<!-- Header -->
	<nav class="navbar navbar-expand-lg navbar-light shadow">
		<div
			class="container d-flex justify-content-between align-items-center">

			<a href="./">
				<img src="resources/images/logo_white.png" width=150>
			</a>

			<button class="navbar-toggler border-0" type="button"
				data-bs-toggle="collapse" data-bs-target="#templatemo_main_nav"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div
				class="align-self-center collapse navbar-collapse flex-fill  d-lg-flex justify-content-lg-between"
				id="templatemo_hmain_nav">
				<div class="flex-fill">
					<ul
						class="nav navbar-nav d-flex justify-content-between mx-lg-auto">
						<li class="nav-item"><a class="nav-link" href="./about">About Us</a>
						</li>
						<li class="nav-item"><a class="nav-link" href="./f_product">Flower</a>
						</li>
						<li class="nav-item"><a class="nav-link" href="./daycount">Day Counter</a>
						</li>
						<li class="nav-item"><a class="nav-link" href="./notice">Notice</a>
						</li>
					</ul>
				</div>
				<div class="navbar align-self-center d-flex">
					<a class="nav-icon position-relative text-decoration-none"
						href="/cart"> 
						<i class="fa fa-fw fa-cart-arrow-down text-white mr-1"></i> </a>
						<div class="hdropdown">
						<span class="hdropbtn"> 
							<i class="fa fa-fw fa-user text-white mr-3"></i>
						</span>
						<div class="hdropdown-content">
							<a href="./mypage?m_id=${mb.m_id}">MyPage</a> 
							<a href="./orderList">OrderList</a>
						</div>
					</div>
					</div>
					</div>
		</div>
	</nav>
	<!-- Close Header -->
	
	
	<!-- Start Script -->
	<script src="./resources/js/jquery-1.11.0.min.js"></script>
	<script src="./resources/js/jquery-migrate-1.2.1.min.js"></script>
	<script src="./resources/js/bootstrap.bundle.min.js"></script>
	<script src="./resources/js/custom.js"></script>
	<!-- End Script -->

