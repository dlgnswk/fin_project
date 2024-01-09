<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	String ctxPath = request.getContextPath();
    //      /board
%> 
<title>판매자 관리 페이지</title>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/css/com_expedia.css" />

<script type="text/javascript">

$(document).ready(function(){
	// 로그아웃 버튼 마우스 올릴때 색 바뀌기
	$("button.btn_logOut").bind("mouseover",function(e){
		$(e.target).css('background-color','#ECF4FD')
	});
	
	$("button.btn_logOut").bind("mouseout",function(e){
		$(e.target).css('background-color','')
	});
	
	
	// 검색 버튼 마우스 올릴때 색 바뀌기
	$("button.btn_search").bind("mouseover",function(e){
		$(e.target).css('background-color','#fde881')
	});
	
	$("button.btn_search").bind("mouseout",function(e){
		$(e.target).css('background-color','#fddb32')
	});
	
	
	
	// 승인허가 버튼 마우스 올릴때 색 바뀌기
	$("button.btn_approve").bind("mouseover",function(e){
		$(e.target).css('background-color','#33c9ff')
	});
	
	$("button.btn_approve").bind("mouseout",function(e){
		$(e.target).css('background-color','#00b0f0')
	});
	
	
	
	// 승인취소 버튼 마우스 올릴때 색 바뀌기
	$("button.btn_reject").bind("mouseover",function(e){
		$(e.target).css('background-color','#ff4d4d')
	});
	
	$("button.btn_reject").bind("mouseout",function(e){
		$(e.target).css('background-color','#cc0000')
	});
	
	
	// 검색 조건 유지시키기
	if(${not empty requestScope.paraMap}){
		$("select[name='searchType']").val("${requestScope.paraMap.searchType}");
		$("input[name='searchWord']").val("${requestScope.paraMap.searchWord}");
		$("select[name='lg_status']").val("${requestScope.paraMap.lg_status}");
	}
	
	// 검색어 입력시 자동글 완성하기
	$("div#displayList").hide();
	var isWordSelect = false;
	$("input[name='searchWord']").keyup(function(){
		
		var wordLength = $(this).val().trim().length;
		var srcWord = $(this).val();
		if(wordLength == 0) {
			$("div#displayList").hide();
		}
		else{
			if($("select[name='searchType']").val() == "fk_h_userid" 	 ||
			   $("select[name='searchType']").val() == "lg_name"   	 ||
			   $("select[name='searchType']").val() == "total_address") {
				   
				   $.ajax({
					  url:"<%= ctxPath%>/searchLodgeShow.exp",
					  type:"get",
					  data:{"searchType":$("select[name='searchType']").val(),
						    "searchWord":$("input[name='searchWord']").val()},
					  dataType:"json",
					  success:function(json){
						  // alert(JSON.stringify(json));
						  var searchArr = [];
						  
						  if(json.length > 0){
							  
							  $.each(json,function(index,item){
								  var search = item.search;
								 
								  if(search.includes(srcWord)){ // search 이라는 문자열에 searchWord 라는 문자열이 포함된 경우라면 true , 
									  searchArr.push(search);
									  }
								  
							  }); // end of each-----------------------------
							  
							  $("input[name='searchWord']").autocomplete({  // 참조 https://jqueryui.com/autocomplete/#default
									source:searchArr,
									select: function(event, ui) {       // 자동완성 되어 나온 공유자이름을 마우스로 클릭할 경우 
										
										$("input[name='searchWord']").val(ui.item.value);
										isWordSelect = true;
										return false;
							        },
							        focus: function(event, ui) {
							            return false;
							        }
								}); 
						  }
					  },
					  error: function(request, status, error){
			           		alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			            }
				   }); // $.ajax-----------------
			   } 
		}
	});
	
	
	$(document).on("click","span.result", function(e){
		const search = $(this).text();
		$("input[name='searchWord']").val(search); // 텍스트 박스에 검색된 결과의 문자열을 입력한다.
		$("div#displayList").hide();
	});
	
	$("input:text[name='searchWord']").bind("keydown",function(e){
		if(e.keyCode == 13){	// 엔터를 했을 경우
			if($("input[name='searchWord']").val().trim() != "" && isWordSelect == true){
				goSearch();
			}
		}
	});
}); // end of $(document).ready(function(){----------------


// Function Declaration
function goSearch(){
	const frm = document.searchFrm;
	frm.method = "get";
	frm.action = "<%= ctxPath%>/searchLodge.exp";
	frm.submit();
} // end of function goSearch()------------------------------



function goApprove(lodge_id){
	if(confirm("정말로 승인하시겠습니까?")){
		$.ajax({
			url:"<%= ctxPath%>/lodgeRegistrationApprove.exp",
			data:{"lodge_id":lodge_id},
			dataType:"json",
			type:"get",
			success:function(json){
				history.go(0);
			},
			error: function(request, status, error){
	       		alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		});
	}
} // end of function goApprove(lodge_id,target)




function goReject(lodge_id){
	if(confirm("정말로 승인을 취소하시겠습니까?")){
		$.ajax({
			url:"<%= ctxPath%>/lodgeRegistrationReject.exp",
			data:{"lodge_id":lodge_id},
			dataType:"json",
			type:"get",
			success:function(json){
				history.go(0);
			},
			error: function(request, status, error){
	       		alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		});
	}	
} // end of function goReject(lodge_id,target)

	
</script>



<style>
	
	.side_menu_container > a {
		color:black;
	}
	
	.side_menu_container > a:hover {
		text-decoration: none;
	}
	
	
	<%-- 테이블 시작--%>
	table{
		border:solid 0px black;
	}
	
	div#mypage_right {
	    padding-top: 45.5px;
	}
	
	div#mypage_right > table {
	    border-collapse:collapse;
	    width:100%;
	    margin-top:2%;
	}
	
	table tr {
		font-weight:normal;
	    height:42px;
	    border-bottom:solid 1px #C6C6C6;
	}
	
	td {
		text-align: center;
	    padding: 10px 0 10px 0;
	    font-size: 13px;
	}
	
	td.col_style{
		background-color:#cccccc;
		color:black;
		border:solid 1px black;
	}
	
	<%-- 테이블 끝--%>
	
	.third_tr, .second_tr{
		border-bottom:solid 2px rgb(25, 48, 130);
	}
	
	.dis_none1{
		display:none;
	} 
	.dis_none2{
		display:none;
	} 
	.dis_none3{
		display:none;
	} 

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
				<svg style="width:35px;height:35px; margin:0 5px 0 0;" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
					<path d="M0 32C0 14.3 14.3 0 32 0H480c17.7 0 32 14.3 32 32s-14.3 32-32 32V448c17.7 0 32 14.3 32 32s-14.3 32-32 32H304V464c0-26.5-21.5-48-48-48s-48 21.5-48 48v48H32c-17.7 0-32-14.3-32-32s14.3-32 32-32V64C14.3 64 0 49.7 0 32zm96 80v32c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16V112c0-8.8-7.2-16-16-16H112c-8.8 0-16 7.2-16 16zM240 96c-8.8 0-16 7.2-16 16v32c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16V112c0-8.8-7.2-16-16-16H240zm112 16v32c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16V112c0-8.8-7.2-16-16-16H368c-8.8 0-16 7.2-16 16zM112 192c-8.8 0-16 7.2-16 16v32c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16V208c0-8.8-7.2-16-16-16H112zm112 16v32c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16V208c0-8.8-7.2-16-16-16H240c-8.8 0-16 7.2-16 16zm144-16c-8.8 0-16 7.2-16 16v32c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16V208c0-8.8-7.2-16-16-16H368zM328 384c13.3 0 24.3-10.9 21-23.8c-10.6-41.5-48.2-72.2-93-72.2s-82.5 30.7-93 72.2c-3.3 12.8 7.8 23.8 21 23.8H328z"/>
				</svg>
				숙박시설 승인 관리
			</h2>

			<div id="mypage_right" style="display:abslute;">
				
				<form name="searchFrm">
					<select name="searchType" style="height:30px; width:103.5px;"> 
						<option value="fk_h_userid">아이디</option>
						<option value="lg_name">시설명</option>
						<option value="total_address">주소</option>
					</select>
					
					<input type="text" name="searchWord" size="40" style="line-height:27px;border:solid 1px black; margin-right:8%;" autocomplete="off" />
					<input type="text" style="display: none;" />
					
					<select name="lg_status" style="height:30px;"> 
						<option value="">승인여부</option>
						<option value="0">승인대기</option>
						<option value="1">승인완료</option>
					</select>
					
					<button type="button" class="btn_search" onclick="goSearch()" style="position:absolute; right:5.6%; border:solid 1px black; height:30px; width:100px; background-color:#fddb32; border-radius: 0.5rem; font-weight:bold; font-size:12pt;">검색</button>
				</form>
				
				<div id="displayList" style="position:absolute; background-color:#ffffff; border:solid 1px gray; border-top:0px; height:80px; width:335px; margin-left: 4.95%; overflow:auto;">
				</div>
				<table>
					<tbody>
						<tr>
							<td style="text-align:center;background-color:#193082; color:white; font-size: 16px;">숙박시설 정보 / 승인 관리</td>
						</tr>
					</tbody>
				</table>		
				<table id="lodge_info">
					
					
					<tbody>
					
					<%-- 숙소 정보 시작--%>				
						<c:if test="${empty requestScope.lodgeIdMapList}">
							등록된 숙박시설이 없습니다.
						</c:if>
						<c:if test="${not empty requestScope.lodgeIdMapList}">
							<c:forEach items="${requestScope.lodgeIdMapList}" var="lodgeRoomInfo">
								<c:forEach items="${lodgeRoomInfo}" var="lodgeRoom" varStatus="status">
									<c:if test="${status.index == 0}">
									<tr style="border-top:solid 2px white; border-bottom:solid 2px black;border-left:solid 2px white;border-right:solid 2px white"><td></td></tr>
										<tr>
											<td class="col_style">판매자ID</td>
											<td colspan="5">${lodgeRoom.fk_h_userid}</td>
											<td style="display:none;"> ${lodgeRoom.lodge_id}</td>
											<td style="padding:0;">
												<c:if test="${lodgeRoom.lg_status == 1}">
													<svg xmlns="http://www.w3.org/2000/svg" height="16" width="14" viewBox="0 0 448 512"><path fill="#008000" d="M438.6 105.4c12.5 12.5 12.5 32.8 0 45.3l-256 256c-12.5 12.5-32.8 12.5-45.3 0l-128-128c-12.5-12.5-12.5-32.8 0-45.3s32.8-12.5 45.3 0L160 338.7 393.4 105.4c12.5-12.5 32.8-12.5 45.3 0z"/></svg>
													승인된 시설
												</c:if>
												<c:if test="${lodgeRoom.lg_status == 0}">	
												</c:if>
											</td>
											<td>
												<c:if test="${lodgeRoom.lg_status == 1}">	
													<button type="button" class="btn_reject" onclick="goReject('${lodgeRoom.lodge_id}')" style="background-color:#cc0000; color:white; width:90px; height:30px; border-radius: 0.5rem;border:solid 1px black;">승인취소</button>
												</c:if>
												<c:if test="${lodgeRoom.lg_status == 0}">	
													<button type="button" class="btn_approve"onclick="goApprove('${lodgeRoom.lodge_id}')" style="background-color:#00b0f0; color:white; width:90px; height:30px; border-radius: 0.5rem;border:solid 1px black;">승인허가</button>
												</c:if>
											</td>
										</tr>
										<tr>
											<td class="col_style" colspan="8">시설명</th>
										</tr>
										<tr>
											<td colspan="8">${lodgeRoom.lg_name}(${lodgeRoom.lg_en_name})</th>
										</tr>
									
										<tr>
											<td colspan="3" rowspan="5" style="padding:0;"><image src="<%=ctxPath%>/resources/images/${lodgeRoom.lodge_id}/lodge_img/${lodgeRoom.lg_img_save_name}" style="width:250px;"> </image></td>
											<td class="col_style">주소</td>
											<td colspan="4">${lodgeRoom.total_address}</td>
										</tr>
										<tr>
											<td class="col_style">우편주소</td>
											<td colspan="4">${lodgeRoom.lg_postcode}</td>
										</tr>
										<tr>
											<td class="col_style">호텔등급</td>
											<c:if test="${lodgeRoom.lg_hotel_star == 0}">
												<td colspan="4">등급이 존재하지 않습니다.</td>
											</c:if>
											<c:if test="${lodgeRoom.lg_hotel_star == 1}">
												<td colspan="4">★</td>
											</c:if>
											<c:if test="${lodgeRoom.lg_hotel_star == 2}">
												<td colspan="4">★★</td>
											</c:if>
											<c:if test="${lodgeRoom.lg_hotel_star == 3}">
												<td colspan="4">★★★</td>
											</c:if>
											<c:if test="${lodgeRoom.lg_hotel_star == 4}">
												<td colspan="4">★★★★</td>
											</c:if>
											<c:if test="${lodgeRoom.lg_hotel_star == 5}">
												<td colspan="4">★★★★★</td>
											</c:if>
										</tr>
										<tr>
											<td class="col_style">숙박시설유형</td>
											<c:if test="${lodgeRoom.fk_lodge_type == 0}">
												<td colspan="4">호텔</td>
											</c:if>
											<c:if test="${lodgeRoom.fk_lodge_type == 1}">
												<td colspan="4">모텔</td>
											</c:if>
											<c:if test="${lodgeRoom.fk_lodge_type == 2}">
												<td colspan="4">레지던스</td>
											</c:if>
											<c:if test="${lodgeRoom.fk_lodge_type == 3}">
												<td colspan="4">리조트</td>
											</c:if>
											<c:if test="${lodgeRoom.fk_lodge_type == 4}">
												<td colspan="4">펜션</td>
											</c:if>
										</tr>
										<tr>
											<td class="col_style">객실수</td>
											<td colspan="4">${lodgeRoom.lg_qty}&nbsp;개</td>
										</tr>
									
							<%-- 숙소 정보 끝--%>
									
										<tr>
											<td class="col_style" colspan="8">룸정보</td>
										</tr>
										
										<tr>
											<td class="col_style" colspan="3">객실이름</td>
											<td class="col_style" colspan="2">객실크기(평수)</td>
											<td class="col_style" >투숙가능인원</td>
											<td class="col_style">가격(1박 기준)</td>
											<td class="col_style">객실수</td>
										</tr>
									</c:if>	
										<tr>
											<td colspan="3">${lodgeRoom.rm_type}</td>
											<td colspan="2">${lodgeRoom.rm_size_meter}㎡(${lodgeRoom.rm_size_pyug}&nbsp;평)</td>
											<td>${lodgeRoom.rm_guest_cnt}&nbsp;명</td>
											<td><fmt:formatNumber pattern="#,###">${lodgeRoom.rm_price}</fmt:formatNumber>&nbsp;원</td>
											<td>${lodgeRoom.rm_cnt}&nbsp;개</td>
										</tr>																	
								</c:forEach>
							</c:forEach>
							
						</c:if>
					</tbody>
					
					
				</table>
				
				
				<div align="center" style="border:solid 0px gray;width:80%;margin:30px auto;">
					${requestScope.pageBar}
				</div>
				
			</div>
		</div>
   </div>	
  </div>
 </div>
</div>
