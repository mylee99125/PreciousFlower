<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="shortcut icon" type="image/x-icon" href="resources/img/favicon.ico">
<script type="text/javascript">
$(function(){
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
});
</script>
<style type="text/css">
#minfo {
	margin-left: auto;
	margin-right: auto;
	margin-bottom: 20px;
	margin-top: 30px;
	border-collapse: separate;
	border-spacing: 0 20px;
}
#minfo-btn1 {
	margin-right: 10px; 
	border: none;
	height: 35px;
	width: 60px;
	outline: none;
	border-radius: 3px;
}
#minfo-btn1:hover {
	background-color: #6e6e6e;
	color: #fff;
	transition: background 0.3s ease-in-out;
}

#minfo-btn2 {
	border: none;
	height: 35px;
	width: 60px;
	outline: none;
	border-radius: 3px;
}
#minfo-btn2:hover {
	background-color: #6e6e6e;
	color: #fff;
	transition: background 0.3s ease-in-out;
}
#minfo td {
	text-align: left;
	padding-left: 50px;
}
#m-btn {
	text-align: right;
}
#addrs {
	border: none;
	height: 35px;
	width: 100px;
	outline: none;
	border-radius: 3px;
}
#addrs:hover {
	background-color: #6e6e6e;
	color: #fff;
	transition: background 0.3s ease-in-out;
}
.validation-form {
	width: 800px;
	height: 720px;
	margin: auto;
	background-color: #FAFAFA;
	padding-top: 50px;
	padding-bottom: 10px;
	border: 2px solid;
	border-color: #e6e6e6;
	border-radius: 5px;
	margin-bottom: 40px;
}
.content_area {
	text-align: center;
	padding-top: 50px;
}

.content_area>h2 {
	margin-top: 40px;
	margin-bottom: 20px;
}
#mbtnarea {
	text-align: center;
}
#address, #extraAddress {
	width: 500px;
}
</style>
</head>
<body>
	<header>
		<jsp:include page="header.jsp"/>
	</header>
	
	<div class="content_area">
		<form class="validation-form" name="m_updateFrm" action="./memUpdate" method="post"
			 enctype="multipart/form-data" novalidate>
		<h2>마이페이지</h2>
	<table id="minfo">
		<tr>
			<td>이름&nbsp;</td>
			<td><input type="text" id="mname" name="m_name" value="${md.m_name}" readonly></td>	
		</tr>
		<tr>
			<td>아이디&nbsp;</td>
			<td><input type="text" id="mid" name="m_id" value="${md.m_id}" readlonly></td>
		</tr>
		<tr>
			<td>비밀번호&nbsp;</td>
			<td><input type="password" id="mpassword" name="m_pwd" value="" >
			<div class="invalid-feedback">비밀번호를 입력해주세요.</div></td>
		</tr>
		<tr>
			<td>생년월일&nbsp;</td>
			<td><input type="date" id="mbirth" name="m_birth" value="${md.m_birth}" readonly></td>
		</tr>
		<tr>
			<td>전화번호&nbsp;</td>
			<td><input type="text" id="mphone" name="m_phone" value="${md.m_phone}">
			<div class="invalid-feedback">전화번호를 확인해주세요.</div></td>
		</tr>
		<tr>
			<td>이메일&nbsp;</td>
			<td><input type="text" id="memail" name="m_email" value="${md.m_email}"></td>
		</tr>
		<tr>
			<td>우편번호&nbsp;</td>
			<td><input type="text" id="postcode" name="m_addr1" value="${md.m_addr1}">
			<input type="button" id="addrs" onclick="execDaumPostcode()" value="주소 검색">
			</td>
		</tr>
		<tr>
			<td>주소&nbsp;</td>
			<td><input type="text" id="address" name="m_addr2" value="${md.m_addr2}"></td>
		</tr>
		<tr>
			<td>상세주소&nbsp;</td>
			<td><input type="text" id="extraAddress" name="m_addr3" value="${md.m_addr3}"
			     placeholder="상세주소를 입력해주세요."></td>
		</tr>
	</table> 
	<div id="mbtnarea">
		<button type="submit" id="minfo-btn1" onclick="location.href = '/memUpdate';">수정</button>
		<button type="button" id="minfo-btn2" onclick="location.href ='/m_delete';">탈퇴</button>
	</div>
  </form>
</div>
		
	
	<footer>
		<jsp:include page="footer.jsp"/>
	</footer>
</body>

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

									<!-- 유효성 검사  END-->


									 <!-- 주소 확인 API -->

<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

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