<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>라이더 회원가입</title>
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="resources/css/riderStyle.css">
<link rel="stylesheet"
   href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
   integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
   crossorigin="anonymous">
<style type="text/css">
.content_area {
   text-align: center;
}

.content_area>h2 {
   margin-top: 40px;
   margin-bottom: 20px;
}

.validation-form {
   width: 45%;
   height: 75%;
   margin: auto;
   background-color: #FAFAFA;
   padding-top: 10px;
   padding-bottom: 10px;
   border: 2px solid;
   border-color: #e6e6e6;
   border-radius: 5px;
   margin-bottom: 40px;
   
}

.rm_join {
   border-collapse: separate;
   border-spacing: 0 20px;
   margin-left: 200px;
}

.rm_join td {
   text-align: left;
}

#category {
   text-align: right;
   padding-right: 20px;
}

input[type=text], input[type=date], input[type=password], input[type=email]{
   width: 200px;
   height: 33px;
   padding-left: 10px;
}

.btn2 {
   width: 140px;
   height: 33px;
   border: none;
   border-radius: 3px;
   outline: none;
}

.btn2:hover {
   background-color: #d9f9dc;
}

#address, #extraAddress {
   width: 345px;
}

#rinsurance {
   width: 200px;
   height: 33px;
}

select {
   padding-left: 10px;
}

#pisert, #re {
   margin-top: 20px;
   margin-bottom: 20px;
}

footer {
   margin-top: 60px;
}

</style>
</head>
<script type="text/javascript">
$(function(){
   var msg = "${msg}";
   if(msg != ""){
      alert(msg);
   }
});
</script>
<body>
   <header>
   <jsp:include page="header.jsp"/>
   </header>

   <div class="content_area">
      <h2>라이더 회원 가입</h2>
      <form class="validation-form" name="r_joinFrm" action="./rmemInsert" method="post" onsubmit="return check()" novalidate>
         <table class="rm_join">
            <tr>
               <td id="category">아이디</td>
               <td>
                  <input type="text" id="rid" name="r_id" autofocus required> 
                  <input type="button" class="btn2" value="아이디 중복확인" onclick="idcheck()">
                  <div class="invalid-feedback">아이디를 입력해주세요.</div>
               </td>
            </tr>
            <tr>
               <td id="category">비밀번호</td>
               <td>
                  <input type="password" id="pwd" name="r_pwd" required>
                  <div class="invalid-feedback">비밀번호를 입력해주세요.</div>
               </td>
            </tr>
            <tr>
               <td id="category">비밀번호 확인</td>
               <td>
                  <input type="password" id="pwdConfirm" required>
                  <div class="invalid-feedback">비밀번호가 일치하지 않습니다.</div>
               </td>
            </tr>
            <tr>
               <td id="category">이름</td>
               <td>
                  <input type="text" id="name" name="r_name" required>
                  <div class="invalid-feedback">이름을 입력해주세요.</div>
               </td>
            </tr>
            <tr>
               <td id="category">생년월일</td>
               <td>
                  <input type="date" id="birth" name="r_birth" required>
                  <div class="invalid-feedback">생년월일을 확인해주세요.</div>
               </td>
            </tr>
            <tr>
               <td id="category">전화번호</td>
               <td>
                  <input type="text" id="phone" name="r_phone" placeholder="010-xxxx-xxxx" required>
                  <div class="invalid-feedback">전화번호를 확인해주세요.</div>
               </td>
            </tr>
            <tr>
               <td id="category">이메일</td>
               <td>
                  <input type="email" id="remail" name="r_email" placeholder="you@example.com" required>
                  <input type="button" class="btn2" value="인증메일 받기" onclick="emailCheck()">
                  <div class="invalid-feedback">이메일을 입력해주세요.</div>
                  <input type="text" class="form-control" id="rauth" name="r_auth" placeholder="인증번호 입력" required>
                  <div class="invalid-feedback">이메일 입력 후 인증번호 받기를 해주세요</div>
                  <span id="mail_check_warn"></span>
               </td>
            </tr>
            <tr>
               <td id="category">우편번호</td>
               <td>
                  <input type="text" id="postcode" name="r_addr1" required>
                  <input type="button" class="btn2" onclick="execDaumPostcode()" value="우편번호 찾기">
                  <div class="invalid-feedback">우편번호를 입력해주세요.</div>
               </td>
            </tr>
            <tr>
               <td id="category">주소</td>
               <td>
                  <input type="text" class="mob_addr" id="address" name="r_addr2">
               </td>
            </tr>
            <tr>
               <td id="category">상세주소</td>
               <td>
                  <input type="text" class="mob_addr" id="extraAddress" name="r_addr3" placeholder="상세주소를 입력해주세요.">
               </td>
            </tr>
            <tr>
               <td id="category">보험</td>
               <td>
                  <select id="rinsurance" name="r_insurance">
                     <option value="">============</option>
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
                  <div class="invalid-feedback">현재 가입하고 계신 보험을 선택해주세요.</div>
               </td>
            </tr>
         </table>
         <input id="pisert" type="submit" class="btn2" value="가입완료"> 
         <input type="reset" id="re" class="btn2" value="초기화"> 
      </form>
   </div>

   <footer>
      <jsp:include page="footer.jsp"></jsp:include>
   </footer>
</body>

<script type="text/javascript">
$("#rauth").blur(function(){
	
	var inputCode = $("#rauth").val(); //입력 코드
	var checkResult = $("#mail_check_warn"); // 비교 결과
	
	if(inputCode == code) {
		checkResult.html("인증번호가 일치합니다");
		checkResult.attr("class", "correct");
	}
	else {
		checkResult.html("인증번호를 다시 확인해주세요");
		checkResult.attr("class", "incorrect");
	}
});

</script>

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

<!-- 이메일 인증  -->
<script type="text/javascript">

var code = ""; //이메일 전송 인증번호 저장하기 위한 코드.

function emailCheck() {
   var riderEmail = $("#remail").val();
   
   $.ajax({
      type : "GET",
      url: "remailCheck?riderEmail=" + riderEmail,
      success: function(result){
         alert("인증메일을 보냈습니다.");
         console.log(result);
         code = result;
      },
      error: function(error){
         
      }      
   });
};
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

<!-- 아이디 중복 체크 -->
<script type="text/javascript">
   
var ckOk = false; 

function idcheck() {
   var inId = $("#rid").val();
   
   //id 값을 입력했는지 검사.
   if(inId == "") {
      alert("아이디를 입력하세요");
      $("#rid").focus();
      return;
   }
   
   var ckObj = {"rid":inId};
   console.log(ckObj);
   
   //서버로 입력한 id 전송
   $.ajax({
      url: "./idCheck",
      type: "get",
      data: ckObj,
      success: function(result){
         console.log(result);
         if(result == "ok"){
            alert("사용가능한 아이디 입니다.");
            ckOk = true;
         }
         else {
            alert("사용할 수 없는 아이디 입니다.");
            $("#rid").val(""); //입력한 아이디 지우기
            $("#rid").focus(); //아이디 입력칸 포커스
            ckOk = false;
         }
      },
      error: function(error) {
         console.log(error);
         ckOk = false;
      }
   });

}

function check(){
   if(ckOk == false){
   alert("아이디 중복 체크를 해주세요.");
   return false;//submit 실행 막기
}
   return true;
}
</script>
</html>