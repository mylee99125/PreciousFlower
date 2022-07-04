<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품수정</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="resources/css/adminStyle.css">
<style type="text/css">
#pupdate {
	text-align: left;
}
#pfile label {
	cursor: pointer;
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
			<button class="btn btn_tab">회원관리</button>
			<button class="btn btn_tab" onclick="location.href='./aa_olist'">주문관리</button>
			<button class="btn btn_tab act" onclick="location.href='./aa_plist'">상품관리</button>
			<button class="btn btn_tab">게시글관리</button>
		</div>
		<div class="content_area">
		<form action="/pupdate" method="post" enctype="multipart/form-data">
			<h3>[상품 수정]</h3>
			<br><br>
			<table id="pupdate" align="center">
				<tr>
					<th>상품코드 :</th>
					<td>
						<input type="text" id="p_code" name="p_code" value="${product.p_code}" autofocus required> 
					</td>
				</tr>
				<tr>
					<th>상품명 :</th>
					<td><input type="text" name="p_name" required
						value="${product.p_name}"></td>
				</tr>
				<tr>
					<th>상품가격 :</th>
					<td><input type="text" name="p_price" required
						value="${product.p_price}"></td>
				</tr>
				<tr>
					<th>상품상세 :</th>
					<td width="300"><textarea rows="5" name="p_detail"
							class="pdetail" style="width: 100%">${product.p_detail}</textarea>
					</td>
				</tr>
				<tr>
					<th>상품이미지 :</th>
					<td>
						<div id="pfile">
						<c:if test="${empty fList}">
							<label style="width: 50%">첨부파일 없음</label>
						</c:if>
						<c:if test="${!empty fList}">
							<c:forEach var="f" items="${fList}">
								<label style="width: 50%;" onclick="del('${f.pf_sysname}');">
									${f.pf_oriname}
								</label>
							</c:forEach>
						</c:if>
						</div>
						<input type="file" name="files" id="file" multiple>
						<input type="hidden" id="filecheck" value="0" name="filecheck">
					</td>
				</tr>
			</table>
			<br><br>
			<input id="pisert" type="submit" class="btn2" value="등록"> 
			<input type="button" class="btn2" value="삭제"
				onclick="delCheck('${product.p_code}')">
		</form>
		</div>
	</div>
</body>
<script type="text/javascript">
	//업로드할 파일을 선택하면, 'fileCheck' 요소의 value를 1로 변경
	$("#file").on("change", function() {
		//파일 입력창에서 선택한 파일 목록 가져오기
		var files = $("#file")[0].files;
		console.log($("#file"));
		console.log(files);

		var fileName = "";

		if (files.length > 1) {//하나 이상의 파일 선택 시
			fileName = files[0].name + " 외 " + (files.length - 1) + "개"
		} else if (files.length == 1) {
			fileName = files[0].name;
		}

		$(".upload-name").val(fileName);

		//fileCheck 부분 변경
		if (fileName == "") {//파일 취소 시
			$("#filecheck").val(0);
			$(".upload-name").val("파일선택");
		} else {//파일 선택 시
			$("#filecheck").val(1);
		}
		console.log($("#filecheck").val());
	});
	
	//이미지 파일 삭제
	function del(sysname){
		console.log(sysname);
		
		var con = confirm("파일을 삭제하겠습니까?");
		
		if(con == true){
			var objdata = {"sysname":sysname};
			//objdata.pcode = ${product.p_code};//파일목록 다시 불러오기에서 사용
			console.log(objdata);
			
			$.ajax({
				url: "./delFile",
				type: "post",
				data: objdata,
				dataType: "json",
				success: function(result){
					console.log(result);
					alert("삭제 성공");
					
					//새로운 파일 목록 출력
					var flist = "";
					var rflist = result.fList;
					console.log(rflist);
					if(rflist.length == 0){
						flist += '<label style="width: 50%">첨부 파일 없음</label>';
					}
					else {
						for(var i = 0; i < rflist.length; i++){
							flist += '<label style="width: 50%" onclick="del(\''
									+ rflist[i].bf_sysname + '\')">'
									+ rflist[i].bf_oriname + '</label>';
						}
					}
					
					$("#pfile").html(flist);
				},
				error: function(error){
					console.log(error);
					alert("삭제 실패");
				}
			});
		}
	}
	
	//상품 삭제
	function delCheck(p_code) {
		var conf = confirm("삭제하시겠습니까?");
		
		if (conf == true) {
			location.href="./pdelete?p_code="+p_code;
		}
	}
</script>
</html>