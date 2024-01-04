<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String ctxPath = request.getContextPath();
%>

<link rel="stylesheet" type="text/css"
	href="<%=ctxPath%>/resources/css/jy/common.css" />

<title>Expedia 비밀번호 입력/변경</title>

<style>
.login_section {
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
	outline: none;
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

.div_birth_input .div_input {
	width: calc(33% - 8px);
}

.div_birth_input {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.radio_btn_label_suffix {
	display: grid;
	grid-auto-rows: min-content;
	grid-template-areas: "radio label space suffix" ". desc desc desc";
	grid-template-columns: min-content 1fr 1rem min-content;
}

h6 {
	font-size: .875rem;
	font-weight: 500;
	line-height: 1.125rem;
	margin: 0;
}

.goAccount:hover {
	block-size: 2.25rem;
	border-radius: 2500rem;
	inline-size: 2.25rem;
	background-color: red;
}

#div_form {
	display: flex;
	flex-direction: column;
	gap: 1rem;
}

.div_input_wrap {
	display: flex;
	flex-direction: column;
	gap: 1rem;
	margin-bottom: 1rem;
}
</style>

<script>
	$(document).ready(function() {
		$("div.err_msg").hide();

		$("input[id='${sessionScope.loginuser.gender}']").prop(
				"checked", true);
		/*
		$("div.div_input").bind("click", function(e) {
			$(e.target).parent().find("label").show();
			$(e.target).parent().find("p.c_placeholder_text").addClass("text_out");
			$(e.target).parent().find("input:text").focus();
		});
		 */
		 
		 // 월 에 한자리 수만 입력시 앞에 0 붙여주기
		 $("input#month").bind("change", function(e) {
			
			 if( $(e.target).val().length <2 ){
				 $(e.target).val("0"+$(e.target).val());
			 }
			 
		 });
		// 일 에 한자리 수만 입력시 앞에 0 붙여주기
		 $("input#day").bind("change", function(e) {
			
			 if( $(e.target).val().length <2 ){
				 $(e.target).val("0"+$(e.target).val());
			 }
			 
		 });

	});
	
		

	// 저장 버튼을 눌렀을 때
	function editBasicInfo() {

		const firstName = $("input#firstName").val().trim();
		const lastName = $("input#lastName").val().trim();
		const birth_d = $("input#day").val().trim();
		const birth_m = $("input#month").val().trim();
		const birth_y = $("input#year").val().trim();
		const mobile = $("input#mobile").val().trim();
		// 휴대폰 번호 정규식
		var regPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
		// 성, 이름 미입력 시, 생년월일 미입력 시 err_msg 띄워주기
		if (firstName == "") {
			alert("이름을 입력해주세요!")
			$("input#firstName").focus();
			return false;
		}
		if (lastName == "") {
			alert("성을 입력해주세요!")
			$("input#lastName").focus();
			return false;
		}
		if (birth_d == "") {
			alert("생년월일을 입력해주세요!")
			$("input#day").focus();
			return false;
		}
		if (birth_m == "") {
			alert("생년월일을 입력해주세요!")
			$("input#month").focus();
			return false;
		}
		if (birth_y == "") {
			alert("생년월일을 입력해주세요!")
			$("input#year").focus();
			return false;
		}
		if (!$("input:radio[name='gender']").is(":checked")) {
			alert("성별을 선택해주세요!")
			return false;
		}
		if (mobile != "" && !regPhone.test(mobile)) {
			alert("올바른 휴대폰 번호 양식으로 입력해주세요!")
			$("input#mobile").focus();
			return false;
		}
		

		const full_birth = birth_y + "-" + birth_m + "-" + birth_d;
		const full_name = lastName + " " + firstName;

		// 생년월일이 날짜 정규식에 맞지 않을 때
		if (!checkValidDate(full_birth)) {
			alert(full_birth);
			alert(full_name);
			alert("올바른 생년월일을 입력해주세요!");

			$("input#month").focus();
			requiredInfoCheck = false;
			return false;
		}
		// 생년월일이 날짜 정규식에는 맞으나 가입일보다 뒤에있을때
		var input_birth = new Date(full_birth);
		var today = new Date();

		if (input_birth >= today) {
			alert("올바른 생년 월일을 입력해주세요!");
			$("input#month").focus();
			return false;
		}

		// 이름, 생년월일, 성별 입력이 올바르게 되었을 때 name 과 birth 에 값을 넣어주고 frm submit()한다
		$("input:hidden[name='birth']").val(full_birth);
		$("input:hidden[name='name']").val(full_name);

		const frm = document.editBasicInfoFrm;
		frm.action = "user_EditBasicInfoEnd.exp";
		frm.method = "post";
		frm.submit();

	}// end of function checkCode() {}-----------------

	// *** 날짜 정규식 함수 *** //
	function checkValidDate(value) {
		var result = true;
		try {
			var date = value.split("-");
			var y = parseInt(date[0], 10), m = parseInt(date[1], 10), d = parseInt(
					date[2], 10);

			var dateRegex = /^(?=\d)(?:(?:31(?!.(?:0?[2469]|11))|(?:30|29)(?!.0?2)|29(?=.0?2.(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00)))(?:\x20|$))|(?:2[0-8]|1\d|0?[1-9]))([-.\/])(?:1[012]|0?[1-9])\1(?:1[6-9]|[2-9]\d)?\d\d(?:(?=\x20\d)\x20|$))?(((0?[1-9]|1[012])(:[0-5]\d){0,2}(\x20[AP]M))|([01]\d|2[0-3])(:[0-5]\d){1,2})?$/;
			result = dateRegex.test(d + '-' + m + '-' + y);
		} catch (err) {
			result = false;
		}
		return result;
	}// end of function checkValidDate(value) {}---------------------

	// 연락처 숫자만 입력 가능 + 하이픈 추가 함수
	function onInputHandler_tel() {

		let text_tel = $("input:text[id='mobile']");
		let tel_val = text_tel.val().replace(/\D/g, "");
		let tel_len = tel_val.length;
		let result = "";

		// 세번째 입력 숫자까지 그대로 출력
		if (tel_len < 4)
			result = tel_val;
		// 4번째에 "-" 추가 후 숫자입력
		else if (tel_len < 8) {
			result += tel_val.substring(0, 3);
			result += "-";
			result += tel_val.substring(3);
			// 9번째에 "-" 추가 후 숫자입력
		} else {
			result += tel_val.substring(0, 3);
			result += "-";
			result += tel_val.substring(3, 7);
			result += "-";
			result += tel_val.substring(7);
		}

		// 결과를 값으로 출력
		text_tel.val(result);
	}
	
</script>

<body style="background-color: white;">
	<div class="nav-top">
		<c:if test="${not empty sessionScope.loginuser.name}">
			<button id="goAccount" type="button"
				style="background: none; border: none; width: 48px; height: 48px"
				onclick="location.href='<%=ctxPath%>/account.exp'">
				<svg class="uitk-icon" aria-label="닫기" role="img" height="24"
					width="24" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"
					xmlns:xlink="http://www.w3.org/1999/xlink">
			<title id="undefined-close-toolbar-title">닫기</title>
			<path fill="#1668e3"
						d="M19 6.41 17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12 19 6.41z"></path></svg>
			</button>
		</c:if>
	</div>
	<div id="container"
		style="inline-size: 100%; margin: auto; max-inline-size: 85rem; padding: 50px 0;">
		<div class="login_section">
			<div>
				<h3>기본정보</h3>
				<div class="div_text">여행 관련 신분증(예: 여권 또는 면허증)과 일치하는 정보를 제공해
					주세요.</div>
			</div>
			<form name="editBasicInfoFrm">
				<div id="div_form">
					<div class="div_input_wrap">
						<h6>성명</h6>
						<div class="div_input">
							<label for="firstName" class="c_label">이름&nbsp;<span
								style="color: red;">*</span></label> <input type="text"
								class="input_code c_input" name="firstName" id="firstName"
								maxlength="64"
								value="${sessionScope.loginuser.name.split(' ')[1]}">
							<div class="c_placeholder_div" style="display: none;">
								<p class="c_placeholder_text" id="text_firstName">
									이름<span style="color: red;">*</span>
								</p>
							</div>
							<div class="err_msg" id="err_msg_firstName">이름을 입력해주세요</div>
						</div>
						<div class="div_input">
							<label for="lastName" class="c_label">성&nbsp;<span
								style="color: red;">*</span></label> <input type="text"
								class="input_code c_input" name="lastName" id="lastName"
								maxlength="64"
								value="${sessionScope.loginuser.name.split(' ')[0]}">
							<div class="c_placeholder_div"
								style="position: relative; display: none;">
								<p class="c_placeholder_text" id="text_lastName">
									성<span style="color: red;">*</span>
								</p>
							</div>
							<div class="err_msg" id="err_msg_lastName">성을 입력해주세요</div>
							<input type="hidden" name="name" readonly />
						</div>
					</div>
					<div class=div_input_wrap>
						<h6>생년월일</h6>
						<div class="div_birth_input">
							<div class="div_input">
								<label for="month" class="c_label">월</label> <input
									type="text" class="input_code c_input" name="month"
									id="month" max="12" pattern="[0-9]*" maxlength="2"
									placeholder="MM" oninput='this.value = this.value.replace(/\D/g, "")'
									value="${sessionScope.loginuser.birth.substring(5,7)}">
							</div>
							<div class="div_input">
								<label for="text" class="c_label">일</label> <input type="number"
									class="input_code c_input" name="day" id="day" max="31"
									pattern="[0-9]*" maxlength="2" placeholder="DD" oninput='this.value = this.value.replace(/\D/g, "")'
									value="${sessionScope.loginuser.birth.substring(8)}">
							</div>
							<div class="div_input">
								<label for="year" class="c_label">연도</label> <input
									type="text" class="input_code c_input" name="year" id="year"
									pattern="[0-9]*" maxlength="4" placeholder="YYYY" oninput='this.value = this.value.replace(/\D/g, "")'
									value="${sessionScope.loginuser.birth.substring(0,4)}">
							</div>
							<input type="hidden" name="birth" readonly />
							<div class="err_msg" id="err_msg_birth">생년월일을 입력해주세요</div>
						</div>
					</div>
					<div class=div_input_wrap>
						<h6 style="margin-top: 1.25rem;">휴대폰 번호</h6>
						<div class="div_input">
							<label for="mobile" class="c_label">전화번호&nbsp;<span
								style="color: red;">*</span></label> <input type="text"
								class="input_code c_input" name="mobile" id="mobile"
								pattern="[0-9]*" maxlength="13" oninput="onInputHandler_tel()"
								value="${sessionScope.loginuser.mobile}">
							<div class="c_placeholder_div" style="display: none;">
								<p class="c_placeholder_text" id="text_mobile">
									전화번호<span style="color: red;">*</span>
								</p>
							</div>
							<div class="err_msg" id="err_msg_mobile">휴대폰 번호를 입력해주세요</div>
						</div>
					</div>

					<fieldset class="uitk-form-grouped-fields">
						<fieldset class="uitk-form-grouped-fields">
							<h6
								class="uitk-heading uitk-heading-7 uitk-spacing uitk-spacing-margin-block-two">성별</h6>
							<fieldset class="uitk-radio-button-group">
								<legend class="is-visually-hidden">gender</legend>
								<div
									class="uitk-layout-flex uitk-layout-flex-flex-wrap-nowrap uitk-radio-button">
									<div
										class="uitk-layout-flex-item uitk-layout-flex-item-flex-grow-1 uitk-radio-button-content">
										<label
											class="uitk-radio-button-label uitk-radio-button-label-haslabelsuffix"
											for="F"><input type="radio" name="gender" id="F"
											class="" aria-label="여성" aria-describedby="" value="F"><span
											aria-hidden="true" class="uitk-radio-button-control"></span><span
											aria-hidden="false" class="uitk-radio-button-label-content">여성</span></label>
									</div>
								</div>
								<div
									class="uitk-layout-flex uitk-layout-flex-flex-wrap-nowrap uitk-radio-button">
									<div
										class="uitk-layout-flex-item uitk-layout-flex-item-flex-grow-1 uitk-radio-button-content">
										<label
											class="uitk-radio-button-label uitk-radio-button-label-haslabelsuffix"
											for="M"><input type="radio" name="gender" id="M"
											class="" aria-label="남성" aria-describedby="" value="M"><span
											aria-hidden="true" class="uitk-radio-button-control"></span><span
											aria-hidden="false" class="uitk-radio-button-label-content">남성</span></label>
									</div>
								</div>
								<div
									class="uitk-layout-flex uitk-layout-flex-flex-wrap-nowrap uitk-radio-button">
									<div
										class="uitk-layout-flex-item uitk-layout-flex-item-flex-grow-1 uitk-radio-button-content">
										<label
											class="uitk-radio-button-label uitk-radio-button-label-haslabelsuffix"
											for="N"><input type="radio" name="gender"
											id="N" class="" aria-label="특정하지 않음"
											aria-describedby="" value="N"><span
											aria-hidden="true" class="uitk-radio-button-control"></span><span
											aria-hidden="false" class="uitk-radio-button-label-content">특정하지 않음</span></label>
									</div>
								</div>
							</fieldset>
						</fieldset>

						<div class="c_btn_pri c_btn c_btn_lg" style="margin: 2rem 0 0 0;">
							<button type="button" id="btn_save"
								class="c_btn_pri c_btn c_btn_lg" onclick="editBasicInfo()">저장</button>
						</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>