<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<head>
<title>Precious Flower - Product Detail</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="apple-touch-icon" href="resources/img/apple-icon.png">
<link rel="shortcut icon" type="image/x-icon"
	href="resources/images/favicon.png">

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
.bubble {
	position: relative;
	width: 600px;
	padding: 10px;
	background: #dcdcdc;
	-webkit-border-radius: 10px;
	-moz-border-radius: 10px;
	border-radius: 10px;
	margin-left: 25px;
}

.bubble:after {
	content: '';
	position: absolute;
	border-style: solid;
	border-width: 8px 16px 8px 0;
	border-color: transparent #dcdcdc;
	display: block;
	width: 0;
	z-index: 1;
	left: -16px;
	top: 16px;
}

#retab {
	width: 100%;
}

#fcbut {
	padding-left: 20px;
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
                        <img class="pcard-img img-fluid" src="resources/upload/${fCon.pf_sysname}" alt="Card image cap" id="product-detail">
                    <!-- 
                    <div class="card mb-3">
                    </div>
                     -->
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
                                        <button type="submit" class="btn btn-success btn-lg" onclick="javascript: form.action='/addcart';">장바구니</button>
                                    </div>
                                    <div id="fcbut" class="col d-grid">
                                        <button type="submit" class="btn btn-success btn-lg" onclick="javascript: form.action='/quickorder';">주문하기</button>
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
        <h4>상품 리뷰&nbsp;<img src="resources/images/writing.png" style="width:30px;"></h4><hr>
		<c:if test="${!empty reList}">
		<c:forEach var="re" items="${reList}">
		<table id="retab">
			<tr>
			<td>
				<img src="resources/images/flower.png" style="width:50px;"><br>
				<h6>${re.re_mid}</h6>
			</td>
			<td width="100%">
				<div class="bubble">
					${re.re_date}<br>
					${re.re_score} | ${re.re_contents}
				</div>
			</td>
			</tr>
		</table>	
		</c:forEach>
		</c:if>
		<c:if test="${empty reList}">
			<tr>
				<td>등록된 리뷰가 없습니다.</td>
			</tr>
		</c:if>
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