<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String ctxPath = request.getContextPath();
%>

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/css/jy/common.css" /> 
<script type="text/javascript" src="<%= ctxPath%>/resources/js/jy/login.js"></script>

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
	.com_placeholder_text {
		bottom: 27.5rem;
	}
</style>

<script>
	
	$(document).ready(function() {
		$("div.err_msg").hide();
		$("label.com_label").hide();
		
		// input 태그에 입력 시 오류 메시지 hide
		$("input#userid").bind("keyup", function (e) {
			$("div#err_msg_userid").hide();
			$(e.target).removeClass("com_invalid");
		});
		$("input[name='pw']").bind("keyup", function (e) {
			$("div#err_msg_pw").hide();
			$(e.target).removeClass("com_invalid");
		});
		
		$("div.div_userid").bind("click", function(e) {
			$(e.target).parent().find("p.com_placeholder_text").addClass("text_out");
			$(e.target).parent().find("label").show();
			$(e.target).parent().find("input:text").focus();
		});
		
		$("input#userid").bind("keyup",function(e){
			if(e.keyCode == 13 ){
				goLogin();
			}
		})
		
	});
	
	// 계속하기 버튼을 눌렀을 때
	function goLogin() {
		// 이메일 유효성 검사 통과 시, DB와 확인
		// 이메일 유효성 검사
		var regExp_userid = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		 
		const val_userid = $("input#userid").val();
		const val_pw = $("input:password[name='pw']").val();
		 
		if(val_userid == ""){
			$("div#err_msg_userid").show();
			$("input#userid").addClass("com_invalid")
			$("div#err_msg_userid").html("<p style='color: red; font-size: 12px;'>이메일을 입력해주세요!</p>");
		}
		else if (!regExp_userid.test(val_userid)) {
			$("div#err_msg_userid").show();
			$("input#userid").addClass("com_invalid")
			$("div#err_msg_userid").html("<p style='color: red; font-size: 12px;'>올바른 이메일을 입력해주세요!</p>");
		}		
		else if ( regExp_userid.test(val_userid) && val_pw != "") {
			
			const userid = $("input#userid").val();
			$("input:text[name='email']").val(userid);
			
			const frm = document.RegFrm;
			frm.action="login_regSendCode.exp";
			frm.method="post";
			frm.submit();
			
		}
		
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
			<div><h2>로그인 또는 회원가입</h2></div>
			<form name="RegFrm">
				<div class="uitk-field has-floatedLabel-label">
					<label for="userid" class="uitk-field-label is-visually-hidden">이메일</label>
					<input id="userid" type="text" name="userid" maxlength="60" class="uitk-field-input"
						placeholder="" aria-required="false" aria-invalid="false">
					<div class="uitk-field-label" aria-hidden="true">이메일</div>
				</div>
				<div class="err_msg" id="err_msg_userid"></div>
				<input type="text" name="email" style="display:none;"/>
				<div class="continue c_btn_pri c_btn c_btn_lg" style="margin-top: 3rem;">
					<button type="button" class="continue c_btn_pri c_btn c_btn_lg" onclick="goLogin()">계속하기</button>
				</div>
			</form>
			<div class="agree">
				<p>계속하면 <a href="">이용약관</a>,<a href="">개인정보 처리방침</a> 및 <a href="">Expedia Rewards 이용약관</a>을 읽었으며 이에 동의하시는 것으로 간주됩니다.</p>
			</div>
		</div>		
	</div>
</body>
</html>