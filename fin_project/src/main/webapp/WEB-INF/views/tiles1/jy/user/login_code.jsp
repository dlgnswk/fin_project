<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
    String ctxPath = request.getContextPath();
%>

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/css/jy/common.css" />

<title>Expedia 로그인/회원가입</title>

<style>

	.login_section{
		width: 400px;
		border-radius: 50%;
		display: flex;
		margin: 0 auto;
		flex-direction: column;
		gap: 1.5rem;
	}
	input {
		width: 100%;
	}
	input:focus {
		outline:none;
	}
	.continue {
		width: 100%;
	}
	
	.agree {
		font-size: 14px;
		margin-top: 1.5rem;
	}
	button#before {
		background-color: transparent;
	    height: 3rem;
	    padding: 0 0.75rem;
	}
	.div_text {
	    font-size: 0.875rem;
	}
	#btn_continue {
		margin: 1.5rem 0;
	}
	#btn_resend {
		margin-bottom: 1rem;
	}
	.c_placeholder_text {
		bottom: 23.3rem;
	}
	
</style>

<script>
	
	$(document).ready(function() {
		$("div.err_msg").hide();
		
		// input 태그에 입력 시 오류 메시지 hide
		$("input#code").bind("keyup", function (e) {
			$("div#err_msg").hide();
			$(e.target).removeClass("c_invalid");
		});
		
		$("div.div_code").bind("click", function(e) {
			$(e.target).parent().find("p.c_placeholder_text").addClass("text_out");
			$(e.target).parent().find("label").show();
			$(e.target).parent().find("input:text").focus();
		});
		
		$("input#code").bind("keyup",function(e){
			if(e.keyCode == 13){
				checkCode();
			}
			
		})
		
	});
	
	// 계속하기 버튼을 눌렀을 때
	function checkCode() {
		
		const user_code = $("input#code").val().trim();
		const userid = "${requestScope.userid}";
		const loginuser = "${requestScope.loginuser.userid}";
		
		// 입력된 코드가 공백이거나 6자리 이하일때
		if(user_code == "" || user_code.length < 6){ 
			$("div#err_msg").show();
			$("input#code").addClass("c_invalid");
			$("div#err_msg").html("<p style='color: red; font-size: 12px;'>6자리의 숫자로 입력해주세요</p>");
		}
		
		// 코드가 6자리 입력이 됐을 때,
		else {
			$.ajax({
				url:"check_code_json.exp",
				type:"POST",
				data:{"user_code":user_code},
				dataType:"json",
				success:function(json){
					// console.log(json.isMatch);
					if(json.isMatch){ // 입력 코드가 맞을 때, frm submit
						const frm = CodeCheckFrm;
						frm.action="user_EditPwFrm.exp";
						frm.method="post";
						frm.submit();
					}
					else {
						alert("인증코드가 일치하지 않습니다. 재입력해주세요");
						$("input#code").val("");
						$("input#code").focus();
					}
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}	
			});
		}
	}// end of function checkCode() {}-----------------

	// 코드 재발송
	function resend_code() {
		
		if (confirm("보안코드를 재발송 하시겠습니까?")){			
			const frm = document.CodeCheckFrm;
			frm.action="login_regSendCode.exp";
			frm.method="post";
			frm.submit();
		};
		
	}
</script>

<body>
<div class="nav-top">
	<button id="before" type="button" style="background: none; border: none;" onclick="javascript:history.back();">
		<svg xmlns="http://www.w3.org/2000/svg" height="20" width="20" viewBox="0 0 448 512" >
		<path fill="#1668E3" d="M9.4 233.4c-12.5 12.5-12.5 32.8 0 45.3l160 160c12.5 12.5 32.8 12.5 45.3 0s12.5-32.8 0-45.3L109.2 288 416 288c17.7 0 32-14.3 32-32s-14.3-32-32-32l-306.7 0L214.6 118.6c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0l-160 160z"/></svg>
	</button>
</div>
	<div id="container" style="inline-size: 100%; margin: auto; max-inline-size: 75rem; padding: 50px 0;">
		<div class="login_section">
			<div><h2>사용자 확인</h2></div>
			<div class="div_text">이메일로 보내드린 보안 코드를 입력해 주세요. 받은 편지함에 없는 경우 스팸 메일함을 확인해 보세요.</div>
			<form name="CodeCheckFrm">
			
				<div class="uitk-field has-floatedLabel-label">
					<label for="code" class="uitk-field-label is-visually-hidden">비밀번호</label>
					<input id="code" type="text" name="code" maxlength="6" pattern="[0-9]*" class="uitk-field-input"
						placeholder="" aria-required="false" aria-invalid="false">
					<input name="hidden" type="text" style="display:none">	
					<div class="uitk-field-label" aria-hidden="true">6자리 코드</div>
				</div>
				<div class="err_msg" id="err_msg"></div>
				<div class="c_btn_pri c_btn c_btn_lg" id="btn_continue">
					<button type="button" class="c_btn_pri c_btn c_btn_lg" onclick="checkCode()">계속하기</button>
				</div>
				<div class="c_btn_teri c_btn c_btn_lg" id="btn_resend">
					<button type="button" class="c_btn_teri c_btn c_btn_lg" onclick="resend_code()">코드 다시보내기</button>
				</div>
				<c:if test="${empty sessionScope.loginuser}">
					<div class="c_btn_teri c_btn c_btn_lg" id="btn_goPwd">
						<button type="button" class="c_btn_teri c_btn c_btn_lg" onclick="location.href='<%= ctxPath%>/login.exp'">이 옵션 대신 비밀번호 입력</button>
					</div>
				</c:if>
				<c:if test="${not empty sessionScope.loginuser}">
					<input type="text" name="userid_isExist" value="${sessionScope.loginuser.userid}" style="display:none;"/>
				</c:if>
				<c:if test="${empty sessionScope.loginuser && not empty requestScope.userid_noExist}">
					<input type="text" name="userid_noExist" value="${requestScope.userid_noExist}" style="display:none;"/>
					<input type="text" name="userid" value="${requestScope.userid_noExist}" style="display:none;"/>
				</c:if>		
			</form>
		</div>		
	</div>
</body>
</html>