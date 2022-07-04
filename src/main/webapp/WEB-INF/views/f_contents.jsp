<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<head>
<title>Precious Flower - Product Detail Page</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="apple-touch-icon" href="resources/img/apple-icon.png">
<link rel="shortcut icon" type="image/x-icon"
	href="resources/img/favicon.ico">

<link rel="stylesheet" href="resources/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/css/templatemo.css">
<link rel="stylesheet" href="resources/css/custom.css">

<!-- Load fonts style after rendering the layout styles -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;200;300;400;500;700;900&display=swap">
<link rel="stylesheet" href="resources/css/fontawesome.min.css">

<!-- Slick -->
<link rel="stylesheet" type="text/css"
	href="resources/css/slick.min.css">
<link rel="stylesheet" type="text/css"
	href="resources/css/slick-theme.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		var msg = "${msg}";
		if (msg != "") {
			alert(msg);
		}
	});
</script>
<style type="text/css">
#fclist {
	border: 2px solid;
	border-left: none;
	border-right: none;
	border-color: #AAEBAA;
	border-collapse: collapse;
	margin-top: 10px;
}
#fcth {
	width: 1%;
	background-color: #E6FFE6;
	border-bottom: 2px solid;
	border-bottom-color: #AAEBAA;
	font-size: 15px;
	padding: 8px;
}
#ltr {
	text-align: center;
	border-bottom: 1px solid;
	border-bottom-color: #d2d2d2;
}
#ltd {
	font-size: 13px;
	vertical-align: middle;
	padding: 8px;
}
</style>
</head>

<body>
  	<header>
	<jsp:include page="header.jsp"/>
	</header>

    <!-- Open Content -->
    <section class="bg-light">
        <div class="container pb-5">
            <br><h4>상품 상세</h4><hr>
            <div class="row">
                <div class="col-lg-5 mt-5">
                    <div class="card mb-3">
                        <img class="card-img img-fluid" src="resources/upload/${fCon.pf_sysname}" alt="Card image cap" id="product-detail">
                    </div>
                </div>
                <!-- col end -->
                <div class="col-lg-7 mt-5">
                    <div class="card">
                        <div class="card-body">
                        	<br>
                            <h1 class="h2">${fCon.p_name}</h1>
                            <p class="h3 py-2"><fmt:formatNumber value="${fCon.p_price}" pattern="###,###"/>원</p>
                            <br>
                            <!-- 
                            <p class="py-2">
                                <i class="fa fa-star text-warning"></i>
                                <i class="fa fa-star text-warning"></i>
                                <i class="fa fa-star text-warning"></i>
                                <i class="fa fa-star text-warning"></i>
                                <i class="fa fa-star text-secondary"></i>
                                <span class="list-inline-item text-dark">
                                	<c:if test="${empty reList}">
                                		Rating 0 | 0 Comments
                                	</c:if>
                                	<c:if test="${!empty reList}">
                                		Rating ${reviewavg} | 36 Comments
                                	</c:if>
                                </span>
                            </p>
                             -->
                            <h6>Description:</h6>
                            <p>${fCon.p_detail}</p>
                            <h6>Avaliable Status : 배달 / 픽업</h6> 
							<br><hr>
                            <form action="" method="post">
                                <input type="hidden" name="mid" value="${mb.m_id}">
                                <input type="hidden" name="pcode" value="${fCon.p_code}">
                                <input type="hidden" name="pname" value="${fCon.p_name}">
                                <input type="hidden" name="pprice" value="${fCon.p_price}">
                                <div class="row">
                                    <div class="col-auto" style="padding-left:250px;">
                                        <ul class="list-inline pb-3">
                                            <li class="list-inline-item text-right">
                                                Quantity
                                                <input type="hidden" name="product-quanity" id="product-quanity" value="1">
                                            </li>
                                            <li class="list-inline-item"><span class="btn btn-success" id="btn-minus">-</span></li>
                                            <li class="list-inline-item"><span class="badge bg-secondary" id="var-value">1</span></li>
                                            <li class="list-inline-item"><span class="btn btn-success" id="btn-plus">+</span></li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="row pb-3">
                                    <div class="col d-grid">
                                        <button type="submit" class="btn btn-success btn-lg" onclick="javascript: form.action='/addcart';">Add To Cart</button>
                                    </div>
                                </div>
                            </form>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Close Content -->
    <br>
    
	<!-- 상품 리뷰 -->
	<div class="container">
        <h4>Product Review</h4><hr>
		<table id="fclist" width="100%">
			<tr id="ltr">
				<th id="fcth">NO</th>
				<th id="fcth">SUBJECT</th>
				<th id="fcth">SCORE</th>
				<th id="fcth">ID</th>
				<th id="fcth">DATE</th>
			</tr>
			<c:if test="${empty reList}">
			<tr id="ltr">
				<td id="ltd" colspan="5" align="center">등록된 리뷰가 없습니다.</td>
			</tr>
			</c:if>
			<c:if test="${!empty reList}">
			<c:forEach var="re" items="${reList}">
			<tr id="ltr">
				<td id="ltd" width="5%">${re.re_num}</td>
				<td id="ltd" width="30%">${re.re_contents}</td>
				<td id="ltd" width="10%">${re.re_score}</td>
				<td id="ltd" width="10%">${re.re_mid}</td>
				<td id="ltd" width="10%">${re.re_date}</td>
			</tr>
			</c:forEach>
			</c:if>
		</table>
	</div>
	<br><br><br><br>

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