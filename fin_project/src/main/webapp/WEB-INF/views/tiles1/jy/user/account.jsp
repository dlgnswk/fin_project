<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<%
	String ctxPath = request.getContextPath();
    //      /board
%> 
<title>마이 페이지</title>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/css/jy/common.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/css/jy/account.css" />

<script type="text/javascript">
	$(document).ready(function(){
		$("button.btn_logOut").bind("mouseover",function(e){
			$(e.target).css('background-color','#ECF4FD')
		});
		
		$("button.btn_logOut").bind("mouseout",function(e){
			$(e.target).css('background-color','')
		});
		
	});

	
</script>



<style>
</style>

<div class="uitk-view-row uitk-view-row-theme-secondary uitk-view-row-layout-centered uitk-view-row-adslot-false">
 <div class="uitk-layout-grid uitk-layout-grid-has-auto-columns uitk-layout-grid-has-columns uitk-layout-grid-has-columns-by-large uitk-layout-grid-has-space uitk-layout-grid-display-grid uitk-spacing uitk-spacing-margin-small-block-six uitk-spacing-margin-large-block-six uitk-spacing-margin-large-inlinestart-six" style="--uitk-layoutgrid-auto-columns: minmax(var(--uitk-layoutgrid-egds-size__0x), 1fr); --uitk-layoutgrid-columns: repeat(1, minmax(0, 1fr)); --uitk-layoutgrid-columns-large: minmax(var(--uitk-layoutgrid-egds-size__76x), var(--uitk-layoutgrid-egds-size__76x)) 2fr; --uitk-layoutgrid-column-gap: var(--uitk-layoutgrid-space-six); --uitk-layoutgrid-row-gap: var(--uitk-layoutgrid-space-six);">


<%--================ 왼쪽 색션 시작 ================--%>	
  <div id="dashboard-content">
   <div id="dashboard-heading-section">
    <div class="uitk-spacing uitk-spacing-padding-blockend-six">
     <div class="uitk-layout-flex uitk-layout-flex-flex-direction-column uitk-card uitk-card-roundcorner-all uitk-card-has-primary-theme">
      <div class="uitk-card-content-section uitk-card-content-section-padded uitk-layout-flex-item">
       <div class="uitk-layout-flex uitk-layout-flex-align-items-center uitk-layout-flex-gap-one uitk-layout-flex-flex-wrap-wrap">
        <div class="uitk-layout-flex uitk-layout-flex-flex-direction-column uitk-layout-flex-item uitk-layout-flex-item-flex-grow-1">
         <h3 class="uitk-heading uitk-heading-6">안녕하세요, ${sessionScope.loginuser.name} 님!</h3>
         <div class="uitk-text overflow-wrap uitk-type-300 uitk-text-default-theme">${sesseionScope.loginuser.userid}</div>
        </div>
        <c:if test="${sessionScope.loginuser.user_lvl eq '블루'}">
	        <span class="uitk-badge-base uitk-badge-base-large uitk-badge-base-has-text uitk-badge-loyalty-global-lowtier">
	         <span class="uitk-badge-base-text" aria-hidden="false">블루</span>
	        </span>
        </c:if>
        <c:if test="${sessionScope.loginuser.user_lvl eq '실버'}">
	        <span class="uitk-badge-base uitk-badge-base-large uitk-badge-base-has-text uitk-badge-loyalty-global-middletier">
	         <span class="uitk-badge-base-text" aria-hidden="false">실버</span>
	        </span>
        </c:if>
        <c:if test="${sessionScope.loginuser.user_lvl eq '골드'}">
	        <span class="uitk-badge-base uitk-badge-base-large uitk-badge-base-has-text uitk-badge-loyalty-global-hightier">
	         <span class="uitk-badge-base-text" aria-hidden="false">골드</span>
	        </span>
        </c:if>       
       </div>
      </div>
     <div class="uitk-card-content-section uitk-card-content-section-padded-block-end uitk-card-content-section-padded-inline-start uitk-card-content-section-padded-inline-end uitk-layout-flex-item">
       <div class="uitk-layout-flex uitk-layout-flex-flex-direction-column">
        <div class="uitk-layout-flex uitk-layout-flex-align-items-center">
         <div class="uitk-text uitk-type-300 uitk-text-default-theme uitk-layout-flex-item">포인트 가치 <sup></sup></div>
         <button type="button" class="uitk-button uitk-button-small uitk-button-tertiary">
          <svg class="uitk-icon uitk-icon-small uitk-icon-default-theme" aria-describedby="info_outline-description" aria-label="info_outline" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
           <title id="info_outline-title">info_outline</title>
           <desc id="info_outline-description">자세한 정보</desc>
           <path fill-rule="evenodd" d="M2 12a10 10 0 1 1 20 0 10 10 0 0 1-20 0zm11-1v6h-2v-6h2zm-1 9a8.01 8.01 0 0 1 0-16 8.01 8.01 0 0 1 0 16zm1-13v2h-2V7h2z" clip-rule="evenodd"></path>
         </svg>
        </button>
       </div>
       <h3 class="uitk-heading uitk-heading-6">₩ ${sessionScope.loginuser.point}</h3>
      </div>
     </div>
     <div class="uitk-card-content-section uitk-card-content-section-padded-block-end uitk-card-content-section-padded-inline-start uitk-card-content-section-padded-inline-end uitk-layout-flex-item">
      <a href="<%= ctxPath%>/user_rewards.exp" aria-label="">
       <div class="uitk-layout-flex uitk-layout-flex-align-items-center uitk-layout-flex-gap-four">
        <div class="uitk-text uitk-type-300 uitk-text-global-loyalty-theme uitk-layout-flex-item uitk-layout-flex-item-flex-grow-1">리워드 적립 현황 보기</div>
        <svg class="uitk-icon uitk-layout-flex-item uitk-icon-directional uitk-icon-default-theme" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path d="M10 6 8.59 7.41 13.17 12l-4.58 4.59L10 18l6-6-6-6z"></path></svg>
       </div>
      </a>
     </div>
    </div>
   </div>
  </div>
  <div>
   <div class="uitk-text uitk-type-300 uitk-text-default-theme">모든 브랜드의 프로필, 리워드와 기본 설정을 한 곳에서 관리해 보세요.</div>
   <div class="uitk-layout-flex uitk-layout-flex-justify-content-center uitk-layout-flex-gap-four uitk-spacing uitk-spacing-padding-blockstart-six">
    <img class="uitk-mark uitk-mark-landscape-oriented" alt="익스피디아 로고" src="https://a.travel-assets.com/egds/marks/onekey__expedia.svg" id="expedia.com" style="--uitk-mark-token-size: var(--mark-size-5);">
    <img class="uitk-mark uitk-mark-landscape-oriented" alt="호텔스닷컴 로고" src="https://a.travel-assets.com/egds/marks/onekey__hotels__english.svg" id="hotels.com" style="--uitk-mark-token-size: var(--mark-size-5);">
    <img class="uitk-mark uitk-mark-landscape-oriented" alt="Vrbo 로고" src="https://a.travel-assets.com/egds/marks/onekey__vrbo.svg" id="vrbo.com" style="--uitk-mark-token-size: var(--mark-size-5);">
   </div>
   <div class="uitk-layout-flex uitk-layout-flex-flex-direction-column uitk-layout-flex-gap-four uitk-spacing uitk-spacing-padding-blockstart-six">
    <div class="uitk-layout-flex uitk-card uitk-card-roundcorner-all uitk-card-has-primary-theme">
     <div class="uitk-card-content-section uitk-card-content-section-padded-block-start uitk-card-content-section-padded-block-end uitk-card-content-section-padded-inline-start uitk-layout-flex-item-align-self-center uitk-layout-flex-item uitk-layout-flex-item-flex-grow-0">
      <svg class="uitk-icon" aria-describedby="person-description" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><desc id="person-description">프로필</desc>
       <path fill-rule="evenodd" d="M16 8a4 4 0 1 1-8 0 4 4 0 0 1 8 0zM4 18c0-2.66 5.33-4 8-4s8 1.34 8 4v2H4v-2z" clip-rule="evenodd"></path>
      </svg>
     </div>
     <div class="uitk-card-content-section uitk-card-content-section-padded uitk-layout-flex-item uitk-layout-flex-item-flex-grow-1">
      <a target="_self" href="<%= ctxPath%>/account.exp" rel="noreferrer" class="uitk-card-link"><span class="is-visually-hidden">프로필</span></a>
      <div class="uitk-text uitk-type-400 uitk-text-default-theme uitk-spacing uitk-spacing-margin-block-half">프로필</div>
     </div>
     <div class="uitk-card-content-section uitk-card-content-section-padded-block-start uitk-card-content-section-padded-block-end uitk-card-content-section-padded-inline-end uitk-layout-flex-item-align-self-center uitk-layout-flex-item uitk-layout-flex-item-flex-grow-0">
      <svg class="uitk-icon uitk-icon-directional" aria-describedby="chevron_right-description" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><desc id="chevron_right-description">chevron</desc>
       <path d="M10 6 8.59 7.41 13.17 12l-4.58 4.59L10 18l6-6-6-6z"></path>
      </svg>
     </div>
    </div>
    <div class="uitk-layout-flex uitk-card uitk-card-roundcorner-all uitk-card-has-primary-theme">
    <div class="uitk-card-content-section uitk-card-content-section-padded-block-start uitk-card-content-section-padded-block-end uitk-card-content-section-padded-inline-start uitk-layout-flex-item-align-self-center uitk-layout-flex-item uitk-layout-flex-item-flex-grow-0">
     <svg class="uitk-icon" aria-describedby="email-description" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
      <desc id="email-description">커뮤니케이션</desc>
      <path fill-rule="evenodd" d="M4 4h16a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2l.01-12A2 2 0 0 1 4 4zm8 9 8-5V6l-8 5-8-5v2l8 5z" clip-rule="evenodd"></path>
     </svg>
    </div>
    <div class="uitk-card-content-section uitk-card-content-section-padded uitk-layout-flex-item uitk-layout-flex-item-flex-grow-1">
     <a target="_self" href="<%= ctxPath%>/user_rewards.exp" rel="noreferrer" class="uitk-card-link"><span class="is-visually-hidden">포인트 내역</span></a>
     <div class="uitk-text uitk-type-400 uitk-text-default-theme uitk-spacing uitk-spacing-margin-block-half">포인트 내역</div>
    </div>
    <div class="uitk-card-content-section uitk-card-content-section-padded-block-start uitk-card-content-section-padded-block-end uitk-card-content-section-padded-inline-end uitk-layout-flex-item-align-self-center uitk-layout-flex-item uitk-layout-flex-item-flex-grow-0">
     <svg class="uitk-icon uitk-icon-directional" aria-describedby="chevron_right-description" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
      <desc id="chevron_right-description">chevron</desc>
      <path d="M10 6 8.59 7.41 13.17 12l-4.58 4.59L10 18l6-6-6-6z"></path>
     </svg>
    </div>
   </div>  
   <div class="uitk-layout-flex uitk-card uitk-card-roundcorner-all uitk-card-has-primary-theme">
    <div class="uitk-card-content-section uitk-card-content-section-padded-block-start uitk-card-content-section-padded-block-end uitk-card-content-section-padded-inline-start uitk-layout-flex-item-align-self-center uitk-layout-flex-item uitk-layout-flex-item-flex-grow-0">
     <svg class="uitk-icon" aria-describedby="local_offer-description" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
      <desc id="local_offer-description">쿠폰</desc>
      <path fill-rule="evenodd" d="m12.41 2.58 9 9c.77.77.78 2.07 0 2.83l-7 7a2 2 0 0 1-2.82.01l-9-9A2 2 0 0 1 2 11V4c0-1.1.9-2 2-2h7c.55 0 1.05.22 1.41.58zM4 5.5a1.5 1.5 0 1 0 3 0 1.5 1.5 0 0 0-3 0z" clip-rule="evenodd"></path>
     </svg>
    </div>
    <div class="uitk-card-content-section uitk-card-content-section-padded uitk-layout-flex-item uitk-layout-flex-item-flex-grow-1">
     <a target="_self" href="<%= ctxPath%>/myrvlist.exp" rel="noreferrer" class="uitk-card-link"><span class="is-visually-hidden">이용후기</span></a>
     <div class="uitk-text uitk-type-400 uitk-text-default-theme uitk-spacing uitk-spacing-margin-block-half">이용후기</div>
    </div>
    <div class="uitk-card-content-section uitk-card-content-section-padded-block-start uitk-card-content-section-padded-block-end uitk-card-content-section-padded-inline-end uitk-layout-flex-item-align-self-center uitk-layout-flex-item uitk-layout-flex-item-flex-grow-0">
     <svg class="uitk-icon uitk-icon-directional" aria-describedby="chevron_right-description" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
      <desc id="chevron_right-description">chevron</desc>
      <path d="M10 6 8.59 7.41 13.17 12l-4.58 4.59L10 18l6-6-6-6z"></path>
     </svg>
    </div>
   </div>
   <div class="uitk-layout-flex uitk-card uitk-card-roundcorner-all uitk-card-has-primary-theme">
    <div class="uitk-card-content-section uitk-card-content-section-padded-block-start uitk-card-content-section-padded-block-end uitk-card-content-section-padded-inline-start uitk-layout-flex-item-align-self-center uitk-layout-flex-item uitk-layout-flex-item-flex-grow-0">
     <svg class="uitk-icon" aria-describedby="local_offer-description" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
      <desc id="local_offer-description">쿠폰</desc>
      <path fill-rule="evenodd" d="m12.41 2.58 9 9c.77.77.78 2.07 0 2.83l-7 7a2 2 0 0 1-2.82.01l-9-9A2 2 0 0 1 2 11V4c0-1.1.9-2 2-2h7c.55 0 1.05.22 1.41.58zM4 5.5a1.5 1.5 0 1 0 3 0 1.5 1.5 0 0 0-3 0z" clip-rule="evenodd"></path>
     </svg>
    </div>
    <div class="uitk-card-content-section uitk-card-content-section-padded uitk-layout-flex-item uitk-layout-flex-item-flex-grow-1">
     <a target="_self" href="account/setting.exp" rel="noreferrer" class="uitk-card-link"><span class="is-visually-hidden">설정</span></a>
     <div class="uitk-text uitk-type-400 uitk-text-default-theme uitk-spacing uitk-spacing-margin-block-half">설정</div>
    </div>
    <div class="uitk-card-content-section uitk-card-content-section-padded-block-start uitk-card-content-section-padded-block-end uitk-card-content-section-padded-inline-end uitk-layout-flex-item-align-self-center uitk-layout-flex-item uitk-layout-flex-item-flex-grow-0">
     <svg class="uitk-icon uitk-icon-directional" aria-describedby="chevron_right-description" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
      <desc id="chevron_right-description">chevron</desc>
      <path d="M10 6 8.59 7.41 13.17 12l-4.58 4.59L10 18l6-6-6-6z"></path>
     </svg>
    </div>
   </div>   
   <div class="uitk-layout-flex uitk-layout-flex-flex-direction-column uitk-spacing uitk-spacing-padding-block-six uitk-spacing-padding-inline-six">
    <button type="button" class="uitk-button uitk-button-medium uitk-button-has-text uitk-button-tertiary" onclick="location.href='<%= ctxPath%>/logout.exp'">로그아웃</button>
   </div>
  </div>
 </div>
</div>
   <%--================ 왼쪽 색션 끝 ================--%>	
			
			
			
   <%--================ 오른쪽 색션 시작 ================--%>
   <div id="profile-content">
    <div role="main" class="uitk-spacing uitk-spacing-padding-large-block-twelve uitk-spacing-padding-large-inline-twelve uitk-card uitk-card-roundcorner-all uitk-card-has-primary-theme" style="--uitk-layoutgrid-auto-columns: minmax(var(--uitk-layoutgrid-egds-size__0x), 1fr); --uitk-layoutgrid-rows: 1fr 1fr; --uitk-layoutgrid-column-gap: var(--uitk-layoutgrid-space-four); --uitk-layoutgrid-row-gap: var(--uitk-layoutgrid-space-four);">
     <div class="uitk-layout-grid uitk-layout-grid-has-auto-columns uitk-layout-grid-has-rows uitk-layout-grid-has-space uitk-layout-grid-display-grid" style="--uitk-layoutgrid-auto-columns: minmax(var(--uitk-layoutgrid-egds-size__0x), 1fr); --uitk-layoutgrid-rows: 1fr 1fr; --uitk-layoutgrid-column-gap: var(--uitk-layoutgrid-space-four); --uitk-layoutgrid-row-gap: var(--uitk-layoutgrid-space-four);">
      <div id="profile-content-heading" class="uitk-layout-grid-item">
       <h1 class="uitk-heading uitk-heading-4">${sessionScope.loginuser.name}</h1>
      </div>
     </div>
     <div class="uitk-layout-grid uitk-layout-grid-has-auto-columns uitk-layout-grid-has-rows uitk-layout-grid-has-space uitk-layout-grid-display-grid" style="--uitk-layoutgrid-auto-columns: minmax(var(--uitk-layoutgrid-egds-size__0x), 1fr); --uitk-layoutgrid-rows: 1fr 1fr; --uitk-layoutgrid-column-gap: var(--uitk-layoutgrid-space-twelve); --uitk-layoutgrid-row-gap: var(--uitk-layoutgrid-space-twelve);">
      <div id="basic-info-section">
       <div class="uitk-layout-grid uitk-layout-grid-align-items-start uitk-layout-grid-has-auto-columns uitk-layout-grid-has-columns uitk-layout-grid-display-grid" style="--uitk-layoutgrid-auto-columns: minmax(var(--uitk-layoutgrid-egds-size__0x), 1fr); --uitk-layoutgrid-columns: 1fr auto;">
        <div class="uitk-layout-grid-item">
         <h3 class="uitk-heading uitk-heading-4">기본 정보</h3>
         <div class="uitk-text uitk-type-300 uitk-text-default-theme uitk-spacing uitk-spacing-margin-blockstart-two">여행 관련 신분증(예: 여권 또는 면허증)과 일치하는 정보를 제공해 주세요.</div>
        </div>
        <button type="button" class="uitk-button uitk-button-medium uitk-button-has-text uitk-button-tertiary" onclick="location.href='<%= ctxPath%>/user_EditBasicInfo.exp'">수정</button>
       </div>
       <div class="uitk-layout-grid uitk-layout-grid-has-auto-columns uitk-layout-grid-has-columns-by-large uitk-layout-grid-has-space uitk-layout-grid-display-grid uitk-spacing uitk-spacing-padding-blockstart-four" style="--uitk-layoutgrid-auto-columns: minmax(var(--uitk-layoutgrid-egds-size__0x), 1fr); --uitk-layoutgrid-columns-large: 1fr 1fr; --uitk-layoutgrid-row-gap: var(--uitk-layoutgrid-space-two);">
        <div>
         <h4 class="uitk-heading uitk-heading-7">이름</h4>
         <c:if test="${not empty sessionScope.loginuser.name}">
         	<div class="uitk-text uitk-type-300 uitk-text-default-theme uitk-spacing">${sessionScope.loginuser.name}</div>
         </c:if>
         <c:if test="${empty sessionScope.loginuser.name}">
         	<div class="uitk-text uitk-type-300 uitk-text-default-theme uitk-spacing">정보 미제공</div>
         </c:if>
        </div>
        <div>
         <h4 class="uitk-heading uitk-heading-7">휴대폰 번호</h4>
         <c:if test="${not empty sessionScope.loginuser.mobile}">
         	<div class="uitk-text uitk-type-300 uitk-text-default-theme uitk-spacing">${sessionScope.loginuser.mobile}</div>
         </c:if>	
         <c:if test="${empty sessionScope.loginuser.mobile}">
         	<div class="uitk-text uitk-type-300 uitk-text-default-theme uitk-spacing">정보 미제공</div>
         </c:if>	
        </div>
        <div>
         <h4 class="uitk-heading uitk-heading-7">생년월일</h4>
         <c:if test="${not empty sessionScope.loginuser.birth}">
         	<div class="uitk-text uitk-type-300 uitk-text-default-theme uitk-spacing">${sessionScope.loginuser.birth.substring(0,4)}년 ${sessionScope.loginuser.birth.substring(5,7)}월 ${sessionScope.loginuser.birth.substring(8)}일</div>
         </c:if>
         <c:if test="${empty sessionScope.loginuser.birth}">
         	<div class="uitk-text uitk-type-300 uitk-text-default-theme uitk-spacing">정보 미제공</div>
         </c:if>
        </div>
        <div>
	     <h4 class="uitk-heading uitk-heading-7">성별</h4>
	     <c:if test="${sessionScope.loginuser.gender eq 'F'}">
	     	<div class="uitk-text uitk-type-300 uitk-text-default-theme uitk-spacing">여성</div>
	     </c:if>
	     <c:if test="${sessionScope.loginuser.gender eq 'M'}">
	     	<div class="uitk-text uitk-type-300 uitk-text-default-theme uitk-spacing">남성</div>
	     </c:if>
	     <c:if test="${sessionScope.loginuser.gender eq 'N'}">
	     	<div class="uitk-text uitk-type-300 uitk-text-default-theme uitk-spacing">특정하지 않음</div>
	     </c:if>
	     <c:if test="${empty sessionScope.loginuser.gender}">
         	<div class="uitk-text uitk-type-300 uitk-text-default-theme uitk-spacing">정보 미제공</div>
         </c:if>	
	    </div>
	   </div>
	  </div>
      <div id="contact-info-section" style="margin-bottom: 3rem;">
       <div class="uitk-layout-grid uitk-layout-grid-align-items-start uitk-layout-grid-has-auto-columns uitk-layout-grid-has-columns uitk-layout-grid-display-grid" style="--uitk-layoutgrid-auto-columns: minmax(var(--uitk-layoutgrid-egds-size__0x), 1fr); --uitk-layoutgrid-columns: 1fr auto;">
        <div class="uitk-layout-grid-item">
         <h3 class="uitk-heading uitk-heading-4">연락처</h3>
	     <div class="uitk-text uitk-type-300 uitk-text-default-theme uitk-spacing uitk-spacing-margin-blockstart-two">정보를 공유하여 계정 활동 알림 및 여행 관련 업데이트를 받으실 수 있습니다.</div>
	    </div>
		<button type="button" class="uitk-button uitk-button-medium uitk-button-has-text uitk-button-tertiary" onclick="location.href='<%= ctxPath%>/user_EditContact.exp'">수정</button>
       </div>
       <div class="uitk-layout-grid uitk-layout-grid-has-auto-columns uitk-layout-grid-has-columns-by-large uitk-layout-grid-has-space uitk-layout-grid-display-grid uitk-spacing uitk-spacing-padding-blockstart-four" style="--uitk-layoutgrid-auto-columns: minmax(var(--uitk-layoutgrid-egds-size__0x), 1fr); --uitk-layoutgrid-columns-large: 1fr 1fr; --uitk-layoutgrid-row-gap: var(--uitk-layoutgrid-space-two);">
        <div>
         <h4 class="uitk-heading uitk-heading-7">휴대폰 번호</h4>
         <c:if test="${not empty sessionScope.loginuser.mobile}">
         	<div class="uitk-text uitk-type-300 uitk-text-default-theme uitk-spacing">${sessionScope.loginuser.mobile}</div>
         </c:if>	
         <c:if test="${empty sessionScope.loginuser.mobile}">
         	<div class="uitk-text uitk-type-300 uitk-text-default-theme uitk-spacing">정보 미제공</div>
         </c:if>
        </div>
        <div>
         <h4 class="uitk-heading uitk-heading-7">이메일</h4>
         <c:if test="${not empty sessionScope.loginuser.email}">
         	<div class="uitk-text uitk-type-300 uitk-text-default-theme uitk-spacing">${sessionScope.loginuser.email}</div>
         </c:if>
         <c:if test="${empty sessionScope.loginuser.email}">
         	<div class="uitk-text uitk-type-300 uitk-text-default-theme uitk-spacing">정보 미제공</div>
         </c:if>
        </div>
        <div>
         <h4 class="uitk-heading uitk-heading-7">비상 연락처</h4>
         <c:if test="${not empty sessionScope.loginuser.emer_phone}">
         	<div class="uitk-text uitk-type-300 uitk-text-default-theme uitk-spacing">${sessionScope.loginuser.emer_phone}</div>
         </c:if>
         <c:if test="${empty sessionScope.loginuser.emer_phone}">
         	<div class="uitk-text uitk-type-300 uitk-text-default-theme uitk-spacing">정보 미제공</div>
         </c:if>
        </div>
        <div>
         <h4 class="uitk-heading uitk-heading-7">주소</h4>
         <c:if test="${not empty sessionScope.loginuser.address}">
         	<div class="uitk-text uitk-type-300 uitk-text-default-theme uitk-spacing">${sessionScope.loginuser.address}, ${sessionScope.loginuser.detailAddress}<c:if test="${not empty sessionScope.loginuser.extraAddress}">${sessionScope.loginuser.extraAddress}</c:if> ${sessionScope.loginuser.postcode}</div>
         </c:if>
         <c:if test="${empty sessionScope.loginuser.address}">
         	<div class="uitk-text uitk-type-300 uitk-text-default-theme uitk-spacing">정보 미제공</div>
         </c:if>
        </div>
       </div>
      </div>
     </div>
    <%-- 추가정보 - 여권 / 다른여행객 추가 삭제
     <div id="more-details-additional-travelers-section">
      <div class="uitk-layout-grid uitk-layout-grid-has-auto-columns uitk-layout-grid-has-columns-by-large uitk-layout-grid-has-space uitk-layout-grid-display-grid" style="--uitk-layoutgrid-auto-columns: minmax(var(--uitk-layoutgrid-egds-size__0x), 1fr); --uitk-layoutgrid-columns-large: repeat(2, minmax(0, 1fr)); --uitk-layoutgrid-column-gap: var(--uitk-layoutgrid-space-twelve); --uitk-layoutgrid-row-gap: var(--uitk-layoutgrid-space-twelve);">
       <div id="more-details-section" class="uitk-layout-grid-item">
        <div id="more-details-section">
        <h3 class="uitk-heading uitk-heading-4">추가 정보</h3>
        <div class="uitk-text uitk-type-300 uitk-text-default-theme uitk-spacing uitk-spacing-margin-blockstart-two">필수 여행 정보를 안전하게 저장해 더 빠르게 예약해 보세요.</div>
        <div class="uitk-layout-flex uitk-layout-flex-flex-direction-column uitk-layout-flex-gap-four uitk-spacing uitk-spacing-padding-blockstart-four">
         <div class="uitk-card uitk-card-roundcorner-all uitk-card-has-border uitk-card-has-link uitk-card-has-primary-theme">
          <div class="uitk-layout-flex uitk-layout-flex-justify-content-space-between">
           <div class="uitk-card-content-section uitk-card-content-section-padded-block-start uitk-card-content-section-padded-block-end uitk-card-content-section-padded-inline-start uitk-layout-flex-item-align-self-center uitk-layout-flex-item uitk-layout-flex-item-flex-grow-0"></div>
           <div class="uitk-card-content-section uitk-card-content-section-padded uitk-layout-flex-item uitk-layout-flex-item-flex-grow-1 truncate">
            <h3 class="uitk-heading uitk-heading-6">여행에 필요한 문서</h3>
            <div class="uitk-text truncate-lines-2 uitk-type-400 uitk-text-default-theme">여권</div>
           </div>
           <div class="uitk-card-content-section uitk-card-content-section-padded-block-start uitk-card-content-section-padded-block-end uitk-card-content-section-padded-inline-end uitk-layout-flex-item-align-self-center uitk-layout-flex-item uitk-layout-flex-item-flex-grow-0">
            <svg class="uitk-icon uitk-icon-directional" aria-describedby="chevron_right-description" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
             <desc id="chevron_right-description">chevron</desc>
             <path d="M10 6 8.59 7.41 13.17 12l-4.58 4.59L10 18l6-6-6-6z"></path>
            </svg>
           </div>
          </div>
          <a href="/expedia/user_EditPassportInfo.exp" class="uitk-card-link">
           <span class="is-visually-hidden">/expedia/user_EditPassportInfo.exp</span>
          </a>
         </div>
        </div>
       </div>
      </div>
      <div id="additional-travelers-section" class="uitk-layout-grid-item">
       <section class="uitk-expando-list">
        <details open="" class="uitk-expando uitk-expando-list-item">
         <summary class="uitk-expando-trigger-content">
          <span class="uitk-expando-title">
           <h4 class="uitk-heading uitk-heading-4">다른 여행객</h4>
           <div class="uitk-text uitk-type-300 uitk-text-default-theme uitk-spacing uitk-spacing-margin-blockstart-two">여행에 자주 동행하는 가족, 친구 또는 동료의 프로필을 저장해 예약을 원활하게 진행하실 수 있어요.</div>
          </span>
          <svg class="uitk-icon uitk-expando-trigger-icon uitk-expando-trigger-icon-active" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
           <path d="M16.59 8.59 12 13.17 7.41 8.59 6 10l6 6 6-6-1.41-1.41z"></path>
          </svg>
         </summary>
         <div class="uitk-expando-body is-indented-trailing" data-testid="uitk-expando-list-body-expanded">
          <div class="uitk-expando-description">
           <div>
            <div class="uitk-spacing uitk-spacing-padding-blockstart-three">
             <div class="uitk-layout-flex uitk-layout-flex-flex-direction-column uitk-layout-flex-gap-two">
              <a target="_blank" href="/user/account/" rel="noreferrer" class="uitk-link uitk-link-align-left uitk-link-layout-default uitk-link-medium" role="link">Mihye Choi</a>
              <a target="_blank" href="/user/account/" rel="noreferrer" class="uitk-link uitk-link-align-left uitk-link-layout-default uitk-link-medium" role="link">JEONGHYUN YOON</a>
              <a target="_blank" href="/user/account/" rel="noreferrer" class="uitk-link uitk-link-align-left uitk-link-layout-default uitk-link-medium" role="link">Eunseon Yu</a>
              <div class="uitk-spacing uitk-spacing-padding-blockstart-three uitk-layout-flex-item">
               <a href="/user/account/" target="_blank" class="uitk-button uitk-button-medium uitk-button-fullWidth uitk-button-has-text uitk-button-as-link uitk-button-secondary">다른 여행객 추가</a>
              </div>
             </div>
            </div>
           </div>
          </div>
         </div>
        </details>
       </section>
      </div>
     </div>
    </div>
    --%>
   </div>	
  </div>
 </div>
</div>
