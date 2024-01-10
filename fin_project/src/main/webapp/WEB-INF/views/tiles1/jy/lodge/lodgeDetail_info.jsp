<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%
	String ctxPath = request.getContextPath();

	
%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/css/jy/common.css"/>
<style>
	
	/* ======== 숙소 상세보기 CSS 시작 - 지연 ======== */
	#top_bar_wrap {
		justify-content: space-between;
		line-height: 3.75rem;
		padding: 0.25rem 0.5rem;
	}
	#top_main_img_wrap .c_grid {
		gap: 2px;
		grid-template-columns: repeat(4, minmax(0, 1fr)); <%-- 반응형임  992px 이하부턴 3 --%>
		grid-template-rows: repeat(2, minmax(0, 1fr));
	}
	
	#mycontent img{
		width: 100%;
		height: 100%;
		object-fit: cover;
		aspect-ratio: 4/3;
	} 
	#main_img_0{
		height: inherit;
		grid-column-start: 1;
		grid-column-end: 3;
		grid-row-start: 1;
		grid-row-end: 3;
	}
	#main_img_1{
		grid-column-start: 3;
		grid-column-end: 4;
		grid-row-start: 1;
		grid-row-end: 2;
	}
	#main_img_2{
		grid-column-start: 4;
		grid-column-end: 5;
		grid-row-start: 1;
		grid-row-end: 2;
	}
	#main_img_3{
		grid-column-start: 3;
		grid-column-end: 4;
		grid-row-start: 2;
		grid-row-end: 3;
	}	
	#main_img_4{
		grid-column-start: 4;
		grid-column-end: 5;
		grid-row-start: 2;
		grid-row-end: 3;
	}		
	#nav_bar {
		background-color: white;
		width: 100%;
	}	
	#nav_ul {
		display: inline-flex;
		height: 2.75rem;
	}
	#nav_ul a {
		align-items: center;
	}
	
	ul, li, a {
		height: inherit;
	}
	.pad_x_1r {
		padding: 0 1rem;
	}
	.pad_x_end {
		padding: 0 0.75rem 0 0;
	}
	#pop_fac ul.c_grid {
		gap: 1rem;
		grid-template-columns: repeat(2, minmax(0, 1fr)); <%-- 반응형임  992px 이하부턴 3 --%>
		grid-template-rows: repeat(3, minmax(0, 1fr));
	}
	#basic_info_container.c_grid {
		grid-template-columns: repeat(3, 1fr);
		gap: 1rem;
	}
	#basic_info_container.c_grid #basic_info {
		grid-column-start: 1;
		grid-column-end: 3;
	}
	#basic_info_container.c_grid #map_info {
		grid-column-start: 3;
		grid-column-end: 4;
	}
	.c_content_txt {
	font-size: 0.875rem;
    line-height: 1.125rem;
    }
    
    #modalContents div {
    	height: auto;
    }
    .more_pic_btn {
	    position: absolute;
	    border-radius: 10rem;
	    width: 75px;
	    height: 40px;
	    transform: translate(280%, -130%);
	    background-color: rgba(60, 60, 60, 0.5);
	    color: white
    }
    .more_pic_btn:hover {
    	background-color: rgba(60, 60, 60, 0.7);    
    }
    .more_pic_btn * {
	    color: white;
    }
    #top_main_img_wrap:hover {
    	cursor:pointer;
    }
    
	svg {
        pointer-events: none;
    }
    /* 헤더 로고 크기 안맞음 수정 */
    #headerOfheader > div > section > div > div > a > img {
   		width: 126px;
    }
    
    
    /* ======== 숙소 상세보기 CSS 끝 - 지연 ========  */
    
    /* 이용후기 모달 관련 CSS 시작 - 채혁 */
    
    .reviewshow > div {
		color: rgba(0, 58, 255, 0.77);		
	}
	.reviewshow > div:hover {
	 	text-decoration: underline;
	 	cursor: pointer;
	}
	
	/* 모달 css 시작 */
	
	.reviewModal{ 
	    position:absolute;
	    width:100%; 
	    height:100%; 
	    background: rgba(0, 0, 0, 0.21); 
	    top:0; 
	    left:0; 
	    display:none;
	    z-index: 100;
	}
	
	body.modal-open {
	    overflow: hidden; /* 페이지 스크롤 막기 */
	}
	
	.reviewModal_header{		
	    width: 720px; /* 500px를 16px 기준으로 나눈 값 */
	    height: 640px;        /* 300px를 16px 기준으로 나눈 값 */
	    background:#fff; 
	    border-radius:0.625rem; /* 10px를 16px 기준으로 나눈 값 */
	    position:relative; 
	    top:50%; 
	    left:50%;
	    margin-top:-320px; /* height의 절반 */
	    margin-left:-360px; /* width의 절반 */
	    text-align:left;
	    box-sizing:border-box; 
	    padding: 50px 0; /* 74px를 16px 기준으로 나눈 값 */
	    line-height:1.4375rem; /* 23px를 16px 기준으로 나눈 값 */
	    cursor:pointer;
	}
	

	#mycontent > div.reviewModal > div > span.close {
	    position: absolute; 
	    top: 6px; /* 15px를 16px 기준으로 나눈 값 */
	    left: 0.9375rem; /* 15px를 16px 기준으로 나눈 값 */
	    color: #0073ff;
	    font-size: 30px;
	    cursor: pointer;	    	    
	}
	
	#mycontent > div.reviewModal > div > span:nth-child(1) {
		position: absolute; 
	   	top: 13px;
    	left: 2.8125rem; 
	}
	
	.rating_avg {
		font-family: 'Josefin Sans', sans-serif;
	}
	
	#mycontent > div.reviewModal > div > div > h4 > span {
		font-family: 'Gothic A1', sans-serif;
		font-size: 20px;
	}
	
	/* 그래프 바 css 시작 */
	
	progress {
	  -webkit-appearance: none;
	}
	
	::-webkit-progress-bar {
		width: 35rem;  /* --> bar 전체 길이 */
	   	height: 8px;   /* --> bar 두께 */
 		border: 0px solid gray;
 		border-radius: 12px;    
	   	background-color: rgba(0, 0, 0, 0.13); /* --> 진행률  배경 색상 */
	}
	
	::-webkit-progress-value {
	  	background-color: rgba(0, 0, 88, 0.96); /* --> 진행률  값 색상 */
	  	border: 0px solid gray;
		border-radius: 12px;
	}
	
	/* progress 바 css 보완 - 지연 */
	.progress_wrap {
		display: flex;
	    flex-direction: column;
	    gap: 0.4rem;
	
	}
	
	/* 그래프 바 css 끝 */
	
	/* 검색창 css 시작 */
	
	
	.input-wrapper {
    position: relative;
    margin-bottom: 20px;
    display: flex;
    align-items: center;
	}
	
	#search-input-box {
	    height: 3rem;
	    border: 1px solid rgba(0, 0, 0, 0.21);
	    border-radius: 10px;
	    outline: none;
	    padding-left: 0.625rem;
	    background-color: #fff;
	    transition: border-color 0.3s ease;
	    margin-right: 10px; /* 버튼과의 간격을 조절하기 위한 마진 추가 */
	}
	
	#search-input-box:focus {
	    border: 2px solid #0073ff;
	}
	
	#search-input-label {
	    position: absolute;
	    top: 18px; /* 레이블의 상단 여백 조정 */
	    left: 10px; /* 레이블의 좌측 여백 조정 */
	    color: #aaa;
	    pointer-events: none;
	    transition: all 0.3s ease;
	}
	
	#search-input-box:focus + #search-input-label,
	#search-input-box:not(:placeholder-shown) + #search-input-label {
	    top: 0;
	    font-size: 13px;
	    color: black;
	}
	
	#mycontent > div.reviewModal > div > div > div.search_filter > form > div > button {
		padding-right: 5.8%;
	    background-color: #0073ff;
	    border: 0px solid #555555;
	    border-radius: 100%;
	    color: white;
	    height: 3rem;
	}
	
	#mycontent > div.reviewModal > div > div > div.search_filter > form > div > button:hover {
	    background-color: rgba(0, 80, 229, 0.91);
	    box-shadow: 0 0.25rem 0.375rem -0.0625rem rgba(0, 0, 0, 0.1), 0 0.125rem 0.25rem -0.0625rem rgba(0, 0, 0, 0.08);	
	}	
	
	/* 검색창 css 끝 */
	
	/* 셀렉트 창 css 시작 */	
	select#rvOrderType:focus {
	    border: 2px solid #0073ff;
	    outline: none;
	}
	
	select#rvOrderType {
	    height: 3rem; /* 32px → 2rem 변환 */
	    font-size: 0.9375rem; /* 15px → 0.9375rem 변환 */
	    border: 1px solid rgba(0, 0, 0, 0.21);
	    border-radius: 0.9375rem; /* 15px → 0.9375rem 변환 */
	    outline: none;
	    padding: 0.625rem; /* 10px → 0.625rem 변환 */
	    background-color: #fff;	
	}
	/* 셀렉트 창 css 끝 */
	
		
	/* 댓글목록 시작  */
	
	.review {
	   background-color: #fff;
	   width: 95.6%;
	}
	
	/* 훌륭해요 글짜크기  */
	
	#review > div > div > div:nth-child(2) > div:nth-child(1) > div:nth-child(2) > div {
	   font-size:1.25rem;
	}
	
	/* 아이디 글짜크기 */
	#review > div > div > div:nth-child(2) > div:nth-child(1) > div:nth-child(4) > div,
	#review > div > div > div:nth-child(2) > div:nth-child(1) > div:nth-child(5) > div,
	#review > div > div > div:nth-child(2) > div:nth-child(1) > div:nth-child(8) > div{
	   font-size:.875rem;
	}
	
	
	/* 모달 css 끝 */
    
    /* 이용후기 모달 관련 CSS 끝 - 채혁 */
    
    
}
	
</style>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2f907461e044a99123a3e7b82800cec7"></script>
<script>
	
	// 몇 박 하는 지!
	if ("${requestScope.stayNight}" != ""){
		var stay_night = "${requestScope.stayNight}";
	}
	else {
		var stay_night = 1;
	}
	
	stay_night = Number(stay_night);
	
	
	$(document).ready(function(){
		
		// 헤더 좌측 짤림 해결
		$("div.global-navigation-row-container").find("a.uitk-header-brand-logo").removeClass("uitk-header-brand-logo");
		
		// 아래로 스크롤 시 바 고정
		document.addEventListener('scroll', onScrollForNav, { passive: true });
		
		
		// 인기 편의 시설 모두 보기 클릭 시, 모달 창 띄우기
		const view_all_fac_btn = document.getElementById('view_all_fac_btn');
		const view_all_fac_modal = document.getElementById('view_all_fac');
		const m_close_btn_fac = document.getElementById('m_close_btn_fac');

		view_all_fac_btn.onclick = function() {
		  view_all_fac_modal.style.display = 'block';
		  document.body.style.overflow = 'hidden';
		}
		m_close_btn_fac.onclick = function() {
		  view_all_fac_modal.style.display = 'none';
		  document.body.style.overflow = 'auto';
		}

		window.addEventListener('click', function (e) {
		    if (e.target === view_all_fac_modal) {
		    	view_all_fac_modal.style.display = 'none';
		    	document.body.style.overflow = 'auto';
		    }
		    
		});   
		
		// 모든 사진 보기 창에서 x 클릭 시, 원상복귀!
		$("button#lg_img_close_btn").bind("click", function(){
			$("div#lg_img_all").css("display","none");
			$("div#myheader").css("display","");
			$("div#myfooter").css("display","");
			$("div#main").css("display","");
			$("html").css("background","");
		    $("body").css("background","");
		    
		});
		
		// 체크인, 체크아웃 날짜 datepicker 로 가져오기!
		var dateSelector = document.querySelector('.dateSelector');
		
		if("${requestScope.d_map.startDate}" != "" && "${requestScope.d_map.endDate}" != ""){
			dateSelector.flatpickr({
		          mode: "range",
		          enable: [{from: "${requestScope.date_map.today_date}", to: "${requestScope.date_map.after_1year_date}"}],
		          dateFormat: "Y-m-d",
		         // 페이지 로드시 넘어온 체크인아웃 날짜 입력해주기
		         defaultDate: ["${requestScope.d_map.startDate}", "${requestScope.d_map.endDate}"]
		      });
			$("input[name='endDate']").val($("input[name='startDate']").val().substring(14));
			$("input[name='startDate']").val($("input[name='startDate']").val().substring(0,10));
		}
		else {
			dateSelector.flatpickr({
		          mode: "range",
		          enable: [{from: "${requestScope.date_map.today_date}", to: "${requestScope.date_map.after_1year_date}"}],
		          dateFormat: "Y-m-d"
		      });
		}
		
		// 체크인 날짜 선택 시, 데이터 쪼개서 각각 체크인, 체크아웃 input 에 넣어주기 
		$("input[name='startDate']").bind("change",function(){
			if($("input[name='startDate']").val().length > 11){
				$("input[name='endDate']").val($("input[name='startDate']").val().substring(14));
				$("input[name='startDate']").val($("input[name='startDate']").val().substring(0,10));
			}
			
		});
		
		const html = $("div#m_popFac_content").html();
		$("div#pop_fac").html(html);	
		
		// 객실 인원 수 버튼 클릭 시 이벤트 (어른은 1~13명, 아이는 0~13명 추가가능)
		$(document).on('click','button.c_guest_cnt_up',function(e){
			const now_cnt = Number($(e.target).parent().parent().find("input").val());
			const guest_type = $(e.target).parent().parent().find("input").attr("name"); // adult_cnt, child_cnt			
			if(guest_type == "adult_cnt"){
				if(now_cnt < 13){
					$(e.target).parent().parent().find("input").val(now_cnt+1);
				}
			}
			else {
				if(now_cnt < 13){
					$(e.target).parent().parent().find("input").val(now_cnt+1);
				}
			}			
		});
		$(document).on('click','button.c_guest_cnt_down',function(e){
			const now_cnt = Number($(e.target).parent().parent().find("input").val());
			const guest_type = $(e.target).parent().parent().find("input").attr("name"); // adult_cnt, child_cnt			
			if(guest_type == "adult_cnt"){
				if(now_cnt>1){
					$(e.target).parent().parent().find("input").val(now_cnt-1);
				}
			}
			else {
				if(now_cnt>=1){
					$(e.target).parent().parent().find("input").val(now_cnt-1);
				}
			}	
		});
		
		// 인원 수 div 에 넘겨받은 정보 입력
		const adults = Number($("input[name='adult_cnt']").val());
		const childs = Number($("input[name='child_cnt']").val());
		const guest_cnt = adults+childs;
		const room = Number($("input[name='need_rm_cnt']").val());
		$("input[name='guest']").val(guest_cnt/room);
		$("input[name='ttl_guest_cnt']").val(guest_cnt);
		$("input[name='room']").val(room);
		
		$("button#guest_cnt_field").html("객실 "+room+"개, "+guest_cnt+"명&nbsp;&nbsp;<span class='c_txt_sm'>(아동"+childs+"명)<span>");
		
		// 지도 생성하기
		var mapContainer = document.getElementById('lg_map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new kakao.maps.LatLng(${requestScope.lodgeinfo.LG_LATITUDE},${requestScope.lodgeinfo.LG_LONGITUDE}), // 지도의 중심좌표
	        level: 4 // 지도의 확대 레벨
	    };

		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	
		// 마커가 표시될 위치입니다 
		var markerPosition  = new kakao.maps.LatLng(${requestScope.lodgeinfo.LG_LATITUDE},${requestScope.lodgeinfo.LG_LONGITUDE}); 
	
		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: markerPosition
		});
	
		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
		
		map.setDraggable(false);
		
		
		// 이 숙박 시설에 대한 정보의 더보기 클릭 시 토글
		const showMore_info_btn = document.getElementById('showMore_info');
		const full_info = document.getElementById('full_info');
		
		showMore_info_btn.addEventListener('click',function(){
			full_info.classList.toggle('c_hide');
			full_info.classList.toggle('c_grid');
			if(showMore_info_btn.innerText=="더보기"){
				showMore_info_btn.innerText = "간단히 보기";
			}
			else if(showMore_info_btn.innerText=="간단히 보기"){
				showMore_info_btn.innerText = "더보기";
			}
		})
		const rm_img_part = document.querySelectorAll('.img_part');
		for(let i=0; i<rm_img_part.length; i++){			
			const rm_seq = rm_img_part[i].getAttribute("rm_seq");
			// console.log("rm_img_part[i]",rm_img_part[i].getAttribute("rm_seq"));
			$.ajax({
				url:"get_room_img_json.exp",
				dataType:"json",
				data:{"rm_seq":rm_seq},
				success: function(json){
					 // console.log(json.rm_img_list);
					 // console.log(rm_img_part[i]);
					const img_list = json.rm_img_list;
					
					let html = '<div class="img_slide c_t_border_r1">'
								+'<div id="rm_img_slide'+i+'" class="carousel slide" data-interval="false">'
								+'<div class="carousel-inner c_t_border_r1">'
					if(img_list != null){				
						$.each(img_list, function(index, item){
							if(item.rm_img_main==1){
								html += '<div class="carousel-item active" >'
											+'<img src="<%=ctxPath%>/resources/images/'+item.fk_lodge_id+'/room_img/'+item.rm_img_save_name+'" class="d-block w-100 image_thumnail"style="object-fit: cover; aspect-ratio: 16/9;">'
										+'</div>';
							}
							else{
								html +=	'<div class="carousel-item" >'
											+'<img src="<%=ctxPath%>/resources/images/'+item.fk_lodge_id+'/room_img/'+item.rm_img_save_name+'" class="d-block w-100 image_thumnail" style="object-fit: cover; aspect-ratio: 16/9;">'
										+'</div>';						 
							}
						});// end of $.each(img_list, function(index, item)------
					}
					else {
					html += '<div class="carousel-item active">'
							+'<img src="<%=ctxPath%>/resources/images/jy/null0.png" class="d-block w-100 image_thumnail"style="object-fit: cover; aspect-ratio: 16/9;">'
						+'</div>'
							+'<div class="carousel-item"'
							+'<img src="<%=ctxPath%>/resources/images/jy/null1.png" class="d-block w-100 image_thumnail" style="object-fit: cover; aspect-ratio: 16/9;">'
						+'</div>';	
					}
									
												
					html +=							'</div>'
					
											+'<a class="carousel-control-prev" href="#rm_img_slide'+i+'" role="button" data-slide="prev"><span class="carousel-control-prev-icon" aria-hidden="true"></span><span class="sr-only">Previous</span></a>'
											+'<a class="carousel-control-next" href="#rm_img_slide'+i+'" role="button" data-slide="next"><span class="carousel-control-next-icon" aria-hidden="true"></span><span class="sr-only">Next</span></a>'
										+'</div>'
									+'</div>';
									
					rm_img_part[i].innerHTML = html;	
						
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			 	}
			}) 
		}
		
		// 고객 이용후기 모달 창에서 검색 정렬 조건이 변경 되었을 때,
		$("select[name='rvOrderType']").bind("change",function(e){
			// alert($(e.target).val());
			// recent_rv, h_rate_rv, l_rate_rv
			const orderType = $(e.target).val();
			$.ajax({
				url:"showReviewList_search_json.exp",
				data:{"lodge_id":"${requestScope.lodgeinfo.LODGE_ID}",
					  "orderType":orderType},
				dataType:"json",
				success:function(json){
					// console.log(json);
					// 정렬 조건에 맞게 정렬된 댓글을  div#view_reviewList 에 뿌려준다~
					const reviewList = json.reviewList;
					
					let html = "";
					if(reviewList != null){
						$.each(reviewList, function(index, item){
							html += '<div style="border-bottom: 1px solid black">';
							// console.log(item);
							if(item.RV_DEPTHNO == 0){
								html += '<div class="c_grid" style="gap:0.875rem; padding:1.2rem 0;">'
									  + 	'<div class="c_h3_head6" style="font-weight:600;">'+item.FK_RV_RATING+'/10 - '+item.RV_RATING_DESC+'</div>'
									  + 	'<div>'
									  +			'<div class="c_txt_sm" style="font-weight:600">'+item.RS_NAME+'</div>'
									  +			'<div class="c_txt_sm">'+item.RV_REGDATE+'</div>'
									  + 	'</div>'
									  + 	'<div class="c_flex" style="flex-direction: column; gap: 0.5rem;">'
									  +			'<div class="c_content_txt">'+item.RV_CONTENT+'</div>'
									  +			'<div class="c_txt_sm">'+item.RS_DATE+'에 '+item.LIVEDATE+' 숙박함</div>'
									  + 	'</div>'
									  + 	'<div class="reviewfindBtn">'
									  +				'<button type="button" onclick="golikeAdd(\''+item.RV_SEQ+'\',this)"><svg xmlns="http://www.w3.org/2000/svg" style="margin-right: 5px;" height="16" width="16" fill="rgba(35, 121, 255, 0.89)" viewBox="0 0 512 512"> <path d="M313.4 32.9c26 5.2 42.9 30.5 37.7 56.5l-2.3 11.4c-5.3 26.7-15.1 52.1-28.8 75.2H464c26.5 0 48 21.5 48 48c0 18.5-10.5 34.6-25.9 42.6C497 275.4 504 288.9 504 304c0 23.4-16.8 42.9-38.9 47.1c4.4 7.3 6.9 15.8 6.9 24.9c0 21.3-13.9 39.4-33.1 45.6c.7 3.3 1.1 6.8 1.1 10.4c0 26.5-21.5 48-48 48H294.5c-19 0-37.5-5.6-53.3-16.1l-38.5-25.7C176 420.4 160 390.4 160 358.3V320 272 247.1c0-29.2 13.3-56.7 36-75l7.4-5.9c26.5-21.2 44.6-51 51.2-84.2l2.3-11.4c5.2-26 30.5-42.9 56.5-37.7zM32 192H96c17.7 0 32 14.3 32 32V448c0 17.7-14.3 32-32 32H32c-17.7 0-32-14.3-32-32V224c0-17.7 14.3-32 32-32z" /></svg><button>'
									  +			'<span class="likeCnt">'+item.LIKECNT+'</span>'
									  + 	'</div>'
									  + '</div>';
							}
							if(item.RV_DEPTHNO > 0){
								html += '<input type="hidden" name="rv_seq" size="38" value="'+item.RV_SEQ+'" autocomplete="off" readonly />'
								  + '<div class="c_grid" style="gap: 0.875rem; padding: 0.5rem 0 1rem 1rem;">'
							      + 	'<div class="c_flex" style="flex-direction: column; gap: 0.3rem;">'
								  +			'<div class="c_txt_sm" style="font-weight:600">└ '+item.LG_NAME+' 님</div>'
								  + 		'<div class="c_txt_sm" style="padding-left:1rem;">'+item.RV_REGDATE+'</div>'
								  + 	'</div>'
								  + 	'<div class="c_txt_sm" style="padding-left:1rem;">'+item.RV_CONTENT+'</div>'
								  +	'</div>';			
							}							
							html += '</div>';
						});

					}
					 console.log(html);
					$("div#view_reviewList").html(html);					
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			 	}
			})
			
		})
		
		// 고객 이용 후기 모달에서 검색 시 엔터 쳤을 때, 
		$("input[name='reviewSearch']").bind("keyup",function(e){
			if( e.keyCode== 13){
				goReviewSearch();
			}
		});
		
		
		// 이용 후기 모두 보기 클릭 시, 모달 창 띄우기
		const view_reviewList_btn = document.getElementById('view_reviewList');
		const reviewModal = document.getElementById('reviewModal');
		const m_close_btn_rv = document.getElementById('m_close_btn_rv');

		view_reviewList_btn.onclick = function() {
			reviewModal.style.display = 'flex';
		  	document.body.style.overflow = 'hidden';
		}
		m_close_btn_rv.onclick = function() {
			reviewModal.style.display = 'none';
		  	document.body.style.overflow = 'auto';
		}

		window.addEventListener('click', function (e) {
		    if (e.target === reviewModal) {
		    	reviewModal.style.display = 'none';
		    	document.body.style.overflow = 'auto';
		    }
		    
		});
		
		
	}); // end of $(document).ready(function(){})----------
	
	function onScrollForNav() {
		
		const header = document.getElementById('myheader');
		const topBar = document.getElementById('top_bar_img_container');
		const headerheight = header.clientHeight;
		const topBarheight = topBar.clientHeight;
		
		// console.log("headerheight => ",headerheight);
		// console.log("topBarheight => ",topBarheight);
		
		const scrollposition = pageYOffset;
		const nav = document.getElementById('nav_bar');
		if(headerheight+topBarheight <= scrollposition){
			nav.classList.add("c_fix");
		}
		else {
			nav.classList.remove("c_fix");
		}
		
	}
	
	// 숙박 시설 모두 보기 클릭 시, 검색 조건 get방식으로  lodgeSearch.action 에 보내준다
	// 보내줘야할 정보 lg_area, lg_area_2, check_in, check_out, travlers, adult, kid
	// http://localhost:9090/expedia/lodgeSearch.action?lg_area=%EA%B0%95%EC%9B%90%ED%8A%B9%EB%B3%84%EC%9E%90%EC%B9%98%EB%8F%84&lg_area_2=%EA%B0%95%EB%A6%89%EC%8B%9C&lg_name=&check_in=2024-01-09&check_out=2024-01-11&travlers=2&adult=2&kid=0
	function goBackLodgeSearch() {
	/*
		<form name="lodgeSearchFrm">
			<input type="hidden" name="check_in" readonly value="">
			<input type="hidden" name="check_out" readonly value="">
			<input type="hidden" name="travlers" readonly value="">
			<input type="hidden" name="adult" readonly value="">
			<input type="hidden" name="kid" readonly value="">							
		</form>
	*/	
		$("input[name='check_in']").val($("input[name='startDate']").val());
		$("input[name='check_out']").val($("input[name='endDate']").val());
		$("input[name='travlers']").val($("input[name='guest']").val());
		$("input[name='adult']").val($("input[name='adults']").val());
		$("input[name='kid']").val($("input[name='childs']").val());
		
		console.log($("input[name='kid']").val());
		
		const frm = document.lodgeSearchFrm;
		frm.action = "lodgeSearch.action";
		frm.method = "get";
		frm.submit();
	}
	
	function go_reservation (price_aft_dis, st_rm_seq) {
		
		const price = Math.round(price_aft_dis).toLocaleString("en");
		const ttl_price = Math.round(price_aft_dis*stay_night*1.1).toLocaleString("en"); // 3을 stay_night으로 바꿔야함
		const rm_seq = st_rm_seq;
		
		$("div.pay_method_price").html("₩"+price);
		$("span.pay_method_ttl_price").html("₩"+ttl_price);
		$("div#go_pay_now_btn").html('<button class="c_btn_pri" style="width: 100%; height: 2.4rem; margin: auto 0;" onclick="go_pay_now(\''+rm_seq+'\')">지금 결제</button>');
		$("div#go_pay_later_btn").html('<button class="c_btn_pri" style="width: 100%; height: 2.4rem; margin: auto 0;" onclick="go_pay_later(\''+rm_seq+'\')">현장 결제</button>');

		// 인기 편의 시설 모두 보기 클릭 시, 모달 창 띄우기
		const view_pay_method_modal = document.getElementById('view_pay_method');
		const view_rm_detail_info_modal = document.getElementById('view_rm_detail_info');
		const m_close_btn_pm = document.getElementById('m_close_btn_pm');
		
		view_pay_method_modal.style.display = 'flex';
		document.body.style.overflow = 'hidden';
		
		m_close_btn_pm.onclick = function() {
			view_pay_method_modal.style.display = 'none';
			if(view_rm_detail_info_modal == null){
		  		document.body.style.overflow = 'auto';
		  	}
			else if(view_rm_detail_info_modal.style.display == 'none'){
				document.body.style.overflow = 'auto';
			}
			
		}

		window.addEventListener('click', function (e) {
		    if (e.target === view_pay_method_modal) {
		    	view_pay_method_modal.style.display = 'none';
		    	if(view_rm_detail_info_modal == null){
			  		document.body.style.overflow = 'auto';
			  	}
				else if(view_rm_detail_info_modal.style.display == 'none'){
					document.body.style.overflow = 'auto';
				}
		    }
		});
	
	}
	
	function goMoreImg() {
		$("div#myheader").css("display","none");
	    $("div#myfooter").css("display","none");
	    $("div#main").css("display","none");
	    $("html").css("background","none");
	    $("body").css("background","none");
	    
	    $("div#lg_img_all").css("display","block");
	    view_lg_img("all", "모든 사진");
	}
	
	// 사진 index 버튼 선택 시, 사진을 띄워줌
	function view_lg_img(img_cano, img_ca_name){
		// img_cano 가 all 일땐 모든 사진, rm 일땐 객실 사진, 그 외엔 img_cate_no 에 맞는 사진 보여줌
		
		$.ajax({
				url:"get_lg_img_json.exp",
				data:{"img_cano":img_cano,
					  "lodge_id":"${requestScope.lodgeinfo.LODGE_ID}"},
				dataType:"json",
				success:function(json){
					
					
					let html = '<div class="h2">'+img_ca_name+'</div>'
							 + '<div class="c_grid_c2" style="gap: 1rem;">';
					
					if(img_cano != "all" || img_cano != "rm"){
						$.each(json.lg_ca_img_list, function(index, item){
							html+= '<button><img src="<%=ctxPath%>/resources/images/'+item.lodge_id+'/lodge_img/'+item.lg_img_save_name+'" ></button>'						
						});
					}
					if(img_cano == 'all'){ // 모두 보기일때 => 숙박시설 전체 사진 + 객실 전체 사진
						$.each(json.lg_all_img_list, function(index, item){
							html+= '<button><img src="<%=ctxPath%>/resources/images/'+item.lodge_id+'/lodge_img/'+item.lg_img_save_name+'" ></button>'						
						});
						$.each(json.all_rm_img_list, function(index, item){
							html+= '<button><img src="<%=ctxPath%>/resources/images/'+item.fk_lodge_id+'/room_img/'+item.rm_img_save_name+'" ></button>'						
						});

					}
					if (img_cano == "rm"){ // 객실 사진 보기일때 => 객실 전체 사진
						$.each(json.all_rm_img_list, function(index, item){
							html+= '<button><img src="<%=ctxPath%>/resources/images/'+item.fk_lodge_id+'/room_img/'+item.rm_img_save_name+'" ></button>'						
						});
					}
					console.log(json.all_rm_img_list);
					
					html += '</div>';
					
					console.log(html);
					$("div#lg_img_thumnail").html(html);
				
				},			
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			 	}
		})
	
	}
	
	function goSearchRoom() {
		
		// 날짜 선택 되어있을 시, submit
		if($("input[name='startDate']").val() != "" && $("input[name='endDate']").val() != ""){
			const frm = document.rmSearchFrm;
			frm.method = "get";
			frm.submit();
		}
		else {
			alert("조회하고자 하는 날짜를 선택해주세요.");
		}
		
		
	}
	
	// 저장 버튼 클릭 시 위시리스트 업데이트 함수
	function add_wishList() {
		
		// 로그인 돼있고
		if("${sessionScope.loginuser.userid}"==""){
			alert("로그인 후에 가능합니다.");
		}
		<%--
		 저장이 돼있을 때, 채워진 하트 > 빈 하트
		 저장이 안돼있을 때, 빈 하트 > 채워진 하트
		 필요한 정보: lodge_id, userid --%>
		else {
			$.ajax({
				
				url:"update_wishList_json.exp",
				data:{"lodge_id":"${requestScope.lodgeinfo.LODGE_ID}"},
				dataType:"json",
				success: function(json){
					if(json.add_wishList == 1){
						alert("위시리스트에 추가 되었습니다.");
						$("svg#wish_before").addClass("c_hide");
						$("svg#wish_after").removeClass("c_hide");
						$("span#wish_txt").html("저장됨");
					}
					if(json.delete_wishList == 1){
						alert("위시리스트에서 삭제 되었습니다.");
						$("svg#wish_before").removeClass("c_hide");
						$("svg#wish_after").addClass("c_hide");
						$("span#wish_txt").html("저장");
					}
					
					
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			 	}
			})
			
		}
	}
	
	// 인원 수 div 클릭  시 호출 되는 함수 - 객실, 인원 수 모달창 띄우기
	function checkGuestCnt() {
		
		$("input[name='adult_cnt']").val($("input[name='adults']").val());
		$("input[name='child_cnt']").val($("input[name='childs']").val());
		$("input[name='need_room_cnt']").val($("input[name='room']").val());
		
		const view_m_guest_cnt = document.getElementById('m_guest_cnt');
		const m_close_btn_gc = document.getElementById('m_close_btn_gc');
		view_m_guest_cnt.style.display="flex";
		document.body.style.overflow = 'hidden';
		
		window.onclick = function(e) {
			if (e.target == view_m_guest_cnt) {
				view_m_guest_cnt.style.display = "none";
				document.body.style.overflow = 'auto';
		  }
		}
		
		m_close_btn_gc.onclick = function() {
			view_m_guest_cnt.style.display = 'none';
		  	document.body.style.overflow = 'auto';
		}
	}
	
	// 객실, 인원 수 모달 창의 완료 버튼 클릭시
	function addGuestCnt() {
		const adults = Number($("input[name='adult_cnt']").val());
		const childs = Number($("input[name='child_cnt']").val());
		const guest_cnt = adults+childs;
		const room = Number($("input[name='need_rm_cnt']").val());
		$("input[name='guest']").val(guest_cnt);
		$("input[name='adults']").val(adults);
		$("input[name='childs']").val(childs);
		$("input[name='room']").val(room);
		
		$("button#guest_cnt_field").html("객실 "+room+"개, "+guest_cnt+"명&nbsp;&nbsp;<span class='c_txt_sm'>(아동"+childs+"명)<span>");
		
		$("div#m_guest_cnt").css("display","none");
		document.body.style.overflow = 'auto';
		
	}
	
	// 지금 결제 클릭 시 0
	function go_pay_now(rm_seq) {
		const ttl_guest_cnt = Number($("input:hidden[name='adults']").val()) + Number($("input:hidden[name='childs']").val());
		$("input:hidden[name='rm_seq']").val(rm_seq);
		$("input:hidden[name='h_userid']").val("${requestScope.lodgeinfo.FK_H_USERID}");
		$("input:hidden[name='payType']").val("0");
		$("input:hidden[name='ttl_guest_cnt']").val(ttl_guest_cnt);
		
		const frm = document.rmSearchFrm;
		frm.action="<%=ctxPath%>/payment/payment.exp";
		frm.method="post";
		frm.submit();
		
	}
	
	
	// 현장 결제 클릭 시 1
	function go_pay_later(rm_seq) {
		const ttl_guest_cnt = Number($("input:hidden[name='adults']").val()) + Number($("input:hidden[name='childs']").val());
		$("input:hidden[name='rm_seq']").val(rm_seq);
		$("input:hidden[name='h_userid']").val("${requestScope.lodgeinfo.FK_H_USERID}");
		$("input:hidden[name='payType']").val("1");
		$("input:hidden[name='ttl_guest_cnt']").val(ttl_guest_cnt);
		
		const frm = document.rmSearchFrm;
		frm.action="<%=ctxPath%>/payment/payment.exp";
		frm.method="post";
		frm.submit();
	}
	
	// 고객 이용 후기 모달에서 keyword 검색 버튼 클릭 시 호출 되는 함수 
	function goReviewSearch() {
		
		// alert($("input[name='reviewSearch']").val().trim());
		const searchWord = $("input[name='reviewSearch']").val().trim();
		if(searchWord == ""){
			alert("검색어를 입력해주세요");
		}
		else {
			
			$.ajax({
				url:"showReviewList_search_json.exp",
				data:{"lodge_id":"${requestScope.lodgeinfo.LODGE_ID}",
					  "searchWord":searchWord},
				dataType:"json",
				success:function(json){
					// console.log(json);
					// 정렬 조건에 맞게 정렬된 댓글을  div#view_reviewList 에 뿌려준다~
					const reviewList = json.reviewList;
					let html = "";
					if(reviewList != null){
						$.each(reviewList, function(index, item){
							html += '<div style="border-bottom: 1px solid black">';
							// console.log(item);
							if(item.RV_DEPTHNO == 0){
								console.log(item);
								html += '<div class="c_grid" style="gap:0.875rem; padding:1.2rem 0;">'
									  + 	'<div class="c_h3_head6" style="font-weight:600;">'+item.FK_RV_RATING+'/10 - '+item.RV_RATING_DESC+'</div>'
									  + 	'<div>'
									  +			'<div class="c_txt_sm" style="font-weight:600">'+item.RS_NAME+'</div>'
									  +			'<div class="c_txt_sm">'+item.RV_REGDATE+'</div>'
									  + 	'</div>'
									  + 	'<div class="c_flex" style="flex-direction: column; gap: 0.5rem;">'
									  +			'<div class="c_content_txt">'+item.RV_CONTENT+'</div>'
									  +			'<div class="c_txt_sm">'+item.RS_DATE+'에 '+item.LIVEDATE+' 숙박함</div>'
									  + 	'</div>'
									  + 	'<div class="reviewfindBtn">'
									  +			'<button type="button" onclick="golikeAdd(\''+item.RV_SEQ+'\',this)"><svg xmlns="http://www.w3.org/2000/svg" style="margin-right: 5px;" height="16" width="16" fill="rgba(35, 121, 255, 0.89)" viewBox="0 0 512 512"> <path d="M313.4 32.9c26 5.2 42.9 30.5 37.7 56.5l-2.3 11.4c-5.3 26.7-15.1 52.1-28.8 75.2H464c26.5 0 48 21.5 48 48c0 18.5-10.5 34.6-25.9 42.6C497 275.4 504 288.9 504 304c0 23.4-16.8 42.9-38.9 47.1c4.4 7.3 6.9 15.8 6.9 24.9c0 21.3-13.9 39.4-33.1 45.6c.7 3.3 1.1 6.8 1.1 10.4c0 26.5-21.5 48-48 48H294.5c-19 0-37.5-5.6-53.3-16.1l-38.5-25.7C176 420.4 160 390.4 160 358.3V320 272 247.1c0-29.2 13.3-56.7 36-75l7.4-5.9c26.5-21.2 44.6-51 51.2-84.2l2.3-11.4c5.2-26 30.5-42.9 56.5-37.7zM32 192H96c17.7 0 32 14.3 32 32V448c0 17.7-14.3 32-32 32H32c-17.7 0-32-14.3-32-32V224c0-17.7 14.3-32 32-32z" /></svg><button>'
									  +			'<span class="likeCnt">'+item.LIKECNT+'</span>'
									  + 	'</div>'
									  + '</div>';
							}
							if(item.RV_DEPTHNO > 0){
								html += '<input type="hidden" name="rv_seq" size="38" value="'+item.RV_SEQ+'" autocomplete="off" readonly />'
									  + '<div class="c_grid" style="gap: 0.875rem; padding: 0.5rem 0 1rem 1rem;">'
								      + 	'<div class="c_flex" style="flex-direction: column; gap: 0.3rem;">'
									  +			'<div class="c_txt_sm" style="font-weight:600">└ '+item.LG_NAME+' 님</div>'
									  + 		'<div class="c_txt_sm" style="padding-left:1rem;">'+item.RV_REGDATE+'</div>'
									  + 	'</div>'
									  + 	'<div class="c_txt_sm" style="padding-left:1rem;">'+item.RV_CONTENT+'</div>'
									  +	'</div>';		
							}							
							html += '</div>';
						});

					}
					 // console.log(html);
					 $("div#view_reviewList").html(html);					
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			 	}
			})
		}
	}
	
	// 고객 이용후기 모달 창에서 이용후기에 좋아요를 눌렀을 때 호출되는 함수 - 채혁
	function golikeAdd(rv_seq, e){
		if(${empty sessionScope.loginuser}){
           alert("좋아요를 하시려면 먼저 로그인 하셔야 합니다.");
           return false;
       	}

        $.ajax({
             url:"<%= ctxPath%>/likeAdd2.exp",
             type:"post",
             data:{"rv_seq":rv_seq,
                   "userid":"${sessionScope.loginuser.userid}"},
             dataType:"json",
             context: this,
             success:function(json) {
                // console.log(JSON.stringify(json));
                // {"msg":"해당제품에\n 좋아요를 클릭하셨습니다."}
                // 또는
                // {"msg":"이미 좋아요를 클릭하셨기에\n 두번 이상 좋아요는 불가합니다."}
                   
             	alert(json.msg);
             	const likecnt = json.likecnt;
             	// console.log(likecnt);             	
             	$(e).parent().parent().find("span.likeCnt").html(likecnt); // 해당 후기의 좋아요 숫자 업데이트 
              //swal(json.msg);
              
             },
             error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
             }
          });
	}
	
	
</script>
<title>Expedia ${requestScope.lodgeinfo.LG_NAME}</title>
<div id="main" style="inline-size: 100%; margin: auto; max-inline-size: 75rem;">
	<div id="top_bar_img_container">
		<div id="top_bar_container" class="" style="background-color: white; height: 4rem;">
			<div id="top_bar_wrap" class="c_flex c_flex_grow-1">
				<div class="" onclick="javascript:goBackLodgeSearch()">
					<div class="">
						<button>
							<svg class="" height="18" width="18" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill="#1668E3" d="M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z"></path></svg>
							<a class="c_text_link_m">숙박 시설 모두 보기</a>
						</button>
					</div>
				</div>
				<div class="c_flex" style="padding: 0 1rem 0 0">
					<div class="" onclick="add_wishList()">
						<button>
							<c:if test="${requestScope.isExist_wish}">
								<svg id="wish_after" class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill="#e61e43" fill-rule="evenodd" d="m12 22-8.44-8.69a5.55 5.55 0 0 1 0-7.72C4.53 4.59 5.9 4 7.28 4c1.4 0 2.75.59 3.72 1.59l1 1.02 1-1.02c.97-1 2.32-1.59 3.72-1.59 1.4 0 2.75.59 3.72 1.59a5.55 5.55 0 0 1 0 7.72L12 22Z" clip-rule="evenodd"></path></svg>
								<svg id="wish_before" class="c_icon_24 c_hide" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill-rule="evenodd" d="m12 22 8.44-8.69a5.55 5.55 0 0 0 0-7.72A5.24 5.24 0 0 0 16.72 4 5.22 5.22 0 0 0 13 5.59L12 6.6l-1-1.02a5.2 5.2 0 0 0-7.44 0 5.55 5.55 0 0 0 0 7.72L12 22Zm0-2.87-7-7.21a3.55 3.55 0 0 1 0-4.94C5.6 6.36 6.44 6 7.28 6c.84 0 1.69.36 2.3.98L12 9.48l2.43-2.5c.6-.62 1.45-.98 2.29-.98.84 0 1.68.36 2.28.98a3.55 3.55 0 0 1 0 4.94l-7 7.2Z" clip-rule="evenodd" opacity=".9"></path></svg>
							</button>
							<span id="wish_txt">저장됨</span>
							</c:if>
							<c:if test="${not requestScope.isExist_wish or empty sessionScope.loginuser}">
								<svg id="wish_after" class="c_icon_24 c_hide" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill="#e61e43" fill-rule="evenodd" d="m12 22-8.44-8.69a5.55 5.55 0 0 1 0-7.72C4.53 4.59 5.9 4 7.28 4c1.4 0 2.75.59 3.72 1.59l1 1.02 1-1.02c.97-1 2.32-1.59 3.72-1.59 1.4 0 2.75.59 3.72 1.59a5.55 5.55 0 0 1 0 7.72L12 22Z" clip-rule="evenodd"></path></svg>
								<svg id="wish_before" class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill-rule="evenodd" d="m12 22 8.44-8.69a5.55 5.55 0 0 0 0-7.72A5.24 5.24 0 0 0 16.72 4 5.22 5.22 0 0 0 13 5.59L12 6.6l-1-1.02a5.2 5.2 0 0 0-7.44 0 5.55 5.55 0 0 0 0 7.72L12 22Zm0-2.87-7-7.21a3.55 3.55 0 0 1 0-4.94C5.6 6.36 6.44 6 7.28 6c.84 0 1.69.36 2.3.98L12 9.48l2.43-2.5c.6-.62 1.45-.98 2.29-.98.84 0 1.68.36 2.28.98a3.55 3.55 0 0 1 0 4.94l-7 7.2Z" clip-rule="evenodd" opacity=".9"></path></svg>
							</button>
							<span id="wish_txt">저장</span>
							</c:if>						
					</div>
				</div>
			</div>
		</div>
		<div id="top_main_img_container">
			<c:if test="${not empty requestScope.lg_img_list}">	
				<div id="top_main_img_wrap" class="c_grid" style="gap: 4px; height: 25rem;">							
					<c:forEach items="${requestScope.lg_img_list}" var="img_list" varStatus="status">
						<c:if test="${not status.last}">
							<div id="main_img_${status.index}" onclick="goMoreImg()"><img src="<%= ctxPath%>/resources/images/${lodgeinfo.LODGE_ID}/lodge_img/${img_list.lg_img_save_name}" style="aspect-ratio:16/9;"></div>
						</c:if>
						<c:if test="${status.last}">
							<div id="main_img_${status.index}"  onclick="goMoreImg()">
								<img src="<%= ctxPath%>/resources/images/${lodgeinfo.LODGE_ID}/lodge_img/${img_list.lg_img_save_name}"style="aspect-ratio:16/9;">
								<div id="more_pic_btn" class="more_pic_btn" onclick="goMoreImg()">
									<button type="button" style="width: inherit; height: inherit;">
										<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill="white" fill-rule="evenodd" d="M22 16V4a2 2 0 0 0-2-2H8a2 2 0 0 0-2 2v12c0 1.1.9 2 2 2h12a2 2 0 0 0 2-2zm-11-4 2.03 2.71L16 11l4 5H8l3-4zm-9 8V6h2v14h14v2H4a2 2 0 0 1-2-2z" clip-rule="evenodd"></path></svg>
										${fn:length(all_lg_img_list)+fn:length(all_rm_img_list)}+
									</button>
								</div>
							</div>
						</c:if>						
					</c:forEach>
				</div>
			</c:if>
			
		</div>
	</div>
	<div id="nav_bar" style="z-index:101;">
		<div class="c_flex" id="nav_bar_container" style="align-items: center; justify-content: space-between; border-bottom: solid 1px #dfe0e4;">
			<div>
				<div id="nav_bar_wrap"class="c_flex">
					<ul id="nav_ul">
						<li class="pad_x_1r">
							<a class="c_flex" href="#basic_info"><span>소개</span></a>
						</li>
						<c:if test="${not empty requestScope.d_map and not empty requestScope.avbl_rm_list}">
							<li class="pad_x_1r">
								<a class="c_flex" href="#result_room_container"><span>객실</span></a>
							</li>
						</c:if>
						<li class="pad_x_1r">
							<a class="c_flex" href="#local_info"><span>위치</span></a>
						</li>
						<c:if test="${not empty requestScope.rmsvc_opt_list or not empty requestScope.cs_opt_list}">
							<li class="pad_x_1r">
								<a class="c_flex" href="#con_fac_container"><span>편의시설/서비스</span></a>
							</li>
						</c:if>
						<c:if test="${not empty requestScope.fac_opt_list}">
							<li class="pad_x_1r">
								<a class="c_flex" href="#basic_policy_container"><span>장애인 지원</span></a>
							</li>
						</c:if>
						<li class="pad_x_1r">
							<a class="c_flex" href="#extra_info_container"><span>정책</span></a>
						</li>
						<li id="highlight_line"></li>
					</ul>				
				</div>
			</div>
			<div class="pad_x_end" id="room_rsv_btn">
				<div class="c_flex">
					<button type="button" class="c_btn_pri" style="width: 7rem; height: 2.4rem; margin: auto 0;" onclick="location.href = '#result_room_container'">객실 예약</button>
				</div>
			</div>
		</div>
	</div>
	<div class="c_container_w c_grid" id="basic_info_container" style="margin-bottom: 0.75rem;">
		<div id="basic_info" style="padding-bottom: 1.25rem;">
			
			<div id="name_part" class="c_grid" style="gap:0.1rem;"> 
				<c:if test="${not empty requestScope.lodgeinfo}" >
					<h1 class="c_h1_head3">${requestScope.lodgeinfo.LG_NAME}</h1>
					<h2 class="c_content_txt">${requestScope.lodgeinfo.LG_EN_NAME}</h2>
				</c:if>
				<c:if test="${requestScope.lodgeinfo.FK_LODGE_TYPE eq 0}">
					<div>
						<c:forEach begin="1" end="${requestScope.lodgeinfo.LG_HOTEL_STAR}" >
						<svg class="c_icon_16" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path d="M12 17.27 18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21 12 17.27z"></path></svg>
						</c:forEach>						
					</div>
				</c:if>
				<c:if test="${requestScope.lodgeinfo.FK_LODGE_TYPE eq 0}">
					<div>${requestScope.lodgeinfo.LG_HOTEL_STAR}성급 ${requestScope.lodgeinfo.LODGE_CONTENT}</div>
				</c:if>
				<c:if test="${requestScope.lodgeinfo.FK_LODGE_TYPE ne 0}">
					<div>${requestScope.lodgeinfo.LODGE_CONTENT}</div>
				</c:if>
			</div>
			<div id="pay_later_txt" class="c_pd_b_15r">
				<div>
					<div class="c_flex" style="padding-top: 1rem;">
						<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill="#227950" d="M9 16.17 4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41L9 16.17z"></path></svg>
						<span style="color: #227950; padding-right: 1.5rem;">지금 예약하고 현장 결제</span>
						<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill="#227950" d="M9 16.17 4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41L9 16.17z"></path></svg>
						<span style="color: #227950; padding-right: 1.5rem;">전액 환불가능</span>
					</div>
				</div>
			</div>
			<div id="go_review" class="c_pd_b_15r" style="padding-bottom: 1.25rem;">
			<c:set var="rv_rate" value="${requestScope.lodgeinfo.RV_RATING_AVG}"/>
				<c:if test="${rv_rate>0}">			
					<div class="c_flex" style="margin-bottom: 0.5rem;">
						<c:if test="${rv_rate>=8}">
							<span class="uitk-badge uitk-badge-base-large uitk-badge-base-has-text uitk-badge-positive"><span class="uitk-badge-base-text" aria-hidden="true"><fmt:formatNumber value="${requestScope.lodgeinfo.RV_RATING_AVG}" pattern=".0"/></span></span>
						</c:if>
						<c:if test="${rv_rate<8}">
							<span class="uitk-badge uitk-badge-base-large uitk-badge-base-has-text uitk-badge-standard"><span class="uitk-badge-base-text" aria-hidden="true"><fmt:formatNumber value="${requestScope.lodgeinfo.RV_RATING_AVG}" pattern=".0"/></span></span>
						</c:if>						
						<h3 class="c_h3_head5" style="padding-left: 0.5rem;">
							<c:if test="${rv_rate>=7.0 and rv_rate<=7.9}">좋아요</c:if>
							<c:if test="${rv_rate>=8.0 and rv_rate<=8.4}">매우 좋아요</c:if>
							<c:if test="${rv_rate>=8.5 and rv_rate<=8.9}">훌륭해요</c:if>
							<c:if test="${rv_rate>=9.0 and rv_rate<=9.4}">매우 훌륭해요</c:if>
							<c:if test="${rv_rate>=9.5 and rv_rate<=10.0}">최고에요</c:if>
						</h3>
					</div>
				</c:if>
				<c:if test="${empty rv_rate}">			
					<div class="c_flex" style="margin-bottom: 0.5rem;">
						<span class="uitk-badge uitk-badge-base-large uitk-badge-base-has-text uitk-badge-standard"><span class="uitk-badge-base-text" aria-hidden="true">0.0</span></span>
						<h3 class="c_h3_head5" style="padding-left: 0.5rem;">이용 후기 없음</h3>
					</div>
				</c:if>
				<div>
					<button type="button" id="view_reviewList">
						<c:if test="${requestScope.lodgeinfo.RV_CNT>0}">
							<a class="c_text_link_m"><fmt:formatNumber pattern="###,###" >${requestScope.lodgeinfo.RV_CNT}</fmt:formatNumber>개 이용 후기 모두 보기</a>
							<svg class="c_icon_18" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill="#1668e3" d="M10 6 8.59 7.41 13.17 12l-4.58 4.59L10 18l6-6-6-6z"></path></svg>
						</c:if>
					</button>
				</div>
			</div>
			
			<div id="pop_fac_container"> 
				<div id="h3">
					<h3 class="c_h3_head5" style="padding-bottom: 0.75rem;">인기 편의 시설</h3>
				</div>
				<div id="pop_fac" style="height: 7rem; overflow: hidden;">
					<div class="c_grid" style="grid-template-columns: repeat(2, 1fr); gap: 1rem;">
					</div>
				</div>
				<div id="view_all_fac_btn" class="c_text_link_m c_flex viewModal" style="padding-top: 0.75rem;">
					<span>모두 보기</span>
					<svg class="c_icon_18" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill="#1668e3" d="M10 6 8.59 7.41 13.17 12l-4.58 4.59L10 18l6-6-6-6z"></path></svg>
				</div>
				
			</div>
		</div>
		<div id="map_info">
			<div style="padding-bottom: 0.5rem;">
				<div id="lg_map" style="width: 100%; height:15rem; border-radius: 1rem;"></div>
			</div>
			<div class="c_content_txt">${requestScope.lodgeinfo.LG_ADDRESS}</div>
			<div id="view_map" class="c_text_link_m c_flex viewModal" style="padding-top: 0.75rem;" onclick="window.open('https://map.kakao.com/link/map/${requestScope.lodgeinfo.LG_LATITUDE},${requestScope.lodgeinfo.LG_LONGITUDE}')">
				<span>지도로 보기</span>
				<svg class="c_icon_18" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill="#1668e3" d="M10 6 8.59 7.41 13.17 12l-4.58 4.59L10 18l6-6-6-6z"></path></svg>
			</div>
			
		</div>
	</div>
	
	<div>
		<div id="view_all_fac" class="c_modalContainer" style="overflow-y:hidden;">
			<div class="c_modalWrap">
				<div id="modalTop_close" class="c_flex" style="block-size: 3rem; align-items: center;">
					<button type="button" id="m_close_btn_fac" class="c_flex modal_close_btn" style="block-size: 3rem; inline-size:3rem;">
						<span class="c_round_btn_blue c_flex" style="block-size: 2.3rem; inline-size:2.3rem; margin: auto;">
							<svg class="c_icon_24" style="margin: auto;" aria-label="닫기" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><title id="undefined-close-toolbar-title">닫기.</title><path fill="#1668e3" d="M19 6.41 17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12 19 6.41z"></path></svg>
						</span>					
					</button>
					숙박 시설 내 편의 시설
				</div>
				<div id="" class="c_grid" style="height: 75vh; padding: 1.5rem; gap:1.5rem;  overflow-y: auto;">
					<div id="m_popFac">
						<div>
							<h3 class="c_h3_head5" style="padding-bottom: 0.75rem;">인기 편의 시설</h3>
						</div>
						<div id="m_popFac_content" >
							<div class="c_grid" style="grid-template-columns: repeat(2, 1fr); gap: 1rem;">
								<c:if test="${requestScope.lodgeinfo.LG_BREAKFAST_YN ne 0}">
									<div class="c_flex c_content_txt" style="align-items: center; gap: 0.3rem;">
										<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill-rule="evenodd" d="M20 3H4v10a4 4 0 0 0 4 4h6a4 4 0 0 0 4-4v-3h2a2 2 0 0 0 2-2V5a2 2 0 0 0-2-2zm0 5h-2V5h2v3zm0 11H4v2h16v-2z" clip-rule="evenodd"></path></svg>
										<span>아침식사 가능</span>
									</div>
								</c:if>
								<c:if test="${requestScope.lodgeinfo.LG_PET_YN ne 0}">
									<div class="c_flex c_content_txt" style="align-items: center; gap: 0.3rem;">
										<svg class="c_icon_24" aria-hidden"true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path d="M9 8a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5zm-4.5 4a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5zm13-6.5a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0zm2 6.5a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5zm-9.7-.61-5.15 5.58A3 3 0 0 0 6.85 22h.65l1.19-.13a30 30 0 0 1 6.62 0l1.19.13h.65a3 3 0 0 0 2.2-5.03l-5.15-5.58a3 3 0 0 0-4.4 0z"></path></svg>
										<span>반려동물 동반 가능</span>
									</div>
								</c:if>
								<c:if test="${requestScope.lodgeinfo.LG_POOL_YN ne 0}">
									<div class="c_flex c_content_txt" style="align-items: center; gap: 0.3rem;">
										<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path d="M9.82 11.64h.01a4.15 4.15 0 0 1 4.36 0h.01c.76.46 1.54.47 2.29 0l.41-.23L10.48 5C8.93 3.45 7.5 2.99 5 3v2.5c1.82-.01 2.89.39 4 1.5l1 1-3.25 3.25c.27.1.52.25.77.39.75.47 1.55.47 2.3 0z"></path><path fill-rule="evenodd" d="M21.98 16.5c-1.1 0-1.71-.37-2.16-.64h-.01a2.08 2.08 0 0 0-2.29 0 4.13 4.13 0 0 1-4.36 0h-.01a2.08 2.08 0 0 0-2.29 0 4.13 4.13 0 0 1-4.36 0h-.01a2.08 2.08 0 0 0-2.29 0l-.03.02c-.47.27-1.08.62-2.17.62v-2c.56 0 .78-.13 1.15-.36a4.13 4.13 0 0 1 4.36 0h.01c.76.46 1.54.47 2.29 0a4.13 4.13 0 0 1 4.36 0h.01c.76.46 1.54.47 2.29 0a4.13 4.13 0 0 1 4.36 0h.01c.36.22.6.36 1.14.36v2z" clip-rule="evenodd"></path><path d="M19.82 20.36c.45.27 1.07.64 2.18.64v-2a1.8 1.8 0 0 1-1.15-.36 4.13 4.13 0 0 0-4.36 0c-.75.47-1.53.46-2.29 0h-.01a4.15 4.15 0 0 0-4.36 0h-.01c-.75.47-1.55.47-2.3 0a4.15 4.15 0 0 0-4.36 0h-.01A1.8 1.8 0 0 1 2 19v2c1.1 0 1.72-.36 2.18-.63l.01-.01a2.07 2.07 0 0 1 2.3 0c1.39.83 2.97.82 4.36 0h.01a2.08 2.08 0 0 1 2.29 0h.01c1.38.83 2.95.83 4.34.01l.02-.01a2.08 2.08 0 0 1 2.29 0h.01zM19 5.5a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0z"></path></svg>
										<span>수영장</span>
									</div>
								</c:if>
								<c:if test="${fn:contains(inet_opt_list, 'wifi')}">
									<div class="c_flex c_content_txt" style="align-items: center; gap: 0.3rem;">
										<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill-rule="evenodd" d="m1 9 2 2a12.73 12.73 0 0 1 18 0l2-2A15.57 15.57 0 0 0 1 9zm8 8 3 3 3-3a4.24 4.24 0 0 0-6 0zm-2-2-2-2a9.91 9.91 0 0 1 14 0l-2 2a7.07 7.07 0 0 0-10 0z" clip-rule="evenodd"></path></svg>
										<span>와이파이</span>
									</div>
								</c:if>
								<c:if test="${requestScope.lodgeinfo.FK_SPA_TYPE ne 0}">
									<div class="c_flex c_content_txt" style="align-items: center; gap: 0.3rem;">
										<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill-rule="evenodd" d="M12.06 2a11.8 11.8 0 0 1 3.43 7.63A14.36 14.36 0 0 0 12 12.26a13.87 13.87 0 0 0-3.49-2.63A12.19 12.19 0 0 1 12.06 2zM2 10a12.17 12.17 0 0 0 10 12 12.17 12.17 0 0 0 10-12c-4.18 0-7.85 2.17-10 5.45A11.95 11.95 0 0 0 2 10z" clip-rule="evenodd"></path></svg>
										<span>스파</span>
									</div>
								</c:if>
								<c:if test="${fn:contains(com_tmp_opt_list, '에어컨')}">
									<div class="c_flex c_content_txt" style="align-items: center; gap: 0.3rem;">
										<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path d="M22 11h-4.17l3.24-3.24-1.41-1.42L15 11h-2V9l4.66-4.66-1.42-1.41L13 6.17V2h-2v4.17L7.76 2.93 6.34 4.34 11 9v2H9L4.34 6.34 2.93 7.76 6.17 11H2v2h4.17l-3.24 3.24 1.41 1.42L9 13h2v2l-4.66 4.66 1.42 1.41L11 17.83V22h2v-4.17l3.24 3.24 1.42-1.41L13 15v-2h2l4.66 4.66 1.41-1.42L17.83 13H22v-2z"></path></svg>
										<span>에어컨</span>
									</div> 
								</c:if>
								<c:if test="${requestScope.lodgeinfo.LG_PARK_YN ne 0}">
									<div class="c_flex c_content_txt" style="align-items: center; gap: 0.3rem;">
										<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill-rule="evenodd" d="M6 3h7a6 6 0 0 1 0 12h-3v6H6V3zm4 8h3.2a2 2 0 0 0 2-2 2 2 0 0 0-2-2H10v4z" clip-rule="evenodd"></path></svg>
										<span>주차 가능</span>
									</div>
								</c:if>
								<c:if test="${fn:contains(din_opt_list, '레스토랑')}">
									<div class="c_flex c_content_txt" style="align-items: center; gap: 0.3rem;">
										<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill-rule="evenodd" d="M20.15 10.15c-1.59 1.59-3.74 2.09-5.27 1.38L13.41 13l6.88 6.88-1.41 1.41L12 14.41l-6.89 6.87-1.41-1.41 9.76-9.76c-.71-1.53-.21-3.68 1.38-5.27 1.92-1.91 4.66-2.27 6.12-.81 1.47 1.47 1.1 4.21-.81 6.12zm-9.22.36L8.1 13.34 3.91 9.16a4 4 0 0 1 0-5.66l7.02 7.01z" clip-rule="evenodd"></path></svg>
										<span>레스토랑</span>
									</div>
								</c:if>
								<c:if test="${fn:contains(din_opt_list, '바')}">
									<div class="c_flex c_content_txt" style="align-items: center; gap: 0.3rem;">
										<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill-rule="evenodd" d="M21 3v2l-8 9v5h5v2H6v-2h5v-5L3 5V3h18zM5.66 5l1.77 2h9.14l1.78-2H5.66z" clip-rule="evenodd"></path></svg>
										<span>바</span>
									</div>
								</c:if>
								<c:if test="${fn:contains(cs_opt_ist, '세탁 서비스')}">
									<div class="c_flex c_content_txt" style="align-items: center; gap: 0.3rem;">
										<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill-rule="evenodd" d="M18 2.01 6 2a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V4c0-1.11-.89-1.99-2-1.99zM11 5a1 1 0 0 0-1-1 1 1 0 0 0-1 1 1 1 0 0 0 1 1 1 1 0 0 0 1-1zM9.17 16.83a4 4 0 0 0 5.66-5.66l-5.66 5.66zM7 4a1 1 0 0 1 1 1 1 1 0 0 1-1 1 1 1 0 0 1-1-1 1 1 0 0 1 1-1zM6 14a6 6 0 1 0 12.01-.01A6 6 0 0 0 6 14z" clip-rule="evenodd"></path></svg>
										<span>세탁 서비스</span>
									</div>
								</c:if>
								<c:if test="${requestScope.lodgeinfo.LG_BUSINESS_YN ne 0}">
									<div class="c_flex c_content_txt" style="align-items: center; gap: 0.3rem;">
										<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill-rule="evenodd" d="M20 7h-4.01V5l-2-2h-4l-2 2v2H4a2 2 0 0 0-2 2v3a2 2 0 0 0 2 2h6v-2h4v2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2zm-10 9v-1H3.01L3 19a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-4h-7v1h-4zm0-9h4V5h-4v2z" clip-rule="evenodd"></path></svg>
										<span>비즈니스 서비스</span>
									</div>
								</c:if>
								<c:if test="${fn:contains(cs_opt_ist, '24시간 운영 프런트 데스크')}">
									<div class="c_flex c_content_txt" style="align-items: center; gap: 0.3rem;">
										<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill-rule="evenodd" d="M19 7V4H5v3H2v13h8v-4h4v4h8V7h-3zM9 10v1h2v1H8V9h2V8H8V7h3v3H9zm6 2h1V7h-1v2h-1V7h-1v3h2v2z" clip-rule="evenodd"></path></svg>
										<span>매일 24시간 운영 프런트 데스크</span>
									</div>
								</c:if>
								<c:if test="${requestScope.lodgeinfo.LG_RM_SERVICE_YN ne 0}">
									<div class="c_flex c_content_txt" style="align-items: center; gap: 0.3rem;">
										<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill-rule="evenodd" d="M14 7c0 .28-.06.55-.16.79A9.01 9.01 0 0 1 21 16H3a9.01 9.01 0 0 1 7.16-8.21A2 2 0 0 1 12 5a2 2 0 0 1 2 2zm8 12v-2H2v2h20z" clip-rule="evenodd"></path></svg>
										<span>룸서비스</span>
									</div>
								</c:if>
								<c:if test="${fn:contains(cs_opt_ist, '하우스키핑')}">
									<div class="c_flex c_content_txt" style="align-items: center; gap: 0.3rem;">
										<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path d="M9 16.17 4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41L9 16.17z"></path></svg>
										<span>하우스 키핑</span>
									</div>
								</c:if>
								<c:if test="${requestScope.lodgeinfo.LG_FA_TRAVEL_YN ne 0}">
									<div class="c_flex c_content_txt" style="align-items: center; gap: 0.3rem;">
										<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path d="M16 22v-1c0-2-1.59-3-4-3-2.5 0-4 1-4 3v1H2v-8.98C2 11.07 5.67 10 7.5 10c1.23 0 3.28.48 4.5 1.39A8.67 8.67 0 0 1 16.5 10c1.83 0 5.5 1.07 5.5 3.02V22h-6zM7 8C5.37 8 4 6.63 4 5s1.37-3 3-3 3 1.37 3 3-1.37 3-3 3zm10 0c-1.63 0-3-1.37-3-3s1.37-3 3-3 3 1.37 3 3-1.37 3-3 3zm-5 9c1.09 0 2-.91 2-2 0-1.09-.91-2-2-2-1.09 0-2 .91-2 2 0 1.09.91 2 2 2z"></path></svg>
										<span>가족 여행 편의 시설</span>
									</div>
								</c:if>
							</div>
						</div>	
					</div>
					<c:if test="${requestScope.lodgeinfo.LG_BREAKFAST_YN eq 1 or not empty requestScope.din_opt_list}">
					<div id="m_food">
						<div>
							<h3 class="c_h3_head5" style="padding-bottom: 0.75rem;">식사 및 음료</h3>
						</div>
						<div>
							<ul class="c_grid" style="gap: 0.1rem;" >
								<c:if test="${requestScope.lodgeinfo.LG_BREAKFAST_YN eq 1}">
									<li class="c_txt-300 c_li_dot">아침 식사 제공(요금 별도)</li>
								</c:if>
								<c:if test="${not empty requestScope.din_opt_list}">
									<c:forEach var="din_opt" items="${requestScope.din_opt_list}">
										<li class="c_txt-300 c_li_dot">시설 내 ${din_opt.din_opt_desc}</li>
									</c:forEach>
								</c:if>
							</ul>
						</div>
					</div>
					</c:if>
					<c:if test="${not empty requestScope.inet_opt_list}">			
						<div id="m_internet">
							<div>
								<h3 class="c_h3_head5" style="padding-bottom: 0.75rem;">인터넷</h3>
							</div>
							<div>
								<ul class="c_grid" style="gap: 0.1rem;" >									
									<c:forEach var="inet" items="${requestScope.inet_opt_list}">
										<li class="c_txt-300 c_li_dot">${inet.inet_opt_desc}이용 가능</li>
									</c:forEach>							
								</ul>
							</div>
						</div>
					</c:if>
					<c:if test="${not empty requestScope.park_opt_list}">	
						<div id="m_park">
							<div>
								<h3 class="c_h3_head5" style="padding-bottom: 0.75rem;">주차 및 교통</h3>
							</div>
							<div>
								<ul class="c_grid" style="gap: 0.1rem;" >
									<c:forEach var="park" items="${requestScope.park_opt_list}">
										<c:if test="${park.fk_park_opt_no eq 0 or park.fk_park_opt_no eq 1}">
											<li class="c_txt-300 c_li_dot">시설 내 ${park.park_opt_desc}주차 이용 가능</li>
										</c:if>	
										<c:if test="${park.fk_park_opt_no eq 2 or park.fk_park_opt_no eq 3}">
											<li class="c_txt-300 c_li_dot">${park.park_opt_desc}&nbsp;가능</li>
										</c:if>
									</c:forEach>	
								</ul>
							</div>
						</div>
					</c:if>	
					<c:if test="${requestScope.lodgeinfo.FK_SPA_TYPE ne 0 or requestScope.lodgeinfo.LG_POOL_YN eq 1}">
						<div id="m_enter">
							<div>
								<h3 class="c_h3_head5" style="padding-bottom: 0.75rem;">즐길 거리</h3>
							</div>
							<div>
								<ul class="c_grid" style="gap: 0.1rem;" >
									<c:if test="${requestScope.lodgeinfo.FK_SPA_TYPE ne 0}">
										<li class="c_txt-300 c_li_dot">${requestScope.lodgeinfo.spa_desc}</li>
									</c:if>
									<c:if test="${not empty requestScope.pool_opt_list}">
										<c:forEach var="pool" items="${requestScope.pool_opt_list}">
											<c:if test="${pool.fk_pool_opt_no eq 0}">
												<li class="c_txt-300 c_li_dot">${pool.pool_opt_desc}&nbsp;수영장</li>
											</c:if>
											<c:if test="${pool.fk_pool_opt_no eq 1}">
												<li class="c_txt-300 c_li_dot">야외&nbsp;수영장&nbsp;(상시 운영)</li>
											</c:if>
											<c:if test="${pool.fk_pool_opt_no eq 2}">
												<li class="c_txt-300 c_li_dot">야외&nbsp;수영장&nbsp;(시즌 운영)</li>
											</c:if>
										</c:forEach>
									</c:if>
								</ul>
							</div>
						</div>
					</c:if>	
					<c:if test="${not empty requestScope.fasvc_opt_list}">	
						<div id="m_family">
							<div>
								<h3 class="c_h3_head5" style="padding-bottom: 0.75rem;">가족 여행 편의 시설</h3>
							</div>
							<div>
								<ul class="c_grid" style="gap: 0.1rem;" >
									<c:forEach var="fasvc" items="${requestScope.fasvc_opt_list}">
										<li class="c_txt-300 c_li_dot">${fasvc.fasvc_opt_desc}</li>
									</c:forEach>	
								</ul>
							</div>
						</div>
					</c:if>						
					<c:if test="${not empty requestScope.fac_opt_list}">
						<div id="m_conFac">
							<div>
								<h3 class="c_h3_head5" style="padding-bottom: 0.75rem;">장애인 편의 시설</h3>
							</div>
							<div>
								<ul class="c_grid" style="gap: 0.1rem;" >
									<c:forEach var="fac" items="${requestScope.fac_opt_list}">
										<li class="c_txt-300 c_li_dot">${fac.fac_opt_desc}</li>
									</c:forEach>	
								</ul>
							</div>
						</div>
					</c:if>	
					<c:if test="${not empty requestScope.cs_opt_list}">
						<div id="m_customerSvc">
							<div>
								<h3 class="c_h3_head5" style="padding-bottom: 0.75rem;">고객 서비스</h3>
							</div>
							<div>
								<ul class="c_grid" style="gap: 0.1rem;" >
									<c:forEach var="cs" items="${requestScope.cs_opt_list}">
										<li class="c_txt-300 c_li_dot">${cs.cs_opt_desc}</li>
									</c:forEach>
								</ul>
							</div>
						</div>
					</c:if>	
					<c:if test="${not empty requestScope.bsns_opt_list}">
						<div id="m_business">
							<div>
								<h3 class="c_h3_head5" style="padding-bottom: 0.75rem;">비즈니스 편의시설</h3>
							</div>
							<div>
								<ul class="c_grid" style="gap: 0.1rem;" >
									<c:forEach var="bsns" items="${requestScope.bsns_opt_list}">
										<li class="c_txt-300 c_li_dot">${bsns.bsns_opt_desc}</li>
									</c:forEach>
								</ul>
							</div>
						</div>
					</c:if>
					<c:if test="${requestScope.lodgeinfo.LG_PET_YN eq 1 or requestScope.lodgeinfo.LG_SMOKE_YN eq 0}">
						<div id="m_etc">
							<div>
								<h3 class="c_h3_head5" style="padding-bottom: 0.75rem;">기타</h3>
							</div>
							<div>
								<ul class="c_grid" style="gap: 0.1rem;" >
									<c:if test="${requestScope.lodgeinfo.LG_PET_YN eq 1}">
										<li class="c_txt-300 c_li_dot">반려동물 동반 가능 숙박 시설</li>
									</c:if>
									<c:if test="${requestScope.lodgeinfo.LG_SMOKE_YN eq 0}">
										<li class="c_txt-300 c_li_dot">금연 숙박 시설</li>
									</c:if>									
								</ul>
							</div>
						</div>
					</c:if>
				</div>
			</div>
		</div>
	</div>
	<div id="search_room_container">
		<div id="h2" style="padding-bottom: 0.75rem;">
			<h2 style="c_h2_head4">객실 선택</h2>
		</div>
		
		<div>
			<div data-stid="section-hotel-search"> 
				<h3 class="is-visually-hidden">검색 조건 변경</h3>
				<div class="uitk-spacing uitk-spacing-margin-blockend-two">
					<div id="FormWrapper">
						<form name="rmSearchFrm">
							<div class="c_grid" style="gap: 1.5rem; grid-template-columns: 1fr 1fr 1fr;">
								<div class="uitk-field has-floatedLabel-label has-icon has-placeholder ">
									<label for="startDate" class="uitk-field-label"><span aria-hidden="true">체크인</span></label>
									<input id="startDate" name="startDate" data-stid="input-date"
										type="text"
										class="uitk-field-input uitk-menu-trigger uitk-faux-input uitk-form-field-trigger dateSelector"
										placeholder="날짜 선택" aria-required="false"
										value="">
									<button class="is-visually-hidden is-hidden" type="button" aria-hidden="true" tabindex="-1"></button>
									<svg class="uitk-icon uitk-field-icon" aria-hidden="true"viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill-rule="evenodd" d="M19 3h-1V1h-2v2H8V1H6v2H5a2 2 0 0 0-1.99 2L3 19a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V5a2 2 0 0 0-2-2zm0 5v11H5V8h14zm-7 2H7v5h5v-5z" clip-rule="evenodd"></path></svg>
								</div>
								<div class="uitk-field has-floatedLabel-label has-icon has-placeholder ">
									<label for="endDate" class="uitk-field-label"><span aria-hidden="true">체크아웃</span></label>
									<input id="endDate" name="endDate" data-stid="input-date"
										type="text"
										class="uitk-field-input uitk-menu-trigger uitk-faux-input uitk-form-field-trigger dateSelector_co"
										placeholder="날짜 선택" aria-required="false"
										value="">
									<button class="is-visually-hidden is-hidden" type="button" aria-hidden="true" tabindex="-1"></button>
									<svg class="uitk-icon uitk-field-icon" aria-hidden="true"viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill-rule="evenodd" d="M19 3h-1V1h-2v2H8V1H6v2H5a2 2 0 0 0-1.99 2L3 19a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V5a2 2 0 0 0-2-2zm0 5v11H5V8h14zm-7 2H7v5h5v-5z" clip-rule="evenodd"></path></svg>
								</div>
								<div class="c_flex" style="gap: 1.5rem;">	
									<div class="uitk-field has-floatedLabel-label has-icon has-placeholder" style="flex-grow: 1;" onclick="javacript:checkGuestCnt()">
										<label for="g_cnt" class="uitk-field-label">인원 수</label>
										<input id="g_cnt" type="text"
											class="uitk-field-input is-hidden" placeholder="Placeholder"
											 value="">
										<c:if test="${not empty requestScope.adult_cnt and not empty requestScope.child_cnt and not empty requestScope.room_cnt}">
											<button id="guest_cnt_field" class="uitk-fake-input uitk-form-field-trigger" type="button">객실 ${requestScope.room_cnt}개, ${requestScope.adult_cnt}명&nbsp;&nbsp;<span class="c_txt_sm">(아동 ${requestScope.child_cnt}명)</span></button>
										</c:if>	
										<c:if test="${empty requestScope.adult_cnt or empty requestScope.room_cnt}">
											<button id="guest_cnt_field" class="uitk-fake-input uitk-form-field-trigger" type="button">객실 1개, 1명&nbsp;&nbsp;<span class="c_txt_sm">(아동 0명)</span></button>
										</c:if>
										<svg class="uitk-icon uitk-field-icon" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <path fill-rule="evenodd" d="M16 8a4 4 0 1 1-8 0 4 4 0 0 1 8 0zM4 18c0-2.66 5.33-4 8-4s8 1.34 8 4v2H4v-2z" clip-rule="evenodd"></path></svg>
									</div>
									<div class="c_flex uitk-field has-floatedLabel-label has-icon has-placeholder" style="flex-grow: 1;">
										<div class="c_flex" style="flex-grow:1;">
											<button type="button" class="c_btn_pri" style="flex-grow:1; height: 2.5rem; margin: auto;" onclick="goSearchRoom()">조회하기</button>
										</div>																			
									</div>
									<c:if test="${not empty requestScope.guest_cnt and not empty requestScope.room_cnt}">
										<input type="hidden" name="guest" readonly value="${requestScope.guest_cnt}">
										<input type="hidden" name="adults" readonly value="${requestScope.adult_cnt}">
										<input type="hidden" name="childs" readonly value="${requestScope.child_cnt}">
										<input type="hidden" name="room" readonly value="${requestScope.room_cnt}">
									</c:if>	
									<c:if test="${empty requestScope.guest_cnt or empty requestScope.room_cnt}">
										<input type="hidden" name="guest" readonly value="1">
										<input type="hidden" name="adults" readonly value="1">
										<input type="hidden" name="childs" readonly value="1">
										<input type="hidden" name="room" readonly value="1">
									</c:if>	
									<input type="hidden" name="lodge_id" readonly value="${requestScope.lodge_id}">
									<input type="hidden" name="ttl_guest_cnt" readonly value="">
									<input type="hidden" name="h_userid" readonly value="">
									<input type="hidden" name="rm_seq" readonly value="">
									<input type="hidden" name="payType" readonly value="">
								</div>	
							</div>						
						</form>
						<form name="lodgeSearchFrm">
							<input type="text" name="lg_area" readonly value="${requestScope.lodgeinfo.LG_AREA}" style="display: none;">
							<input type="text" name="lg_area_2" readonly value="${requestScope.lodgeinfo.LG_AREA_2}" style="display: none;">
							<input type="text" name="lg_name" readonly value="" style="display: none;">
							<input type="hidden" name="check_in" readonly value="">
							<input type="hidden" name="check_out" readonly value="">
							<input type="hidden" name="travlers" readonly value="">
							<input type="hidden" name="adult" readonly value="">
							<input type="hidden" name="kid" readonly value="">							
						</form>
					</div>
				</div>
			</div>		
		</div>
		
		<div id="m_guest_cnt" class="c_modalContainer_sm" style="overflow-y: hidden;" >
			<div class="c_modalWrap_xsm" style="margin: auto; width: 28rem; overflow-y: hidden;">
				<div class="c_flex modalTop_close" style="block-size: 3rem; height:auto; align-items: center;">
					<button type="button" id="m_close_btn_gc" class="c_flex modal_close_btn" style="block-size: 3rem; inline-size: 3rem;">
						<span class="c_round_btn_blue c_flex" style="block-size: 2.3rem; inline-size: 2.3rem; margin: auto;">
							<svg class="c_icon_24" style="margin: auto;" aria-label="닫기" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <title id="undefined-close-toolbar-title">닫기.</title><path fill="#1668e3" d="M19 6.41 17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12 19 6.41z"></path></svg>
						</span>
					</button>
					인원 수
				</div>
				<div style="padding: 1.5rem;">
					<h3 class="c_txt_sm" style="font-weight: 500;"><span>객실</span></h3>
					<div class="c_flex" style="justify-content: space-between; height: 3rem; align-items:center;">
						<div class="c_flex c_content_txt"><span style="margin:auto;">성인</span></div>
						<div class="c_flex">
							<button class="c_guest_cnt_btn c_guest_cnt_down">
								<span class="c_flex">
									<svg class="c_icon_18" style="margin:auto;" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><title id="room-1-0-adults-decrease-title">객실 1의 성인 수 줄이기</title><path d="M19 13H5v-2h14v2z"></path></svg>
								</span>
							</button>
							<c:if test="${not empty requestScope.adult_cnt}">
								<input name="adult_cnt" value="${requestScope.adult_cnt}" min="1" max="10" style="width: 3rem; text-align: center;" readonly>
							</c:if>
							<c:if test="${empty requestScope.adult_cnt}">
								<input name="adult_cnt" value="1" min="1" max="10" style="width: 3rem; text-align: center;" readonly>
							</c:if>
							<button class="c_guest_cnt_btn c_guest_cnt_up">
								<span class="c_flex">
									<svg class="c_icon_18" style="margin:auto;" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><title id="room-1-0-adults-increase-title">객실 1의 성인 수 늘리기</title><path d="M19 13h-6v6h-2v-6H5v-2h6V5h2v6h6v2z"></path></svg>
								</span>
							</button>
						</div>
					</div>
					<div class="c_flex c_border_btm c_pd_b_15r" style="justify-content: space-between; height: 3rem; align-items:center;">
						<div>
							<div class="c_flex c_content_txt"><span style="margin:auto 0">아동</span></div>
							<div class="c_flex c_txt_sm"><span style="margin:auto 0;">만 0~17세</span></div>
						</div>
						<div class="c_flex">
							<button class="c_guest_cnt_btn c_guest_cnt_down">
								<span class="c_flex">
									<svg class="c_icon_18" style="margin:auto;" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><title id="room-1-0-adults-decrease-title">객실 1의 성인 수 줄이기</title><path d="M19 13H5v-2h14v2z"></path></svg>
								</span>
							</button>
							<c:if test="${not empty requestScope.child_cnt}">
								<input name="child_cnt" value="${requestScope.child_cnt}" min="0" max="10" style="width: 3rem; text-align: center;" readonly>
							</c:if>
							<c:if test="${empty requestScope.child_cnt}">
								<input name="child_cnt" value="0" min="0" max="10" style="width: 3rem; text-align: center;" readonly>
							</c:if>
							<button class="c_guest_cnt_btn c_guest_cnt_up">
								<span class="c_flex">
									<svg class="c_icon_18" style="margin:auto;" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><title id="room-1-0-adults-increase-title">객실 1의 성인 수 늘리기</title><path d="M19 13h-6v6h-2v-6H5v-2h6V5h2v6h6v2z"></path></svg>
								</span>
							</button>
						</div>
					</div>
					<div class="c_flex" style="justify-content: space-between; height: 3rem; align-items:center;">
						<div class="c_flex c_content_txt"><span style="margin:auto;">객실 수</span></div>
						<div class="c_flex">
							<button class="c_guest_cnt_btn c_guest_cnt_down">
								<span class="c_flex">
									<svg class="c_icon_18" style="margin:auto;" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><title id="room-1-0-adults-decrease-title">객실 1의 성인 수 줄이기</title><path d="M19 13H5v-2h14v2z"></path></svg>
								</span>
							</button>
							<c:if test="${not empty requestScope.room_cnt}">
								<input name="need_rm_cnt" value="${requestScope.room_cnt}" min="1" max="10" style="width: 3rem; text-align: center;" readonly>
							</c:if>
							<c:if test="${empty requestScope.room_cnt}">
								<input name="need_rm_cnt" value="1" min="1" max="10" style="width: 3rem; text-align: center;" readonly>
							</c:if>							
							<button class="c_guest_cnt_btn c_guest_cnt_up">
								<span class="c_flex">
									<svg class="c_icon_18" style="margin:auto;" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><title id="room-1-0-adults-increase-title">객실 1의 성인 수 늘리기</title><path d="M19 13h-6v6h-2v-6H5v-2h6V5h2v6h6v2z"></path></svg>
								</span>
							</button>
						</div>
					</div>
					<div class="" style="padding-top: 1.5rem;">
						<div class="c_flex">
							<button type="button" class="c_btn_pri" style="width: 100%; height: 2.4rem; margin: auto 0;" onclick="addGuestCnt()">완료</button>
						</div>
					</div>
				</div>		
			</div>
		</div>
<c:if test="${not empty requestScope.d_map.startDate}">
	<div class="" id="result_room_container" style="padding-bottom: 1.5rem;">
		<div class="c_grid c_grid_c3" style="gap: 1.5rem;">
		<c:if test="${not empty requestScope.avbl_rm_list}">	
			<c:forEach items="${requestScope.avbl_rm_list}" var="rm_list" varStatus="status">
				<div id="rm_item${status.index}" class="c_it_container_w c_grid" style="border: solid 1px #dfe0e4">
						<div class="img_part" rm_seq='${rm_list.rm_seq}'>
						</div>
						<div class="c_flex" style="flex-direction: column; justify-content: space-between;">
							<div id="short_info_part" style="padding: 0.75rem 0.75rem;">
								<div><h3 class="c_h3_head6">${rm_list.rm_type}</h3></div>
								<div style="padding-top: 0.5rem;">
									<ul class="c_grid" style="gap:0.5rem;">
										<li class="c_flex">
											<div class="c_flex" style="margin: auto 0; padding-right: 0.5rem;">
												<svg class="c_icon_18" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path d="M6 18h2l-3 3-3-3h2V6c0-1.1.9-2 2-2h12V2l3 3-3 3V6H6v12zm14-8v2h-2v-2h2zm0 8a2 2 0 0 1-2 2v-2h2zm0-4v2h-2v-2h2zm-4 4v2h-2v-2h2zm-4 0v2h-2v-2h2z"></path></svg>
											</div>
											<span class="c_content_txt">${rm_list.rm_size_meter}㎡</span>
										</li>
										<c:if test="${rm_list.rm_breakfast_yn eq 1}">
											<li class="c_flex">
												<div class="c_flex" style="margin: auto 0; padding-right: 0.5rem;">
													<svg class="c_icon_18" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill-rule="evenodd" d="M20 3H4v10a4 4 0 0 0 4 4h6a4 4 0 0 0 4-4v-3h2a2 2 0 0 0 2-2V5a2 2 0 0 0-2-2zm0 5h-2V5h2v3zm0 11H4v2h16v-2z" clip-rule="evenodd"></path></svg>
												</div>
												<span class="c_content_txt">무료 아침 식사</span>
											</li>
										</c:if>
										<c:set var="inet_opt" value="${requestScope.inet_opt_list}" />
										<c:if test="${fn:contains(inet_opt, 'wifi')}">
											<li class="c_flex">
												<div class="c_flex" style="margin: auto 0; padding-right: 0.5rem;">
													<svg class="c_icon_18" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill-rule="evenodd" d="m1 9 2 2a12.73 12.73 0 0 1 18 0l2-2A15.57 15.57 0 0 0 1 9zm8 8 3 3 3-3a4.24 4.24 0 0 0-6 0zm-2-2-2-2a9.91 9.91 0 0 1 14 0l-2 2a7.07 7.07 0 0 0-10 0z" clip-rule="evenodd"></path></svg>
												</div>
												<span class="c_content_txt">무료 WiFi</span>
											</li>
										</c:if>
										<c:if test="${rm_list.rm_single_bed>0 or rm_list.rm_ss_bed>0 or rm_list.rm_double_bed>0 or rm_list.rm_queen_bed>0 or rm_list.rm_king_bed>0}">
											<li class="c_flex">
												<div class="c_flex" style="margin: auto 0; padding-right: 0.5rem;">
													<svg class="c_icon_18" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill-rule="evenodd" d="M11 7h8a4 4 0 0 1 4 4v9h-2v-3H3v3H1V5h2v9h8V7zm-1 3a3 3 0 1 1-6 0 3 3 0 0 1 6 0z" clip-rule="evenodd"></path></svg>
												</div>
												<span class="c_content_txt">									
													<c:if test="${rm_list.rm_single_bed>0}">
														싱글 침대 ${rm_list.rm_single_bed}개&nbsp;
													</c:if>
													<c:if test="${rm_list.rm_ss_bed>0}">
														슈퍼싱글 침대 ${rm_list.rm_ss_bed}개&nbsp;&nbsp;
													</c:if>
													<c:if test="${rm_list.rm_double_bed>0}">
														더블 침대 ${rm_list.rm_double_bed}개&nbsp;&nbsp;
													</c:if>
													<c:if test="${rm_list.rm_queen_bed>0}">
														퀸사이즈 침대 ${rm_list.rm_queen_bed}개&nbsp;&nbsp;
													</c:if>
													<c:if test="${rm_list.rm_king_bed>0}">
														킹사이즈 침대 ${rm_list.rm_king_bed}개&nbsp;&nbsp;
													</c:if>
												</span>
											</li>
										</c:if>
										<c:if test="${rm_list.fk_view_no ne 0}">			
											<li class="c_flex">
												<c:if test="${rm_list.fk_view_no eq 1 or rm_list.fk_view_no eq 3 or rm_list.fk_view_no eq 6}">
													<div class="c_flex rm_view_svg" style="margin: auto 0; padding-right: 0.5rem;"><svg class="c_icon_18" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path d="M21.98 14H22h-.02ZM5.35 13c1.19 0 1.42 1 3.33 1 1.95 0 2.09-1 3.33-1 1.19 0 1.42 1 3.33 1 1.95 0 2.09-1 3.33-1 1.19 0 1.4.98 3.31 1v-2c-1.19 0-1.42-1-3.33-1-1.95 0-2.09 1-3.33 1-1.19 0-1.42-1-3.33-1-1.95 0-2.09 1-3.33 1-1.19 0-1.42-1-3.33-1-1.95 0-2.09 1-3.33 1v2c1.9 0 2.17-1 3.35-1Zm13.32 2c-1.95 0-2.09 1-3.33 1-1.19 0-1.42-1-3.33-1-1.95 0-2.1 1-3.34 1-1.24 0-1.38-1-3.33-1-1.95 0-2.1 1-3.34 1v2c1.95 0 2.11-1 3.34-1 1.24 0 1.38 1 3.33 1 1.95 0 2.1-1 3.34-1 1.19 0 1.42 1 3.33 1 1.94 0 2.09-1 3.33-1 1.19 0 1.42 1 3.33 1v-2c-1.24 0-1.38-1-3.33-1ZM5.35 9c1.19 0 1.42 1 3.33 1 1.95 0 2.09-1 3.33-1 1.19 0 1.42 1 3.33 1 1.95 0 2.09-1 3.33-1 1.19 0 1.4.98 3.31 1V8c-1.19 0-1.42-1-3.33-1-1.95 0-2.09 1-3.33 1-1.19 0-1.42-1-3.33-1-1.95 0-2.09 1-3.33 1-1.19 0-1.42-1-3.33-1C3.38 7 3.24 8 2 8v2c1.9 0 2.17-1 3.35-1Z"></path></svg></div>
												</c:if>
												<c:if test="${rm_list.fk_view_no eq 2}">
													<div class="c_flex rm_view_svg" style="margin: auto 0; padding-right: 0.5rem;"><svg class="c_icon_18" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path d="m14 6-3.75 5 2.85 3.8-1.6 1.2L7 10l-6 8h22L14 6z"></path></svg></div>
												</c:if>
												<c:if test="${rm_list.fk_view_no eq 4}">
													<div class="c_flex rm_view_svg" style="margin: auto 0; padding-right: 0.5rem;"><svg class="c_icon_18" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill-rule="evenodd" d="M15 5v6h6v10H3V7h6V5l3-3 3 3zM5 19h2v-2H5v2zm2-4H5v-2h2v2zm-2-4h2V9H5v2zm6 8v-2h2v2h-2zm0-6v2h2v-2h-2zm0-2V9h2v2h-2zm0-6v2h2V5h-2zm8 14h-2v-2h2v2zm-2-4h2v-2h-2v2z" clip-rule="evenodd"></path></svg></div>
												</c:if>
												<c:if test="${rm_list.fk_view_no eq 5}">
													<div class="c_flex rm_view_svg" style="margin: auto 0; padding-right: 0.5rem;"><svg class="c_icon_18" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path d="M13 15.93a7 7 0 1 0-2 0V20H5v2h14v-2h-6v-4.07z"></path></svg></div>
												</c:if>
												<span class="c_content_txt rm_view_desc">${rm_list.view_desc}</span>
											</li>
										</c:if>				
										<li class="c_flex">
											<div class="c_flex" style="margin: auto 0; padding-right: 0.5rem;">
												<svg class="c_icon_18" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill-rule="evenodd" d="M10.99 8A3 3 0 1 1 5 8a3 3 0 0 1 6 0zm8 0A3 3 0 1 1 13 8a3 3 0 0 1 6 0zM8 13c-2.33 0-7 1.17-7 3.5V19h14v-2.5c0-2.33-4.67-3.5-7-3.5zm7.03.05c.35-.03.68-.05.97-.05 2.33 0 7 1.17 7 3.5V19h-6v-2.5c0-1.48-.81-2.61-1.97-3.45z" clip-rule="evenodd"></path></svg>
											</div>
											<span class="c_content_txt">${rm_list.rm_guest_cnt}명</span>
										<li class="c_flex">
											<div class="c_flex" style="margin: auto 0; padding-right: 0.5rem;">
												<svg class="c_icon_18" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path d="M9 16.17 4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41L9 16.17z"></path></svg>
											</div>
											<span class="c_content_txt">지금 예약하고 현장 결제</span>
										</li>							
									</ul>
									</div>
								<div class="c_flex" style="padding-top: 0.4rem; color: #227950;">
									<span class="c_content_txt">일부 환불 가능</span>
									<div class="c_flex" style="margin: auto 0; padding-left: 0.5rem;">
										<svg class="c_icon_18" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill="#227950" fill-rule="evenodd" d="M2 12a10 10 0 1 1 20 0 10 10 0 0 1-20 0zm11-1v6h-2v-6h2zm-1 9a8.01 8.01 0 0 1 0-16 8.01 8.01 0 0 1 0 16zm1-13v2h-2V7h2z" clip-rule="evenodd"></path></svg>
									</div>
								</div>
								<div id="view_rm_detail_btn" class="c_text_link_m c_flex" lodge_id="${rm_list.fk_lodge_id}" rm_seq="${rm_list.rm_seq}" onclick="javascript:show_rm_detail(this)" style="padding-top: 0.75rem;" >
									<span>자세히 보기</span>
									<svg class="c_icon_18" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill="#1668e3" d="M10 6 8.59 7.41 13.17 12l-4.58 4.59L10 18l6-6-6-6z"></path></svg>
								</div>
							</div>
							<c:set var="price" value="${rm_list.rm_price}"/>
							<c:set var="d_rate" value="${requestScope.d_rate}"/>
							<c:set var="stay_night" value="${requestScope.stayNight}"/>
							
							<div id="price_part" style="padding: 0.75rem 0.75rem;">
								<div class="c_flex" style="justify-content: space-between;">
									<div class="c_gird">
										<c:if test="${d_rate>0}">
											<span class="uitk-badge uitk-badge-large uitk-badge-deal-member uitk-badge-has-text uitk-spacing uitk-spacing-margin-blockend-one">
												<svg class="uitk-icon uitk-icon-small" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill-rule="evenodd" d="m17.1 16.05 1.22-1.18 3.48-3.48a.78.78 0 0 0 .2-.6l-1.3-7.1a.57.57 0 0 0-.42-.42l-7.06-1.26a.78.78 0 0 0-.61.19L2.1 12.7a.36.36 0 0 0 0 .51l8.68 8.69c.14.13.37.14.5 0l4.24-4.23a2.88 2.88 0 0 0 4.9-2.26v-.1c0-.28-.03-1.02-.26-1.5L19 14.9a1.54 1.54 0 1 1-3 .62c-.03-.5.19-2.34.5-4.07a26.11 26.11 0 0 1 .56-2.48l.02.04a1.62 1.62 0 1 0-1.42-.12c-.13.57-.26 1.26-.41 2.1a29.62 29.62 0 0 0-.57 4.88l-.83.83-6.56-6.55 6.04-6.04c.07-.08.2-.12.3-.1l5.2.94c.09.01.18.1.2.2l.98 5.18c.02.1-.03.23-.1.3l-3.1 3.1c-.2.75-.43 2.05.3 2.31zm-6.24 3.4-6.29-6.32a.18.18 0 0 1 0-.25l1.72-1.72 6.56 6.56-1.74 1.73a.18.18 0 0 1-.25 0z" clip-rule="evenodd"></path></svg>
												<span class="uitk-badge-text" aria-hidden="false"> 회원가 <fmt:formatNumber value="${d_rate*100}" pattern="###,###" />% 할인</span>
											</span>
										</c:if>
										<div class="c_flex" style="gap: 0.3rem; align-items: center;">																				
											<div class="c_h3_head5">₩<fmt:formatNumber value="${price*(1-d_rate)}" pattern="###,###" /></div>											
											<c:if test="${d_rate ne '0'}">
												<div class="c_content_txt" style="text-decoration: underline line-through;">₩<fmt:formatNumber value="${price}" pattern="###,###" /></div>
											</c:if>									
										</div>
										<div>
											<div class="c_txt_sm">총 요금: <span>₩<fmt:formatNumber value="${price*(1-d_rate)*stay_night*1.1}" pattern="###,###" /></span></div>
										</div>
										<div class="c_txt_sm">세금 및 수수료 포함</div>
										<div id="view_price_detail_btn1" class="price_detail c_text_link_m c_flex" style="padding-top: 0.75rem;" onclick="javascript:goPriceDetail('${rm_list.rm_price}','${rm_list.rm_seq}')">
											<span>요금 세부 정보</span>
											<svg class="c_icon_18" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill="#1668e3" d="M10 6 8.59 7.41 13.17 12l-4.58 4.59L10 18l6-6-6-6z"></path></svg>
										</div>
									</div>
									<div class="room_rsv_btn" style="margin-top: auto;">
										<div class="c_flex">
											<button class="c_btn_pri" style="width: 7rem; height: 2.4rem; margin: auto 0;" onclick="go_reservation('${price*(1-d_rate)}','${rm_list.rm_seq}')">예약하기</button>
										</div>
									</div>
								</div>
							</div>
						</div>	
					</div>
				</c:forEach>
			</c:if>
		</div>
	</div>
		
	<div id="view_rm_detail"></div>
	
	<div id="view_price_detail" class="c_modalContainer_sm" style="overflow-y: hidden;"></div>
	
	<div id="view_pay_method" class="c_modalContainer_sm" style="overflow-y: hidden;">
		<div class="c_modalWrap_sm" style="overflow-y: hidden;">
			<div class="c_flex modalTop_close" style="block-size: 3rem; height:auto; align-items: center;">
				<button type="button" id="m_close_btn_pm" class="c_flex modal_close_btn" style="block-size: 3rem; inline-size: 3rem;">
					<span class="c_round_btn_blue c_flex" style="block-size: 2.3rem; inline-size: 2.3rem; margin: auto;">
						<svg class="c_icon_24" style="margin: auto;" aria-label="닫기" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <title id="undefined-close-toolbar-title">닫기.</title><path fill="#1668e3" d="M19 6.41 17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12 19 6.41z"></path></svg>
					</span>
				</button>
				결제 옵션 선택
			</div>
			<div id="pay_method_wrap" class="c_grid" style="padding: 0.875rem; gap: 1.5rem; overflow-y: auto;">
				<div class="c_grid" style="grid-template-columns:1fr 1fr; gap: 1rem;">
					<div class="c_border_all c_flex" style="flex-direction:column; justify-content:space-between; padding: 0.875rem; gap:0.5rem;">
						<div class="c_grid" style="gap: 0.875rem;">						
							<div class="c_h3_head6">지금 결제</div>
							<ul class="c_content_txt c_flex" style="flex-direction:column; gap: 0.5rem;">
								<li class="c_li_dot">고객님이 사용하시는 통화로 결제가 처리됩니다.</li>
								<li class="c_li_dot">직불카드 또는 신용카드로 결제하실 수 있습니다.</li>
							</ul>
						</div>	
						<div class="c_grid" style="gap: 0.875rem;">
							<div class="c_flex" style="justify-content: end;">
								<div class="c_flex" style="flex-direction: column; justify-content: end; gap:0.1rem;">
									<div class="c_flex" style="gap: 0.3rem; justify-content: end; ">								
										<div class="c_h3_head5 pay_method_price"></div>																	
									</div>
									<div>
										<div class="c_txt_sm" style="text-align: end;">총 요금: <span class="pay_method_ttl_price"></span></div>
									</div>
									<div class="c_txt_sm" style="text-align: end;">세금 및 수수료 포함</div>								
								</div>											
							</div>
							<div id="go_pay_now_btn" class="c_flex">
								<button class="c_btn_pri" style="width: 100%; height: 2.4rem; margin: auto 0;" onclick="go_pay_now()">지금 결제</button>
							</div>							
						</div>	
					</div>
					<div class="c_border_all c_flex" style="flex-direction:column; justify-content:space-between; padding: 0.875rem; gap:0.5rem;">
						<div class="c_grid" style="gap: 0.875rem;">						
							<div class="c_h3_head6">숙박 시 결제</div>
							<ul class="c_content_txt c_flex" style="flex-direction:column; gap: 0.5rem;">
								<li class="c_li_dot">숙박하실 때까지 결제 금액이 청구되지 않습니다.</li>
								<li class="c_li_dot">선호하시는 통화(KRW)로 숙박 시설에 직접 결제합니다.</li>
							</ul>
						</div>	
						<div class="c_grid" style="gap: 0.875rem;">
							<div class="c_flex" style="justify-content: end;">
								<div class="c_flex" style="flex-direction: column; justify-content: end; gap:0.1rem;">
									<div class="c_flex" style="gap: 0.3rem; justify-content: end; ">								
										<div class="c_h3_head5 pay_method_price"></div>																	
									</div>
									<div>
										<div class="c_txt_sm" style="text-align: end;">총 요금: <span class="pay_method_ttl_price"></span></div>
									</div>
									<div class="c_txt_sm" style="text-align: end;">세금 및 수수료 포함</div>								
								</div>											
							</div>
							<div id="go_pay_later_btn" class="c_flex">
								<button class="c_btn_pri" style="width: 100%; height: 2.4rem; margin: auto 0;" onclick="go_pay_later()">현장 결제</button>
							</div>							
						</div>	
					</div>		
				</div>				
			</div>
		</div>
	</div>
</c:if>	
	<c:if test="${empty requestScope.d_map.startDate}">		
			<div class="c_border_r1 c_pd_all_75" style="background-color: white; padding-bottom: 0.75rem; margin-bottom: 5rem;">
				<span style="color:#a7183c; font-size:0.875rem; line-height:1.125rem;">객실을 조회하고자 하는 날짜를 선택해주세요.</span>
			</div>
		</c:if>
		<c:if test="${empty requestScope.avbl_rm_list}">		
			<div class="c_border_r1 c_pd_all_75" style="background-color: white; padding-bottom: 0.75rem; margin-bottom: 5rem;">
				<span style="color:#a7183c; font-size:0.875rem; line-height:1.125rem;">익스피디아에 선택하신 날짜와 조건에 맞는 예약 가능한 객실이 없습니다. 다른 날짜 혹은 조건을 입력해 예약 가능 여부를 확인해 보세요.</span>
			</div>
		</c:if>
	
	<div id="rcmd_lodge_container"></div>
<%-- 지역 정보 삭제
	<div class="c_container_w" id="local_info_container">
		<div id="local_info" class="c_grid_c3" style="gap: 1.5rem;">
			<div id="local_info_txt" class="c_grid_c3_it1">
				<h2 class="c_h2_head4" style="padding:0 0 1.5rem 0;">이 지역에 대한 정보</h2>
				<h3 class="c_h3_head5">강릉</h3>
				<div class="c_content_txt" style="padding:0.75rem 0;">
					강릉에 있는 ${requestScope.lodgeinfo.LG_NAME}의 경우 해변 근처에 위치해 있습니다. 액티비티에 관심이 많으시다면 주문진항, 남애항에 가보세요. 용화산 자연휴양림, 대관령 양떼목장도 인기 명소로 유명합니다. 각종 이벤트나 게임이 개최되는 강릉 아이스 아레나, 강릉 올림픽 파크도 놓치지 마세요.
				</div>
				<div id="">
					<a href="#">
						강릉 여행 가이드 보기
						<svg class="c_icon_18" aria-label="새 창에서 열림" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <title id="open_in_new-0-title">새 창에서 열림</title><path fill-rule="evenodd" d="M5 5v14h14v-7h2v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h7v2H5zm9 0V3h7v7h-2V6.41l-9.83 9.83-1.41-1.41L17.59 5H14z" clip-rule="evenodd"></path></svg>
					</a>
				</div>
			</div>	
			<div class="c_grid_c3_it23">
				<div class=" uitk-card uitk-card-roundcorner-all uitk-card-has-border uitk-card-has-link uitk-spacing uitk-spacing-margin-blockend-six uitk-card-has-primary-theme">
					<div class="uitk-card-content-section">
						<div class="LazyLoad is-visible" style="height: 200px;">
							<h3 class="is-visually-hidden">지도</h3>
							<figure class="uitk-image uitk-image-fit-cover uitk-image-ratio-21-9 uitk-image-ratio">
								<div class="uitk-image-placeholder">
									<img alt="" class="uitk-image-media" src="https://maps.googleapis.com/maps/api/staticmap?&amp;size=660x330&amp;map_id=3b266eb50d2997c6&amp;zoom=13&amp;markers=icon:https%3A%2F%2Fa.travel-assets.com%2Fshopping-pwa%2Fimages%2Fhis-preview-marker.png%7C37.80392%2C128.90765&amp;channel=expedia-HotelInformation&amp;maptype=roadmap&amp;scale=1&amp;key=AIzaSyCYjQus5kCufOpSj932jFoR_AJiL9yiwOw&amp;signature=fR_vqdj5VcKQUAQOP1-JQ2nlQbM=">
								</div>
							</figure>
						</div>
					</div>
					<div class="uitk-card-content-section uitk-card-content-section-border-block-start uitk-card-content-section-has-link uitk-card-content-section-padded EGDS-type-300">
						<button type="button" class="uitk-link uitk-link-align-left uitk-link-layout-inline">지도로 보기</button>
						<button type="button" class="uitk-card-link">
							<span class="is-visually-hidden">지도로 보기</span>
						</button>
					</div>
					<section class="EGDS-button uitk-card-link">
						<span class="is-visually-hidden">지도</span>
					</section>
				</div>
			</div>
		</div>
	</div>
	 --%>	
	 
	<div id="lodge_desc_container" class="c_container_w" style="margin-top: 1.5rem;">
		<div id="lodge_desc" class="c_grid_c3 c_border_btm" style="padding-bottom: 2rem">
			<div id="lodge_desc_head" class="c_grid_c3_it1">
				<h2 class="c_h2_head4">이 숙박 시설에 대한 정보</h2>
			</div>
			<div class="c_grid_c3_it23">
				<div id="lodge_desc_cont_head">
					<h3 class="c_h3_head5">${requestScope.lodgeinfo.LG_NAME}</h3>
				</div>	
				<div id="lodge_desc_cont" class="c_grid" style="row-gap: 1rem;">
					<div id="preview_info" style="display: grid; row-gap: 1rem;">
						<div>
							<c:if test="${requestScope.lodgeinfo.FK_LODGE_TYPE eq 0}">
								<span class="c_content_txt">${requestScope.lodgeinfo.LG_HOTEL_STAR}성급 ${requestScope.lodgeinfo.LODGE_CONTENT}</span>
							</c:if>
							<c:if test="${requestScope.lodgeinfo.FK_LODGE_TYPE ne 0}">
								<span class="c_content_txt">${requestScope.lodgeinfo.LODGE_CONTENT}</span>
							</c:if>
						</div>
						<c:if test="${requestScope.lodgeinfo.LG_DINING_PLACE_YN eq 1 or requestScope.lodgeinfo.LG_BUSINESS_YN eq 1}">
							<div class="c_content_txt">${requestScope.lodgeinfo.LG_NAME}에서는
							<c:forEach var="din" items="${requestScope.din_opt_list}" varStatus="status">
								<c:if test="${not status.last}">
									${din.din_opt_desc},
								</c:if>
								<c:if test="${status.last and requestScope.lodgeinfo.LG_BUSINESS_YN eq 0}">
									${din.din_opt_desc}
								</c:if>
								<c:if test="${status.last and requestScope.lodgeinfo.LG_BUSINESS_YN eq 1}">
									${din.din_opt_desc},
								</c:if>
							</c:forEach>
							<c:forEach var="bsns" items="${requestScope.bsns_opt_list}" varStatus="status">
								<c:if test="${not status.last}">
									${bsns.bsns_opt_desc},
								</c:if>
								<c:if test="${status.last}">
									${bsns.bsns_opt_desc}
								</c:if>
							</c:forEach>
							 등을 이용하실 수 있습니다.
						</c:if>
						<c:if test="${(requestScope.lodgeinfo.LG_DINING_PLACE_YN ne 1 or requestScope.lodgeinfo.LG_BUSINESS_YN ne 1) and requestScope.lodgeinfo.LG_POOL_YN eq 1}">
							<div class="c_content_txt">${requestScope.lodgeinfo.LG_NAME}에서는
							<c:forEach var="pool" items="${requestScope.pool_opt_list}" varStatus="status">
								<c:if test="${not status.last}">
									${pool.pool_opt_desc},
								</c:if>
								<c:if test="${status.last and requestScope.lodgeinfo.LG_BUSINESS_YN eq 0}">
									${pool.pool_opt_desc}
								</c:if>
							</c:forEach>
							 등을 이용하실 수 있습니다.
						</c:if>
						<c:if test="${requestScope.lodgeinfo.LG_DINING_PLACE_YN ne 1 and requestScope.lodgeinfo.LG_BUSINESS_YN ne 1 and requestScope.lodgeinfo.LG_POOL_YN ne 1}">
							<div class="c_content_txt">${requestScope.lodgeinfo.LG_NAME}에서는 다양한 편의 시설을 이용하실 수 있습니다.
						</c:if>
						<c:if test="${requestScope.lodgeinfo.FK_SPA_TYPE ne 0}">
							 휴식 및 재충전을 위해 스파에서 시간을 보내보세요.
						</c:if>
						<c:if test="${fn:contains(din_opt_list, '레스토랑')}">
							 시설 내 레스토랑에서 식사를 즐겨보세요.
						</c:if>
						<c:if test="${not empty requestScope.inet_opt_list}">
							 모든 고객은 
							<c:forEach var="inet" items="${requestScope.inet_opt_list}" varStatus="status">
								<c:if test="${not status.last}">
									${inet.inet_opt_desc},
								</c:if>
								<c:if test="${status.last}">
									${inet.inet_opt_desc}
								</c:if>
							 </c:forEach>
							  등을 이용하실 수 있습니다.
						</c:if>
						</div>					
						<div class="c_content_txt">이 호텔에서는 다음과 같은 편의 시설 및 서비스를 함께 이용하실 수 있습니다.</div>
					</div>
					<div id="full_info" class="c_hide" style="row-gap: 1rem;">
						<div class="c_content_txt">
							<ul style="display: grid; grid-template-rows: repeat(5, auto); row-gap: 0.5rem;">
								<c:if test="${not empty requestScope.pool_opt_list}">
									<li class="c_li_dot"><span> 수영장 이용가능 -
									<c:forEach var="pool" items="${requestScope.pool_opt_list}" varStatus="status">
										<c:if test="${not status.last}">
											${pool.pool_opt_desc},
										</c:if>
										<c:if test="${status.last}">
											${pool.pool_opt_desc}
										</c:if>									
									</c:forEach>
									</span></li>							
								</c:if>
								<c:if test="${not empty requestScope.park_opt_list}">
									<li class="c_li_dot"><span> 주차 -
									<c:forEach var="park" items="${requestScope.park_opt_list}" varStatus="status">									
										<c:if test="${not status.last}">
											${park.park_opt_desc},
										</c:if>
										<c:if test="${status.last}">
											${park.park_opt_desc}
										</c:if>										
									</c:forEach>
									</span></li>							
								</c:if>
								<c:if test="${not empty requestScope.cs_opt_list}">
									<li class="c_li_dot"><span> 고객 서비스 제공 - 
									<c:forEach var="cs" items="${requestScope.cs_opt_list}" varStatus="status">									
										<c:if test="${not status.last}">
											${cs.cs_opt_desc},
										</c:if>
										<c:if test="${status.last}">
											${cs.cs_opt_desc}
										</c:if>										
									</c:forEach>
									</span></li>							
								</c:if>
								<c:if test="${not empty requestScope.fasvc_opt_list}">
									<li class="c_li_dot"><span> 가족 여행객 들을 위한 서비스 및 시설 - 
									<c:forEach var="fasvc" items="${requestScope.fasvc_opt_list}" varStatus="status">									
										<c:if test="${not status.last}">
											${fasvc.fasvc_opt_desc},
										</c:if>
										<c:if test="${status.last}">
											${fasvc.fasvc_opt_desc}
										</c:if>										
									</c:forEach>
									</span></li>							
								</c:if>
								
							</ul>
						</div>
						<div class="c_content_txt">객실 특징</div>
						<c:if test="${not empty requestScope.com_tmp_opt_list and not empty requestScope.com_ent_opt_list}">
						<div class="c_content_txt">모든 <fmt:formatNumber pattern="###,###" >${requestScope.lodgeinfo.TTL_RM_CNT}</fmt:formatNumber>개 객실에는 
							<c:if test="${not empty requestScope.com_tmp_opt_list and not empty requestScope.com_ent_opt_list}">
								쾌적한 실내를 위한  
								<c:forEach var="tmp" items="${requestScope.com_tmp_opt_list}" varStatus="status">									
									<c:if test="${not status.last}">
										${tmp.tmp_opt_desc},
									</c:if>
									<c:if test="${status.last}">
										${tmp.tmp_opt_desc}
									</c:if>										
								</c:forEach>
								 외에도 특별한 숙박 경험을 위해 
								<c:forEach var="ent" items="${requestScope.com_ent_opt_list}" varStatus="status">									
									<c:if test="${not status.last}">
										${ent.ent_opt_desc},
									</c:if>
									<c:if test="${status.last}">
										${ent.ent_opt_desc}
									</c:if>										
								</c:forEach>
								 등이 제공됩니다
							</c:if>
							<c:if test="${not empty requestScope.com_tmp_opt_list and empty requestScope.com_ent_opt_list}">
								쾌적한 실내를 위한  
								<c:forEach var="tmp" items="${requestScope.com_tmp_opt_list}" varStatus="status">									
									<c:if test="${not status.last}">
										${tmp.tmp_opt_desc},
									</c:if>
									<c:if test="${status.last}">
										${tmp.tmp_opt_desc}
									</c:if>										
								</c:forEach>
								 이 제공됩니다.
							</c:if>
							<c:if test="${empty requestScope.com_tmp_opt_list and not empty requestScope.com_ent_opt_list}">
								특별한 숙박 경험을 위해 
								<c:forEach var="ent" items="${requestScope.com_ent_opt_list}" varStatus="status">									
									<c:if test="${not status.last}">
										${ent.ent_opt_desc},
									</c:if>
									<c:if test="${status.last}">
										${ent.ent_opt_desc}
									</c:if>										
								</c:forEach>
								 등이 제공됩니다.
							</c:if>
						</div>
						</c:if>
						<c:if test="${empty requestScope.com_tmp_opt_list and empty requestScope.com_ent_opt_list}">					
							<div class="c_content_txt">모든 <fmt:formatNumber pattern="###,###" >${requestScope.lodgeinfo.TTL_RM_CNT}</fmt:formatNumber>개 객실에는 다양한 편의 시설 등을 이용할 수 있습니다.</div>
						</c:if>
						<div class="c_content_txt">이 밖에 다음과 같은 편의 시설 및 서비스를 이용하실 수 있습니다.</div>
						<div class="c_content_txt">
							<ul style="display: grid; grid-template-rows: repeat(3, auto); row-gap: 0.5rem;">
								
								<c:if test="${not empty requestScope.com_bath_opt_list}">
									<li class="c_li_dot"><span>욕실 용품 혹은 시설 - 
									<c:forEach var="bath" items="${requestScope.com_bath_opt_list}" varStatus="status">									
										<c:if test="${not status.last}">
											${bath.bath_opt_desc},
										</c:if>
										<c:if test="${status.last}">
											${bath.bath_opt_desc}
										</c:if>										
									</c:forEach>
									</span></li>							
								</c:if>
								<c:if test="${not empty requestScope.com_snk_opt_list}">
									<li class="c_li_dot"><span>객실 내 
									<c:forEach var="snk" items="${requestScope.com_snk_opt_list}" varStatus="status">									
										<c:if test="${not status.last}">
											${snk.snk_opt_desc},
										</c:if>
										<c:if test="${status.last}">
											${snk.snk_opt_desc}
										</c:if>										
									</c:forEach>
									 제공</span></li>							
								</c:if>
								<c:if test="${not empty requestScope.com_kt_opt_list}">
									<li class="c_li_dot"><span>객실 내 조리기구 - 
									<c:forEach var="kt" items="${requestScope.com_kt_opt_list}" varStatus="status">									
										<c:if test="${not status.last}">
											${kt.kt_opt_desc},
										</c:if>
										<c:if test="${status.last}">
											${kt.kt_opt_desc}
										</c:if>										
									</c:forEach>
									</span></li>							
								</c:if>
								<c:if test="${not empty requestScope.rmsvc_opt_list}">
									<li class="c_li_dot"><span>
									<c:forEach var="rmsvc" items="${requestScope.rmsvc_opt_list}" varStatus="status">									
										<c:if test="${not status.last}">
											${rmsvc.rmsvc_opt_desc},
										</c:if>
										<c:if test="${status.last}">
											${rmsvc.rmsvc_opt_desc}
										</c:if>										
									</c:forEach>
									이용 가능</span></li>							
								</c:if>
							</ul>
						</div>
					</div>
				</div>	
				<div id="showMore_cont" style="padding-top: 1rem;">
					<button id="showMore_info" type="button" class="c_text_link_m">더보기</button>
				</div>
			</div>
		</div>
		<div id="safe_info" class="c_grid_c3" style="padding: 2rem 0;">
			<div id="safe_info_head" class="c_grid_c3_it1">
				<h2 class="c_h2_head4">청소 및 안전 조치</h2>
			</div>			
			<div class="c_grid_c3_it23">
				<div class="c_grid" style="grid-template-rows: repeat(4, auto); gap: 1.5rem;">
					<div id="safe_info_it1">
						<div class="c_grid" style="grid-template-rows: repeat(4, auto); gap: 0.25rem;">
							<div class="c_flex" style="gap: 0.75rem;">
								<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <path d="M19.14 7.25 18 10l-1.14-2.86L14 6l2.86-1.14L18 2l1.14 2.86L22 6l-2.86 1.25zM11 10 9 4l-2 6-6 2 6 2 2 6 2-6 6-2-6-2zm4.5 10.5-1.5-1 1.5-1 1-1.5 1 1.5 1.5 1-1.5 1-1 1.5-1-1.5z"></path></svg>
								<div id="lodge_desc_cont_head">
									<h3 class="c_h3_head5">청결기준 강화</h3>
								</div>
							</div>
							<div>청소 시 소독제를 사용합니다.</div>
							<div>접촉이 많은 표면을 소독합니다.</div>
							<div>세스코(한국)의 청소 및 소독 지역 지침을 준수합니다.</div>
						</div>
					</div>
					<div id="safe_info_it2">
						<div class="c_grid" style="grid-template-rows: repeat(4, auto); gap: 0.25rem;">
							<div class="c_flex" style="gap: 0.75rem;">
								<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <path d="m10 22-.5-7H8V9c0-1.1.9-2 2-2h4a2 2 0 0 1 2 2v6h-1.5l-.5 7h-4Zm4-18a2 2 0 0 1-2 2 2 2 0 0 1-2-2c0-1.1.9-2 2-2a2 2 0 0 1 2 2Zm-8 7H4V9l-3 3 3 3v-2h2v-2Zm12 0h2V9l3 3-3 3v-2h-2v-2Z"></path></svg>
								<div id="lodge_desc_cont_head">
									<h3 class="c_h3_head5">사회적 거리두기</h3>
								</div>
							</div>
							<div>사회적 거리두기를 시행하고 있습니다.</div>
						</div>
					</div>
					<div id="safe_info_it3">
						<div class="c_grid" style="grid-template-rows: repeat(4, auto); gap: 0.25rem;">
							<div class="c_flex" style="gap: 0.75rem;">
								<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <path d="M9 16.17 4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41L9 16.17z"></path></svg>
								<div id="lodge_desc_cont_head">
									<h3 class="c_h3_head5">안전조치</h3>
								</div>
							</div>
							<div>직원들이 개인 보호 장비를 착용합니다.</div>
							<div>직원 체온 측정을 실시하고 있습니다.</div>
							<div>고객 체온 측정이 가능합니다.</div>
							<div>손 소독제를 제공합니다.</div>
						</div>
					</div>
					<div>이 정보는 파트너사에서 제공했습니다.</div>
				</div>
			</div>
		</div>
	</div>
	
	<div id="con_fac_container" class="c_container_w" style="margin-top: 1.5rem;">
		<div id="con_fac_desc1" class="c_grid_c_1_2 c_border_btm" style="padding-bottom: 2rem">
			<div id="con_fac_desc1_head" class="c_grid_c_it1">
				<h2 class="c_h2_head4">숙박 시설 내 편의 시설</h2>
			</div>
			<div id="con_fac_desc1_con1" class="c_grid_c2 c_grid_c_it2" style="gap:1.5rem;">			
				<c:if test="${requestScope.lodgeinfo.LG_BREAKFAST_YN eq 1 or not empty requestScope.din_opt_list}">
					<div id="con_fac1_it1">
						<div class="c_grid" style="gap: 0.75rem;">
							<div class="c_flex" style="gap: 0.75rem;">
								<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <path fill-rule="evenodd" d="M20.15 10.15c-1.59 1.59-3.74 2.09-5.27 1.38L13.41 13l6.88 6.88-1.41 1.41L12 14.41l-6.89 6.87-1.41-1.41 9.76-9.76c-.71-1.53-.21-3.68 1.38-5.27 1.92-1.91 4.66-2.27 6.12-.81 1.47 1.47 1.1 4.21-.81 6.12zm-9.22.36L8.1 13.34 3.91 9.16a4 4 0 0 1 0-5.66l7.02 7.01z" clip-rule="evenodd"></path></svg>
								<div class="con_fac_it_head">
									<h3 class="c_h3_head5">식사 및 음료</h3>
								</div>
							</div>
							<div class="c_content_txt c_grid" style="padding-left: 2.3rem; gap: 0.5rem;">
								<c:if test="${requestScope.lodgeinfo.LG_BREAKFAST_YN eq 1}">
									<div>아침 식사</div>
								</c:if>
								<c:if test="${not empty requestScope.din_opt_list}">
									<c:forEach var="din_opt" items="${requestScope.din_opt_list}">
										<div>시설 내 ${din_opt.din_opt_desc}</div>
									</c:forEach>
								</c:if>
							</div>
						</div>
					</div>
				</c:if>
				<c:if test="${not empty requestScope.inet_opt_list}">
					<div id="con_fac1_it2">
						<div class="c_grid" style="gap: 0.75rem;">
							<div class="c_flex" style="gap: 0.75rem;">
								<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <path fill-rule="evenodd" d="m1 9 2 2a12.73 12.73 0 0 1 18 0l2-2A15.57 15.57 0 0 0 1 9zm8 8 3 3 3-3a4.24 4.24 0 0 0-6 0zm-2-2-2-2a9.91 9.91 0 0 1 14 0l-2 2a7.07 7.07 0 0 0-10 0z" clip-rule="evenodd"></path></svg>
								<div class="con_fac_it_head">
									<h3 class="c_h3_head5">인터넷</h3>
								</div>
							</div>
							<div class="c_content_txt c_grid" style="padding-left: 2.3rem; gap: 0.5rem;">
								<c:forEach var="inet" items="${requestScope.inet_opt_list}">
									<div>${inet.inet_opt_desc}이용 가능</div>
								</c:forEach>	
							</div>
						</div>
					</div>
				</c:if>	
				<c:if test="${not empty requestScope.park_opt_list}">
					<div id="con_fac1_it3">
						<div class="c_grid" style="gap: 0.75rem;">
							<div class="c_flex" style="gap: 0.75rem;">
								<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <path fill-rule="evenodd" d="M6 3h7a6 6 0 0 1 0 12h-3v6H6V3zm4 8h3.2a2 2 0 0 0 2-2 2 2 0 0 0-2-2H10v4z" clip-rule="evenodd"></path></svg>
								<div class="con_fac_it_head">
									<h3 class="c_h3_head5">주차 및 교통편</h3>
								</div>
							</div>
							<div class="c_content_txt c_grid" style="padding-left: 2.3rem; gap: 0.75rem;">
								<c:forEach var="park" items="${requestScope.park_opt_list}">
									<c:if test="${park.fk_park_opt_no eq 0 or park.fk_park_opt_no eq 1}">
										<div>시설 내 ${park.park_opt_desc}주차 이용 가능</div>
									</c:if>
									<c:if test="${park.fk_park_opt_no eq 2 or park.fk_park_opt_no eq 3}">
										<div>${park.park_opt_desc}&nbsp;가능</div>		
									</c:if>	
								</c:forEach>							
							</div>
						</div>
					</div>
				</c:if>	
				<c:if test="${requestScope.lodgeinfo.FK_SPA_TYPE ne 0 or requestScope.lodgeinfo.LG_POOL_YN eq 1}">
					<div id="con_fac1_it4">
						<div class="c_grid" style="gap: 0.75rem;">
							<div class="c_flex" style="gap: 0.75rem;">
								<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <path d="M22 10.18V6H2v4.18c.9 0 1.66.75 1.66 1.66 0 .9-.76 1.66-1.66 1.66v4.18h20V13.5c-.9 0-1.66-.76-1.66-1.66 0-.9.76-1.66 1.66-1.66zm-4.16 4.57c0 .23-.2.43-.43.43H6.59a.43.43 0 0 1-.43-.43V8.93c0-.23.2-.43.43-.43h10.82c.23 0 .43.2.43.43v5.82zm-10-4.57h8.32v3.32H7.84v-3.32z"></path></svg>
								<div class="con_fac_it4_head">
									<h3 class="c_h3_head5">즐길거리</h3>
								</div>
							</div>
							<div class="c_content_txt c_grid" style="padding-left: 2.3rem; gap: 0.75rem;">
								<c:if test="${requestScope.lodgeinfo.FK_SPA_TYPE ne 0}">
								<div>${requestScope.lodgeinfo.spa_desc}</div>
							</c:if>
							<c:if test="${not empty requestScope.pool_opt_list}">
								<c:forEach var="pool" items="${requestScope.pool_opt_list}">
									<c:if test="${pool.fk_pool_opt_no eq 0}">
										<div>${pool.pool_opt_desc}&nbsp;수영장</div>
									</c:if>
									<c:if test="${pool.fk_pool_opt_no eq 1}">
										<div>야외&nbsp;수영장&nbsp;(상시 운영)</div>
									</c:if>
									<c:if test="${pool.fk_pool_opt_no eq 2}">
										<div>야외&nbsp;수영장&nbsp;(시즌 운영)</div>
									</c:if>
								</c:forEach>
							</c:if>								
							</div>
						</div>
					</div>
				</c:if>	
				<c:if test="${not empty requestScope.fasvc_opt_list}">
					<div id="con_fac1_it5">
						<div class="c_grid" style="gap: 0.75rem;">
							<div class="c_flex" style="gap: 0.75rem;">
								<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <path d="M16 22v-1c0-2-1.59-3-4-3-2.5 0-4 1-4 3v1H2v-8.98C2 11.07 5.67 10 7.5 10c1.23 0 3.28.48 4.5 1.39A8.67 8.67 0 0 1 16.5 10c1.83 0 5.5 1.07 5.5 3.02V22h-6zM7 8C5.37 8 4 6.63 4 5s1.37-3 3-3 3 1.37 3 3-1.37 3-3 3zm10 0c-1.63 0-3-1.37-3-3s1.37-3 3-3 3 1.37 3 3-1.37 3-3 3zm-5 9c1.09 0 2-.91 2-2 0-1.09-.91-2-2-2-1.09 0-2 .91-2 2 0 1.09.91 2 2 2z"></path></svg>
								<div class="con_fac_it5_head">
									<h3 class="c_h3_head5">가족여행 편의시설</h3>
								</div>
							</div>
							<div class="c_content_txt c_grid" style="padding-left: 2.3rem; gap: 0.75rem;">
								<c:forEach var="fasvc" items="${requestScope.fasvc_opt_list}">
									<div>${fasvc.fasvc_opt_desc}</div>
								</c:forEach>							
							</div>
						</div>
					</div>
				</c:if>	
			
				<c:if test="${not empty requestScope.fac_opt_list}">
					<div class="con_fac_it1">
						<div class="c_grid" style="grid-template-rows: repeat(4, auto); gap: 0.75rem;">
							<div class="c_flex" style="gap: 0.75rem;">
								<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <path fill-rule="evenodd" d="M19 7V4H5v3H2v13h8v-4h4v4h8V7h-3zM9 10v1h2v1H8V9h2V8H8V7h3v3H9zm6 2h1V7h-1v2h-1V7h-1v3h2v2z" clip-rule="evenodd"></path></svg>
								<div id="lodge_desc_cont_head">
									<h3 class="c_h3_head5">장애인 편의 시설</h3>
								</div>
							</div>
							<div class="c_content_txt c_grid" style="padding-left: 2.3rem; gap: 0.75rem;">
								<c:forEach var="fac" items="${requestScope.fac_opt_list}">
									<div>${fac.fac_opt_desc}</div>
								</c:forEach>								
							</div>
						</div>
					</div>
				</c:if>
				<c:if test="${not empty requestScope.cs_opt_list}">
					<div class="con_fac_it2">
						<div class="c_grid" style="grid-template-rows: repeat(4, auto); gap: 0.75rem;">
							<div class="c_flex" style="gap: 0.75rem;">
								<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <path fill-rule="evenodd" d="M14 7c0 .28-.06.55-.16.79A9.01 9.01 0 0 1 21 16H3a9.01 9.01 0 0 1 7.16-8.21A2 2 0 0 1 12 5a2 2 0 0 1 2 2zm8 12v-2H2v2h20z" clip-rule="evenodd"></path></svg>
								<div id="lodge_desc_cont_head">
									<h3 class="c_h3_head5">고객 서비스</h3>
								</div>
							</div>
							<div class="c_content_txt c_grid" style="padding-left: 2.3rem; gap: 0.75rem;">
								<c:forEach var="cs" items="${requestScope.cs_opt_list}">
									<div>${cs.cs_opt_desc}</div>
								</c:forEach>							
							</div>
						</div>
					</div>
				</c:if>
				<c:if test="${not empty requestScope.bsns_opt_list}">	
					<div id="safe_info_it3">
						<div class="c_grid" style="grid-template-rows: repeat(4, auto); gap: 0.75rem;">
							<div class="c_flex" style="gap: 0.75rem;">
								<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <path fill-rule="evenodd" d="M20 7h-4.01V5l-2-2h-4l-2 2v2H4a2 2 0 0 0-2 2v3a2 2 0 0 0 2 2h6v-2h4v2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2zm-10 9v-1H3.01L3 19a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-4h-7v1h-4zm0-9h4V5h-4v2z" clip-rule="evenodd"></path></svg>
								<div id="lodge_desc_cont_head">
									<h3 class="c_h3_head5">비즈니스 편의 시설</h3>
								</div>
							</div>
							<div class="c_content_txt c_grid" style="padding-left: 2.3rem; gap: 0.75rem;">
								<c:forEach var="bsns" items="${requestScope.bsns_opt_list}">
									<div>${bsns.bsns_opt_desc}</div>
								</c:forEach>							
							</div>
						</div>
					</div>
				</c:if>	
				<c:if test="${requestScope.lodgeinfo.LG_PET_YN eq 1 or requestScope.lodgeinfo.LG_SMOKE_YN eq 0}">
					<div id="safe_info_it4">
						<div class="c_grid" style="grid-template-rows: repeat(4, auto); gap: 0.75rem;">
							<div class="c_flex" style="gap: 0.75rem;">
								<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <path d="M9 16.17 4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41L9 16.17z"></path></svg>
								<div id="lodge_desc_cont_head">
									<h3 class="c_h3_head5">기타</h3>
								</div>
							</div>
							<div class="c_content_txt c_grid" style="padding-left: 2.3rem; gap: 0.75rem;">
								<c:if test="${requestScope.lodgeinfo.LG_PET_YN eq 1}">
									<div>반려동물 동반 가능 숙박 시설</div>
								</c:if>
								<c:if test="${requestScope.lodgeinfo.LG_SMOKE_YN eq 0}">
									<div>금연 숙박 시설</div>
								</c:if>							
							</div>
						</div>
					</div>
				</c:if>	
			</div>
		</div>
		
		<div id="con_fac_desc2" class="c_grid_c_1_2" style="padding: 2rem 0;">
			<div id="con_fac_desc2_head" class="c_grid_c_it1">
				<h2 class="c_h2_head4">객실 편의 시설</h2>
			</div>
			<div class="c_grid_c2 c_grid_c_it2" style="gap: 1.5rem;">
				<div id="con_fac_it1">
					<div class="c_grid" style="gap: 0.75rem;">
						<div class="c_flex" style="gap: 0.75rem;">
							<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill-rule="evenodd" d="M11 7h8a4 4 0 0 1 4 4v9h-2v-3H3v3H1V5h2v9h8V7zm-1 3a3 3 0 1 1-6 0 3 3 0 0 1 6 0z" clip-rule="evenodd"></path></svg>
							<div class="con_fac_it_head">
								<h3 class="c_h3_head5">침실</h3>
							</div>
						</div>
						<div class="c_content_txt c_grid" style="padding-left: 2.3rem; gap: 0.5rem;">
							<div>에어컨</div>
							<div>침대 시트</div>
							<div>난방</div>
						</div>
					</div>
				</div>
				<c:if test="${not empty requestScope.com_bath_opt_list}">
					<div id="con_fac_it2">
						<div class="c_grid" style="gap: 0.75rem;">
							<div class="c_flex" style="gap: 0.75rem;">
								<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill-rule="evenodd" d="M20 13V4.83C20 3.27 18.73 2 17.17 2c-.75 0-1.47.3-2 .83l-1.25 1.25c-.16-.05-.33-.08-.51-.08-.4 0-.77.12-1.08.32l2.76 2.76c.2-.31.32-.68.32-1.08 0-.18-.03-.34-.07-.51l1.25-1.25a.828.828 0 0 1 1.41.59V13H2v6c0 1.1.9 2 2 2 0 .55.45 1 1 1h14c.55 0 1-.45 1-1 1.1 0 2-.9 2-2v-6h-2ZM4 19h16v-4H4v4Z" clip-rule="evenodd"></path></svg>
								<div class="con_fac_it_head">
									<h3 class="c_h3_head5">욕실</h3>
								</div>
							</div>
							<div class="c_content_txt c_grid" style="padding-left: 2.3rem; gap: 0.5rem;">
								<c:forEach var="c_bath" items="${requestScope.com_bath_opt_list}">
									<div>${c_bath.bath_opt_desc}</div>
								</c:forEach>												
							</div>
						</div>
					</div>
				</c:if>
				<c:if test="${not empty requestScope.com_ent_opt_list}">
					<div id="con_fac_it3">
						<div class="c_grid" style="gap: 0.75rem;">
							<div class="c_flex" style="gap: 0.75rem;">
								<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path d="M9 16.17 4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41L9 16.17z"></path></svg>
								<div class="con_fac_it_head">
									<h3 class="c_h3_head5">엔터테인먼트</h3>
								</div>
							</div>
							<div class="c_content_txt c_grid" style="padding-left: 2.3rem; gap: 0.75rem;">
								<c:forEach var="c_ent" items="${requestScope.com_ent_opt_list}">
									<div>${c_ent.ent_opt_desc}</div>
								</c:forEach>											
							</div>
						</div>
					</div>
				</c:if>
				<c:if test="${not empty requestScope.com_snk_opt_list}">	
					<div id="con_fac2_it1">
						<div class="c_grid" style="grid-template-rows: repeat(4, auto); gap: 0.75rem;">
							<div class="c_flex" style="gap: 0.75rem;">
								<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill-rule="evenodd" d="M20.15 10.15c-1.59 1.59-3.74 2.09-5.27 1.38L13.41 13l6.88 6.88-1.41 1.41L12 14.41l-6.89 6.87-1.41-1.41 9.76-9.76c-.71-1.53-.21-3.68 1.38-5.27 1.92-1.91 4.66-2.27 6.12-.81 1.47 1.47 1.1 4.21-.81 6.12zm-9.22.36L8.1 13.34 3.91 9.16a4 4 0 0 1 0-5.66l7.02 7.01z" clip-rule="evenodd"></path></svg>
								<div id="con_fac_desc2_head">
									<h3 class="c_h3_head5">식사 및 음료</h3>
								</div>
							</div>
							<div class="c_content_txt c_grid" style="padding-left: 2.3rem; gap: 0.75rem;">
								<c:forEach var="c_snk" items="${requestScope.com_snk_opt_list}">
									<div>${c_snk.snk_opt_desc}</div>
								</c:forEach>
							</div>
						</div>
					</div>
				</c:if>
				<c:if test="${not empty requestScope.rmsvc_opt_list}">
					<div id="con_fac2_it3">
						<div class="c_grid" style="grid-template-rows: repeat(4, auto); gap: 0.75rem;">
							<div class="c_flex" style="gap: 0.75rem;">
								<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path d="M9 16.17 4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41L9 16.17z"></path></svg>
								<div id="lodge_desc_cont_head">
									<h3 class="c_h3_head5">기타</h3>
								</div>
							</div>
							<div class="c_content_txt c_grid" style="padding-left: 2.3rem; gap: 0.75rem;">
								<c:forEach var="l_rmsvc" items="${requestScope.rmsvc_opt_list}">
									<div>${l_rmsvc.rmsvc_opt_desc}</div>
								</c:forEach>
							</div>
						</div>
					</div>
				</c:if>
			</div>	
		</div>
	</div>
	
	<div id="basic_policy_container" class="c_container_w" style="margin-top: 1.5rem;">
		<div id="b_policy" class="c_grid_c_1_2">
			<div id="b_policy_head" class="c_grid_c_it1">
				<h2 class="c_h2_head4">장애인 지원</h2>
				<div class="c_content_txt" style="line-height: 1.25rem; margin-top: 0.5rem; padding: 0.25rem 0  0.75rem 0;">장애인 편의 시설 관련 특별 요청이 있으신 경우, 예약 후 받은 예약 확인 메일에 나와 있는 정보로 숙박 시설에 문의해 주세요.</div>
			</div>
			<div class="c_grid_c2 c_grid_c_it2">
				<c:if test="${not empty requestScope.fac_opt_list}">
					<div class="disabled_fac_con ">
						<div class="c_grid" style="grid-template-rows: repeat(4, auto); gap: 1rem;">
							<div class="c_flex" style="gap: 0.75rem;">
								<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <path d="m21.61 21.41-.47-1.1a.49.49 0 0 0-.16-.2.4.4 0 0 0-.23-.06h-.84V7.4a.4.4 0 0 0-.12-.28.38.38 0 0 0-.29-.13h-3.75V2.41a.4.4 0 0 0-.12-.28.38.38 0 0 0-.29-.13H4.5a.38.38 0 0 0-.3.13.4.4 0 0 0-.11.28v17.64h-.84a.4.4 0 0 0-.23.07.49.49 0 0 0-.16.18l-.47 1.11a.44.44 0 0 0-.03.2c0 .08.03.14.07.2a.38.38 0 0 0 .33.2h18.48a.38.38 0 0 0 .33-.2.36.36 0 0 0 .07-.2c0-.06 0-.13-.03-.2zM9.09 17h-2.5v-2.5h2.5V17zm0-5h-2.5V9.5h2.5V12zm0-5h-2.5V4.5h2.5V7zm4.16 12.77h-2.5V14.5h2.5v5.27zm0-7.77h-2.5V9.5h2.5V12zm0-5h-2.5V4.5h2.5V7zm4.16 10h-2.5v-2.5h2.5V17zm0-5h-2.5V9.5h2.5V12z"></path></svg>
								<div id="lodge_desc_cont_head">
									<h3 class="c_h3_head5">공용구역</h3>
								</div>
							</div>
							<div class="c_content_txt c_grid" style="padding-left: 2.3rem; gap: 0.75rem;">
								<c:forEach var="fac" items="${requestScope.fac_opt_list}">
									<div>${fac.fac_opt_desc}</div>
								</c:forEach>
							</div>
						</div>
					</div>
				</c:if>
				<div class="disabled_fac_con ">
					<div class="c_grid" style="grid-template-rows: repeat(4, auto); gap: 1rem;">
						<div class="c_flex" style="gap: 0.75rem;">
							<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <path d="M19 19V4h-4V3H5v16H3v2h12V6h2v15h4v-2h-2zm-6 0H7V5h6v14zm-3-8h2v2h-2v-2z"></path></svg>
							<div id="lodge_desc_cont_head">
								<h3 class="c_h3_head5">객실</h3>
							</div>
						</div>
						<div class="c_content_txt c_grid" style="padding:0 0 0 2.3rem; gap: 0.75rem;">
							<div>객실 내 장애인 편의 시설(일부 객실에서 이용 가능)</div>
						</div>
					</div>
				</div>
			</div>	
		</div>
	</div>
	
	<div id="extra_info_container" class="c_container_w" style="margin-top: 1.5rem;">
		<div id="extra_info" class="c_grid_c3" style="gap: 1.5rem;">
			<div id="extra_info_head" class="c_grid_c3_it1">
				<h2 class="c_h2_head4">중요정보</h2>
			</div>
			
			<div class="extra_info_con c_grid_c3_it23">
				<div class="c_grid" style="gap: 1rem;">
					<div class="c_grid" style="gap: 0.75rem;">
						<div id="extra_info_head">
							<h3 class="c_h3_head5">기타 선택 사항</h3>
						</div>
						<div class="c_content_txt c_grid" style="gap: 1.25rem;">
							<c:if test="${not empty requestScope.lodgeinfo.LG_CHECKIN_START_TIME and not empty requestScope.lodgeinfo.LG_CHECKIN_END_TIME}">
								<div>체크인 시작 시간은 ${requestScope.lodgeinfo.LG_CHECKIN_START_TIME}이며, 체크인 종료 시간은 ${requestScope.lodgeinfo.LG_CHECKIN_END_TIME}입니다.</div>
							</c:if>	
							<c:if test="${not empty requestScope.lodgeinfo.LG_CHECKOUT_TIME}">
								<div>체크아웃 시간은 ${requestScope.lodgeinfo.LG_CHECKOUT_TIME}입니다.</div>
							</c:if>				
							<c:if test="${not empty requestScope.lodgeinfo.LG_AGE_LIMIT}">
								<div>최소 체크인 나이 - 만 ${requestScope.lodgeinfo.LG_AGE_LIMIT}세</div>
							</c:if>	
						</div>
					</div>
				</div>
			</div>
			<div class="extra_info_con c_grid_c3_it23">
				<div class="" style="gap: 1rem;">
					<div class="c_grid" style="gap: 0.75rem;">
						<div id="extra_info_head">
							<h3 class="c_h3_head5">알아두실 사항</h3>
						</div>
						<div class="c_content_txt c_grid" style="gap: 1.25rem;">
							<div>추가 인원에 대한 요금이 부과될 수 있으며, 이는 숙박 시설 정책에 따라 다릅니다.</div>
							<div>체크인 시 부대 비용 발생에 대비해 정부에서 발급한 사진이 부착된 신분증과 신용카드, 직불카드 또는 현금으로 보증금이 필요할 수 있습니다.</div>
							<div>특별 요청 사항은 체크인 시 이용 상황에 따라 제공 여부가 달라질 수 있으며 추가 요금이 부과될 수 있습니다. 또한, 반드시 보장되지는 않습니다.</div>
							<div>이 숙박 시설에서 사용 가능한 결제 수단은 신용카드, 현금입니다.</div>
							<div>이 숙박 시설은 안전을 위해 연기 감지기 등을 갖추고 있습니다.</div>
							<div>고객 정책과 문화적 기준이나 규범은 국가 및 숙박 시설에 따라 다를 수 있습니다. 명시된 정책은 숙박 시설에서 제공했습니다.</div>
						</div>
					</div>
				</div>
			</div>
			
			<div class="extra_info_con c_grid_c3_it23">
				<div class="" style="gap: 1rem;">
					<div class="c_grid" style="gap: 0.75rem;">
						<div id="extra_info_head">
							<h3 class="c_h3_head5">국가 공인 등급</h3>
						</div>
						<div class="c_content_txt c_grid" style="gap: 1.25rem;">
							<div>고객 편의를 위해 저희 등급 시스템을 기준으로 해당 정보를 제공했습니다.</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</div>

<div id="lg_img_all" style="display:none;">
	<div id="lg_img_close" class="c_flex" style="block-size: 3rem; align-items: center; ">
		<button type="button" id="lg_img_close_btn" class="c_flex modal_close_btn" style="block-size: 3rem; inline-size:3rem;">
			<span class="c_round_btn_blue c_flex" style="block-size: 2.3rem; inline-size:2.3rem; margin: auto;">
				<svg class="c_icon_24" style="margin: auto;" aria-label="닫기" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><title id="undefined-close-toolbar-title">닫기.</title><path fill="#1668e3" d="M19 6.41 17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12 19 6.41z"></path></svg>
			</span>					
		</button>
		<span class="c_content_txt">${requestScope.lodgeinfo.LG_NAME}</span>
	</div>
	<div id="lg_img_all"style="inline-size: 100%; margin: auto; max-inline-size: 80rem;">
		<div id="lg_img_index" class="c_flex" style="gap: 0.75rem; padding: 1rem 0;">
			
			<div class="img_index_btn" onclick="javascript:view_lg_img('all','모든 사진')">				
				<button class="c_txt_sm c_flex" style="align-items: center;">모든 사진 (${fn:length(all_rm_img_list)+fn:length(all_lg_img_list)})</button>
			</div>			
			<c:if test="${fn:length(all_rm_img_list)>0}">
				<div class="img_index_btn" onclick="javascript:view_lg_img('rm','객실')">				
					<button class="c_txt_sm c_flex" style="align-items: center;">객실 (${fn:length(all_rm_img_list)})</button>
				</div>
			</c:if>
			<%-- img_cat_list forEach문 value에 fk_img_ca_no 넣어주기--%>
			<c:if test="${not empty requestScope.lg_img_ca_list}">		
				<c:forEach var="ca_list" items="${requestScope.lg_img_ca_list}">
					<c:if test="${ca_list.img_cate_no ne 6}">
						<div class="img_index_btn" onclick="javascript:view_lg_img('${ca_list.img_cate_no}','${ca_list.img_cate_name}')">				
							<button class="c_txt_sm c_flex" style="align-items: center;">${ca_list.img_cate_name} (${ca_list.ca_img_cnt})</button>
						</div>
					</c:if>
				</c:forEach>	
			</c:if>
		</div>
		<div id="lg_img_thumnail">
			<div class="h2"></div>
			<div class="c_grid_c2" style="gap: 1rem;">
			</div>
		</div>
		
	</div>
</div>

<!-- 이용후기 모달 -->
<div>
	<div id="reviewModal" class="c_modalContainer">
		<div class="c_modalWrap" style="width:40rem; overflow: hidden;" >
			<div class="c_flex modalTop_close" style="block-size: 3rem; align-items: center;">
				<button type="button" id="m_close_btn_rv"class="c_flex modal_close_btn" style="block-size: 3rem; inline-size: 3rem;">
					<span class="c_round_btn_blue c_flex" style="block-size: 2.3rem; inline-size: 2.3rem; margin: auto;">
						<svg class="c_icon_24" style="margin: auto;" aria-label="닫기" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"  xmlns:xlink="http://www.w3.org/1999/xlink"><title id="undefined-close-toolbar-title">닫기.</title><path fill="#1668e3" d="M19 6.41 17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12 19 6.41z"></path></svg>
					</span>
				</button>
				고객 이용 후기
			</div>			
			<div class="reviewModal_content" style="height: 77vh; overflow-y: auto;  overflow-x: hidden; padding: 0 2rem;">
				<br>
				<h4 class="rating_avg" style=" font-size: 1.25rem; font-weight: 600;"><fmt:formatNumber value="${requestScope.lodgeinfo.RV_RATING_AVG}" pattern=".0"/>/10.0 - 
					<span>
						<c:if test="${rv_rate>=7.0 and rv_rate<=7.9}">좋아요</c:if>
						<c:if test="${rv_rate>=8.0 and rv_rate<=8.4}">매우 좋아요</c:if>
						<c:if test="${rv_rate>=8.5 and rv_rate<=7.9}">훌륭해요</c:if>
						<c:if test="${rv_rate>=9.0 and rv_rate<=9.4}">매우 훌륭해요</c:if>
						<c:if test="${rv_rate>=9.5 and rv_rate<=10.0}">최고에요</c:if>
					</span>
				
				</h4>
				<span style="font-size: 0.875rem;">${requestScope.lodgeinfo.RV_CNT}개 실제 이용 고객 후기</span>
				<div class="rating" style="margin-top: 3%;">
					<div class="progressbar_1 progress_wrap">					    
				      <h5 class="c_txt_sm">
						10 - 훌륭해요 <span style="float: right;">${requestScope.rv_cnt_byRate.TEN}</span>
					  </h5>
					 	<progress id="progress" value="${requestScope.rv_cnt_byRate.TEN}" min="0" max="${requestScope.lodgeinfo.RV_CNT}"></progress>			
					</div>
					<div class="progressbar_2 progress_wrap">
						<h5 class="c_txt_sm">
							8 - 좋아요 <span style="float: right;">${requestScope.rv_cnt_byRate.EIGHT}</span>
						</h5>
						<progress id="progress" value="${requestScope.rv_cnt_byRate.EIGHT}" min="0" max="${requestScope.lodgeinfo.RV_CNT}"></progress>
					</div>
					<div class="progressbar_3 progress_wrap">
						<h5 class="c_txt_sm">
							6 - 괜찮아요 <span style="float: right;">${requestScope.rv_cnt_byRate.SIX}</span>
						</h5>
						<progress id="progress" value="${requestScope.rv_cnt_byRate.SIX}" min="0" max="${requestScope.lodgeinfo.RV_CNT}"></progress>
					</div>
					<div class="progressbar_4 progress_wrap">
						<h5 class="c_txt_sm">
							4 - 별로에요 <span style="float: right;">${requestScope.rv_cnt_byRate.FOUR}</span>
						</h5>
						<progress id="progress" value="${requestScope.rv_cnt_byRate.FOUR}" min="0" max="${requestScope.lodgeinfo.RV_CNT}"></progress>
					</div>
					<div class="progressbar_5 progress_wrap">
						<h5 class="c_txt_sm">
							2 - 너무 별로에요<span style="float: right;">${requestScope.rv_cnt_byRate.TWO}</span>
						</h5>
						<progress id="progress" value="${requestScope.rv_cnt_byRate.TWO}" min="0" max="${requestScope.lodgeinfo.RV_CNT}"></progress>
					</div>
				</div>
	
	
	
				<div class="search_filter c_flex" style="margin-top: 3%; flex-direction: column;">
					<!-- <input type="text" style="height: 50px; border: 1px solid black; border-radius: 10px;" id="search-input-box" name="reviewSearch" placeholder="  이용 후기 검색" /> -->
					<form name="rv_searchFrm">
						<div class="input-wrapper c_flex">
							<input type="text" id="search-input-box" name="reviewSearch" style="flex-grow: 1; padding-block-start:1rem; font-size: 0.875rem"  maxlength="200" autocomplete="off" /> 
							<label for="search-input-box" id="search-input-label">이용 후기 검색</label>
							<button type="button" onclick="goReviewSearch()" style="background: #0073FF; inline-size: 3rem; block-size: 3rem;">
								<svg class="uitk-icon uitk-icon-leading" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill="white" fill-rule="evenodd" d="M14.71 14h.79l4.99 5L19 20.49l-5-4.99v-.79l-.27-.28a6.5 6.5 0 1 1 .7-.7l.28.27zM5 9.5a4.5 4.5 0 1 0 8.99.01A4.5 4.5 0 0 0 5 9.5z" clip-rule="evenodd"></path></svg>
							</button>
						</div>
						<select name="rvOrderType" id="rvOrderType" style="">
							<option value="recent_rv">최근 이용 후기</option>
							<option value="h_rate_rv">최고 고객 평점</option>
							<option value="l_rate_rv">최저 고객 평점</option>
						</select>
						<input type="text" value="" style="display:none;"/>
						<input type="text" value="" style="display:none;"/>
					</form>
				</div>
								
				<div id="view_reviewList" class="review">
					<c:forEach var="reviewList" items="${requestScope.reviewList}">		
						<div style="border-bottom: 1px solid black;">
							<c:if test="${reviewList.RV_DEPTHNO == 0}">                       
		                        <div class="c_grid" style="gap:0.875rem; padding:1.2rem 0;">
			                        <div class="c_h3_head6" style="font-weight:600;">${reviewList.FK_RV_RATING}/10 - ${reviewList.RV_RATING_DESC}</div>
			                        
			                        <div>
			                           <div class="c_txt_sm" style="font-weight:600">${reviewList.RS_NAME}</div>
			                           <div class="c_txt_sm">${reviewList.RV_REGDATE}</div>
			                        </div>
			                        <div class="c_flex" style="flex-direction: column; gap: 0.5rem;">
			                        	<div class="c_content_txt">${reviewList.RV_CONTENT}</div>
			                        	<div class="c_txt_sm">${reviewList.RS_DATE}에 ${reviewList.LIVEDATE} 숙박함</div>
			                        </div>
			                        <div class="reviewfindBtn">
			                           	<%-- <button type="button" class="btn_like" id="btnLike">좋아요</button>&nbsp;&nbsp; --%>
			                           	<button type="button" onclick="golikeAdd('${reviewList.RV_SEQ}',this)">
			                           		<svg xmlns="http://www.w3.org/2000/svg" style="margin-right: 5px;" height="16" width="16" fill="rgba(35, 121, 255, 0.89)" viewBox="0 0 512 512"><path d="M313.4 32.9c26 5.2 42.9 30.5 37.7 56.5l-2.3 11.4c-5.3 26.7-15.1 52.1-28.8 75.2H464c26.5 0 48 21.5 48 48c0 18.5-10.5 34.6-25.9 42.6C497 275.4 504 288.9 504 304c0 23.4-16.8 42.9-38.9 47.1c4.4 7.3 6.9 15.8 6.9 24.9c0 21.3-13.9 39.4-33.1 45.6c.7 3.3 1.1 6.8 1.1 10.4c0 26.5-21.5 48-48 48H294.5c-19 0-37.5-5.6-53.3-16.1l-38.5-25.7C176 420.4 160 390.4 160 358.3V320 272 247.1c0-29.2 13.3-56.7 36-75l7.4-5.9c26.5-21.2 44.6-51 51.2-84.2l2.3-11.4c5.2-26 30.5-42.9 56.5-37.7zM32 192H96c17.7 0 32 14.3 32 32V448c0 17.7-14.3 32-32 32H32c-17.7 0-32-14.3-32-32V224c0-17.7 14.3-32 32-32z" /></svg>
			                           	</button>
			                           	<span class="likeCnt">${reviewList.LIKECNT}</span>
			                        </div>
	                        	</div>
							</c:if>
		                    <c:if test="${reviewList.RV_DEPTHNO > 0}">
		                    	<input type="hidden" name="rv_seq" size="38" value="${reviewList.RV_SEQ}" autocomplete="off" readonly />
								<div class="c_grid" style="gap: 0.875rem; padding: 0.5rem 0 1rem 1rem;">	
									<div class="c_flex" style="flex-direction: column; gap: 0.3rem;">
										<div class="c_txt_sm" style="font-weight:600">└ ${reviewList.LG_NAME} 님 </div>
										<div class="c_txt_sm" style="padding-left:1rem;">${reviewList.RV_REGDATE}</div>
									</div>
									<div class="c_txt_sm" style="padding-left:1rem;">${reviewList.RV_CONTENT}</div>
								</div>
		                    </c:if>
	                    </div>    
					</c:forEach>                   
                   	<br>
                	<div style="display: flex; justify-content: center;">
					    <button type="button" style="width: 30%; height: 30px; border: 1px solid black; margin-bottom: 5%; background-color: #fff; color: #1668e3; border-radius: 2500rem;">이용 후기 더보기</button>
					</div>
					<br>
				</div>
			</div>
		</div>	
	</div>
</div>


<script>

$(document).ready(function(){
	
	
	
});

//자세히 보기 버튼을 클릭 했을 때,
function show_rm_detail(e) {
	
	// alert("들어옴!");
	// 모달창에 띄워서 보여줄 객실의 rm_seq 가져오기
	const rm_seq = $(e).attr("rm_seq");
	const lodge_id = $(e).attr("lodge_id");
	// console.log("rm_seq => ",rm_seq);
	// console.log("lodge_id => ",lodge_id);
	
	$.ajax({
		url:"rmDetail_info_json.exp",
 		data:{"rm_seq":rm_seq,
 			  "lodge_id":lodge_id},
	 	dataType:"json",
	 	success:function(json){
			 
			// console.log(json);
			// {bath_opt_list: Array(5), snk_opt_list: Array(2), ent_opt_list: Array(2), tmp_opt_list: Array(2)}
			// console.log(json.bath_opt_list[0].bath_opt_desc);
			// 타월 제공
			
			
			let html = '';
			 
			const bath_list = json.bath_opt_list;
			const snk_list = json.snk_opt_list;
			const kt_list = json.kt_opt_list;
			const ent_list = json.ent_opt_list;
			const tmp_list = json.tmp_opt_list;
			const img_list = json.rm_img_list;
			const l_inet_list = json.inet_opt_list;
			const l_rmsvc_list = json.rmsvc_opt_list;
			
			const rm_info = json.rm_list;
			// console.log(img_list);
			// console.log(bath_list.length);
			
			const price = Math.ceil(Number(rm_info.rm_price)).toLocaleString('en');
			const d_rate = ${d_rate};
			const d_rate_per = d_rate*100;
			const d_rate_price = rm_info.rm_price*stay_night*d_rate;
			const price_one_night_before_sale = Math.ceil(rm_info.rm_price).toLocaleString('en');	
			const price_one_night = Math.ceil(rm_info.rm_price*(1-d_rate)).toLocaleString('en');	
			const tax = Math.ceil(rm_info.rm_price*stay_night*0.1).toLocaleString('en');
			const ttl_price = Math.ceil(rm_info.rm_price*0.1*stay_night + rm_info.rm_price*stay_night*(1-d_rate)).toLocaleString('en');
		
			
			html +=
				'<div>'
					+'<div id="view_rm_detail_info" class="c_modalContainer" style="overflow-y: hidden;">'
						+'<div class="c_modalWrap" style="width: 45rem;">'
							+'<div class="c_flex modalTop_close" style="block-size: 3rem; align-items: center;">'
								+'<button type="button" id="m_close_btn_rm"class="c_flex modal_close_btn" style="block-size: 3rem; inline-size: 3rem;">'
									+'<span class="c_round_btn_blue c_flex" style="block-size: 2.3rem; inline-size: 2.3rem; margin: auto;">'
										+'<svg class="c_icon_24" style="margin: auto;" aria-label="닫기" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"  xmlns:xlink="http://www.w3.org/1999/xlink"><title id="undefined-close-toolbar-title">닫기.</title><path fill="#1668e3" d="M19 6.41 17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12 19 6.41z"></path></svg>'
									+'</span>'
								+'</button>'
								+'객실 정보'
							+'</div>'
							+'<div id="" class="c_grid" style="height: 75vh; padding: 0.5rem 1.5rem; gap: 1.5rem; overflow-y: auto;">'
								+'<div id="m_rm_img">'
									+'<div class="img_slide c_border_r1">'
										+'<div id="rm_img_slide" class="carousel slide" data-interval="false">'
											+'<div class="carousel-inner c_border_r1">'
			if(img_list != null){				
				$.each(img_list, function(index, item){
					if(index==1){
						html += '<div class="carousel-item active" style="height: 23rem;">'
									+'<img src="<%=ctxPath%>/resources/images/'+lodge_id+'/room_img/'+item.rm_img_save_name+'" class="d-block w-100 image_thumnail"style="object-fit: cover; aspect-ratio: 16/9;">'
								+'</div>';
					}
					else{
						html +=	'<div class="carousel-item" style="height: 23rem;">'
									+'<img src="<%=ctxPath%>/resources/images/'+lodge_id+'/room_img/'+item.rm_img_save_name+'" class="d-block w-100 h-100 image_thumnail" style="object-fit: cover; aspect-ratio: 16/9;">'
								+'</div>';						
					}
				});// end of $.each(img_list, function(index, item)------
			}
			else {
				html += '<div class="carousel-item active" style="height: 23rem;">'
							+'<img src="<%=ctxPath%>/resources/images/jy/null0.png" class="d-block w-100 image_thumnail"style="object-fit: cover; aspect-ratio: 16/9;">'
						+'</div>'
		       			+'<div class="carousel-item" style="height: 23rem;">'
							+'<img src="<%=ctxPath%>/resources/images/jy/null1.png" class="d-block w-100 h-100 image_thumnail" style="object-fit: cover; aspect-ratio: 16/9;">'
						+'</div>';	
			}
									
												
			html +=							'</div>'

											+'<a class="carousel-control-prev" href="#rm_img_slide" role="button" data-slide="prev"><span class="carousel-control-prev-icon" aria-hidden="true"></span><span class="sr-only">Previous</span></a>'
											+'<a class="carousel-control-next" href="#rm_img_slide" role="button" data-slide="next"><span class="carousel-control-next-icon" aria-hidden="true"></span><span class="sr-only">Next</span></a>'
										+'</div>'
									+'</div>'
								+'</div>'
								+'<div id="m_rm_spec">'
									+'<div style="padding-bottom: 0.75rem;">'
										+'<h3 class="c_h3_head5">'+rm_info.rm_type+'</h3>'
										+'<div class="c_txt-300">'+rm_info.view_desc+'</div>'
									+'</div>'
								
									+'<div class="c_border_r1" style="background-color: #ecf4fd; padding: 0.875rem;">'
										+'<div class="c_flex c_content_txt" style="align-items: center; gap: 0.3rem; padding-bottom: 0.5rem;">'
											+'<svg class="c_icon_24" aria-describedby="cleanliness-description" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><desc id="cleanliness-description">cleanliness</desc><path d="M19.14 7.25 18 10l-1.14-2.86L14 6l2.86-1.14L18 2l1.14 2.86L22 6l-2.86 1.25zM11 10 9 4l-2 6-6 2 6 2 2 6 2-6 6-2-6-2zm4.5 10.5-1.5-1 1.5-1 1-1.5 1 1.5 1.5 1-1.5 1-1 1.5-1-1.5z"></path></svg>'
											+'<h3 class="c_h3_head6">주요 특징</h3>'
										+'</div>'
										+'<div class="c_flex c_txt-300" style="column-gap: 1rem; row-gap: 0.5rem; flex-wrap: wrap;">';
			if(rm_info.rm_breakfast_yn == "1"){
				html += '<div>조식 제공</div>'
			}
			if(rm_info.fk_view_no != "0"){
				html += '<div>'+rm_info.view_desc+'</div>'
			}
			if(rm_info.rm_smoke_yn == "0"){
				html += '<div>금연객실</div>'
			}
			if(rm_info.rm_wheelchair_yn != '0'){
				html += '<div>휠체어 이용가능</div>'
			}
			if(tmp_list != null){
				$.each(tmp_list, function(index, item){
					if(index<1){
						html += '<div>'+item.tmp_opt_desc+'</div>'
					}
				})
			}
			if(bath_list != null){
				$.each(bath_list, function(index, item){
					if(index<2){
						html += '<div>'+item.bath_opt_desc+'</div>'
					}
				})
				
			}
			if(ent_list != null){
				$.each(ent_list, function(index, item){
					if(index<2){
						html += '<div>'+item.ent_opt_desc+'</div>'
					}
				})
			}
			if(snk_list != null){
				$.each(snk_list, function(index, item){
					if(index<2){
						html += '<div>'+item.snk_opt_desc+'</div>'
					}
				})
			}
			html  +=					  '</div>'
									+'</div>'
									+'<div style="padding-top: 1rem;">'
										+'<ul class="c_grid" style="gap:0.8rem;">'
											+'<li class="c_flex">'
											+'<div class="c_flex" style="margin: auto 0; padding-right: 0.5rem;">'
												+'<svg class="c_icon_18" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path d="M6 18h2l-3 3-3-3h2V6c0-1.1.9-2 2-2h12V2l3 3-3 3V6H6v12zm14-8v2h-2v-2h2zm0 8a2 2 0 0 1-2 2v-2h2zm0-4v2h-2v-2h2zm-4 4v2h-2v-2h2zm-4 0v2h-2v-2h2z"></path></svg>'
											+'</div>'
											+'<span class="c_content_txt">'+rm_info.rm_size_meter+'㎡</span>'

										+'</li>';	
				if(rm_info.rm_breakfast_yn == "1"){
					html += '<li class="c_flex">'
								+'<div class="c_flex" style="margin: auto 0; padding-right: 0.5rem;">'
									+'<svg class="c_icon_18" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill-rule="evenodd" d="M20 3H4v10a4 4 0 0 0 4 4h6a4 4 0 0 0 4-4v-3h2a2 2 0 0 0 2-2V5a2 2 0 0 0-2-2zm0 5h-2V5h2v3zm0 11H4v2h16v-2z" clip-rule="evenodd"></path></svg>'
								+'</div>'
								+'<span class="c_content_txt">무료 아침식사</span>'
							+'</li>';
				}
				$.each(l_inet_list, function(index,item) {
					if(item.fk_inet_opt_no=="0" || item.fk_inet_opt_no=="1"){
						html += '<li class="c_flex">'
									+'<div class="c_flex" style="margin: auto 0; padding-right: 0.5rem;">'
										+'<svg class="c_icon_18" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill-rule="evenodd" d="m1 9 2 2a12.73 12.73 0 0 1 18 0l2-2A15.57 15.57 0 0 0 1 9zm8 8 3 3 3-3a4.24 4.24 0 0 0-6 0zm-2-2-2-2a9.91 9.91 0 0 1 14 0l-2 2a7.07 7.07 0 0 0-10 0z" clip-rule="evenodd"></path></svg>'
									+'</div>'
									+'<span class="c_content_txt">무료 wifi</span>'
								+'</li>';
						return false;
					}
				});
										
				if(rm_info.rm_single_bed>0 || rm_info.rm_ss_bed>0 || rm_info.rm_double_bed>0 || rm_info.rm_queen_bed>0 || rm_info.rm_king_bed>0) {	
					html += '<li class="c_flex">'
								+'<div class="c_flex" style="margin: auto 0; padding-right: 0.5rem;">'
									+'<svg class="c_icon_18" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill-rule="evenodd" d="M11 7h8a4 4 0 0 1 4 4v9h-2v-3H3v3H1V5h2v9h8V7zm-1 3a3 3 0 1 1-6 0 3 3 0 0 1 6 0z" clip-rule="evenodd"></path></svg>'
								+'</div>'
								+'<span class="c_content_txt">';
					if(rm_info.rm_single_bed>0){
						html += '싱글 침대 '+rm_info.rm_single_bed+'개&nbsp;';
					}
					if(rm_info.rm_ss_bed>0){
						html += '슈퍼싱글 침대 '+rm_info.rm_ss_bed+'개&nbsp;';
					}
					if(rm_info.rm_double_bed>0){
						html += '싱글 침대 '+rm_info.rm_double_bed+'개&nbsp;';
					}
					if(rm_info.rm_queen_bed>0){
						html += '싱글 침대 '+rm_info.rm_queen_bed+'개&nbsp;';
					}
					if(rm_info.rm_king_bed>0){
						html += '싱글 침대 '+rm_info.rm_king_bed+'개&nbsp;';
					}
				}				
				
				html += '</span>'
					+'</li>';
					
				
				if(rm_info.fk_view_no != 0){
					html += '<li class="c_flex">'
					if(rm_info.fk_view_no == 1 ||rm_info.fk_view_no == 3 ||rm_info.fk_view_no == 6){
						html +='<div class="c_flex rm_view_svg" style="margin: auto 0; padding-right: 0.5rem;"><svg class="c_icon_18" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path d="M21.98 14H22h-.02ZM5.35 13c1.19 0 1.42 1 3.33 1 1.95 0 2.09-1 3.33-1 1.19 0 1.42 1 3.33 1 1.95 0 2.09-1 3.33-1 1.19 0 1.4.98 3.31 1v-2c-1.19 0-1.42-1-3.33-1-1.95 0-2.09 1-3.33 1-1.19 0-1.42-1-3.33-1-1.95 0-2.09 1-3.33 1-1.19 0-1.42-1-3.33-1-1.95 0-2.09 1-3.33 1v2c1.9 0 2.17-1 3.35-1Zm13.32 2c-1.95 0-2.09 1-3.33 1-1.19 0-1.42-1-3.33-1-1.95 0-2.1 1-3.34 1-1.24 0-1.38-1-3.33-1-1.95 0-2.1 1-3.34 1v2c1.95 0 2.11-1 3.34-1 1.24 0 1.38 1 3.33 1 1.95 0 2.1-1 3.34-1 1.19 0 1.42 1 3.33 1 1.94 0 2.09-1 3.33-1 1.19 0 1.42 1 3.33 1v-2c-1.24 0-1.38-1-3.33-1ZM5.35 9c1.19 0 1.42 1 3.33 1 1.95 0 2.09-1 3.33-1 1.19 0 1.42 1 3.33 1 1.95 0 2.09-1 3.33-1 1.19 0 1.4.98 3.31 1V8c-1.19 0-1.42-1-3.33-1-1.95 0-2.09 1-3.33 1-1.19 0-1.42-1-3.33-1-1.95 0-2.09 1-3.33 1-1.19 0-1.42-1-3.33-1C3.38 7 3.24 8 2 8v2c1.9 0 2.17-1 3.35-1Z"></path></svg></div>'
					}
					if(rm_info.fk_view_no == 2){
						html +='<div class="c_flex rm_view_svg" style="margin: auto 0; padding-right: 0.5rem;"><svg class="c_icon_18" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path d="m14 6-3.75 5 2.85 3.8-1.6 1.2L7 10l-6 8h22L14 6z"></path></svg></div>'
					}
					if(rm_info.fk_view_no == 4){
						html +='<div class="c_flex rm_view_svg" style="margin: auto 0; padding-right: 0.5rem;"><svg class="c_icon_18" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill-rule="evenodd" d="M15 5v6h6v10H3V7h6V5l3-3 3 3zM5 19h2v-2H5v2zm2-4H5v-2h2v2zm-2-4h2V9H5v2zm6 8v-2h2v2h-2zm0-6v2h2v-2h-2zm0-2V9h2v2h-2zm0-6v2h2V5h-2zm8 14h-2v-2h2v2zm-2-4h2v-2h-2v2z" clip-rule="evenodd"></path></svg></div>'
					}
					if(rm_info.fk_view_no == 5){
						html +='<div class="c_flex rm_view_svg" style="margin: auto 0; padding-right: 0.5rem;"><svg class="c_icon_18" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path d="M13 15.93a7 7 0 1 0-2 0V20H5v2h14v-2h-6v-4.07z"></path></svg></div>'
					}
					
					
					html		+='<span class="c_content_txt rm_view_desc">'+rm_info.view_desc+'</span>'
							+'</li>';
				}
													
					html +=	'<li class="c_flex">'
								+'<div class="c_flex" style="margin: auto 0; padding-right: 0.5rem;">'
									+'<svg class="c_icon_18" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill-rule="evenodd" d="M10.99 8A3 3 0 1 1 5 8a3 3 0 0 1 6 0zm8 0A3 3 0 1 1 13 8a3 3 0 0 1 6 0zM8 13c-2.33 0-7 1.17-7 3.5V19h14v-2.5c0-2.33-4.67-3.5-7-3.5zm7.03.05c.35-.03.68-.05.97-.05 2.33 0 7 1.17 7 3.5V19h-6v-2.5c0-1.48-.81-2.61-1.97-3.45z" clip-rule="evenodd"></path></svg>'
								+'</div>'
								+'<span class="c_content_txt">'+rm_info.rm_guest_cnt+'명</span>'
							+'<li class="c_flex">'
								+'<div class="c_flex" style="margin: auto 0; padding-right: 0.5rem;">'
									+'<svg class="c_icon_18" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path d="M9 16.17 4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41L9 16.17z"></path></svg>'
								+'</div>'
								+'<span class="c_content_txt">'+'지금 예약하고 현장 결제'+'</span>'
							+'</li>'
						+'</ul>'
					+'</div>'
				+'</div>'
				+'<div id="m_rm_fac">'
					+'<div>'
						+'<h3 class="c_h3_head5" style="padding-bottom: 1.25rem;">'+'객실 편의 시설'+'</h3>'
					+'</div>'
					+'<div class="c_grid" style="grid-template-columns: 1fr 1fr; gap: 2rem;">';
				if(bath_list!=null && bath_list.length>0){
					html += '<div>'
								+'<div class="c_flex" style="margin:0 0 1rem 0; align-items: center;">'
									+'<div class="c_flex" style="margin: auto 0; padding-right: 1rem;">'
										+'<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">'+'<path fill-rule="evenodd" d="M20 13V4.83C20 3.27 18.73 2 17.17 2c-.75 0-1.47.3-2 .83l-1.25 1.25c-.16-.05-.33-.08-.51-.08-.4 0-.77.12-1.08.32l2.76 2.76c.2-.31.32-.68.32-1.08 0-.18-.03-.34-.07-.51l1.25-1.25a.828.828 0 0 1 1.41.59V13H2v6c0 1.1.9 2 2 2 0 .55.45 1 1 1h14c.55 0 1-.45 1-1 1.1 0 2-.9 2-2v-6h-2ZM4 19h16v-4H4v4Z" clip-rule="evenodd">'+'</path>'+'</svg>'
									+'</div>'
									+'<h3 class="c_h3_head6">'+'욕실'+'</h3>'
								+'</div>'
								+'<ul class="c_grid" style="gap: 0.6rem;">';
					$.each(bath_list, function(index, item){
						html += '<li class="c_li_dot" style="font-size: 0.5rem; padding-left: 1rem;"><span class="c_txt-300" style="padding-left: 0.2rem;">'+item.bath_opt_desc+'</span></li>';
					});							
					html +=		'</ul>'	
							+'</div>';
				}
				if(kt_list!=null && kt_list.length>0){
					html += '<div>'
								+'<div class="c_flex" style="margin:0 0 1rem 0; align-items: center;">'
									+'<div class="c_flex" style="margin: auto 0; padding-right: 1rem;">'
										+'<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">'+'<path fill-rule="evenodd" d="M20 13V4.83C20 3.27 18.73 2 17.17 2c-.75 0-1.47.3-2 .83l-1.25 1.25c-.16-.05-.33-.08-.51-.08-.4 0-.77.12-1.08.32l2.76 2.76c.2-.31.32-.68.32-1.08 0-.18-.03-.34-.07-.51l1.25-1.25a.828.828 0 0 1 1.41.59V13H2v6c0 1.1.9 2 2 2 0 .55.45 1 1 1h14c.55 0 1-.45 1-1 1.1 0 2-.9 2-2v-6h-2ZM4 19h16v-4H4v4Z" clip-rule="evenodd"></path></svg>'
									+'</div>'
									+'<h3 class="c_h3_head6">'+'주방/조리시설'+'</h3>'
								+'</div>'
								+'<ul class="c_grid" style="gap: 0.6rem;">';
					$.each(kt_list, function(index, item){
						html += '<li class="c_li_dot" style="font-size: 0.5rem; padding-left: 1rem;"><span class="c_txt-300" style="padding-left: 0.2rem;">'+item.kt_opt_desc+'</span></li>';
					});							
					html +=		'</ul>'	
							+'</div>';
				}	
				if(snk_list!=null && snk_list.length>0){
					html += '<div>'
								+'<div class="c_flex" style="margin:0 0 1rem 0; align-items: center;">'
									+'<div class="c_flex" style="margin: auto 0; padding-right: 1rem;">'
										+'<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">'+'<path fill-rule="evenodd" d="M20.15 10.15c-1.59 1.59-3.74 2.09-5.27 1.38L13.41 13l6.88 6.88-1.41 1.41L12 14.41l-6.89 6.87-1.41-1.41 9.76-9.76c-.71-1.53-.21-3.68 1.38-5.27 1.92-1.91 4.66-2.27 6.12-.81 1.47 1.47 1.1 4.21-.81 6.12zm-9.22.36L8.1 13.34 3.91 9.16a4 4 0 0 1 0-5.66l7.02 7.01z" clip-rule="evenodd"></path></svg>'
									+'</div>'
									+'<h3 class="c_h3_head6">'+'객실 내 다과'+'</h3>'
								+'</div>'
								+'<ul class="c_grid" style="gap: 0.6rem;">';
					$.each(snk_list, function(index, item){
						html += '<li class="c_li_dot" style="font-size: 0.5rem; padding-left: 1rem;"><span class="c_txt-300" style="padding-left: 0.2rem;">'+item.snk_opt_desc+'</span></li>';
					});							
					html +=		'</ul>'	
							+'</div>';
				}	
				if(ent_list!=null && ent_list.length>0){
					html += '<div>'
								+'<div class="c_flex" style="margin:0 0 1rem 0; align-items: center;">'
									+'<div class="c_flex" style="margin: auto 0; padding-right: 1rem;">'
										+'<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">'+'<path d="M9 16.17 4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41L9 16.17z">'+'</path>'+'</svg>'
									+'</div>'
									+'<h3 class="c_h3_head6">'+'엔터테인먼트'+'</h3>'
								+'</div>'
								+'<ul class="c_grid" style="gap: 0.6rem;">';
					$.each(ent_list, function(index, item){
						html += '<li class="c_li_dot" style="font-size: 0.5rem; padding-left: 1rem;"><span class="c_txt-300" style="padding-left: 0.2rem;">'+item.ent_opt_desc+'</span></li>';
					});							
					html +=		'</ul>'	
							+'</div>';
				}	
				if(tmp_list!=null && tmp_list.length>0){
					html += '<div>'
								+'<div class="c_flex" style="margin:0 0 1rem 0; align-items: center;">'
									+'<div class="c_flex" style="margin: auto 0; padding-right: 1rem;">'
										+'<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">'+'<path d="M9 16.17 4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41L9 16.17z">'+'</path>'+'</svg>'
									+'</div>'
									+'<h3 class="c_h3_head6">'+'온도조절기'+'</h3>'
								+'</div>'
								+'<ul class="c_grid" style="gap: 0.6rem;">';
					$.each(tmp_list, function(index, item){
						html += '<li class="c_li_dot" style="font-size: 0.5rem; padding-left: 1rem;"><span class="c_txt-300" style="padding-left: 0.2rem;">'+item.tmp_opt_desc+'</span></li>';
					});							
					html +=		'</ul>'	
							+'</div>';
				}	
				
				if(l_rmsvc_list!=null && l_rmsvc_list.length>0){
					html += '<div>'
								+'<div class="c_flex" style="margin:0 0 1rem 0; align-items: center;">'
									+'<div class="c_flex" style="margin: auto 0; padding-right: 1rem;">'
										+'<svg class="c_icon_24" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">'+'<path d="M9 16.17 4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41L9 16.17z">'+'</path>'+'</svg>'
									+'</div>'
									+'<h3 class="c_h3_head6">'+'기타'+'</h3>'
								+'</div>'
								+'<ul class="c_grid" style="gap: 0.6rem;">';
					$.each(l_rmsvc_list, function(index, item){
						html += '<li class="c_li_dot" style="font-size: 0.5rem; padding-left: 1rem;"><span class="c_txt-300" style="padding-left: 0.2rem;">'+item.rmsvc_opt_desc+'</span></li>';
					});							
					html +=		'</ul>'	
							+'</div>';
				}

					html += '</div>'
						+'</div>'
						+'<div id="m_rm_opt" style="padding-top: 1.5rem;">'
							+'<div class="c_border_all c_grid" style="padding: 0.875rem;">'
								+'<div>'
									+'<h3 class="c_h3_head5" style="padding-bottom: 0.75rem;">객실 옵션</h3>'
								+'</div>'
								+'<div class="c_grid" style=" gap: 0.5rem;">'
									+'<div class="c_grid c_txt-300" style="padding-top: 0.4rem;">'
										+'<span style="color: #227950; padding-right: 1.5rem;">전액 환불가능</span>'
										+'<div style="font-size:0.75rem;">'+'<span>'+'1월 8일(월)'+'</span> 전까지</div>'
									+'</div>'
									+'<div>'
										+'<div class="c_flex" style="gap: 0.3rem; align-items: center;">'
											+'<div class="c_h3_head5" style="font-weight: bold;">₩'+price_one_night+'</div>'
					if(d_rate!='0'){
						html +=	'<div class="c_content_txt" style="text-decoration: underline line-through;">₩'+price_one_night_before_sale+'</div>'
					}
											
					html +=				'</div>'
										+'<div class="c_txt_sm">총 요금: ₩'+ttl_price+'</div>'
										+'<div class="c_txt_sm">세금 및 수수료 포함</div>'
										+'<div class="c_flex" style="justify-content: space-between;">'
											+'<div id="view_price_detail_btn2" class="price_detail c_text_link_m c_flex" style="align-items: end;" onclick="javascript:goPriceDetail(\''+rm_info.rm_price+'\',\''+rm_seq+'\')">'
												+'<span>요금 세부 정보</span>'
												+'<svg class="c_icon_18" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">'+'<path fill="#1668e3" d="M10 6 8.59 7.41 13.17 12l-4.58 4.59L10 18l6-6-6-6z">'+'</path>'+'</svg>'
											+'</div>'
											+'<div class="room_rsv_btn" style="margin-top: auto;">'
												+'<div class="c_flex">'
													+'<button class="c_btn_pri" style="width: 6.5rem; height: 2.2rem; margin: auto 0;" onclick="go_reservation(\''+rm_info.rm_price*(1-d_rate)+'\',\''+rm_seq+'\')">예약하기</button>'
												+'</div>'
											+'</div>'	
										+'</div>'
									+'</div>'
								+'</div>'
							+'</div>'
						+'</div>'
					+'</div>'
				+'</div>'
			+'</div>'
		+'</div>';
			
			
			$("div#view_rm_detail").html(html);
			 
			// 모달 창 띄우기
			$("div#view_rm_detail_info").css("display","flex");
			document.body.style.overflow = 'hidden';
			
			
			// x 버튼 누르거나 바깥 누르면 사라지도록!
			const view_rm_detail_modal = document.getElementById('view_rm_detail_info');
			const m_close_btn_rm = document.getElementById('m_close_btn_rm');
			
			m_close_btn_rm.onclick = function() {
				view_rm_detail_modal.style.display = 'none';
			  	document.body.style.overflow = 'auto';
			}
			
			window.onclick = function(e) {
			  if (e.target == view_rm_detail_modal) {
				view_rm_detail_modal.style.display = "none";
			    document.body.style.overflow = 'auto';
			    
			  }
			}			
			
			 
		 },
		 
		 error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		 }
	 });
	
}


function goPriceDetail(st_price, rm_seq) {

	const price = Math.ceil(Number(st_price)).toLocaleString('en');
	const d_rate = ${d_rate};
	const d_rate_per = d_rate*100;
	const d_rate_price = st_price*stay_night*d_rate;
	const price_all_night = Math.ceil(st_price*stay_night*(1-d_rate)).toLocaleString('en');	
	const tax = Math.ceil(st_price*stay_night*0.1).toLocaleString('en');
	const ttl_price = Math.ceil(st_price*0.1*stay_night + st_price*stay_night*(1-d_rate)).toLocaleString('en');
	
	let html = '<div class="c_modalWrap_sm">'					
		+'<div class="c_flex modalTop_close" style="block-size: 3rem; height:auto; align-items: center;">'					
		+'<button type="button" id="m_close_btn_pd" class="c_flex modal_close_btn" style="block-size: 3rem; inline-size: 3rem;">'				
			+'<span class="c_round_btn_blue c_flex" style="block-size: 2.3rem; inline-size: 2.3rem; margin: auto;">'			
				+'<svg class="c_icon_24" style="margin: auto;" aria-label="닫기" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><title id="undefined-close-toolbar-title">닫기.</title><path fill="#1668e3" d="M19 6.41 17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12 19 6.41z"></path></svg>'		
			+'</span>'			
		+'</button>'				
		+'요금 세부 정보'
	+'</div>'					
	+'<div id="priceDetail" class="c_grid" style="padding: 1.5rem; gap: 1.5rem; overflow-y: auto;">'					
		+'<div class="c_flex" style="flex-direction: column; gap:0.6rem;">'				
			+'<div>'			
				+"<c:set var='price' value='10'/>"
				+'<div class="c_flex" style="justify-content: space-between;">'		
					+'<div class="c_content_txt">${stay_night}박</div>'	
					+'<div class="c_content_txt">₩'+price_all_night+'</div>'	
				+'</div>'		
				+'<div class="c_flex" style="padding-left:0.5rem; flex-direction: column;">'		
					+'<div class="c_txt_sm">₩'+price+'/1박</div>';
	if(d_rate!='0'){
		html +=	'<div class="c_txt_sm">회원 할인 '+d_rate_per+'% 할인 <span style="color:#227950;">-₩'+d_rate_price+'</span></div>'	
	}		
	
	html +=		'</div>'		
			+'</div>'			
			+'<div class="c_flex" style="justify-content: space-between;">'			
				+'<div class="c_flex" style="padding-top: 0.4rem;">'		
					+'<span class="c_content_txt">세금 및 수수료</span>'	
					+'<div class="c_flex" style="margin: auto 0; padding-left: 0.5rem;">'	
						+'<svg class="c_icon_18" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill-rule="evenodd" d="M2 12a10 10 0 1 1 20 0 10 10 0 0 1-20 0zm11-1v6h-2v-6h2zm-1 9a8.01 8.01 0 0 1 0-16 8.01 8.01 0 0 1 0 16zm1-13v2h-2V7h2z" clip-rule="evenodd"></path></svg>'
					+'</div>'	
				+'</div>'		
				+'<div class="c_content_txt">₩'+tax+'</div>'		
			+'</div>'			
		+'</div>'				
		+'<div class="c_border_btm" style="width: 100%;"></div>'				
		+'<div>'				
			+'<div class="c_flex" style="flex-direction: column; gap:1.5rem;">'			
				+'<div class="c_flex" style="justify-content: space-between;">'		
					+'<div class="c_h3_head6">총금액</div>'	
					+'<div class="c_h3_head6" style=" font-weight: bold;">'+ttl_price+'</div>'	
				+'</div>'		
				+'<div class="room_rsv_btn" style="margin-top: auto;">'		
					+'<div class="c_flex">'	
						+'<button class="c_btn_pri" style="width: 100%; height: 2.4rem; margin: auto 0;"onclick="go_reservation(\''+st_price+'\',\''+rm_seq+'\')">예약하기</button>'
					+'</div>'	
				+'</div>'		
			+'</div>'			
		+'</div>'				
	+'</div>'					
	+'</div>';
			
	
	$("div#view_price_detail").html(html);

	const view_price_detail = document.getElementById('view_price_detail');
	const view_rm_detail_info_modal = document.getElementById('view_rm_detail_info');
	const m_close_btn_pd = document.getElementById('m_close_btn_pd');
	view_price_detail.style.display="flex";
	document.body.style.overflow = 'hidden';
	
	// 객실 상세 모달창 없을때 요금상세 페이지 닫을 시(요금상세 모달 밖의 body 클릭) overflow auto 로 변경해준다.
	window.onclick = function(e) {
	  if (e.target == view_price_detail) {
		  view_price_detail.style.display = "none";
		  if(view_rm_detail_info_modal == null){
		  		document.body.style.overflow = 'auto';
		  	}
		  else if(view_rm_detail_info_modal.style.display == 'none'){
				document.body.style.overflow = 'auto';
			}
	  }
	}
	
	// 객실 상세 모달창 없을때 요금상세 페이지 닫을 시(x 클릭) overflow auto 로 변경해준다. 
	m_close_btn_pd.onclick = function() {
		view_price_detail.style.display = 'none';
		if(view_rm_detail_info_modal == null){
	  		document.body.style.overflow = 'auto';
	  	}
		else if(view_rm_detail_info_modal.style.display == 'none'){
			document.body.style.overflow = 'auto';
		}

	}
	
}



</script>