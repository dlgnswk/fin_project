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
	
	// 검색 조건 유지시키기
	if(${not empty requestScope.paraMap}){
		$("select[name='searchType']").val("${requestScope.paraMap.searchType}");
		$("input[name='searchWord']").val("${requestScope.paraMap.searchWord}");
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
			if($("select[name='searchType']").val() == "h_userid" 	 ||
			   $("select[name='searchType']").val() == "h_name"   	 ||
			   $("select[name='searchType']").val() == "h_lodgename" ||
			   $("select[name='searchType']").val() == "h_businessNo" ) {
				   
				   $.ajax({
					  url:"<%= ctxPath%>/searchHostShow.exp",
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
	
	
	$("tr.column_text").mouseover(function(){
		$(this).css("background-color","#f2f2f2");
	});
	$("tr.column_text").mouseout(function(){
		$(this).css("background-color","");
	});
}); // end of $(document).ready(function(){----------------


// Function Declaration
function goSearch(){
	const frm = document.searchFrm;
	frm.method = "get";
	frm.action = "<%= ctxPath%>/searchHost.exp";
	frm.submit();
} // end of function goSearch()------------------------------


function goSearchBusinessNo(hostName,legalName,businessNo,target){
	
	$.ajax({
		url:"<%= ctxPath%>/searchBusinessNo.exp",
		data:{"hostName":hostName,
			  "legalName":legalName,
			  "businessNo":businessNo},
		dataType:"json",
		success:function(json){
			// alert(JSON.stringify(json));
			// {"n":1}
			if(json.n == 1){
				$(target).parent().parent().find("td.compareResult").html(`<span class="compare_result" style="font-weight:bold; color:green;">가능</span>`);
				$(target).parent().parent().find("button.changeDisplay1").removeClass('dis_none1');
				$(target).parent().parent().find("button.changeDisplay2").removeClass('dis_none2');
			}
			else{
				$(target).parent().parent().find("td.compareResult").html(`<span class="compare_result" style="font-weight:bold; color:red;">불가능</span>`);
				$(target).parent().parent().find("td.dis_none3").removeClass('dis_none3');
				$(target).parent().parent().find("td.go_hide1").addClass('dis_none1');
				$(target).parent().parent().find("td.go_hide2").addClass('dis_none2');
				
				$(target).parent().parent().find("button.changeDisplay3").removeClass('dis_none3');
			}
		},
		error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        }
	});
} // end of function goSearchBusinessNo---------------


function goApprove(hostId,target){
	
	$.ajax({
		url:"<%= ctxPath%>/businessApprove.exp",
		data:{"hostId":hostId},
		dataType:"json",
		success:function(json){
			//alert(JSON.stringify(json));
			
			if(json.n == 1){
				alert("승인 성공되었습니다.");
				$(target).parent().parent().find("td.go_hide1").addClass('dis_none1');
				$(target).parent().parent().find("td.go_hide2").addClass('dis_none1');
				$(target).parent().parent().find("td.dis_none2").removeClass('dis_none2');
				history.go(0);
			}
			else{
				alert("승인 실패");
			}
		},
		error: function(request, status, error){
       		alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        }
	});
	
} // end of function goApprove(target)---------------------------------


function goReject(hostId,target){
	
	$.ajax({
		url:"<%= ctxPath%>/businessReject.exp",
		data:{"hostId":hostId},
		dataType:"json",
		success:function(json){
			//alert(JSON.stringify(json));
			
			if(json.n == 1){
				alert("승인거부 되었습니다.");
				history.go(0);
			}
			else{
				alert("승인거부 실패");
			}
		},
		error: function(request, status, error){
       		alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        }
	});
	
} // end of function goApprove(target)---------------------------------




function goslideDown(target){

	if($(target).next().is(".dis_none1") && $(target).next().next().is(".dis_none1")){
		$(target).next().removeClass("dis_none1");
		$(target).next().next().removeClass("dis_none1");
	}
	else{
		$(target).next().addClass("dis_none1");
		$(target).next().next().addClass("dis_none1");
	}
		
}


	
</script>



<style>
	.padd_24 {
		margin:0 0 24px 0;
	}
	.padd_12 {
		margin-bottom:12px;
	}
	.btn_style {
	    --egds-legacy-background-color: hsla(0,0%,100%,0);
	    --egds-legacy-color: #1668e3;
	    --egds-legacy-fill-color: #1668e3;
	    background-color: var(--egds-undefined,var(--egds-legacy-background-color));
	    border-radius: 2500rem;
	    color: var(--egds-secondary,var(--egds-legacy-color));
	}
	
	.side_menu_container > a {
		color:black;
	}
	
	.side_menu_container > a:hover {
		text-decoration: none;
	}
	
	
	<%-- 테이블 시작--%>
	
	div#mypage_right {
	    padding-top: 45.5px;
	    width: 100%;
	}
	
	div#mypage_right > table {
	    border-collapse:collapse;
	    width:100%;
	    margin-top:2%;
	}
	
	div#mypage_right > table th {
	    text-align:center;
	}
	div#mypage_right > table th.table_title {
	    height:42px;
	    border-top: solid 0px #000;
	    border-bottom: solid 0px #000;
	    background-color: #193082;
	}
	
	div#mypage_right > table th {
	    font-weight:normal;
	}
	
	div#mypage_right > table tr {
	    height:42px;
	    border-bottom:solid 1px #C6C6C6;
	}
	
	tr.column_text > td {
		text-align: center;
	    padding: 10px 0 10px 0;
	    font-size: 13px;
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
	
	th,td{
		border:solid 0px red;
	}
	
	tr.column_text{
		cursor:pointer;
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
				<svg style="width:35px;height:35px; margin:0 5px 0 0;" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512">
					<path d="M192 0c-41.8 0-77.4 26.7-90.5 64H64C28.7 64 0 92.7 0 128V448c0 35.3 28.7 64 64 64H320c35.3 0 64-28.7 64-64V128c0-35.3-28.7-64-64-64H282.5C269.4 26.7 233.8 0 192 0zm0 64a32 32 0 1 1 0 64 32 32 0 1 1 0-64zM305 273L177 401c-9.4 9.4-24.6 9.4-33.9 0L79 337c-9.4-9.4-9.4-24.6 0-33.9s24.6-9.4 33.9 0l47 47L271 239c9.4-9.4 24.6-9.4 33.9 0s9.4 24.6 0 33.9z"/>
				</svg>
				판매자 관리
			</h2>

			<div id="mypage_right" style="display:abslute;">
				
				<form name="searchFrm">
					<select name="searchType" style="height:30px;"> 
						<option value="h_userid">아이디</option>
						<option value="h_name">성함</option>
						<option value="h_lodgename">사업장명</option>
						<option value="h_businessNo">사업자번호</option>
					</select>
					
					<input type="text" name="searchWord" size="40" style="line-height:27px;border:solid 1px black; autocomplete="off" />
					<input type="text" style="display: none;" />
					
					<button type="button" class="btn_search" onclick="goSearch()" style="position:absolute; right:5.6%; border:solid 1px black; height:30px; width:100px; background-color:#fddb32; border-radius: 0.5rem; font-weight:bold; font-size:12pt;">검색</button>
				</form>
				
				<div id="displayList" style="position:absolute; background-color:#ffffff; border:solid 1px gray; border-top:0px; height:80px; width:335px; margin-left: 4.95%; overflow:auto;">
				</div>
				
				<table id="shopping_info">
					<thead>
						<tr>
							<th colspan="7" class="table_title page_title" style="color:white;">판매자 관리</th>
						</tr>
						<tr>
							<th class="table_field_1 table_font__s" style="font-size:9pt; font-weight:bold;" width="146px">판매자ID</th>
							<th class="table_field_2 table_font__s" style="font-size:9pt; font-weight:bold;" width="113px">이름</th>
							<th class="table_field_3 table_font__s" style="font-size:9pt; font-weight:bold;" width="133px">연락처</th>
							<th class="table_field_5 table_font__s" style="font-size:9pt; font-weight:bold;" width="113px">사업장명</th>
							<th class="table_field_6 table_font__s" style="font-size:9pt; font-weight:bold;" width="120px">주소</th>
							<th class="table_field_7 table_font__s" style="font-size:9pt; font-weight:bold;" width="122px">승인여부</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${not empty requestScope.hostList}">	
							<c:forEach var="hostvo" items="${requestScope.hostList}">
								
									<tr class="column_text collapsible" onclick="goslideDown(this)" style="word-break: keep-all;">
										<td style="font-size:8pt;">${hostvo.h_userid}</td>
		
										<td style="font-size:8pt;">${hostvo.h_name}</td>
		
										<td style="font-size:8pt;">${hostvo.h_mobile}</td>
		
										<td style="font-size:8pt;">${hostvo.h_lodgename}</td>
		
										<td style="font-size:8pt;">${hostvo.h_address}&nbsp;${hostvo.h_detailAddress}&nbsp;${hostvo.h_extraAddress}</td>
										
										<c:if test="${hostvo.h_status == 0}">
											<td style="font-size:8pt;">승인대기</td>
										</c:if>
										<c:if test="${hostvo.h_status == 1}">
											<td style="font-size:8pt; color:green;"><svg xmlns="http://www.w3.org/2000/svg" height="16" width="14" viewBox="0 0 448 512"><path fill="#008000" d="M438.6 105.4c12.5 12.5 12.5 32.8 0 45.3l-256 256c-12.5 12.5-32.8 12.5-45.3 0l-128-128c-12.5-12.5-12.5-32.8 0-45.3s32.8-12.5 45.3 0L160 338.7 393.4 105.4c12.5-12.5 32.8-12.5 45.3 0z"/></svg>
												승인</td>
										</c:if>
										<c:if test="${hostvo.h_status == 2}">
											<td style="font-size:8pt; color:red;"><svg xmlns="http://www.w3.org/2000/svg" height="16" width="12" viewBox="0 0 384 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#ff0000" d="M342.6 150.6c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0L192 210.7 86.6 105.4c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3L146.7 256 41.4 361.4c-12.5 12.5-12.5 32.8 0 45.3s32.8 12.5 45.3 0L192 301.3 297.4 406.6c12.5 12.5 32.8 12.5 45.3 0s12.5-32.8 0-45.3L237.3 256 342.6 150.6z"/></svg>
												승인거부</td>
										</c:if>
									</tr>
								
								
								
									<tr class="second_tr dis_none1" style="border-top:solid 2px rgb(25, 48, 130); border-left:solid 2px rgb(25, 48, 130); border-right:solid 2px rgb(25, 48, 130);">
										<c:if test="${hostvo.h_status == 0}">
											<th class="table_field_5 table_font__s second_th" width="146px" style="font-size:9pt; font-weight:bold;">법인명</th>
											<th class="table_field_5 table_font__s second_th" width="15%" style="font-size:9pt; font-weight:bold;">사업자번호</th>
											<th class="table_field_5 table_font__s second_th" width="18%" style="font-size:9pt; font-weight:bold;">승인가능여부조회</th>
											<th class="table_field_5 table_font__s second_th" width="15%" style="font-size:9pt; font-weight:bold;">가능여부</th>
										</c:if>	
										<c:if test="${hostvo.h_status == 1}">
											<th class="table_field_5 table_font__s second_th" width="146px" style="font-size:9pt; font-weight:bold;">법인명</th>
											<th class="table_field_5 table_font__s second_th" width="15%" style="font-size:9pt; font-weight:bold;">사업자번호</th>
										</c:if>
										<c:if test="${hostvo.h_status == 2}">
											<th class="table_field_5 table_font__s second_th" width="146px" style="font-size:9pt; font-weight:bold;">법인명</th>
											<th class="table_field_5 table_font__s second_th" width="15%" style="font-size:9pt; font-weight:bold;">사업자번호</th>
										</c:if>
									</tr>
									<tr class="column_text third_tr dis_none1" style="word-break: keep-all;border-bottom:solid 2px rgb(25, 48, 130); border-left:solid 2px rgb(25, 48, 130); border-right:solid 2px rgb(25, 48, 130);">
										<td style="font-size:8pt;" class="second_td">${hostvo.h_legalName}</td>
										<td style="font-size:8pt;" class="second_td">${hostvo.h_businessNo}</td>
										
										<c:if test="${hostvo.h_status == 0}">
											<td class="second_td"><button id="searchBusinessNo" type="button" onclick="goSearchBusinessNo('${hostvo.h_name}','${hostvo.h_legalName}','${hostvo.h_businessNo}',this)" style="border:solid 1px black; height:30px; width:40px; border-radius: 0.5rem; font-weight:bold;">조회</button></td>
											<td class="compareResult second_td" style="font-size:8pt;"></td>
											<td class="second_td go_hide1"><button type="button" class="dis_none1 changeDisplay1" onclick="goApprove('${hostvo.h_userid}',this)" style="border:solid 1px black; height:30px; width:120px; border-radius: 0.5rem; font-weight:bold;">사업자 승인</button></td>
											<td class="second_td go_hide2"><button type="button" class="dis_none2 changeDisplay2" onclick="goReject('${hostvo.h_userid}',this)" style="border:solid 1px black; height:30px; width:120px; border-radius: 0.5rem; font-weight:bold;">사업자 승인거부</button></td>
											<td class="dis_none3 second_td" colspan="2"><button type="button" class="dis_none3 changeDisplay3" onclick="goReject('${hostvo.h_userid}',this)" style="border:solid 1px black; height:30px; width:120px; border-radius: 0.5rem; font-weight:bold;">사업자 승인거부</button></td>
										</c:if>
										<c:if test="${hostvo.h_status == 1}">
											<td class="compareResult second_td" style="font-size:8pt;"></td>
											<td class="second_td" colspan="2" style="color:green;">관리자에 의한 승인</td>
										</c:if>
										<c:if test="${hostvo.h_status == 2}">
											<td class="second_td"></td>
											<td class="second_td" colspan="2" style="color:red;">관리자에 의한 승인거부</td>
										</c:if>
									</tr>
								
							</c:forEach>	
						</c:if>
						
						<c:if test="${empty requestScope.hostList}">
							<tr class="column_text" style="word-break: keep-all;">
								<td colspan="7">데이터가 없습니다.</td>
							</tr>
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
