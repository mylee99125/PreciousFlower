<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<head>
    <title>Precious Flower - Order</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="apple-touch-icon" href="resources/img/apple-icon.png">
    <link rel="shortcut icon" type="image/x-icon" href="resources/img/favicon.ico">

    <link rel="stylesheet" href="resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/templatemo.css">
    <link rel="stylesheet" href="resources/css/custom.css">

    <!-- Load fonts style after rendering the layout styles -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;200;300;400;500;700;900&display=swap">
    <link rel="stylesheet" href="resources/css/fontawesome.min.css">

    <!-- Slick -->
    <link rel="stylesheet" type="text/css" href="resources/css/slick.min.css">
    <link rel="stylesheet" type="text/css" href="resources/css/slick-theme.css">
    <link rel="stylesheet" href="resources/css/adminStyle.css">
    
<style type="text/css">
/* 오더 전용 css */

.mb_table{
    width: 100%;
    border-spacing: 0;
    border-bottom: 1px solid #b6b6b6; 
 }
 .member_info_div td{
 	padding : 12px;
 	text-align: left;
 }
  /* 사용자 주소 정보 */
  .addressInfo_input_div table {
    margin-left: 35%;
 }
 .addressInfo_div{
 	margin-top: 30px;
 }
 
 .addressInfo_input_div_wrap{
 	border-bottom: 1px solid #f3f3f3;
 	height: 350px;
 	float: center;
 }
.address_btn {
    background-color: #555;
    color: white;
    float: center;
    border: none;
    outline: none;
    padding: 14px 16px;
    font-size: 17px;
    width: 100%;
}

.address_btn:hover{
	background-color: #777;
}

.addressInfo_input_div input{
	padding-left: 10px;
}

.addressInfo_button_div::after{
	content:'';
	display:block;
	clear:both;
}
		.addressInfo_input_div{
			padding:12px;
			text-align: center;
			display: none;
			line-height: 40px;
		}
		.addressInfo_input_div th{
			border-color: transparent;
		    background-color: transparent;		
		}
		.addressInfo_input_div th{
			padding : 12px 5px 12px 20px;
			vertical-align: top;
		}
		.addressInfo_input_div td{
			padding : 8px 12px;
		}		
		.addressInfo_input_div_2 input{
			padding: 6px 5px;
		}
.address_search_btn{
    vertical-align: middle;
    display: inline-block;
    border: 1px solid #aaa;
    width: 90px;
    text-align: center;
    height: 30px;
    line-height: 30px;
    color: #555;
    cursor: pointer;
}

.rec_addr2, .rec_addr3, .rec_date {
	width: 300px;
}

#table {
	background-color: #FAFAFA;
}
#cartsum {
	margin-top: 30px;
	margin-bottom: 30px;
	text-align: center;
}

#btnarea {
	margin-top: 10px;
	text-align: center;
}

#btnarea button:hover {
	background-color: #3c3838;
	color: white;
}

#table {
	margin-top: 20px;
	margin-bottom: 20px;
}

.cartbtn {
	border: none;
	outline: none;
	height: 40px;
	width: 100px;
	border-radius: 3px;
}

#modi {
	width: 140px;
}

footer {
	margin-top: 60px;
}
</style>

	<!-- Start Script -->
    <script src="resources/js/jquery-1.11.0.min.js"></script>
    <script src="resources/js/jquery-migrate-1.2.1.min.js"></script>
    <script src="resources/js/bootstrap.bundle.min.js"></script>
    <script src="resources/js/templatemo.js"></script>
    <script src="resources/js/custom.js"></script>
    <!-- End Script -->


<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
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

    <!-- Modal -->
    <div class="modal fade bg-white" id="templatemo_search" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="w-100 pt-1 mb-5 text-right">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="" method="get" class="modal-content modal-body border-0 p-0">
                <div class="input-group mb-2">
                    <input type="text" class="form-control" id="inputModalSearch" name="q" placeholder="Search ...">
                    <button type="submit" class="input-group-text bg-success text-light">
                        <i class="fa fa-fw fa-search text-white"></i>
                    </button>
                </div>
            </form>
        </div>
    </div>


    <!-- Open Content -->
    <section class="bg-light">
        <div class="container pb-5">
        
            <br><h4>주문</h4><hr>
            <div class="row">
            
            <form class="validation-form" id="payfrm" action="/forder" method="post" novalidate>
            
           	<!-- 주문자 정보 -->
			<div class="member_info_div">
			
					<table class="table_text_align_center mb_table">
						<tbody>
							<tr>
								<th style="width: 25%;">주문 방법</th>
								<td style="width: *">
									<input type="radio" name="o_type" value="픽업" onclick="plusfee(2)" checked="checked"> 찾아가기 |
									<input type="radio" name="o_type" value="배송" onclick="plusfee(1)"> 배송하기(+3,000원) </td>
							</tr>
							<tr>
								<th style="width: 25%;">주문하시는 분</th>
								<td style="width: *">${md.m_name} | ${md.m_phone}<br>${md.m_email}
								<input type="hidden" class="o_mid" name="o_mid" value="${md.m_id}">
								</td>
							</tr>
							<tr>
								<th>수령 일자 :</th>
								<td>
									<input class="rec_date" type="datetime-local" id="currentDate" name="o_rdate" >
									<div class="invalid-feedback">수령하실 시간을 입력해주세요.</div>
								</td>	
							</tr>
						</tbody>
					</table>
				</div>
			
			<!-- 배송지 정보 -->
			<div class="addressInfo_div"  id="togo">
				<div class="addressInfo_button_div">
					<button class="address_btn address_btn_1" onclick="showAdress('1')" style="background-color: #3c3838;">받으시는 분 정보</button>
				</div>
				
				<div class="addressInfo_input_div_wrap" align="center">
					<div class="addressInfo_input_div addressInfo_input_div_1" style="display: block">
					<table>
						<colgroup>
							  <col width="25%">
							  <col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th>받으시는 분 이름</th>
								<td>
									<input class="rec_name" type="text" name="o_rec" required>
									<div class="invalid-feedback">받으시는 분 이름을 입력해주세요.</div>
								</td>
							</tr>
							<tr>
								<th>받으시는 분 전화번호 :</th>
								<td>
									<input class="rec_phone" type="text" id="rec_phone" name="o_phone" placeholder="010-XXXX-XXXX.">
									<div class="invalid-feedback">받으시는 분 전화번호를 입력해주세요.</div>
								</td>
							</tr>
							<tr>
								<th>받으시는 분 주소</th>
							</tr>
							<tr>
								<th>우편번호 :</th>
								<td>
									<input class="rec_addr1" type="text" id="postcode" name="o_addr1" required>
									<div class="invalid-feedback">우편번호를 입력해주세요.</div>
									<input type="button" onclick="execDaumPostcode()" value="주소 검색">
								</td>
							</tr>
							<tr>
								<th>주소 :</th>
								<td>
									<input class="rec_addr2" type="text" id="address" name="o_addr2">
								</td>
							</tr>
							<tr>
								<th>상세주소 :</th>
								<td>
									<input class="rec_addr3" type="text" id="extraAddress" name="o_addr3" placeholder="상세주소를 입력해주세요.">
									<div class="invalid-feedback">받으시는 분 상세 주소를 입력해주세요.</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>	

		<table id="table" align="center">
			<tr>
				<th></th>
				<th colspan="2" align="center">상품정보</th>
				<th>수량</th>
				<th>상품금액</th>
				<th>합계금액</th>
			</tr>
			<c:if test="${!empty corder}">
			<c:set var="count" value="0"/>
			<c:set var="sum" value="0"/>
			<c:forEach var="co" items="${corder}" varStatus="status">
				<tr>
					<td width="10%" height="80">
					<input type="hidden" name="o_pcode" id="opcode" value="${co.c_pcode}"/>
					</td>
					
					<td width="3%">
						<img src="resources/upload/${co.pf_sysname}" style="width:70px; vertical-align:middle;">
					</td>
					<td width="10%"><a>${co.c_pname}</a></td>
					<td width="10%">${co.c_count}개</td>	
					<td width="10%">
						<fmt:formatNumber value="${co.p_price}" pattern="###,###"/>원
							<input type="hidden" name="o_pname" id="opname" value="${co.p_name}"/>
							<input type="hidden" name="o_count" id="ocount" value="${co.c_count}"/>
					</td>	
					<td width="10%">
						<fmt:formatNumber value="${co.c_pprice}" pattern="###,###"/>원
					</td>	
				</tr>
				<c:set var="focount" value="${status.count}"/>
				<c:set var="sum" value="${sum + co.c_pprice}"/>
			</c:forEach>
		</c:if>
	</table>
	<div id="cartsum"><h4>총 ${focount}개의 상품금액 <fmt:formatNumber value="${sum}" pattern="###,###"/>원</h4></div>
					<input type="hidden" name="o_price" id="oprice" value="${sum}"/>
	<div id="btnarea">
		<button type="button" class="cartbtn" id="modi" name="move" value="modify" onclick="location.href='./cart';">주문 수정하기</button>
		<button type="button" class="cartbtn" id="payment" name="submit" value="payment">결제하기</button>
	</div>				
  </form>	
 </div>
</div>
</section>
    <!-- Close Content -->
  	<footer>
	<jsp:include page="footer.jsp"/>
	</footer>
	
 								<!-- 유효성 검사  -->
<script>
    window.addEventListener('load', () => {
      const forms = document.getElementsByClassName('validation-form');

      Array.prototype.filter.call(forms, (form) => {
        form.addEventListener('submit', function (event) {
          if (form.checkValidity() === false) {
            event.preventDefault();
            event.stopPropagation();
          }

          form.classList.add('was-validated');
        }, false);
      });
    }, false);
  </script>
 									
									<!-- 배송비 추가 -->
<script src="resources/js/jquery.number.min.js"></script>
<script type="text/javascript">
var gn = 2;
var sum = ${sum};
$("#togo").hide();

function plusfee(n) {
	if(gn == n){
		return;
	}
	//console.log("선택");
	
	if(n == 1){
		sum += 3000;
		$("#togo").show();
	}
	else{
		sum -= 3000;
		$("#togo").hide();
	}
	
	gn = n;
	
	console.log(sum);
	$("#oprice").val(sum);
	
	csum = addComma(sum+'');
	
	var fsum = "총 " + ${focount} + "개의 상품금액 " + csum + "원";
	console.log(fsum);
	
	$("#cartsum").html(fsum);
}

</script>

<!-- 원화 콤마 표시 -->

<script type="text/javascript">
function addComma(value){
    value = value.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    return value; 
}

</script>
    
<!-- 주소 확인 API -->

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                    
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 주소변수 문자열과 참고항목 문자열 합치기
                    addr += extraAddr;
                
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("extraAddress").focus();
            }
        }).open();
        
    }
    
</script>

<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript" src="resources/js/jquery.serializeObject.js"></script>
<script type="text/javascript">

//var form = document.getElementById("payfrm");

$("#payment").click(function() {
	var form = $("#payfrm");
	console.log(form);
	var osum = $("#oprice").val();
	//goAction(form);
	
        IMP.init('imp08436080'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
        
        IMP.request_pay({
            pg : 'kakaopay',
            pay_method : 'card',
            merchant_uid : 'merchant_' + new Date().getTime(),
            name : 'Precious Flower 결제서비스',
            amount : osum, //totalPrice
            buyer_email : '${md.m_email}',
            buyer_name : '${md.m_name}',
            buyer_tel : '${md.m_phone}',
            buyer_postcode : '123-456',
            
        }, function(rsp) {
        	console.log(rsp);
            if ( rsp.success ) {
            	var msg = "결제가 완료되었습니다.";
                msg += '결제 금액 : ' + rsp.paid_amount;
                console.log(msg);
                //$(form).submit();
                goAction(form);
                //return true;
            } else {
                var msg = '결제에 실패하였습니다.';
                msg += '에러내용 : ' + rsp.error_msg;
            }
            alert(msg);
        });
  
    });
    
    function goAction(frm){
    	var jFrm = frm.serializeObject();
    	console.log(jFrm);
    	
    	$.ajax({
    		url: "forder",
    		type: "post",
    		data: jFrm,
    		dataType: "json",
    		success: function(result){
    			console.log(result);
    			location.href='/ordersuccess';
    		},
    		error: function(error){
    			console.log(error);
    		}
    	});
    	
    }

</script>
</body>
</html>