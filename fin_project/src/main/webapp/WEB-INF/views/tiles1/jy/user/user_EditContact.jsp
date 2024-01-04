<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%
	String ctxPath = request.getContextPath();
%>    
    
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/css/jy/account.css" />
<style>


</style>

<script>
	
	// Function Declaration
	// 저장 버튼 클릭 시
	function goEditContact() {
		
		const mobile = $("input#mobile").val().trim();
		const emer_phone = $("input#emer_phone").val().trim();
		// 휴대폰 번호 정규식 검사
		var regPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
		if (mobile != "" && !regPhone.test(mobile)) {
			alert("올바른 휴대폰 번호 양식으로 입력해주세요!")
			$("input#mobile").focus();
			return false;
		}
		if (emer_phone != "" && !regPhone.test(emer_phone)) {
			alert("올바른 휴대폰 번호 양식으로 입력해주세요!")
			$("input#emer_phone").focus();
			return false;
		}
		
		const frm = document.editContactFrm;
		frm.action ="user_EditContactEnd.exp";
		frm.method = "post";
		frm.submit();
		
	}

	// Function Declaration
	// 주소 검색 창 띄우기
	function searchAddress () {
		
		new daum.Postcode({
	    	oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            let addr = ''; // 주소 변수
	            let extraAddr = ''; // 참고항목 변수
	
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
	                // 조합된 참고항목을 해당 필드에 넣는다.
	                document.getElementById("extraAddress").value = extraAddr;
	            
	            } else {
	                document.getElementById("extraAddress").value = '';
	            }
	
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('postcode').value = data.zonecode;
	            document.getElementById("address").value = addr;
	            // 커서를 상세주소 필드로 이동한다.
	            document.getElementById("detailAddress").focus();
	        }
		
		}).open();
	
	// 주소를 읽기전용(readonly) 로 만들기
    $("input#address").attr("readonly", true);
		
	}
	
	// 연락처 숫자만 입력 가능 + 하이픈 추가 함수
	function onInputHandler_tel() {
		
		$("input.tel").bind("keyup",function(e){
			let text_tel = $(e.target);
			let tel_val = text_tel.val().replace(/\D/g, "");
			let tel_len = tel_val.length;
			let result = "";
			
			// 세번째 입력 숫자까지 그대로 출력
		    if(tel_len < 4) result = tel_val;
		    // 4번째에 "-" 추가 후 숫자입력
		    else if(tel_len < 8){
			  	result += tel_val.substring(0,3);
			    result += "-";
			    result += tel_val.substring(3);
		    // 9번째에 "-" 추가 후 숫자입력
		    } else{
			  	result += tel_val.substring(0,3);
			    result += "-";
			    result += tel_val.substring(3,7);
			    result += "-";
			    result += tel_val.substring(7);
		    }
		 	// 결과를 값으로 출력
			text_tel.val(result);
		})
		
		
				
	}
</script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<body style="background-color: white;">
	<div class="nav-top">
		<c:if test="${not empty sessionScope.loginuser.name}">
			<button id="goAccount" type="button" style="background: none; border: none; width:48px; height: 48px" onclick="location.href='<%= ctxPath%>/account.exp'">
				<svg class="uitk-icon" aria-label="닫기" role="img" height="24" width="24" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
				<title id="undefined-close-toolbar-title">닫기</title>
				<path fill="#1668e3" d="M19 6.41 17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12 19 6.41z"></path></svg>
			</button>
		</c:if>
	</div>

	<div class="uitk-sheet-content uitk-sheet-content-padded" style="display:flex; justify-content: center;">
		<div id="edit-contact-info-form" style="width: 480px;">
			<div class="uitk-layout-flex uitk-layout-flex-justify-content-center uitk-spacing uitk-spacing-margin-blockend-one">
				<div class="uitk-layout-flex-item uitk-layout-flex-item-max-width-120x">
					<h3 class="uitk-heading uitk-heading-4">연락처</h3>
					<div class="uitk-text uitk-type-300 uitk-text-default-theme uitk-spacing">정보를 공유하여 계정 활동 알림 및 여행 관련 업데이트를 받으실 수 있습니다.</div>
				</div>
			</div>
			<form name="editContactFrm" class="uitk-form has-required-indicator">
				<div class="uitk-layout-flex uitk-layout-flex-justify-content-center">
					<div class="uitk-layout-flex uitk-layout-flex-flex-direction-column uitk-layout-flex-gap-one uitk-layout-flex-item uitk-layout-flex-item-max-width-120x" style="flex-grow:1;">
						<div>
							<fieldset class="uitk-form-grouped-fields">
								<h6 class="uitk-heading uitk-heading-7 uitk-spacing uitk-spacing-margin-block-three">휴대폰 번호</h6>
								<div class="uitk-layout-grid uitk-layout-grid-has-auto-columns uitk-layout-grid-has-space uitk-layout-grid-display-grid"
									style="-uitk-layoutgrid-auto-columns: minmax(var(- -uitk-layoutgrid-egds-size__0x), 1fr); - -uitk-layoutgrid-column-gap: var(- -uitk-layoutgrid-space-three); - -uitk-layoutgrid-row-gap: var(- -uitk-layoutgrid-space-three);">
									<div class="uitk-layout-grid uitk-layout-grid-has-auto-columns uitk-layout-grid-has-columns uitk-layout-grid-has-space uitk-layout-grid-display-grid"
										style="-uitk-layoutgrid-auto-columns: minmax(var(- -uitk-layoutgrid-egds-size__0x), 1fr); - -uitk-layoutgrid-columns: repeat(2, minmax(0, 1fr)); - -uitk-layoutgrid-column-gap: var(- -uitk-layoutgrid-space-three); - -uitk-layoutgrid-row-gap: var(- -uitk-layoutgrid-space-three);">
										<div class="uitk-field has-floatedLabel-label">
											<label for="mobile" class="uitk-field-label is-visually-hidden">전화번호</label>
											<input id="mobile" type="tel" name="mobile" class="uitk-field-input tel" placeholder=""
											aria-required="false" aria-invalid="false" value="${sessionScope.loginuser.mobile}">
											<div class="uitk-field-label" aria-hidden="true">전화번호</div>
										</div>
									</div>									
								</div>
							</fieldset>
						</div>
						<div class="uitk-spacing uitk-spacing-margin-blockend-four" style="margin-top:2rem;">
							<fieldset class="uitk-form-grouped-fields">
								<h6 class="uitk-heading uitk-heading-7 uitk-spacing uitk-spacing-margin-blockend-two">비상 연락처</h6>
								<p class="uitk-subheading uitk-spacing uitk-spacing-margin-block-three">긴급 상황 발생 시 연락처</p>
								<div
									class="uitk-layout-grid uitk-layout-grid-has-auto-columns uitk-layout-grid-has-space uitk-layout-grid-display-grid"
									style="-uitk-layoutgrid-auto-columns: minmax(var(- -uitk-layoutgrid-egds-size__0x), 1fr); - -uitk-layoutgrid-column-gap: var(- -uitk-layoutgrid-space-three); - -uitk-layoutgrid-row-gap: var(- -uitk-layoutgrid-space-three); display:flex; flex-direction:column; gap: 0.75rem;">
									<div class="uitk-field has-floatedLabel-label">
										<label for="emer_name"
											class="uitk-field-label is-visually-hidden">연락받으실 분 이름</label>
											<input id="emer_name" type="text" name="emer_name"
											class="uitk-field-input" placeholder="" aria-required="false" aria-invalid="false" value="${sessionScope.loginuser.emer_name}">
										<div class="uitk-field-label" aria-hidden="true">연락받으실 분 이름</div>
									</div>
									<div>
										<fieldset class="uitk-form-grouped-fields">
											<div
												class="uitk-layout-grid uitk-layout-grid-has-auto-columns uitk-layout-grid-has-space uitk-layout-grid-display-grid"
												style="-uitk-layoutgrid-auto-columns: minmax(var(- -uitk-layoutgrid-egds-size__0x), 1fr); - -uitk-layoutgrid-column-gap: var(- -uitk-layoutgrid-space-three); - -uitk-layoutgrid-row-gap: var(- -uitk-layoutgrid-space-three);">
												<div
													class="uitk-layout-grid uitk-layout-grid-has-auto-columns uitk-layout-grid-has-columns uitk-layout-grid-has-space uitk-layout-grid-display-grid"
													style="-uitk-layoutgrid-auto-columns: minmax(var(- -uitk-layoutgrid-egds-size__0x), 1fr); - -uitk-layoutgrid-columns: repeat(2, minmax(0, 1fr)); - -uitk-layoutgrid-column-gap: var(- -uitk-layoutgrid-space-three); - -uitk-layoutgrid-row-gap: var(- -uitk-layoutgrid-space-three);">
													
													<div class="uitk-field has-floatedLabel-label">
														<label for="emer_phone"
															class="uitk-field-label is-visually-hidden">전화번호</label>
															<input id="emer_phone" type="tel" name="emer_phone" pattern="[0-9]*" maxlength="13"
																class="uitk-field-input tel" placeholder="" aria-required="false" aria-invalid="false" oninput="onInputHandler_tel()"
																value="${sessionScope.loginuser.emer_phone}">
														<div class="uitk-field-label" aria-hidden="true">전화번호</div>
													</div>
												</div>
											</div>
										</fieldset>
									</div>
								</div>
							</fieldset>
						</div>
						<div class="uitk-spacing uitk-spacing-margin-blockend-four">
							<h6 class="uitk-heading uitk-heading-7 uitk-spacing uitk-spacing-margin-block-two">이메일</h6>
							<p class="uitk-subheading uitk-spacing uitk-spacing-margin-block-three">${sessionScope.loginuser.email}</p>
							<p class="uitk-paragraph uitk-paragraph-2">설정에서 이메일을 변경하실 수 있습니다.</p>
						</div>
						<h6 class="uitk-heading uitk-heading-7 uitk-spacing uitk-spacing-margin-block-three">주소</h6>
						<fieldset class="uitk-form-grouped-fields" style="display: flex; flex-direction: column; gap: 0.75rem;">
							<div class="uitk-layout-flex uitk-layout-flex-flex-direction-column uitk-layout-flex-gap-three">
								<div class="uitk-field has-floatedLabel-label" onclick="searchAddress()">
									<label for="address" class="uitk-field-label is-visually-hidden">주소</label>
										<c:if test="${not empty sessionScope.loginuser.address}">
										<input id="address" type="text" name="address" class="uitk-field-input" placeholder="" aria-required="false"
										aria-invalid="false" value="${sessionScope.loginuser.address}" onclick="searchAddress()">
										</c:if>
										<c:if test="${empty sessionScope.loginuser.address}">
											<input id="address" type="text" name="address" class="uitk-field-input" placeholder="" aria-required="false"
											aria-invalid="false" value="" onclick="searchAddress()">
										</c:if>
									<div class="uitk-field-label" aria-hidden="true">주소</div>
								</div>
							</div>
							<div class="uitk-layout-flex uitk-layout-flex-flex-direction-column uitk-layout-flex-gap-three">
								<div class="uitk-field has-floatedLabel-label">
									<label for="detailAddress" class="uitk-field-label is-visually-hidden">상세 주소(아파트, 동, 호 등)</label>
										<input id="detailAddress" name="detailAddress" type="text" class="uitk-field-input empty-placeholder" placeholder=""
										aria-required="false" aria-invalid="false" value="${sessionScope.loginuser.detailAddress}">
									<div class="uitk-field-label" aria-hidden="true">상세 주소(아파트, 동, 호 등)</div>
								</div>
							</div>	
							<div class="uitk-layout-flex uitk-layout-flex-flex-direction-column uitk-layout-flex-gap-three">
								<div class="uitk-field has-floatedLabel-label">
									<label for="extraAddress" class="uitk-field-label is-visually-hidden">참고 주소</label>
									<input id="extraAddress" name="extraAddress" type="text" class="uitk-field-input empty-placeholder" placeholder="" readonly
									aria-required="false" aria-invalid="false" value="${sessionScope.loginuser.extraAddress}">
									<div class="uitk-field-label" aria-hidden="true">참고 주소</div>
								</div>
							</div>
							<div class="uitk-layout-flex uitk-layout-flex-flex-direction-column uitk-layout-flex-gap-three">	
								<div class="uitk-field has-floatedLabel-label">
									<label for="postcode"
										class="uitk-field-label is-visually-hidden">우편번호</label>
										<c:if test="${not empty sessionScope.loginuser.postcode}">
											<input id="postcode" type="text" name="postcode" class="uitk-field-input" placeholder="" readonly aria-required="false"
											aria-invalid="false" value="${sessionScope.loginuser.postcode}">
										</c:if>
										<c:if test="${empty sessionScope.loginuser.postcode}">
											<input id="postcode" type="text" name="postcode" class="uitk-field-input" placeholder="" readonly aria-required="false"
											aria-invalid="false" value="">
										</c:if>										
									<div class="uitk-field-label" aria-hidden="true">우편번호</div>
								</div>
							</div>
						</fieldset>
						<div class="uitk-layout-flex-item-align-self-center uitk-layout-flex-item">
							<div class="uitk-spacing uitk-spacing-margin-blockstart-four">
								<button type="button" class="uitk-button uitk-button-medium uitk-button-primary" onclick="goEditContact()">
									<div class="uitk-spacing uitk-spacing-padding-block-two uitk-spacing-padding-inline-six">저장</div>
								</button>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>

</body>