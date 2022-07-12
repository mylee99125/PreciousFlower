<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품등록</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="resources/css/adminStyle.css">
<style type="text/css">
h3 {
	padding-top: 10px;
}
</style>
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
	<jsp:include page="aa_aheader.jsp"/>
	</header>
	<div class="tab_wrap tab_area">
		<div class="btn_area clearfix">
			<button class="btn btn_tab" onclick="location.href='./aa_main'">Home</button>
			<button class="btn btn_tab" onclick="location.href='./aa_mlist'">회원관리</button>
			<button class="btn btn_tab" onclick="location.href='./aa_olist'">주문관리</button>
			<button class="btn btn_tab act" onclick="location.href='./aa_plist'">상품관리</button>
			<button class="btn btn_tab" onclick="location.href='./aa_notice'">게시글관리</button>
		</div>
		<div class="content_area">
		<form action="./productInsert" method="post"
			enctype="multipart/form-data" onsubmit="return check()">
			<h3>[상품 등록]</h3>
			<br><br>
			<table id="pinsert" align="center">
				<tr>
					<th>상품코드 :</th>
					<td><input type="text" id="p_code" name="p_code" autofocus
						required> <input type="button" class="btn2"
						value="상품코드 중복확인" onclick="codeCheck()"></td>
				</tr>
				<tr>
					<th>상품명 :</th>
					<td><input type="text" name="p_name" required></td>
				</tr>
				<tr>
					<th>상품가격 :</th>
					<td><input type="text" name="p_price" required></td>
				</tr>
				<tr>
					<th>상품상세 :</th>
					<td width="300">
					<textarea rows="5" name="p_detail"
							class="pdetail" style="width: 100%"></textarea>
					</td>
				</tr>
				<tr>
					<th>상품이미지 :</th>
					<td>
						<input type="file" name="files" id="file" multiple>
						<input type="hidden" id="filecheck" value="0" name="filecheck">
					</td>
				</tr>
			</table>
			<br><br>
			<input id="pisert" type="submit" class="btn2" value="등록"> 
			<input type="reset" class="btn2" value="초기화"> 
		</form>
		</div>
	</div>
</body>
<script type="text/javascript">
	//업로드할 파일을 선택하면, 'fileCheck' 요소의 value를 1로 변경
	$("#file").on("change", function(){
	//파일 입력창에서 선택한 파일 목록 가져오기
	var files = $("#file")[0].files;
	console.log($("#file"));
	console.log(files);
	
	var fileName = "";
	
	if(files.length > 1){//하나 이상의 파일 선택 시
		fileName = files[0].name + " 외 "
			+ (files.length - 1) + "개"
	}
	else if(files.length == 1){
		fileName = files[0].name;
	}
	
	$(".upload-name").val(fileName);
	
	//fileCheck 부분 변경
	if(fileName == ""){//파일 취소 시
		$("#filecheck").val(0);
		$(".upload-name").val("파일선택");
	}
	else {//파일 선택 시
		$("#filecheck").val(1);
	}
	console.log($("#filecheck").val());
	});

	//상품코드 중복 체크
	var ckOk = false; //false일 경우 등록 프로세스 실행 X

	function codeCheck() {
		var inCode = $("#p_code").val();

		//code 값을 입력했는지 검사
		if (inCode == "") { //입력을 안했을 경우
			alert("상품코드를 입력하세요.");
			$("#p_code").focus();
			return;
		}

		var ckObj = {
			"p_code" : inCode
		};
		console.log(ckObj);

		//서버로 입력한 code 전송
		$.ajax({
			url : "./codeCheck",
			type : "get",
			data : ckObj,
			success : function(result) {
				console.log(result);
				if (result == "ok") {
					alert("코드 사용 가능");
					ckOk = true;
				} else {
					alert("사용할 수 없는 코드입니다.");
					$("#p_code").val("");//입력한 아이디 지우기
					$("#p_code").focus();//코드 입력칸 포커스
					ckOk = false;
				}
			},
			error : function(error) {
				console.log(error);
				ckOk = false;
			}
		});
	}

	function check() {
		if (ckOk == false) {
			alert("상품코드 중복 체크를 해주세요.");
			return false;//submit 실행 막기
		} else {
			return true;//중복 체크 한 상태
		}
	}
</script>
</html>

















