<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>라이더 정보 수정</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script type="text/javascript">
$(function(){
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
});	
</script>
<style>
.content_area {
	text-align: center;
}

.content_area>h2 {
	margin-top: 40px;
	margin-bottom: 20px;
}

.table_area {
	width: 800px;
	height: 660px;
	margin: auto;
	background-color: #FAFAFA;
	padding-top: 10px;
	padding-bottom: 10px;
	border: 2px solid;
	border-color: #e6e6e6;
	border-radius: 5px;
	margin-bottom: 40px;
}

.rm_modi {
	border-collapse: separate;
	border-spacing: 0 20px;
	margin-left: 150px;
	text-align: center;
}

.rm_modi td {
	text-align: left;
}

#category {
	text-align: left;
	padding-right: 20px;
	width: 100px;
	margin-left: 200px;
}

input[type=text], input[type=date], input[type=password]{
	width: 200px;
	height: 33px;
	padding-left: 10px;
}

#addr1-2 {
	width: 100px;
	height: 33px;
	border: none;
	border-radius: 3px;
	outline: none;
}

#addr1-2:hover {
	background-color: #d9f9dc;
}

#addr2, #addr3 {
	width: 305px;
}

.rmodi_btn {
	margin-top: 10px;
}

.btn2 {
	margin-right: 10px;
	width: 100px;
	height: 33px;
	border: none;
	border-radius: 3px;
	outline: none;
}

.btn2:hover {
	background-color: #d9f9dc;
}

select {
	padding-left: 10px;
}

#insurance {
	width: 200px;
	height: 33px;
}

footer {
	margin-top: 60px;
}
#address, #detailAddress {
	width: 500px;
}
</style>
</head>
<body>

	<header>
		<jsp:include page="r_header.jsp" />
	</header>
	
	<div class="tab_wrap tab_area">
		<div class="btn_area clearfix">
			<button class="btn btn_tab" onclick="location.href='./r_main'">배송관리</button>
			<button class="btn btn_tab" onclick="location.href='./r_dList'">배송이력</button>
			<button class="btn btn_tab act" onclick="location.href='./r_modify'">마이페이지</button>
		</div>
		
		<div class="content_area">
			<h2>정보 수정</h2>
			<div class="table_area">
				<form name="r_joinFrm" class="validation-form" action="./rmemUpdate" method="post" onsubmit="return check()" enctype="multipart/form-data" novalidate>	
					<table class="rm_modi">
						<tr>
							<td id="category">이름&nbsp;</td>
							<td><input type="text" value="${riderList.r_name}" name="r_name" id="rmp_r"  readonly></td>
						</tr>
						<tr>
							<td id="category">아이디&nbsp;</td>
							<td><input type="text" value="${riderList.r_id}" name="r_id" id="rmp_r" readonly></td>
						</tr>
						<tr>
							<td id="category">비밀번호&nbsp;</td>
							<td><input type="password" name="r_pwd" value="">
							<div class="invalid-feedback">비밀번호를 입력해주세요.</div></td>
							
						</tr>
						<tr>
							<td id="category">생년월일&nbsp;</td>
							<td><input type="date" name="r_birth" value="${riderList.r_birth}">
							<div class="invalid-feedback">생년월일을 확인해주세요.</div></td>
							
						</tr>
						<tr>
							<td id="category">전화번호&nbsp;</td>
							<td><input type="text" name="r_phone" value="${riderList.r_phone}">
							<div class="invalid-feedback">전화번호를 확인해주세요.</div></td>
							
						</tr>
						<tr>
							<td id="category">이메일&nbsp;</td>
							<td><input type="text" name="r_email" value="${riderList.r_email}">
							<div class="invalid-feedback">이메일을 입력해주세요.</div></td>
						</tr>
						<tr>
							<td id="category">우편번호&nbsp;</td>
							<td><input type="text" id="postcode" name="r_addr1" value="${riderList.r_addr1}">
								<input type="button" onclick="execDaumPostcode()" value="주소 검색">
								<div class="invalid-feedback">주소를 확인해주세요.</div>
							</td>
						</tr>
						<tr>
							<td id="category">주소&nbsp;</td>
							<td><input type="text" id="address" name="r_addr2" value="${riderList.r_addr2}"></td>
						</tr>
						<tr>
							<td id="category">상세주소&nbsp;</td>
							<td><input type="text" id="detailAddress" name="r_addr3" value="${riderList.r_addr3}"></td>
						</tr>
						<tr>
							<td id="category">보험&nbsp;</td>
							<td>
								<select id="insurance" name="r_insurance">
									<option value="">======</option>
									<option>다이렉트카보험</option>
									<option>메리츠화재</option>
									<option>삼성화재</option>
									<option>한화손해보험</option>
									<option>현대해상</option>
									<option>흥국화재</option>
									<option>DB손해보험</option>
									<option>KB손해보험</option>
									<option>MG손해보험</option>
								</select>
							<div class="invalid-feedback">현재 가입하고 계신 보험을 선택해주세요.</div></td>
							
						</tr>
					</table>
					<table class="rmodi_btn">
						<tr>
							<td><input type="submit" class="btn2" value="수정 완료"></td>
							<td><input type="button" class="btn2" value="탈퇴" onclick="location.href ='/r_delete';"></td>
							
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
	
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
</body>

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
</html>