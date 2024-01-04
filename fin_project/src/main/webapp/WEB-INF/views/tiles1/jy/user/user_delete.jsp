<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>
<script>
	
	function goDelete() {
		if( confirm("계정 삭제 시 동일 아이디로 재가입이 불가능합니다.\n그대로 삭제하시겠습니까?") ) {
			
			const frm = document.user_deleteFrm;
			frm.action = "<%= ctxPath%>/account/user_deleteEnd.exp";
			frm.method = "post";
			frm.submit();
			
		}
	}

	
</script>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/css/jy/user_delete.css" />
<body style="background-color: white;">
<button id="goAccount" type="button" style="background: none; border: none; width:48px; height: 48px" onclick="location.href='<%= ctxPath%>/account.exp'">
	<svg class="uitk-icon" aria-label="닫기" role="img" height="24" width="24" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
	<title id="undefined-close-toolbar-title">닫기</title>
	<path fill="#1668e3" d="M19 6.41 17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12 19 6.41z"></path></svg>
</button>
<div class="uitk-layout-flex uitk-layout-flex-align-items-center uitk-layout-flex-flex-direction-column uitk-layout-flex-gap-three">
	<form id="user_deleteFrm" name="user_deleteFrm"
		class="uitk-layout-flex-item uitk-spacing uitk-spacing-margin-blockend-twelve">
			<div class="uitk-layout-flex uitk-layout-flex-align-items-center uitk-layout-flex-flex-direction-column">
				<div
					class="uitk-spacing uitk-spacing-margin-block-four uitk-spacing-padding-inline-six uitk-layout-flex-item uitk-layout-flex-item-max-width-one_hundred_twelve">
					<div
						class="uitk-layout-flex uitk-layout-flex-flex-direction-column">
						<h1 class="uitk-heading uitk-heading-6 uitk-spacing uitk-spacing-margin-block-three uitk-layout-flex-item">
							계정 삭제</h1>
						<p class="uitk-subheading uitk-spacing uitk-spacing-margin-blockend-four uitk-layout-flex-item">계정을 삭제하는 이유를 알려주시겠어요?</p>
						<div class="uitk-layout-flex uitk-layout-flex-flex-wrap-nowrap uitk-switch uitk-checkbox">
							<input icon="check" id="tooManyEmail"
								name="tooManyEmail" type="checkbox"
								class="uitk-layout-flex-item uitk-layout-flex-item-flex-shrink-0"
								value="1"><span aria-hidden="true"
								class="uitk-layout-flex-item uitk-layout-flex-item-flex-shrink-0 uitk-switch-control"></span>
							<div class="uitk-layout-flex-item uitk-layout-flex-item-flex-grow-1 uitk-switch-content">
								<label class="uitk-checkbox-switch-label uitk-switch-label" for="tooManyEmail"><span>이메일 또는 알림이 너무 많음</span></label>
							</div>
						</div>
						<div
							class="uitk-layout-flex uitk-layout-flex-flex-wrap-nowrap uitk-switch uitk-checkbox">
							<input icon="check" id="haveOtherAccount"
								name="haveOtherAccount" type="checkbox"
								class="uitk-layout-flex-item uitk-layout-flex-item-flex-shrink-0"
								value="1"><span aria-hidden="true"
								class="uitk-layout-flex-item uitk-layout-flex-item-flex-shrink-0 uitk-switch-control"></span>
							<div class="uitk-layout-flex-item uitk-layout-flex-item-flex-grow-1 uitk-switch-content">
								<label class="uitk-checkbox-switch-label uitk-switch-label" for="haveOtherAccount"><span>다른 이메일로 계정이 있음</span></label>
							</div>
						</div>
						<div
							class="uitk-layout-flex uitk-layout-flex-flex-wrap-nowrap uitk-switch uitk-checkbox">
							<input icon="check" id="endTrip"
								name="endTrip" type="checkbox"
								class="uitk-layout-flex-item uitk-layout-flex-item-flex-shrink-0"
								value="1"><span aria-hidden="true"
								class="uitk-layout-flex-item uitk-layout-flex-item-flex-shrink-0 uitk-switch-control"></span>
							<div class="uitk-layout-flex-item uitk-layout-flex-item-flex-grow-1 uitk-switch-content">
								<label class="uitk-checkbox-switch-label uitk-switch-label" for="endTrip"><span>여행이 끝났으므로 이 계정이 필요 없음</span></label>
							</div>
						</div>
						<div
							class="uitk-layout-flex uitk-layout-flex-flex-wrap-nowrap uitk-switch uitk-checkbox">
							<input icon="check" id="badRsvExp"
								name="badRsvExp"
								type="checkbox"
								class="uitk-layout-flex-item uitk-layout-flex-item-flex-shrink-0"
								value="1"><span aria-hidden="true"
								class="uitk-layout-flex-item uitk-layout-flex-item-flex-shrink-0 uitk-switch-control"></span>
							<div class="uitk-layout-flex-item uitk-layout-flex-item-flex-grow-1 uitk-switch-content">
								<label class="uitk-checkbox-switch-label uitk-switch-label" for="badRsvExp"><span>예약 경험이 좋지 않았음</span></label>
							</div>
						</div>
						<div
							class="uitk-layout-flex uitk-layout-flex-flex-wrap-nowrap uitk-switch uitk-checkbox">
							<input icon="check" id="etc"
								name="etc" type="checkbox"
								class="uitk-layout-flex-item uitk-layout-flex-item-flex-shrink-0"
								value=""><span aria-hidden="true"
								class="uitk-layout-flex-item uitk-layout-flex-item-flex-shrink-0 uitk-switch-control"></span>
							<div
								class="uitk-layout-flex-item uitk-layout-flex-item-flex-grow-1 uitk-switch-content">
								<label class="uitk-checkbox-switch-label uitk-switch-label" for="etc"><span>기타</span></label>
							</div>
						</div>
						<button type="button" onclick="goDelete()" class="uitk-button uitk-button-large uitk-button-has-text uitk-button-primary uitk-spacing replay-reveal uitk-spacing-margin-blockstart-twelve uitk-layout-flex-item">제출하기</button>
						<button id="tell-us-why-skip" type="button" onclick="goDelete()" class="uitk-button uitk-button-large uitk-button-has-text uitk-button-tertiary uitk-spacing uitk-spacing-margin-blockstart-two uitk-layout-flex-item">건너뛰기</button>
					</div>
				</div>
			</div>
		</form>
	</form>
</div>
</body>