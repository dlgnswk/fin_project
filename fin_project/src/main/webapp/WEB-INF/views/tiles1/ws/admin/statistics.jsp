<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	String ctxPath = request.getContextPath();
    //      /board
%> 
<title>통계 페이지</title>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/css/com_expedia.css" />

<style>

	.side_menu_container > a {
		color:black;
	}
	
	.side_menu_container > a:hover {
		text-decoration: none;
	}
	
	<%-- 차트 css 시작 --%>
	
	.highcharts-figure,
	.highcharts-data-table table {
	    min-width: 310px;
	    max-width: 800px;
	    margin: 1em auto;
	}
	
	#container {
	    height: 400px;
	}
	
	.highcharts-data-table table {
	    font-family: Verdana, sans-serif;
	    border-collapse: collapse;
	    border: 1px solid #ebebeb;
	    margin: 10px auto;
	    text-align: center;
	    width: 100%;
	    max-width: 500px;
	}
	
	.highcharts-data-table caption {
	    padding: 1em 0;
	    font-size: 1.2em;
	    color: #555;
	}
	
	.highcharts-data-table th {
	    font-weight: 600;
	    padding: 0.5em;
	}
	
	.highcharts-data-table td,
	.highcharts-data-table th,
	.highcharts-data-table caption {
	    padding: 0.5em;
	}
	
	.highcharts-data-table thead tr,
	.highcharts-data-table tr:nth-child(even) {
	    background: #f8f8f8;
	}
	
	.highcharts-data-table tr:hover {
	    background: #f1f7ff;
	}
	
	
	<%-- 차트 css 끝 --%>
	
	div#table_container table {width: 100%}
   	div#table_container th, div#table_container td {border: solid 1px gray; text-align: center;} 
   	div#table_container th {background-color: #595959; color: white;} 
	


	
</style>

<script src="<%= ctxPath%>/resources/Highcharts-10.3.3/code/highcharts.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.3/code/modules/series-label.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.3/code/highcharts-more.js"></script>  <%--================ 버블 ================--%>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.3/code/modules/data.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.3/code/modules/drilldown.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.3/code/modules/exporting.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.3/code/modules/export-data.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.3/code/modules/accessibility.js"></script>


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
        
        <span class="uitk-badge-base uitk-badge-base-large uitk-badge-base-has-text uitk-badge-loyalty-global-lowtier">
         <span class="uitk-badge-base-text" aria-hidden="false">블루</span>
        </span>
       
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
      <svg style="width:20px;height:20px; margin:0 10px 0 0;"xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
		 <path d="M416 208c0 45.9-14.9 88.3-40 122.7L502.6 457.4c12.5 12.5 12.5 32.8 0 45.3s-32.8 12.5-45.3 0L330.7 376c-34.4 25.2-76.8 40-122.7 40C93.1 416 0 322.9 0 208S93.1 0 208 0S416 93.1 416 208zM208 352a144 144 0 1 0 0-288 144 144 0 1 0 0 288z"/>
	 </svg>
     </div>
     <div class="uitk-card-content-section uitk-card-content-section-padded uitk-layout-flex-item uitk-layout-flex-item-flex-grow-1">
      <a target="_self" href="<%= ctxPath%>/searchUser.exp" rel="noreferrer" class="uitk-card-link"><span class="is-visually-hidden">회원 관리</span></a>
      <div class="uitk-text uitk-type-400 uitk-text-default-theme uitk-spacing uitk-spacing-margin-block-half">회원 관리</div>
     </div>
     <div class="uitk-card-content-section uitk-card-content-section-padded-block-start uitk-card-content-section-padded-block-end uitk-card-content-section-padded-inline-end uitk-layout-flex-item-align-self-center uitk-layout-flex-item uitk-layout-flex-item-flex-grow-0">
      <svg class="uitk-icon uitk-icon-directional" aria-describedby="chevron_right-description" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><desc id="chevron_right-description">chevron</desc>
       <path d="M10 6 8.59 7.41 13.17 12l-4.58 4.59L10 18l6-6-6-6z"></path>
      </svg>
     </div>
    </div>
    <div class="uitk-layout-flex uitk-card uitk-card-roundcorner-all uitk-card-has-primary-theme">
    <div class="uitk-card-content-section uitk-card-content-section-padded-block-start uitk-card-content-section-padded-block-end uitk-card-content-section-padded-inline-start uitk-layout-flex-item-align-self-center uitk-layout-flex-item uitk-layout-flex-item-flex-grow-0">
     <svg style="width:25px;height:25px; margin:0 5px 0 0;" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512">
		<path d="M192 0c-41.8 0-77.4 26.7-90.5 64H64C28.7 64 0 92.7 0 128V448c0 35.3 28.7 64 64 64H320c35.3 0 64-28.7 64-64V128c0-35.3-28.7-64-64-64H282.5C269.4 26.7 233.8 0 192 0zm0 64a32 32 0 1 1 0 64 32 32 0 1 1 0-64zM305 273L177 401c-9.4 9.4-24.6 9.4-33.9 0L79 337c-9.4-9.4-9.4-24.6 0-33.9s24.6-9.4 33.9 0l47 47L271 239c9.4-9.4 24.6-9.4 33.9 0s9.4 24.6 0 33.9z"/>
	</svg>
    </div>
    <div class="uitk-card-content-section uitk-card-content-section-padded uitk-layout-flex-item uitk-layout-flex-item-flex-grow-1">
     <a target="_self" href="<%= ctxPath%>/searchHost.exp" rel="noreferrer" class="uitk-card-link"><span class="is-visually-hidden">사업자 승인 관리</span></a>
     <div class="uitk-text uitk-type-400 uitk-text-default-theme uitk-spacing uitk-spacing-margin-block-half">사업자 승인 관리</div>
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
     <svg style="width:25px;height:25px; margin:0 5px 0 0;" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
		<path d="M0 32C0 14.3 14.3 0 32 0H480c17.7 0 32 14.3 32 32s-14.3 32-32 32V448c17.7 0 32 14.3 32 32s-14.3 32-32 32H304V464c0-26.5-21.5-48-48-48s-48 21.5-48 48v48H32c-17.7 0-32-14.3-32-32s14.3-32 32-32V64C14.3 64 0 49.7 0 32zm96 80v32c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16V112c0-8.8-7.2-16-16-16H112c-8.8 0-16 7.2-16 16zM240 96c-8.8 0-16 7.2-16 16v32c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16V112c0-8.8-7.2-16-16-16H240zm112 16v32c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16V112c0-8.8-7.2-16-16-16H368c-8.8 0-16 7.2-16 16zM112 192c-8.8 0-16 7.2-16 16v32c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16V208c0-8.8-7.2-16-16-16H112zm112 16v32c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16V208c0-8.8-7.2-16-16-16H240c-8.8 0-16 7.2-16 16zm144-16c-8.8 0-16 7.2-16 16v32c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16V208c0-8.8-7.2-16-16-16H368zM328 384c13.3 0 24.3-10.9 21-23.8c-10.6-41.5-48.2-72.2-93-72.2s-82.5 30.7-93 72.2c-3.3 12.8 7.8 23.8 21 23.8H328z"/>
	</svg>
    </div>
    <div class="uitk-card-content-section uitk-card-content-section-padded uitk-layout-flex-item uitk-layout-flex-item-flex-grow-1">
     <a target="_self" href="<%= ctxPath%>/searchLodge.exp" rel="noreferrer" class="uitk-card-link"><span class="is-visually-hidden">숙박시설 승인 관리</span></a>
     <div class="uitk-text uitk-type-400 uitk-text-default-theme uitk-spacing uitk-spacing-margin-block-half">숙박시설 승인 관리</div>
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
    	<svg style="width:25px;height:25px; margin:0 5px 0 0;" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"><path fill="#000000" d="M304 240V16.6c0-9 7-16.6 16-16.6C443.7 0 544 100.3 544 224c0 9-7.6 16-16.6 16H304zM32 272C32 150.7 122.1 50.3 239 34.3c9.2-1.3 17 6.1 17 15.4V288L412.5 444.5c6.7 6.7 6.2 17.7-1.5 23.1C371.8 495.6 323.8 512 272 512C139.5 512 32 404.6 32 272zm526.4 16c9.3 0 16.6 7.8 15.4 17c-7.7 55.9-34.6 105.6-73.9 142.3c-6 5.6-15.4 5.2-21.2-.7L320 288H558.4z"/></svg>
    </div>
    <div class="uitk-card-content-section uitk-card-content-section-padded uitk-layout-flex-item uitk-layout-flex-item-flex-grow-1">
     <a target="_self" href="<%= ctxPath%>/statistics.exp" rel="noreferrer" class="uitk-card-link"><span class="is-visually-hidden">통계</span></a>
     <div class="uitk-text uitk-type-400 uitk-text-default-theme uitk-spacing uitk-spacing-margin-block-half">통계</div>
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
     	<div>
			<h2>
				<svg style="width:35px;height:35px; margin:0 5px 0 0;" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"><path fill="#000000" d="M304 240V16.6c0-9 7-16.6 16-16.6C443.7 0 544 100.3 544 224c0 9-7.6 16-16.6 16H304zM32 272C32 150.7 122.1 50.3 239 34.3c9.2-1.3 17 6.1 17 15.4V288L412.5 444.5c6.7 6.7 6.2 17.7-1.5 23.1C371.8 495.6 323.8 512 272 512C139.5 512 32 404.6 32 272zm526.4 16c9.3 0 16.6 7.8 15.4 17c-7.7 55.9-34.6 105.6-73.9 142.3c-6 5.6-15.4 5.2-21.2-.7L320 288H558.4z"/></svg>
				통계 정보 관리
			</h2>

			<div id="mypage_right" style="display:abslute;">
				<div style="width: 100%; min-height: 1100px; margin: auto;">	
					<form name="searchFrm" style="margin: 20px 0 50px 0;">
						<select name="searchType" id="searchType" style="height: 30px;">
							<option value="">통계선택하세요</option>
							<option value="yearGenderUser">년도별 성별 등록 회원수</option>
							<option value="regionOccupancy">행정구역별 숙박시설 개수</option> <%-- 행정구역별 숙박시설 점유율 --%>
							<option value="quatorTotalReservation">분기별 숙박시설 전체 예약건수</option>
						</select>
					</form>
					<div id="chart_container"></div>
					<div id="table_container" style="margin: 40px 0 0 0;"></div>
				</div>
			</div>
			
			
<script type="text/javascript">

	$(document).ready(function(){
		// 로그아웃 버튼 마우스 올릴때 색 바뀌기
		$("button.btn_logOut").bind("mouseover",function(e){
			$(e.target).css('background-color','#ECF4FD')
		});
		
		$("button.btn_logOut").bind("mouseout",function(e){
			$(e.target).css('background-color','')
		});
		
		
		$("select#searchType").change(function(e){
			func_choice($(this).val());
		});
		
		// 문서가 로드 되어지면 페이지가  보이도록 한다.
		$("select#searchType").val("yearGenderUser").trigger("change");
		

	});	// end of $(document).ready(function(){})----------------
	
	
	// Function Declaration
	function func_choice(searchTypeVal){
		
		switch (searchTypeVal) {
		case "" : // 통계선택하세요 를 선택한 경우
			$("div#chart_container").empty();
			$("div#table_container").empty();
			$("div.highcharts-data-table").empty();
			break;
			
		case "yearGenderUser" : // 년도별 성별 등록 회원수 를 선택한 경우
			
		$.ajax({
			url:"<%= ctxPath%>/admin/yearGenderUser.exp",
			dataType:"json",
			success:function(json){
				// alert(JSON.stringify(json));
				
				$("div#chart_container").empty();
				$("div#table_container").empty();
				$("div.highcharts-data-table").empty();
				
				let resultArr = [];
				
				for(let i=0;i<json.length;i++){
					let registerYear_Arr = [];
					registerYear_Arr.push(Number(json[i].Y2016));
					registerYear_Arr.push(Number(json[i].Y2017));
					registerYear_Arr.push(Number(json[i].Y2018));
					registerYear_Arr.push(Number(json[i].Y2019));
					registerYear_Arr.push(Number(json[i].Y2020));
					registerYear_Arr.push(Number(json[i].Y2021));
					registerYear_Arr.push(Number(json[i].Y2022));
					registerYear_Arr.push(Number(json[i].Y2023));
					
					let obj = {
					        name:json[i].gender,
					        data:registerYear_Arr};
					resultArr.push(obj);
					
				} // end of for-----------------
				
				////////////////////////////////////////////////
				
				Highcharts.chart('chart_container', {

			    title: {
			        text: '2016-2023 익스피디아 성별  년도별 등록 회원수 '
			    },
			
			    subtitle: {
			        text: 'Source: <a href="http://localhost:9090/expedia/searchUser.exp" target="_blank">Expedia.user</a>'
			    },
			
			    yAxis: {
			        title: {
			            text: '등록 회원수'
			        }
			    },
			
			    xAxis: {
			        accessibility: {
			            rangeDescription: '범위: 2016 to 2023'
			        }
			    },
			
			    legend: {
			        layout: 'vertical',
			        align: 'right',
			        verticalAlign: 'middle'
			    },
			
			    plotOptions: {
			        series: {
			            label: {
			                connectorAllowed: false
			            },
			            pointStart: 2016
			        }
			    },
			
			    series: resultArr,
			
			    responsive: {
			        rules: [{
			            condition: {
			                maxWidth: 500
			            },
			            chartOptions: {
			                legend: {
			                    layout: 'horizontal',
			                    align: 'center',
			                    verticalAlign: 'bottom'
			                }
			            }
			        }]
			    }

			});
			
			////////////////////////////////////////////////
			
			let v_html = "<table>";
			
			v_html += "<tr>" +
						"<th>성별</th>" + 
						"<th>2016년</th>" + 
						"<th>2017년</th>" +
						"<th>2018년</th>" +
						"<th>2019년</th>" +
						"<th>2020년</th>" +
						"<th>2021년</th>" +
						"<th>2022년</th>" +
						"<th>2023년</th>" +
					  "</tr>";
		  
		  	$.each(json, function(index,item){
		  		v_html += "<tr>" +
		  					"<td>"+item.gender+"</td>" +
		  					"<td>"+item.Y2016+"</td>" +
		  					"<td>"+item.Y2017+"</td>" +
		  					"<td>"+item.Y2018+"</td>" +
		  					"<td>"+item.Y2019+"</td>" +
		  					"<td>"+item.Y2020+"</td>" +
		  					"<td>"+item.Y2021+"</td>" +
		  					"<td>"+item.Y2022+"</td>" +
		  					"<td>"+item.Y2023+"</td>" +
		  				  "</tr>";
		  	});			 
		  	
				v_html += "</table>";
			  	
			  	$("div#table_container").html(v_html);
			
			},
			error: function(request, status, error){
            	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
           	}
		});
			
			break;
			
		case "regionOccupancy": // 행정구역별 숙박시설 점유율 를 선택한 경우
			$.ajax({
				url:"<%= ctxPath%>/chart/regionOccupancy.exp",
				dataType:"json",
				success:function(json){
					// alert(JSON.stringify(json));
					
					$("div#chart_container").empty();
					$("div#table_container").empty();
					$("div.highcharts-data-table").empty();
					
					let regionnameArr = [];
					
					$.each(json,function(index,item){
						regionnameArr.push({name: item.lg_area,
		                                       y: Number(item.cnt),  //y: Number(item.percentage), 
		                               drilldown: item.lg_area});	
					});
					
					
					let lodgeQtyArr = []; // 특정 행정구역에 존재하는 숙박시설들 중 객실수의 퍼센티지
					
					$.each(json,function(index,item){
						$.ajax({
							url:"<%= ctxPath%>/chart/lodgeQtyPercentage.exp",
							data:{"lg_area":item.lg_area},
							dataType:"json",
							success:function(json2){  //success:function(json) json 이름 충돌되서 에러난다. json2 로 변경한다.
								// alert(JSON.stringify(json2));
								
								let subArr = []; // [     [배열안의 배열 이걸말한다.]    ]
								
								$.each(json2,function(index2,item2){ // [ ["남",45],["여",45] ] 만들기
									
									subArr.push([item2.lg_name,
										         Number(item2.cnt)]);  //  Number(item2.percentage)]);
									
								}); // end of $.each(json2,function(index2,item2)---------------------------
								
								lodgeQtyArr.push({
										name: item.lg_area,
						                id: item.lg_area,
							                data: subArr	
								});		
								
							},
							error: function(request, status, error){
				            	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				           	}
							
						});
					}); // end of $.each(json,function(index,item){})---------------
					
					///////////////////////////////////////////////////////////
					Highcharts.chart('chart_container', {
					    chart: {
					        type: 'column'
					    },
					    title: {
					        align: 'left',
					        text: '행정구역별 숙박시설 개수와 숙박시설 당 객실수'
					    },
					    subtitle: {
					        align: 'left',
					        text: 'Click the columns to view versions. Source: <a href="http://localhost:9090/expedia/searchLodge.exp" target="_blank">Expedia.user</a>'
					    },
					    accessibility: {
					        announceNewData: {
					            enabled: true
					        }
					    },
					    xAxis: {
					        type: 'category'
					    },
					    yAxis: {
					        title: {
					            text: '개수'
					        }
					
					    },
					    legend: {
					        enabled: false
					    },
					    plotOptions: {
					        series: {
					            borderWidth: 0,
					            dataLabels: {
					                enabled: true,
					                format: '{point.y} 개'
					            }
					        }
					    },
					
					    tooltip: {
					        headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
					        pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y} 개</b> of total<br/>'
					    },
					
					    series: [
					        {
					            name: "행정구역",
					            colorByPoint: true,
					            data: regionnameArr
					        }
					    ],
					    drilldown: {
					        breadcrumbs: {
					            position: {
					                align: 'right'
					            }
					        },
					        series: lodgeQtyArr
					    }
					});
					///////////////////////////////////////////////////////////
				},
				error: function(request, status, error){
	            	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	           	}
			});
			break;	
			
		case "quatorTotalReservation" : // 분기별 숙박시설 전체 예약건수
			
			$.ajax({
				url:"<%= ctxPath%>/chart/quatorTotalReservation.exp",
				dataType:"json",
				success:function(json){
					// alert(JSON.stringify(json));
					/* [{"quator":"1분기","cnt":"1"},
						{"quator":"3분기","cnt":"1"},
						{"quator":"2분기","cnt":"1"},
						{"quator":"4분기","cnt":"3"}] */
								
					$("div#chart_container").empty();
					$("div#table_container").empty();
					$("div.highcharts-data-table").empty();

					let quatorCnt_Arr = [];

					for(let i=0;i<json.length;i++){
						
						quatorCnt_Arr.push([Number(json[i].cnt)]);

					} // end of for-----------------
					// alert("quatorCnt_Arr" + quatorCnt_Arr); // 1,1,1,3
					
					 
					////////////////////////////////////////////////
					
					Highcharts.chart('chart_container', {
				    chart: {
				        type: 'bar'
				    },
				    title: {
				        text: '분기별 숙박시설 전체 예약건수'
				    },
				    xAxis: {
				        categories: ['1분기', '2분기', '3분기', '4분기']
				    },
				    yAxis: {
				        min: 0,
				        title: {
				            text: '예약건수'
				        }
				    },
				    legend: {
				        reversed: true
				    },
				    plotOptions: {
				        series: {
				            stacking: 'normal',
				            dataLabels: {
				                enabled: true
				            }
				        }
				    },
				    series: [{
				        name: '예약건수',
				        data: quatorCnt_Arr
				    }]
				});
				
				////////////////////////////////////////////////
				
				let v_html = "<table>";
				
				v_html += "<tr>" +
							"<th>분기</th>" + 
							"<th>예약건수</th>" +
						  "</tr>";
			  
			  	$.each(json, function(index,item){
			  		v_html += "<tr>" +
			  					"<td>"+item.quator+"</td>" +
			  					"<td>"+item.cnt+" 건</td>" +
			  				  "</tr>";
			  	});			 
			  	
					v_html += "</table>";
				  	
				  	$("div#table_container").html(v_html);
				
				},
				error: function(request, status, error){
	            	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	           	}
			}); 
			
			break;
		}
		
		
		
		
	} // end of function func_choice(searchTypeVal)
	
	

</script>
			
			
			
			
		</div>
   </div>	
  </div>
 </div>
</div>
