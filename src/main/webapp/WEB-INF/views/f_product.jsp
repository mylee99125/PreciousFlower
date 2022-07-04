<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <title>Precious Flower - Product Listing Page</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="apple-touch-icon" href="resources/img/apple-icon.png">
    <link rel="shortcut icon" type="image/x-icon" href="resources/images/logo.png">

    <link rel="stylesheet" href="resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/templatemo.css">
    <link rel="stylesheet" href="resources/css/custom.css">

    <!-- Load fonts style after rendering the layout styles -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;200;300;400;500;700;900&display=swap">
    <link rel="stylesheet" href="resources/css/fontawesome.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
});
</script>
</head>

<body>
  	<header>
	<jsp:include page="header.jsp"/>
	</header>

    <!-- Start Content -->
    <div class="container py-5">
        <div class="row">
            <div class="col-lg-3">
                <h1 class="h2 pb-4">Categories</h1>
                <ul class="list-unstyled templatemo-accordion">
                    <li class="pb-3">
                        <a class="collapsed d-flex justify-content-between h4 text-decoration-none" href="./f_product?codestr=BO">
                            꽃다발
                        </a>
                    </li>
                    <li class="pb-3">
                        <a class="collapsed d-flex justify-content-between h4 text-decoration-none" href="./f_product?codestr=BA">
                            꽃바구니
                        </a>
                    </li>
                    <li class="pb-3">
                        <a class="collapsed d-flex justify-content-between h4 text-decoration-none" href="./f_product?codestr=PL">
                            화분
                        </a>
                    </li>
                </ul>
            </div>
			<!-- 정렬 -->
            <div class="col-lg-9">
                <!-- 상품목록 시작 -->
                <div class="row">
                <c:if test="${empty pList}">
               		등록된 상품이 없습니다.
                </c:if>
                <c:if test="${!empty pList}">
                <c:forEach var="p" items="${pList}">
                    <div class="col-md-4">
                        <div class="card mb-4 product-wap rounded-0">
                            <div class="card rounded-0">
                            	<a href="./f_contents?p_code=${p.p_code}">
	                                <img class="card-img rounded-0 img-fluid" src="resources/upload/${p.pf_sysname}">
                            	</a>
                                    	<!--  
                                <div class="card-img-overlay rounded-0 product-overlay d-flex align-items-center justify-content-center">
                                    <ul class="list-unstyled">
                                        <li><a class="btn btn-success text-white" href="shop-single.html"><i class="far fa-heart"></i></a></li>
                                        <li><a class="btn btn-success text-white mt-2" href="shop-single.html"><i class="far fa-eye"></i></a></li>
                                        <li><a class="btn btn-success text-white mt-2" href="shop-single.html"><i class="fas fa-cart-plus"></i></a></li>
                                    </ul>
                                </div>
                                        -->
                            </div>
                            <div class="card-body">
                            	<div style="text-align:center;">
                                	<a href="./f_contents?p_code=${p.p_code}" class="h3 text-decoration-none">${p.p_name}</a>
                                </div>
                                <!-- 
                                <ul class="list-unstyled d-flex justify-content-center mb-1">
                                    <li>
                                        <i class="text-warning fa fa-star"></i>
                                        <i class="text-warning fa fa-star"></i>
                                        <i class="text-warning fa fa-star"></i>
                                        <i class="text-muted fa fa-star"></i>
                                        <i class="text-muted fa fa-star"></i>
                                    </li>
                                </ul>
                                -->
                                <p class="text-center mb-0"><fmt:formatNumber value="${p.p_price}" pattern="###,###"/>원</p>
                            </div>
                        </div>
                    </div>
                    </c:forEach>
                    </c:if>
                    </div>
                <!-- 페이징 -->
                <div class="row">
                    <ul class="pagination pagination-lg justify-content-end">
                    	${ppaging}                        
                    </ul>
                </div>
            </div>

        </div>
    </div>
    <!-- End Content -->

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