<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
    String ctxPath = request.getContextPath();
%>

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/css/jy/common.css" />

<title>Expedia 비밀번호 입력/변경</title>

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
	.c_placeholder_text {
		margin: 0;
		padding-left: 0.5rem;
		position: relative;
		bottom: 35px;
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
	.error_msg {
		font-size: 0.8rem;
		line-height: 1.5rem;
	}
	ul {
		padding-left: 20px;
	}
</style>

<script>
	
	$(document).ready(function() {
		$("div.err_msg").hide();
		
		$("input#pw").bind("keyup", function (e) {
			if( e.keyCode == 13 ){ // 비밀번호 입력 후 엔터 시, submit 하러 간다
				updatePw();
			}
		})
		
		// 숫자/문자/특수문자 포함 형태의 8~20 자리 이내의 암호 정규표현식 객체 생성
		const regExp_pwd = new RegExp(/^.*(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
		
		$("input#pw").bind("keyup", function (e) {
			const bool = regExp_pwd.test($(e.target).val());
			
			if(!bool){ // 비밀번호 정규식에 맞지 않을 경우 err_msg 보여주기
				$("div#err_msg").show();
				$("div#err_msg").html("<div class='error_msg'><ul>"
									+"<li class='err_msg_pw'>8~20자의 길이 </li>"
									+"<li class='err_msg_pw'>최소 1개의 대문자, 영소문자, 특수문자, 숫자를 포함.</li>"
									+"<li class='err_msg_pw'>사용 가능한 특수문자: ! @ # $ % ^ &amp; * ( ) - + / &lt; &gt; , .</li></ul></div>");
			}
			
			else { // 비밀번호 정규식에 맞을 경우 err_msg 숨기고 button 활성화				
				$("button#btn_update").attr("disabled",false);
				$("div#err_msg").hide();
				if( e.keyCode == 13 ){ // 비밀번호 입력 후 엔터 시, submit 하러 간다
					updatePw();
				}
			}
		});
		
		$("div.div_pw").bind("click", function(e) {
			$(e.target).parent().find("p.c_placeholder_text").addClass("text_out");
			$(e.target).parent().find("label").show();
			$(e.target).parent().find("input:text").focus();
		});
		
	});
	
	// 비밀번호 업데이트를 눌렀을 때
	function updatePw() {
		
		const frm = document.updatePwFrm;
		frm.action = "user_EditPwEnd.exp";
		frm.method = "post";
		frm.submit();
		
		
	}// end of function checkCode() {}-----------------

</script>

<body>
<div class="nav-top">
	<button id="before" type="button" style="background: none; border: none;" onclick="javascript:history.back();">
		<svg xmlns="http://www.w3.org/2000/svg" height="20" width="20" viewBox="0 0 448 512" >
		<path fill="#1668E3" d="M9.4 233.4c-12.5 12.5-12.5 32.8 0 45.3l160 160c12.5 12.5 32.8 12.5 45.3 0s12.5-32.8 0-45.3L109.2 288 416 288c17.7 0 32-14.3 32-32s-14.3-32-32-32l-306.7 0L214.6 118.6c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0l-160 160z"/></svg>
	</button>
</div>
	<div id="container" style="inline-size: 100%; margin: auto; max-inline-size: 85rem; padding: 50px 0;">
		<div class="login_section">
			<div>
				<c:if test="${not empty request.sessionScope.loginuser}">
					<h2>비밀번호 변경</h2>
				</c:if>
				<c:if test="${empty request.sessionScope.loginuser}">
					<h2>비밀번호 입력</h2>
				</c:if>
			</div>
			<div class="div_text">흔하지 않으면서도 보안성이 높은 비밀번호를 사용해주세요.</div>
			<form name="updatePwFrm">
				<div class="div_pw">
					<label for="pw" class="c_label" style="display:none;">비밀번호</label>
					<input type="password" class="input_code c_input" name="pw" id="pw"  maxlength="64" >
					<input type="text" class="input_code c_input" name="hidden" maxlength="64" style="display:none;">
					<div class="c_placeholder_div"><p class="c_placeholder_text" id="text_pw">비밀번호</p></div>
				</div>
				<div class="err_msg" id="err_msg"></div>
				<div class="c_btn_pri c_btn c_btn_lg" id="btn_continue">
					<button type="button" id="btn_update" class="c_btn_pri c_btn c_btn_lg" onclick="updatePw()" disabled>비밀번호를 업데이트 해주세요</button>
				</div>
				<c:if test="${not empty requestScope.userid_isExist}">
					<input type="text" name="userid_isExist" value="${requestScope.userid_isExist}" style="display:none;"/>
				</c:if>
				<c:if test="${not empty requestScope.userid_noExist}">
					<input type="text" name="userid_noExist" value="${requestScope.userid_noExist}" style="display:none;"/>
				</c:if>				
			</form>
		</div>		
	</div>
</body>
</html>