<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	String ctxPath = request.getContextPath();
    //      /expedia
%>  

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/css/jh/hotel/hotelSearch.css" />

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		// 재훈 : 넘어온 최초 검색 조건들을 통해 숙박시설 리스트 보여주기
		ajax_form_search();
		
		// 재훈 : 페이지 로드시 검색화면 가리기
		$("div#div_destination_search").hide();
		
		// 재훈 : 목적지 검색창 클릭시 검색화면 보이기
		$("div#btn_destination").click(function(e) {
			$("div#div_destination_search").show();
			$("input#input_destination_search").val($("input#input_destination").val());
			$("input#input_destination_search").focus();
		});
		
		// 재훈 : 검색창에 keyup시 검색하기
		$("input#input_destination_search").bind("keyup",function(){
			var searchWord = $(this).val();
			// console.log("확인용 searchWord : " + searchWord);
			
			if(searchWord != ""){
				$.ajax({
					url:"<%= ctxPath%>/index/destination_search.action",
					data:{"searchWord":searchWord},
					dataType:"json",
					success : function(json){
						
						var searchResultArr = [];
						
						// '제' 검색시 나오는 결과
						console.log(JSON.stringify(json))
						/*
							[{"lg_nation":"한국","lg_area":"제주특별자치도"}
							,{"lg_nation":"한국","lg_area_2":"제주시","lg_area":"제주특별자치도"}
							,{"lg_nation":"한국","lg_area_2":"서귀포시","lg_area":"제주특별자치도","lg_name":"제주신라호텔"}]
						*/
						
				    	// console.log(json.length);
						// 5
						
					
						if(json.length > 0){
						
							$.each(json, function(index,item){
								// 호텔 검색결과인 경우
								if(item.lg_name != null){
									searchResultArr.push({
										value: item.lg_name+"("+item.lg_area_2+", "+item.lg_area+", "+item.lg_nation+")",
										name: item.lg_name,
										area_2: item.lg_area_2,
										area: item.lg_area,
										nation: item.nation
				                	});
								}
								// 상세도시 검색결과인 경우
								else if(item.lg_area_2 != null){
									searchResultArr.push({
										value: item.lg_area_2+"("+item.lg_area+", "+item.lg_nation+")",
										name: "",
										area_2: item.lg_area_2,
										area: item.lg_area,
										nation: item.nation
				                	});
								}
								// 큰 도시 검색결과인 경우
								else{
									searchResultArr.push({
										value: item.lg_area+"("+item.lg_nation+")",
										name: "",
										area_2: "",
										area: item.lg_area,
										nation: item.lg_nation
				                	});
								}
									
								console.log(searchResultArr)
								
							}); // end of $.each(json, function(index,item)
							
							$("input#input_destination_search").autocomplete({  // 참조 https://jqueryui.com/autocomplete/#default
								source:searchResultArr,
								select: function(event, ui) {       // 자동완성 되어 나온 공유자이름을 마우스로 클릭할 경우 
									$("input#input_destination").val(ui.item.value);
									// console.log(ui.item.value)
									$("input[name='lg_name']").val(ui.item.name);
									$("input[name='lg_area_2']").val(ui.item.area_2);
									$("input[name='lg_area']").val(ui.item.area);
									
									$("div#div_destination_search").hide(); 
									return false;
						        },
						        focus: function(event, ui) {
						            return false;
						        }
							});
							
						}// end of if------------------------------------
						
					}// end of success-----------------------------------
					
				});// end of ajax
				
			} // end of if(searchWord != "")
			
		}); // end of $("input#input_destination_search").bind("keyup",function(){
			
		// 재훈 : flatpickr 한글로 변경
		flatpickr.localize(flatpickr.l10ns.ko);
		
		// 재훈 : flatpickr로 달력만들기
		dateSelector();
		// 2023-12-05 ~ 2023-12-06 형식으로 나옴.
		
		
		// 재훈 : 페이지 로드시 인원 선택창 가리기
		$("div#travler_select").hide();
	
		// 재훈 : 인원 선택창 클릭시 선택화면 보이기
		$("div#box_travler").click(function(e) {
			$("div#travler_select").show();
		});
		
		// 재훈 : 페이지 로드시 전체인원 추가하기
		if(${requestScope.map.travlers} != ""){
			$("span#total_travler").text(${requestScope.map.travlers});
		}
		
		// 재훈 : 인원 선택창 클릭시 선택화면 보이기
		$("button[name='btn_travler']").click(function(e) {
			$("div#travler_select").hide();
			$("span#total_travler").text($("input[name='travlers']").val());
		});
		
		// 재훈 : 페이지 로드시 인원 선택 버튼 클래스 추가
		$("button[name='btn_travler']").addClass("btn_travler_ok");
		
		// 재훈 : 페이지 로드시 span#total_travler의 기본 인원수를 hidden input[name='travlers']에 넣어주기
		$("input[name='travlers']").val(${requestScope.map.travlers});
		
		// 재훈 : 페이지 로드시 인원선택창에 기본값을 띄워주기
		$("input.adult_cnt_select").val(${requestScope.map.adult});
		$("input.kid_cnt_select").val(${requestScope.map.kid});
		$("input[name='adult']").val(${requestScope.map.adult});
		$("input[name='kid']").val(${requestScope.map.kid});

		// 재훈 : 인원선택창이 0인 경우 버튼 disabled로 변경
		if(Number($("input.kid_cnt_select").val()) == 0){
			$("button.kid_cnt_minus").addClass("border","solid 1px lightgray");
		}
		if(Number($("input.adult_cnt_select").val()) == 0){
			$("button.adult_cnt_minus").addClass("border","solid 1px lightgray");
		}
		
		// 재훈 : 인원선택창에서 더하기 빼기 클릿기 인원수 변경하기
		// 어른 인원수 마이너스하기
		$("button.adult_cnt_minus").click(function(){
			
			var adult_cnt = Number($("input.adult_cnt_select").val());
			var kid_cnt = Number($("input.kid_cnt_select").val());
			
			// 어른 인원수가 0일 경우
			if(adult_cnt == 0){
				return;
			}
			// 어른 인원수가 0이 아닐 경우
			else{
				// 어른 마이너스 버튼 활성화
				$("button.adult_cnt_minus").removeClass("border","solid 1px lightgray");
				
				// 어른 인원수가 10일 경우
				if($("input.adult_cnt_select").val() == 10){
					$("button.adult_cnt_plus").removeClass("border","solid 1px lightgray");
				}
				
				if(adult_cnt == 1){
					return;
				}
				
				// 어른 인원수에서 -1
				$("input.adult_cnt_select").val(adult_cnt - 1);
				
				// 어른 인원수에서 -1 한 값을 어른 인원수에 넣어줌
				adult_cnt = Number($("input.adult_cnt_select").val());
				$("input[name='adult']").val(adult_cnt);
				
				// 어른 인원수와 아동 인원수가 10 이하인 경우 경고 숨김
				if(adult_cnt + kid_cnt <= 10){
					$("div#travler_alert").text("");
					$("button[name='btn_travler']").attr("disabled", false);
					$("button[name='btn_travler']").removeClass("btn_travler_no");
					$("button[name='btn_travler']").addClass("btn_travler_ok");
				}
				else{
					$("div#travler_alert").text("예약 인원은 최소 1인, 최대 10인입니다.");
					$("button[name='btn_travler']").attr("disabled", true);
					$("button[name='btn_travler']").removeClass("btn_travler_ok");
					$("button[name='btn_travler']").addClass("btn_travler_no");
				}
				
				// 어른 인원수와 아동 인원수가 10 이하인 경우 경고 보여주기
				if(adult_cnt + kid_cnt == 0){
					$("div#travler_alert").text("예약 인원은 최소 1인, 최대 10인입니다.");
					$("button[name='btn_travler']").attr("disabled", true);
					$("button[name='btn_travler']").removeClass("btn_travler_ok");
					$("button[name='btn_travler']").addClass("btn_travler_no");
				}
				
				if(adult_cnt == 1){
					$("button.adult_cnt_minus").addClass("border","solid 1px lightgray");
				}
				
				if($("input[name='travlers']").val() > 0 && adult_cnt + kid_cnt <=10){
					$("input[name='travlers']").val(adult_cnt + kid_cnt);
				}
				
			}
			
		})
		
		// 어른 인원수 플러스하기
		$("button.adult_cnt_plus").click(function(){
			
			var adult_cnt = Number($("input.adult_cnt_select").val());
			var kid_cnt = Number($("input.kid_cnt_select").val());
			
			if(adult_cnt >= 10){
				return;
			}
			else{
				// 어른 인원 추가 버튼 활성화
				$("button.adult_cnt_plus").removeClass("border","solid 1px lightgray");

				// 어른 인원수가 0인 경우 
				if($("input.adult_cnt_select").val() == 0){
					$("button.adult_cnt_minus").removeClass("border","solid 1px lightgray");
				}
				
				$("input.adult_cnt_select").val(adult_cnt + 1);
				
				adult_cnt = Number($("input.adult_cnt_select").val());
				$("input[name='adult']").val(adult_cnt);
				
				if(adult_cnt + kid_cnt > 10){
					$("div#travler_alert").text("예약 인원은 최소 1인, 최대 10인입니다.");
					$("button[name='btn_travler']").attr("disabled", true);
					$("button[name='btn_travler']").removeClass("btn_travler_ok");
					$("button[name='btn_travler']").addClass("btn_travler_no");
				}
				else{
					$("div#travler_alert").text("");
					$("button[name='btn_travler']").attr("disabled", false);
					$("button[name='btn_travler']").addClass("btn_travler_ok");
					$("button[name='btn_travler']").removeClass("btn_travler_no");
				}
				
				if($("input.adult_cnt_select").val() == 10){
					$("button.adult_cnt_plus").addClass("border","solid 1px lightgray");
				}
				
				if($("input[name='travlers']").val() < 10){
					$("input[name='travlers']").val(adult_cnt + kid_cnt);
				}
				
			}
			
		})
		
		// 아동 인원수 마이너스하기
		$("button.kid_cnt_minus").click(function(){
			
			var adult_cnt = Number($("input.adult_cnt_select").val());
			var kid_cnt = Number($("input.kid_cnt_select").val());
			
			if(kid_cnt == 0){
				return;
			}
			else{
				$("button.kid_cnt_minus").removeClass("border","solid 1px lightgray");
				
				if($("input.kid_cnt_select").val() == 10){
					$("button.kid_cnt_plus").removeClass("border","solid 1px lightgray");
				}
				
				$("input.kid_cnt_select").val(kid_cnt - 1);
				
				kid_cnt = Number($("input.kid_cnt_select").val());
				$("input[name='kid']").val(kid_cnt);
				
				if(adult_cnt + kid_cnt <= 10){
					$("div#travler_alert").text("");
					$("button[name='btn_travler']").attr("disabled", false);
					$("button[name='btn_travler']").removeClass("btn_travler_no");
					$("button[name='btn_travler']").addClass("btn_travler_ok");
				}
				else{
					$("div#travler_alert").text("예약 인원은 최소 1인, 최대 10인입니다.");
					$("button[name='btn_travler']").attr("disabled", true);
					$("button[name='btn_travler']").removeClass("btn_travler_ok");
					$("button[name='btn_travler']").addClass("btn_travler_no");
				}
				
				if(adult_cnt + kid_cnt == 0){
					$("div#travler_alert").text("예약 인원은 최소 1인, 최대 10인입니다.");
					$("button[name='btn_travler']").attr("disabled", true);
					$("button[name='btn_travler']").removeClass("btn_travler_ok");
					$("button[name='btn_travler']").addClass("btn_travler_no");
				}
				
				if(Number($("input.kid_cnt_select").val()) == 0){
					$("button.kid_cnt_minus").addClass("border","solid 1px lightgray");
				}
				
				if($("input[name='travlers']").val() > 0 && adult_cnt + kid_cnt <=10){
					$("input[name='travlers']").val(adult_cnt + kid_cnt);
				}
				
			}
			
		})
		
		// 아동 인원수 플러스하기
		$("button.kid_cnt_plus").click(function(){
			
			var adult_cnt = Number($("input.adult_cnt_select").val());
			var kid_cnt = Number($("input.kid_cnt_select").val());
			
			if(kid_cnt >= 10){
				return;
			}
			else{
				$("button.kid_cnt_plus").removeClass("border","solid 1px lightgray");
				
				if($("input.kid_cnt_select").val() == 0){
					$("button.kid_cnt_minus").removeClass("border","solid 1px lightgray");
				}
				
				$("input.kid_cnt_select").val(kid_cnt + 1);
				
				kid_cnt = Number($("input.kid_cnt_select").val());
				$("input[name='kid']").val(kid_cnt);
				
				if(adult_cnt + kid_cnt > 10){
					$("div#travler_alert").text("예약 인원은 최소 1인, 최대 10인입니다.");
					$("button[name='btn_travler']").attr("disabled", true);
					$("button[name='btn_travler']").removeClass("btn_travler_ok");
					$("button[name='btn_travler']").addClass("btn_travler_no");
				}
				else{
					$("div#travler_alert").text("");
					$("button[name='btn_travler']").attr("disabled", false);
					$("button[name='btn_travler']").addClass("btn_travler_ok");
					$("button[name='btn_travler']").removeClass("btn_travler_no");
				}
				
				if($("input.kid_cnt_select").val() == 10){
					$("button.kid_cnt_plus").addClass("border","solid 1px lightgray");
				}
				
				if($("input[name='travlers']").val() < 10){
					$("input[name='travlers']").val(adult_cnt + kid_cnt);
				}
				
			}
			
		});
		
		// 재훈 : 검색버튼 클릭시 flatpickr를 통해 나온 값의 형태를 변경시켜주기
		$("button[name='btn_search']").click(function(){
			
			// =========== 목적지 검색 유효성 검사하기 시작 =========== //
			var searchWord = $("input#input_destination").val();
			
			if(searchWord == ""){
				alert("검색어를 입력하셔야합니다.");
				return;
			}
			
			// =========== 목적지 검색 유효성 검사하기 끝 =========== //
			
			
			// =========== 날짜 검색 유효성 검사 시작 =========== //
			var date_val = $("input#input_date").val();
			var date_val_arr = date_val.split(" ~ ");
			// 2023-12-05 ~ 2023-12-06
			
			if(date_val_arr.length != 2){
				alert("출발일과 도착일 모두 설정하셔야 합니다.");
				return;
			}
			
			var start_date;
			var finish_date;
			
			for(var i=0; i<date_val_arr.length; i++){
				if(i==0){
					start_date = date_val_arr[i];
				}
				else{
					finish_date = date_val_arr[i];
				}
			}
			// console.log("start_date : ", start_date);
			// 2023-12-05
			// console.log("finish_date : ", finish_date);
			// 2023-12-06

			$("input[name='check_in']").val(start_date);
			$("input[name='check_out']").val(finish_date);
			// =========== 날짜 검색 유효성 검사 끝 =========== //
			
			const frm = document.searchFrm;
			frm.submit(); 
			
		});
	
		//////////////////////////////////////////////////////////////////////////
		//////////////////////////////////////////////////////////////////////////
		//////////////////////////////////////////////////////////////////////////
		
		// 재훈 : 필터 form 만들기
		
		// 재훈 : 금액으로 form 보내기
		// =========== 금액으로 form 보내기 시작 =========== //
		// 최저가 인풋 클릭시
		$("input#search_price_min").click(function(){
			
			const default_min_price = $("input[name='price_min']").val();
			
			// 최저가 인풋 비워주기
			$("input#search_price_min").val("");
			
			// 최저가 인풋에서 블러했을때
			$("input#search_price_min").blur((e) => {

				// 값 미입력시
				if($("input#search_price_min").val() == ""){
					$("input#search_price_min").val(default_min_price);
				}
				// 값 입력시
				else{
					$("input[name='price_min']").val($("input#search_price_min").val());
					
					filter_search();
				}
			})
		}); // end of $("input#search_price_min").click(function(){});
		
		// 최고가 인풋 클릭시
		$("input#search_price_max").click(function(){
			
			const default_max_price = $("input[name='price_max']").val();
			
			// 최고가 인풋 비워주기
			$("input#search_price_max").val("");
			
			// 최고가 인풋에서 블러했을때
			$("input#search_price_max").blur((e) => {
				
				// 값 미입력시
				if($("input#search_price_max").val() == ""){
					$("input#search_price_max").val(default_max_price);
				}
				// 값 입력시
				else{
					$("input[name='price_max']").val($("input#search_price_max").val());
					
					filter_search();
				}
			})
		}); // end of $("input#search_price_max").click(function(){});
		// =========== 금액으로 form 보내기 끝 =========== //
		
		
		
		
		
		//////////////////////////////////////////////////////////////////////////
		//////////////////////////////////////////////////////////////////////////
		//////////////////////////////////////////////////////////////////////////
		
		
		// 클릭한 체크박스의 호텔등급을 배열로 만들기
		$("input.lg_star").click(function(){
			var star_arr = [];
			var star = "";
			
			if($("input.lg_star:checked").length > 0){
				for(var i=0; i<$("input.lg_star:checked").length; i++){
					star_arr.push($("input.lg_star:checked").eq(i).val());
				 }
			}
			star = star_arr.join(",");
			$("input[name='lg_star']").val(star);
			
			filter_search();
		});
		
		// 로드될경우 클릭했던 성급에 체크하기
		if ("${requestScope.map.lg_star}" != "" && "${requestScope.map.lg_star}" != "null") {
			var star = "${requestScope.map.lg_star}";
			var star_arr = star.split(",");
			for(var i=0; i<$("input.lg_star").length; i++){
				for(var j=0; j<star_arr.length; j++){
					if($("input.lg_star").eq(i).val() == star_arr[j]){
						$("input.lg_star").eq(i).prop('checked', true);
					}
				}
			}
		}
		
		if($("input[name='lg_star']").val() != ""){
			var star_arr = star.split(",");
			for(var i=0; i<$("input.lg_star").length; i++){
				for(var j=0; j<star_arr.length; j++){
					if($("input.lg_star").eq(i).val() == star_arr[j]){
						$("input.lg_star").eq(i).prop('checked', true);
					}
				}
			}
		}
		// =========== 호텔등급으로 form 보내기   끝 =========== //

		
		// =========== 시설타입으로 form 보내기 시작 =========== //
		// 클릭한 체크박스의 시설타입을 배열로 만들기
		$("input.lodge_type").click(function(){
			var lodge_type_arr = [];
			var lodge_type = "";
			
			if($("input.lodge_type:checked").length > 0){
				for(var i=0; i<$("input.lodge_type:checked").length; i++){
					lodge_type_arr.push($("input.lodge_type:checked").eq(i).val());
				 }
			}
			lodge_type = lodge_type_arr.join(",");
			$("input[name='lodge_type']").val(lodge_type);
			
			filter_search();
		});
		
		// 로드될경우 클릭했던 시설타입에 체크하기
		if ("${requestScope.map.lodge_type}" != "" && "${requestScope.map.lodge_type}" != "null") {
			var lodge_type = "${requestScope.map.lodge_type}";
			var lodge_type_arr = lodge_type.split(",");
			for(var i=0; i<$("input.lodge_type").length; i++){
				for(var j=0; j<lodge_type_arr.length; j++){
					if($("input.lodge_type").eq(i).val() == lodge_type_arr[j]){
						$("input.lodge_type").eq(i).prop('checked', true);
					}
				}
			}
		}
		
		if($("input[name='lodge_type']").val() != ""){
			var lodge_type_arr = lodge_type.split(",");
			for(var i=0; i<$("input.lodge_type").length; i++){
				for(var j=0; j<lodge_type_arr.length; j++){
					if($("input.lodge_type").eq(i).val() == star_arr[j]){
						$("input.lodge_type").eq(i).prop('checked', true);
					}
				}
			}
		}
		// =========== 시설타입으로 form 보내기   끝 =========== //
		
		
		// =========== 편의시설 종류로 form 보내기 시작 =========== //
		
		// 간단히 보기 숨기기
		$("span.read_less").parent().hide();
		
		// 페이지 로드시 
		for(var i=0; i<$("input.amenities").length; i++){
			if(i>2){
				// 3개까지만 보여주고 나머지는 숨기기
				$("input.amenities").eq(i).parent().hide();
			}
		};
		
		// 더 보기 클릭시
		$("span.read_more").click(function(){
			view_more();
		});
		
		// 간단히 보기 클릭시
		$("span.read_less").click(function(){
			view_less();
		});
		
		// 체크박스 클릭시 보내주기
		$("input.amenities").click(function(e){
			filter_search();
		});
		
		// 로드될경우 클릭했던 편의시설 종류에 체크하기
		//	- 조식
		if ("${requestScope.map.breakfast}" != "off" && "${requestScope.map.breakfast}" != "null") {
			$("input[name='breakfast']").prop('checked', true);
		}
		//	- 수영장
		if ("${requestScope.map.pool}" != "off" && "${requestScope.map.pool}" != "null") {
			$("input[name='pool']").prop('checked', true);
		}
		//	- 와이파이
		if ("${requestScope.map.wifi}" != "off" && "${requestScope.map.wifi}" != "null") {
			$("input[name='wifi']").prop('checked', true);
		}
		//	- 바다 전망
		if ("${requestScope.map.seaView}" != "off" && "${requestScope.map.seaView}" != "null") {
			$("input[name='seaView']").prop('checked', true);
		}
		//	- 반려동물
		if ("${requestScope.map.pet}" != "off" && "${requestScope.map.pet}" != "null") {
			$("input[name='pet']").prop('checked', true);
		}
		//	- 스파
		if ("${requestScope.map.spa}" != "off" && "${requestScope.map.spa}" != "null") {
			$("input[name='spa']").prop('checked', true);
		}
		//	- 주차
		if ("${requestScope.map.parking}" != "off" && "${requestScope.map.parking}" != "null") {
			$("input[name='parking']").prop('checked', true);
		}
		//	- 주방
		if ("${requestScope.map.kitchen}" != "off" && "${requestScope.map.kitchen}" != "null") {
			$("input[name='kitchen']").prop('checked', true);
		}
		//	- 에어컨
		if ("${requestScope.map.aircon}" != "off" && "${requestScope.map.aircon}" != "null") {
			$("input[name='aircon']").prop('checked', true);
		}
		//	- 레스토랑
		if ("${requestScope.map.restaurant}" != "off" && "${requestScope.map.restaurant}" != "null") {
			$("input[name='restaurant']").prop('checked', true);
		}
		//	- 유아용 침대
		if ("${requestScope.map.babyBed}" != "off" && "${requestScope.map.babyBed}" != "null") {
			$("input[name='babyBed']").prop('checked', true);
		}
		//	- 세탁기 및 건조대
		if ("${requestScope.map.washerDryer}" != "off" && "${requestScope.map.washerDryer}" != "null") {
			$("input[name='washerDryer']").prop('checked', true);
		}
		
		for(var i=0; i<$("input.amenities:checked").length; i++){
			var checked_name = $("input.amenities:checked").eq(i).attr("name");

			for(var j=0; j<$("input.amenities").length; j++){
				var name = $("input.amenities").eq(j).attr("name");
				if(name == checked_name){
					if(j > 2){
						view_more();
					}
				}
			}
		}
		// =========== 편의시설 종류로 form 보내기   끝 =========== //
		
		
		// =========== 고객 평점으로 form 보내기 시작 =========== //
		// 로드될 경우
		if("${requestScope.map.rating}" == "" || "${requestScope.map.rating}" == "null"){
			// 보낸 평점이 없는 경우 전체보기 radio에  checked
			$("input.rating_all").prop("checked", true);
		}
		
		// 보낸 평점이 있는 경우 해당 radio에  checked
		for(var i=0; i<$("input[name='rating']").length; i++){
			if($("input[name='rating']").eq(i).val() == "${requestScope.map.rating}"){
				$("input[name='rating']").eq(i).prop("checked", true);
			}
			else{
				$("input[name='rating']").eq(i).prop("checked", false);
			}
		}
		
		// 체크박스 클릭시 보내주기
		$("input[name='rating']").click(function(e){
			filter_search();
		});
		// =========== 고객 평점으로 form 보내기    끝 =========== //
		
		
		// =========== 정렬순서 form 보내기 시작 =========== //
		// select 변경시 보내주기
		$(document).on("change", "select[name='sort']", function(){
			filter_search();
		})
		
		// 보낸 평점이 있는 경우 해당 radio에  checked
		for(var i=0; i<$("option.sort_item").length; i++){
			if($("option.sort_item").eq(i).val() == "${requestScope.map.sort}"){
				$("option.sort_item").eq(i).prop("selected", true);
			}
			else{
				$("option.sort_item").eq(i).prop("selected", false);
			}
		}
		// =========== 정렬순서 form 보내기    끝 =========== //
		
		
		// =========== 숙소 상세 페이지로 보내기 시작 =========== //
		// 숙소 설명란 클릭시
		$(document).on("click", "div.search_item_desc", function(){
			
			$("form[name='go_detail_frm']").find("input[name=lodge_id]").val($(this).find(".lodge_id").val());
			$("form[name='go_detail_frm']").find("input[name=startDate]").val($(this).find(".check_in").val());
			$("form[name='go_detail_frm']").find("input[name=endDate]").val($(this).find(".check_out").val());
			
			$("form[name='go_detail_frm']").find("input[name=guest]").val(${requestScope.map.travlers});
			$("form[name='go_detail_frm']").find("input[name=adults]").val(${requestScope.map.adult});
			$("form[name='go_detail_frm']").find("input[name=childs]").val(${requestScope.map.kid});
			
			const frm = document.go_detail_frm;
			frm.action = "<%= ctxPath%>/lodgeDetail_info.exp";
			frm.submit();
			
		});
		// 숙소 이미지 클릭시
		$(document).on("click", "div.carousel-inner", function(){
			
			$("form[name='go_detail_frm']").find("input[name=lodge_id]").val($(this).parent().parent().parent().find(".lodge_id").val());
			$("form[name='go_detail_frm']").find("input[name=startDate]").val($(this).parent().parent().parent().find(".check_in").val());
			$("form[name='go_detail_frm']").find("input[name=endDate]").val($(this).parent().parent().parent().find(".check_out").val());
			
			$("form[name='go_detail_frm']").find("input[name=guest]").val(${requestScope.map.travlers});
			$("form[name='go_detail_frm']").find("input[name=adults]").val(${requestScope.map.adult});
			$("form[name='go_detail_frm']").find("input[name=childs]").val(${requestScope.map.kid});
			
			const frm = document.go_detail_frm;
			frm.action = "<%= ctxPath%>/lodgeDetail_info.exp";
			frm.submit();
			
		});
		// =========== 숙소 상세 페이지로 보내기 시작 =========== //
		
		
		// 재훈 : 위시리스트 버튼 클릭시
		// =========== 위시리스트 버튼을 클릭하면 테이블에 insert 하기 시작 =========== //
		$(document).on("click", "div.add_wishlist_btn", function(){
			
			var wishlist_status = $(this).find("input.wishlist_status").val()
			
			// 비워진 하트라면 추가하기
			if(wishlist_status != "fill_heart"){
				// 위시리스트 삭제 ajax
				
				var wishlist_lodge_id = $(this).find("input.add_wishlist_lodge_id").val();
				
				$.ajax({
					url:"<%= ctxPath%>/addWishlistAjax.action",
					data:{"wishlist_lodge_id":wishlist_lodge_id},
					dataType:"json",
					success : function(json){
					
						if(json.n == 1){
							// 새로고침
							window.location.reload();
						}
						
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
						  
				});
				
			}
			// 채워진 하트라면 삭제하기
			else{
				// 위시리스트 추가 ajax
				var wishlist_lodge_id = $(this).find("input.add_wishlist_lodge_id").val();
				
				$.ajax({
					url:"<%= ctxPath%>/delWishlistAjax.action",
					data:{"wishlist_lodge_id":wishlist_lodge_id},
					dataType:"json",
					success : function(json){
					
						if(json.n == 1){
							// 새로고침
							window.location.reload();
						}
						
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
						  
				});
				
			}
			
		});
		// =========== 위시리스트 버튼을 클릭하면 테이블에 insert 하기   끝 =========== //
		
		
		// 재훈 : 검색창에 x 클릭할경우 검색내용 지워주기
		$("button#search_clear").click(function(){
			$("input#input_destination").val("");
			$("input#input_destination_search").val("");
			
		});
		
		
	}); // end of $(document).ready(function(){});
	
	// Function Declarationfunction
	function dateSelector(){;
		
		var dateSelector = document.querySelector('.dateSelector');dateSelector.flatpickr({
		    mode: "range",
		    enable: [{from: "${requestScope.date_map.today_date}", to: "${requestScope.date_map.after_1year_date}"}],
		    dateFormat: "Y-m-d",
			// 페이지 로드시 넘어온 체크인아웃 날짜 입력해주기
			defaultDate: ["${requestScope.map.check_in}", "${requestScope.map.check_out}"]
		})
		
	};
	
	// =========== 선택, 검색창 div 외부 클릭시 숨겨주기 시작 =========== //
	$(document).mouseup(function (e) {
		var movewrap = $("div#div_destination_search");
		if (movewrap.has(e.target).length === 0) {
			movewrap.hide();
		}
	});

	$(document).mouseup(function (e) {
		var movewrap = $("div#travler_select");
		if (movewrap.has(e.target).length === 0) {
			movewrap.hide();
		}
	});
	// =========== 선택, 검색창 div 외부 클릭시 숨겨주기 끝 =========== //
	
	
	// =========== 총 금액을 구하기위해 박수를 구하는 함수  시작 =========== //
	function getDate(d1, d2){
		
		const date1 = new Date(d1);
		const date2 = new Date(d2);
		
		const diffDate = date1.getTime() - date2.getTime();
  
		return Math.abs(diffDate / (1000 * 60 * 60 * 24)); // 밀리세컨 * 초 * 분 * 시 = 일
	};
	// =========== 총 금액을 구하기위해 박수를 구하는 함수   끝 =========== //
	
	
	// =========== 더 보기, 간단히 보기 버튼 클릭시 나오는 함수 시작 =========== //
	function view_more(){
		// 간단히 보기 보여주기
		$("span.read_less").parent().show();
		// 더 보기 숨기기
		$("span.read_more").parent().hide();
		// li 태그 보여주기
		$("input.amenities").parent().show()
	}
	function view_less(){
		for(var i=0; i<$("input.amenities").length; i++){
			if(i>2){
				// 3개까지만 보여주고 나머지는 숨기기
				$("input.amenities").eq(i).parent().hide();
				// 더 보기 보여주기
				$("span.read_more").parent().show();
				// 간단히 보기 숨기기
				$("span.read_less").parent().hide();
			}
		}
	}
	// =========== 더 보기, 간단히 보기 버튼 클릭시 나오는 함수    끝 =========== //
	
	
	
	
	// ======================================================================================= //
	// ================================= form 을 통한 ajax 검색 시작 ================================= //
	function ajax_form_search(){
		
		$.ajax({
			url:"<%= ctxPath%>/lodgeSearchAjax.action",
			data:{"lg_name":"${requestScope.map.lg_name}",
				  "lg_area_2":"${requestScope.map.lg_area_2}",
				  "lg_area":"${requestScope.map.lg_area}",
				  "check_in":"${requestScope.map.check_in}",
				  "check_out":"${requestScope.map.check_out}",
				  "travlers":"${requestScope.map.travlers}",
				  "adult":"${requestScope.map.adult}",
				  "kid":"${requestScope.map.kid}",
				  "price_min":"${requestScope.map.price_min}",
				  "price_max":"${requestScope.map.price_max}",
				  "lg_star":"${requestScope.map.lg_star}",
				  "lodge_type":"${requestScope.map.lodge_type}",
				  "breakfast":"${requestScope.map.breakfast}",
				  "pool":"${requestScope.map.pool}",
				  "wifi":"${requestScope.map.wifi}",
				  "seaView":"${requestScope.map.seaView}",
				  "pet":"${requestScope.map.pet}",
				  "spa":"${requestScope.map.spa}",
				  "parking":"${requestScope.map.parking}",
				  "kitchen":"${requestScope.map.kitchen}",
				  "aircon":"${requestScope.map.aircon}",
				  "restaurant":"${requestScope.map.restaurant}",
				  "babyBed":"${requestScope.map.babyBed}",
				  "washerDryer":"${requestScope.map.washerDryer}",
				  "breakfast":"${requestScope.map.breakfast}",
				  "rating":"${requestScope.map.rating}",
				  "sort":"${requestScope.map.sort}"},
			dataType:"json",
			success : function(json){
			// 	console.log(JSON.stringify(json))
			/*
				[{"fk_cancel_opt":" ","lg_area_2":"서귀포시","lodge_id":"JESH0001","rm_price":"550000","lg_name":"제주신라호텔","lg_area":"제주특별자치도"}
				,{"fk_cancel_opt":" ","lg_area_2":"서귀포시","lodge_id":"JEHI0002","rm_price":"410227","lg_name":"히든 클리프 호텔&네이쳐","lg_area":"제주특별자치도"}]
			*/
				
				let v_html = "";
				
				// 검색결과가 있는 경우
				if(json.length > 0){
					
					$.each(json, function(index, item){
						
						const lodgeImgArr = ${requestScope.lodgeImgArr};
						
						v_html += 	"<div class='search_item_view'>";
								 		<%-- 숙소 메인이미지 보여주는 캐러셀 시작 --%>
								 		
						const lodgeIdArr = ${requestScope.lodgeIdArr};
						var wishlistYN = 0;
						
						if(${sessionScope.loginuser != null}){
						
							if(lodgeIdArr.length > 0) {
								$.each(lodgeIdArr, function(index3, item3){
									
									if(wishlistYN == 0){
										
										if(item3.fk_lodge_id == item.lodge_id){
										
											v_html += "<div class='add_wishlist_btn'>"
										
											v_html +=	"<svg class='uitk-icon fill_heart' aria-hidden='true' viewBox='0 0 24 24' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink'>"
											v_html +=		"<path fill-rule='evenodd' d='m12 22-8.44-8.69a5.55 5.55 0 0 1 0-7.72C4.53 4.59 5.9 4 7.28 4c1.4 0 2.75.59 3.72 1.59l1 1.02 1-1.02c.97-1 2.32-1.59 3.72-1.59 1.4 0 2.75.59 3.72 1.59a5.55 5.55 0 0 1 0 7.72L12 22Z' clip-rule='evenodd'></path>"
											v_html +=	"</svg>"
	
											v_html +=	"<input type='hidden' class='wishlist_status' value='fill_heart'/>"
											v_html +=	"<input type='hidden' class='add_wishlist_lodge_id' value='" + item.lodge_id + "' />"
											v_html += "</div>"
											
											wishlistYN = wishlistYN + 1;
										}
										else{
											
											v_html += "<div class='add_wishlist_btn'>"
											
											v_html +=	"<svg class='uitk-icon uitk-favorite-switch-border' aria-hidden='true' viewBox='0 0 24 24' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink'>"
											v_html +=		"<path fill-rule='evenodd' d='m12 22 8.44-8.69a5.55 5.55 0 0 0 0-7.72A5.24 5.24 0 0 0 16.72 4 5.22 5.22 0 0 0 13 5.59L12 6.6l-1-1.02a5.2 5.2 0 0 0-7.44 0 5.55 5.55 0 0 0 0 7.72L12 22Zm0-2.87-7-7.21a3.55 3.55 0 0 1 0-4.94C5.6 6.36 6.44 6 7.28 6c.84 0 1.69.36 2.3.98L12 9.48l2.43-2.5c.6-.62 1.45-.98 2.29-.98.84 0 1.68.36 2.28.98a3.55 3.55 0 0 1 0 4.94l-7 7.2Z' clip-rule='evenodd' opacity='.9'></path>"
											v_html +=	"</svg>"
	
											v_html +=	"<input type='hidden' class='wishlist_status' value='border_heart'/>"
											v_html +=	"<input type='hidden' class='add_wishlist_lodge_id' value='" + item.lodge_id + "' />"
											v_html += "</div>"
										}
									}
									
								});
							}
							else{
								
								v_html += "<div class='add_wishlist_btn'>"
								
								v_html +=	"<svg class='uitk-icon uitk-favorite-switch-border' aria-hidden='true' viewBox='0 0 24 24' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink'>"
								v_html +=		"<path fill-rule='evenodd' d='m12 22 8.44-8.69a5.55 5.55 0 0 0 0-7.72A5.24 5.24 0 0 0 16.72 4 5.22 5.22 0 0 0 13 5.59L12 6.6l-1-1.02a5.2 5.2 0 0 0-7.44 0 5.55 5.55 0 0 0 0 7.72L12 22Zm0-2.87-7-7.21a3.55 3.55 0 0 1 0-4.94C5.6 6.36 6.44 6 7.28 6c.84 0 1.69.36 2.3.98L12 9.48l2.43-2.5c.6-.62 1.45-.98 2.29-.98.84 0 1.68.36 2.28.98a3.55 3.55 0 0 1 0 4.94l-7 7.2Z' clip-rule='evenodd' opacity='.9'></path>"
								v_html +=	"</svg>"
	
								v_html +=	"<input type='hidden' class='wishlist_status' value='border_heart'/>"
								v_html +=	"<input type='hidden' class='add_wishlist_lodge_id' value='" + item.lodge_id + "' />"
								v_html += "</div>"
								
							};
						};
						
						v_html +=		"<div class='search_item_img'>";
						v_html +=			"<div id='carouselExampleIndicators" + index + "' class='carousel slide' data-interval='false'>";
						
						v_html +=				"<div class='carousel-inner'>";
						v_html +=					"<c:if test='${not empty requestScope.lodgeImgArr}'>";
						
						var carousel_cnt = 0;
						
						$.each(lodgeImgArr, function(index2, item2){
							
							if(item2.fk_lodge_id == item.lodge_id){
								if(carousel_cnt == 0){
									v_html +=			"<div class='carousel-item active'>";
									v_html +=				"<img src='<%= ctxPath%>/resources/images/" + item.lodge_id + "/lodge_img/" + item2.lg_img_save_name + "' class='d-block w-100 image_thumnail'>";
									v_html +=			"</div>";
									
									carousel_cnt = carousel_cnt + 1;
								}
								else{
									v_html +=			"<div class='carousel-item'>";
									v_html +=				"<img src='<%= ctxPath%>/resources/images/" + item.lodge_id + "/lodge_img/" + item2.lg_img_save_name + "' class='d-block w-100 h-100 image_thumnail'>";
									v_html +=			"</div>";
								}
							}
						});
						
						v_html +=					"</c:if>";
						v_html +=				"</div>";
							
						v_html +=				"<a class='carousel-control-prev' href='#carouselExampleIndicators" + index + "' role='button' data-slide='prev'>";
						v_html +=					"<span class='carousel-control-prev-icon' aria-hidden='true'></span>";
						v_html +=					"<span class='sr-only'>Previous</span>";
						v_html +=				"</a>"
						v_html +=				"<a class='carousel-control-next' href='#carouselExampleIndicators" + index + "' role='button' data-slide='next'>";
						v_html +=					"<span class='carousel-control-next-icon' aria-hidden='true'></span>";
						v_html +=					"<span class='sr-only'>Next</span>";
						v_html +=				"</a>";
						v_html +=			"</div>";
						v_html +=		"</div>";
						
										<%-- 숙소 상세 정보 보여주기 --%>
						v_html +=		"<div class='search_item_desc'>";
											<%-- 상단 정보(숙소이름, 지역명) --%>
						v_html +=			"<div class='lodge_desc_top'>";
						v_html +=				"<form name='RoomListFrm'>";
						v_html +=					"<input type='hidden' class='lodge_id' value='" + item.lodge_id + "' />";
						v_html +=					"<input type='hidden' class='check_in' value='" + item.check_in + "' />";
						v_html +=					"<input type='hidden' class='check_out' value='" + item.check_out + "' />";
						v_html +=					"<input type='hidden' class='guest' value='${requestScope.map.travlers}' />";
						v_html +=					"<input type='hidden' class='adults' value='${requestScope.map.adult}' />";
						v_html +=					"<input type='hidden' class='childs' value='${requestScope.map.kid}' />";
						v_html +=					"<input type='hidden' class='room' value='1' />";
						v_html +=				"</form>";
						v_html +=				"<div class='lg_name'>" + item.lg_name + "</div>";
						v_html +=				"<div class='lg_area'>";
						v_html +=					"<span>" + item.lg_area_2 + "</span>";
						v_html +=					"<span>, </span>";
						v_html +=					"<span>" + item.lg_area + "</span>";
						v_html +=				"</div>"
						v_html +=			"</div>"
							
						v_html +=				"<div class='under_info'>";
												<%-- 중단 정보 --%>
						v_html +=				"<div class='lodge_desc_middle'>";
													<%-- 좌중단 정보(환불가능, 현장결제) --%>
						v_html +=					"<div class='lodge_desc_middle_left'>";
						v_html +=						"<div>";
						v_html +=							item.fk_cancel_opt;
						v_html +=						"</div>";
						v_html +=						"<div>";
						v_html +=							"지금 예약하고 현장결제";
						v_html +=						"</div>";
						v_html +=					"</div>";
													
													<%-- 우중단 정보(회원할인율, 금액(원가, 할인가)) --%>
						v_html +=					"<div class='lodge_desc_middle_right'>";
									
						<%---------------------------- 비회원일때 보여주는 금액 ----------------------------%>
						if(${sessionScope.loginuser == null}){
							v_html +=					"<div class='member_discount'>";
							v_html +=						"<span class='uitk-badge uitk-badge-deal-member uitk-badge-has-text uitk-layout-flex-item-align-self-flex-end uitk-layout-flex-item'>";
							v_html +=						"</span>";
							v_html +=					"</div>";
							
														<%-- 금액 --%>
							v_html +=					"<div class='lg_price'>";
															<%-- 원가 --%>
							v_html +=						"<div class='lg_price_org_no_login'>";
							v_html +=							"&#8361;" + Number(item.rm_price).toLocaleString('en');
							v_html +=							"<input type='hidden' class='origin_price' value='" + Number(item.rm_price) + "'/>";
							v_html +=						"</div>";
							v_html +=					"</div>";
						}
						<%---------------------------- 회원일때 보여주는 금액 ----------------------------%>
						else{
														<%-- 회원할인율 --%>
							v_html +=					"<div class='member_discount'>";
							v_html +=						"<span class='uitk-badge uitk-badge-large uitk-badge-deal-member uitk-badge-has-text uitk-layout-flex-item-align-self-flex-end uitk-layout-flex-item'>";
							v_html +=							"<svg class='uitk-icon uitk-icon-small' aria-hidden='true' viewBox='0 0 24 24' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink'>";
							v_html +=								"<path fill-rule='evenodd' d='m17.1 16.05 1.22-1.18 3.48-3.48a.78.78 0 0 0 .2-.6l-1.3-7.1a.57.57 0 0 0-.42-.42l-7.06-1.26a.78.78 0 0 0-.61.19L2.1 12.7a.36.36 0 0 0 0 .51l8.68 8.69c.14.13.37.14.5 0l4.24-4.23a2.88 2.88 0 0 0 4.9-2.26v-.1c0-.28-.03-1.02-.26-1.5L19 14.9a1.54 1.54 0 1 1-3 .62c-.03-.5.19-2.34.5-4.07a26.11 26.11 0 0 1 .56-2.48l.02.04a1.62 1.62 0 1 0-1.42-.12c-.13.57-.26 1.26-.41 2.1a29.62 29.62 0 0 0-.57 4.88l-.83.83-6.56-6.55 6.04-6.04c.07-.08.2-.12.3-.1l5.2.94c.09.01.18.1.2.2l.98 5.18c.02.1-.03.23-.1.3l-3.1 3.1c-.2.75-.43 2.05.3 2.31zm-6.24 3.4-6.29-6.32a.18.18 0 0 1 0-.25l1.72-1.72 6.56 6.56-1.74 1.73a.18.18 0 0 1-.25 0z' clip-rule='evenodd'></path>";
							v_html +=							"</svg>";
							
							if ("${sessionScope.loginuser.user_lvl}" == "블루"){
								v_html +=						"<span class='uitk-badge-text' aria-hidden='false'>" + "회원가 10% 할인 " + "</span>";
							}
							else if ("${sessionScope.loginuser.user_lvl}" == "실버") {
								v_html +=						"<span class='uitk-badge-text' aria-hidden='false'>" + "회원가 15% 할인 " + "</span>";
							}
							else{
								v_html +=						"<span class='uitk-badge-text' aria-hidden='false'>" + "회원가 20% 할인 " + "</span>";
							}
							
							v_html +=						"</span>";
							v_html +=					"</div>";
							
														<%-- 금액 --%>
							v_html +=					"<div class='lg_price'>";
															<%-- 원가 --%>
							v_html +=						"<div class='lg_price_org'>";
							v_html +=							"&#8361;" + Number(item.rm_price).toLocaleString('en');
							v_html +=							"<input type='hidden' class='origin_price' value='" + Number(item.rm_price) + "'/>";
							v_html +=						"</div>";
							if ("${sessionScope.loginuser.user_lvl}" == "블루"){
															<%-- 할인가 --%>
								v_html +=						"<div class='lg_price_disc'>";
								v_html +=							"&#8361;" + Math.ceil(Number(item.rm_price * 0.9)).toLocaleString('en');
								v_html +=						"</div>";
							}
							else if ("${sessionScope.loginuser.user_lvl}" == "실버") {
															<%-- 할인가 --%>
								v_html +=						"<div class='lg_price_disc'>";
								v_html +=							"&#8361;" + Math.ceil(Number(item.rm_price * 0.85)).toLocaleString('en');
								v_html +=						"</div>";
							}
							else {
															<%-- 할인가 --%>
								v_html +=						"<div class='lg_price_disc'>";
								v_html +=							"&#8361;" + Math.ceil(Number(item.rm_price * 0.8)).toLocaleString('en');
								v_html +=						"</div>";
							}
							v_html +=					"</div>";
						}
						
						v_html +=					"</div>";
						v_html +=				"</div>";
						v_html +=			"</div>";
											<%-- 하단 정보 --%>
						v_html +=			"<div class='lodge_desc_bottom'>";
												<%-- 좌하단 정보(=평점, 후기) --%>
						v_html +=				"<div class='lodge_desc_bottom_left'>";
						
						
						<%---------------------------- 점수 구분 ----------------------------%>
						if(Number(item.rating).toFixed(1) >= 9){
							<%-- 평점 --%>
							v_html +=				"<div class='rv_rating'>";
							v_html +=					"<span class='uitk-badge uitk-badge-base-large uitk-badge-base-has-text uitk-badge-positive'>";
							v_html +=						"<span class='uitk-badge-base-text'>" + Number(item.rating).toFixed(1) + "</span>";
							v_html +=					"</span>";
							v_html +=				"</div>";
														
													<%-- 후기 --%>
							v_html +=				"<div class='rv_rating_desc'>";
							v_html +=					"<div>";
							v_html +=						"매우 훌륭해요";
							v_html +=					"</div>";
						}
						else if(Number(item.rating).toFixed(1) >= 8){
							<%-- 평점 --%>
							v_html +=				"<div class='rv_rating'>";
							v_html +=					"<span class='uitk-badge uitk-badge-base-large uitk-badge-base-has-text uitk-badge-positive'>";
							v_html +=						"<span class='uitk-badge-base-text'>" + Number(item.rating).toFixed(1) + "</span>";
							v_html +=					"</span>";
							v_html +=				"</div>";
														
													<%-- 후기 --%>
							v_html +=				"<div class='rv_rating_desc'>";
							v_html +=					"<div>";
							v_html +=						"훌륭해요";
							v_html +=					"</div>";
						}
						else if(Number(item.rating).toFixed(1) < 8 && Number(item.rating).toFixed(1) > 0){
							<%-- 평점 --%>
							v_html +=				"<div class='rv_rating'>";
							v_html +=					"<span class='uitk-badge uitk-badge-base-large uitk-badge-base-has-text uitk-badge-positive'>";
							v_html +=						"<span class='uitk-badge-base-text'>" + Number(item.rating).toFixed(1) + "</span>";
							v_html +=					"</span>";
							v_html +=				"</div>";
														
													<%-- 후기 --%>
							v_html +=				"<div class='rv_rating_desc'>";
							v_html +=					"<div>";
							v_html +=						"훌륭해요";
							v_html +=					"</div>";
						}
						else {
							<%-- 평점 --%>
							v_html +=				"<div class='rv_rating'>";
							v_html +=					"<span class='uitk-badge uitk-badge-base-large uitk-badge-base-has-text uitk-badge-standard'>";
							v_html +=						"<span class='uitk-badge-base-text'>" + Number(item.rating).toFixed(1) + "</span>";
							v_html +=					"</span>";
							v_html +=				"</div>";
														
													<%-- 후기 --%>
							v_html +=				"<div class='rv_rating_desc'>";
							v_html +=					"<div>";
							v_html +=						"후기없음";
							v_html +=					"</div>";
						}
						
														
						v_html +=						"<div class='rv_cnt'>";
						v_html +=							"이용 후기 " + Math.ceil(Number(item.review_cnt * 0.8)).toLocaleString('en') + "개";
						v_html +=						"</div>";
						v_html +=					"</div>";
						v_html +=				"</div>";
												
												<%-- 우중단 정보(전체금액, 세금 및 수수료) --%>
						v_html +=				"<div class='lodge_desc_bottom_right'>";
						v_html +=					"<div class='total_price'>";
						
														var date = getDate(item.check_in, item.check_out);
														
						<%---------------------------- 비회원일때 보여주는 금액 ----------------------------%>
						if(${sessionScope.loginuser == null}){
							v_html +=					"총 요금 : &#8361;" + Math.ceil(Number((item.rm_price * date)) * 1.1 ).toLocaleString('en');
						}
						<%---------------------------- 회원일때 보여주는 금액 ----------------------------%>
						else{
							if ("${sessionScope.loginuser.user_lvl}" == "블루"){
								v_html +=				"총 요금 : &#8361;" + Math.ceil(Number((item.rm_price * 0.9 * date)) * 1.1 ).toLocaleString('en');
							}
							else if ("${sessionScope.loginuser.user_lvl}" == "실버") {
								v_html +=				"총 요금 : &#8361;" + Math.ceil(Number((item.rm_price * 0.85 * date)) * 1.1 ).toLocaleString('en');
							}
							else{
								v_html +=				"총 요금 : &#8361;" + Math.ceil(Number((item.rm_price * 0.8 * date)) * 1.1 ).toLocaleString('en');
							}
						}
						
						v_html +=					"</div>";
													
						v_html +=					"<div>";
						v_html +=						"세금 및 수수료 포함";
						v_html +=					"</div>";
						v_html +=				"</div>";
						v_html +=			"</div>";
						v_html +=		"</div>";
						v_html +=	"</div>";
						
						$("div#search_item_list").html(v_html);
						
					});

				}
				else{
					
					v_html += 	"<div class='no_search_item_view'>";
					v_html += 		"<div class='no_search_item_view_inner'>";
					v_html += 			"<div>";
					v_html += 				"<svg class='uitk-icon' aria-hidden='true' viewBox='0 0 24 24' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink'>";
					v_html += 					"<path fill-rule='evenodd' d='M14.71 14h.79l4.99 5L19 20.49l-5-4.99v-.79l-.27-.28a6.5 6.5 0 1 1 .7-.7l.28.27zM5 9.5a4.5 4.5 0 1 0 8.99.01A4.5 4.5 0 0 0 5 9.5z' clip-rule='evenodd'></path>";
					v_html += 				"</svg>";
					v_html += 			"</div>";
					v_html += 			"<div class=''>";
					v_html += 				"<h3>검색 결과 없음</h3>";
					v_html += 			"</div>";
					v_html += 			"<div class=''>필터를 삭제하고 다시 시도해 보세요.</div>";
					v_html += 		"</div>";
					v_html += 	"</div>";
					
					$("div#search_item_list").html(v_html);
					
				}
				
				console.log("${requestScope.map.price_max}");
				// 처음 검색화면인 경우
				if("${requestScope.map.price_max}" == ""){
					
					// 가져온 숙소 리스트중에서 최고가인 금액을 hidden input에 저장하기
					for(var i=0; i<$("input.origin_price").length; i++){
						
						var max_price = Number($("input.origin_price").eq(i).val());
						var default_max_price = Number($("input#search_price_max").val());
						
						if(default_max_price < max_price){
							$("input#search_price_max").val(max_price);
						} 
					}// end of for-------------------------------------
					
					// 로드시 최저가 최대가 입력하기
					$("input[name='price_min']").val(Number($("input#search_price_min").val()));
					$("input#search_price_min").val("￦" + Number($("input#search_price_min").val()).toLocaleString('en'));
					
					$("input[name='price_max']").val(Number($("input#search_price_max").val()));
					$("input#search_price_max").val("￦" + Number($("input#search_price_max").val()).toLocaleString('en'));
					
				}
				// 필터를 사용한 경우
				else{
					console.log(default_max_price);
					
					// 가져온 숙소 리스트중에서 최고가인 금액을 hidden input에 저장하기
					for(var i=0; i<$("input.origin_price").length; i++){
						var max_price = Number($("input.origin_price").eq(i).val());
						console.log(max_price);
						var default_max_price = Number($("input#search_price_max").val());
						console.log(default_max_price);
						
						if(default_max_price < max_price){
							$("input#search_price_max").val(max_price);
						}
					}// end of for-------------------------------------
					
					// 로드시 최저가 최대가 입력하기
					$("input[name='price_min']").val(Number(${requestScope.map.price_min}));
					$("input#search_price_min").val("￦" + Number(${requestScope.map.price_min}).toLocaleString('en'));
					
					$("input[name='price_max']").val(Number(${requestScope.map.price_max}));
					$("input#search_price_max").val("￦" + Number(${requestScope.map.price_max}).toLocaleString('en'));
					
				};
				
				// 처음 검색화면에서 넘어온 날짜를 hidden input에 넣어두기
				$("input[name='check_in']").val("${requestScope.map.check_in}");
				$("input[name='check_out']").val("${requestScope.map.check_out}");
				
				// 처음 검색화면에서 넘어온 성급을 보여주기
				$("input[name='lg_star']").val("${requestScope.map.lg_star}");
				
				// 처음 검색화면에서 넘어온 성급을 보여주기
				$("input[name='lodge_type']").val("${requestScope.map.lodge_type}");
				
				// 체크된 숙소성급을 표시해주기
				$("input.lg_star:checked").each(function(){
					$(this).next().removeClass("unchecked_lg_star");
					$(this).next().addClass("checked_lg_star");
				});
				
				if("${requestScope.map.lg_name}" == "" &&
				   "${requestScope.map.lg_area}" == "" &&
				   "${requestScope.map.lg_area_2}" == ""){
					$("input#input_destination").val("전체");
				}
				
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});// end of ajax
	} // end of ajax_form_search(){};
	// ================================= form 을 통한 ajax 검색   끝 ================================= //
	// ======================================================================================= //
	
	// 재훈 : 필터를 선택할 경우 새로운 조건을 추가한 ajax 호출
	function filter_search(){
		const frm = document.searchFrm;
		frm.submit();
	};
	
	
</script>

<c:if test="${not empty requestScope.map.hotel}">
	<title>${requestScope.map.hotel} 검색결과</title>
</c:if>
<c:if test="${empty requestScope.map.hotel}">
	<title>${requestScope.map.city} 호텔 검색결과</title>
</c:if>

<body style="background-color: f3f3f5;">
	<div style="inline-size: 100%; margin: auto; max-inline-size: 75rem; padding: 10px 0;">
		
		<!-- 재훈 : 검색 박스 만들기 시작 -->
		<form name="searchFrm">
			<div id="search_box">
				<div id="div_search_box">
					<div id="div_search_box_align">
					
						<!-- 재훈 : 목적지 검색 시작 -->
						<div id="btn_destination" style="background-color: white;">
							
							<div id="btn_destination_field">
								<!-- 재훈 : 목적지 아이콘 -->
								<div style="width:30px; margin: 0 10px;">
									<svg class="uitk-icon" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
										<path fill-rule="evenodd" d="M5 9a7 7 0 1 1 14 0c0 5.25-7 13-7 13S5 14.25 5 9zm4.5 0a2.5 2.5 0 1 0 5 0 2.5 2.5 0 0 0-5 0z" clip-rule="evenodd"></path>
									</svg>
								</div>
								
								<!-- 재훈 : 목적지 내용 -->
								<div>
									<div style="display: inline-block;">
										<div style="font-size: 12px; margin:0;">목적지</div>
										
										<c:choose>
											<c:when test="${not empty requestScope.map.lg_name}">
												<input id="input_destination" type="text" placeholder="클릭해서 검색하세요." autocomplete="off" value="${requestScope.map.lg_name}(${requestScope.map.lg_area_2},${requestScope.map.lg_area},한국)" />
											</c:when>
											<c:when test="${empty requestScope.map.lg_name && not empty requestScope.map.lg_area_2}">
												<input id="input_destination" type="text" placeholder="클릭해서 검색하세요." autocomplete="off" value="${requestScope.map.lg_area_2}(${requestScope.map.lg_area},한국)" />
											</c:when>
											<c:when test="${empty requestScope.map.lg_name && empty requestScope.map.lg_area_2 && not empty requestScope.map.lg_area}">
												<input id="input_destination" type="text" placeholder="클릭해서 검색하세요." autocomplete="off" value="${requestScope.map.lg_area}(한국)" />
											</c:when>
											<c:otherwise>
												<input id="input_destination" type="text" placeholder="클릭해서 검색하세요." autocomplete="off" />
											</c:otherwise>
										</c:choose>
										
										<%--
										<input name="nation" type="hidden"/>
										--%>
										<c:choose>
											<c:when test="${not empty requestScope.map.lg_name}">
												<input name="lg_name" type="hidden" value="${requestScope.map.lg_name}"/>
												<input name="lg_area_2" type="hidden" value="${requestScope.map.lg_area_2}"/>
												<input name="lg_area" type="hidden" value="${requestScope.map.lg_area}"/>
											</c:when>
											<c:when test="${empty requestScope.map.lg_name && not empty requestScope.map.lg_area_2}">
												<input name="lg_name" type="hidden" value=""/>
												<input name="lg_area_2" type="hidden" value="${requestScope.map.lg_area_2}"/>
												<input name="lg_area" type="hidden" value="${requestScope.map.lg_area}"/>
											</c:when>
											<c:otherwise>
												<input name="lg_name" type="hidden" value=""/>
												<input name="lg_area_2" type="hidden" value=""/>
												<input name="lg_area" type="hidden" value="${requestScope.map.lg_area}"/>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</div>
							<!-- 재훈 : 목적지 클릭하면 나오는 div 시작 -->
							<div id="div_destination_search">
								<div id="city_searching_result">
									<div id="search_bar">
										<!-- 재훈 : 목적지 검색하는 input -->
										<input id="input_destination_search" type="text" placeholder="목적지" autocomplete="off"/>
										
										<button type="button" id="search_clear">
											<svg class="uitk-icon uitk-icon-small" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
												<path fill-rule="evenodd" d="M2 12a10 10 0 1 1 20 0 10 10 0 1 1-20 0zm13.59 5L17 15.59 13.41 12 17 8.41 15.59 7 12 10.59 8.41 7 7 8.41 10.59 12 7 15.59 8.41 17 12 13.41 15.59 17z" clip-rule="evenodd"></path>
											</svg>
										</button>
									</div>
									<div id="search_none"></div>
									
									<hr style="width: 100%; margin: 0; padding: 0;">
									
								</div>
							</div>
							<!-- 재훈 : 목적지 클릭하면 나오는 div 시작 -->
							
						</div>
						<!-- 재훈 : 목적지 검색 끝 -->
					
						<!-- 재훈 : 날짜 검색 시작 -->
						<div id="btn_date" style="background-color: white;">
							<!-- 재훈 : 날짜 아이콘 -->
							<div style="width:30px; margin: 0 10px;">
								<svg class="uitk-icon" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
									<path fill-rule="evenodd" d="M19 3h-1V1h-2v2H8V1H6v2H5a2 2 0 0 0-1.99 2L3 19a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V5a2 2 0 0 0-2-2zm0 5v11H5V8h14zm-7 2H7v5h5v-5z" clip-rule="evenodd"></path>
								</svg>
							</div>
							
							<!-- 재훈 : 날짜 내용 -->
							<div>
								<div style="display: inline-block;">
									<div id="div_date" >
										<div id="div_date_desc" style="font-size: 12px; margin:0;">날짜</div>
										<div id="div_date_select">
											<input id="input_date" class="dateSelector" />
										</div>
									</div>
									
									<input name="check_in" type="hidden" />
									<input name="check_out" type="hidden" />
								</div>
							</div>
						</div>
						<!-- 재훈 : 날짜 검색 끝 -->
					
						<!-- 재훈 : 인원수 검색 시작 -->
						<div id="box_travler" style="background-color: white;">
							<!-- 재훈 : 날짜 아이콘 -->
							<div style="width:30px; margin: 0 10px;">
								<svg class="uitk-icon" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
									<path fill-rule="evenodd" d="M16 8a4 4 0 1 1-8 0 4 4 0 0 1 8 0zM4 18c0-2.66 5.33-4 8-4s8 1.34 8 4v2H4v-2z" clip-rule="evenodd"></path>
								</svg>
							</div>
							
							<!-- 재훈 : 인원수 내용 -->
							<div>
								<div style="display: inline-block;">
									<div style="font-size: 12px; margin:0;">인원수</div>
									<div id="defaultTravler">객실&nbsp;<span>1</span>개&nbsp;&nbsp;<span id="total_travler">2</span>명</div>
									
									<input name="travlers" type="hidden" />
									<input name="adult" type="hidden" />
									<input name="kid" type="hidden" />
								</div>
							</div>
						</div>
						<!-- 재훈 : 인원수 상세 선택 -->
						<div id="travler_select" class="box_travler_select">
							<div id="travler_select_detail">
								<div style="font-weight: bold;">객실</div>
								<div id="travler_adult">
									<div>성인</div>
									<div class="select_cnt">
										<button type="button" class="btn_circle adult_cnt_minus">
											<svg class="uitk-icon uitk-step-input-icon" aria-label="객실 1의 성인 수 줄이기" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
												<path d="M19 13H5v-2h14v2z"></path>
											</svg>
										</button>
										
										<input class="travler_cnt adult_cnt_select" readonly style="outline: none;"/>
										
										<button type="button" class="btn_circle adult_cnt_plus">
											<svg class="uitk-icon uitk-step-input-icon" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
												<path d="M19 13h-6v6h-2v-6H5v-2h6V5h2v6h6v2z">
											</svg>
										</button>
									</div>
								</div>
								<div id="travler_kid">
									<div>
										<div>아동</div>
										<div style="color: gray;">만 0~17 세</div>
									</div>
									<div class="select_cnt">
										<button type="button" class="btn_circle kid_cnt_minus">
											<svg class="uitk-icon uitk-step-input-icon" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
												<path d="M19 13H5v-2h14v2z"></path>
											</svg>
										</button>
										
										<input class="travler_cnt kid_cnt_select" readonly style="outline: none;"/>
										
										<button type="button" class="btn_circle kid_cnt_plus">
											<svg class="uitk-icon uitk-step-input-icon" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
												<path d="M19 13h-6v6h-2v-6H5v-2h6V5h2v6h6v2z">
											</svg>
										</button>
									</div>
								</div>
								<div id="div_travler_btn">
									<div style="width: 250px; color: red; text-align: left; font-size: 14px;">
										<div id="travler_alert"></div>
									</div>
									<button name="btn_travler" type="button">완료</button>
								</div>
							</div>
						</div>
						<!-- 재훈 : 인원수 검색 끝 -->
						
						<button name="btn_search" type="button">
							<svg class="uitk-icon uitk-icon-leading" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
								<path fill-rule="evenodd" d="M14.71 14h.79l4.99 5L19 20.49l-5-4.99v-.79l-.27-.28a6.5 6.5 0 1 1 .7-.7l.28.27zM5 9.5a4.5 4.5 0 1 0 8.99.01A4.5 4.5 0 0 0 5 9.5z" clip-rule="evenodd"></path>
							</svg>
						</button>
						
					</div>
				</div>
			</div>
		
			<!-- 재훈 : 검색 박스 만들기 끝 -->
		
		
			<!-- 재훈 : 검색내용 본문 시작 -->
			<div id="search_content">
				<!-- 재훈 : 검색된 내용 필터 시작 -->
				<div id="search_filter">
					
					<div id="filter_price">
						<span>1박당 요금</span>
						<div id="search_price_boundary">
							<div class="search_price">
								<label for="search_price_min" >최소</label>
								<input id="search_price_min" type="text" value="0">
								<input name="price_min" type="hidden" value="0">
							</div>
							<div class="search_price">
								<label for="search_price_max" >최대</label>
								<input id="search_price_max" type="text" value="0">
								<input name="price_max" type="hidden" value="0">
							</div>
						</div>
					</div>
				
					<div id="filter_star">
						<span>숙박시설 등급</span>
						<div>
							<ul>
								<li>
									<input type="checkbox" class="lg_star" id="5star" value="5"/>
									<label class="lg_star_icon unchecked_lg_star" for="5star">5★</label>
								</li>
								<li>
									<input type="checkbox" class="lg_star" id="4star" value="4"/>
									<label class="lg_star_icon unchecked_lg_star" for="4star">4★</label>
								</li>
								<li>
									<input type="checkbox" class="lg_star" id="3star" value="3"/>
									<label class="lg_star_icon unchecked_lg_star" for="3star">3★</label>
								</li>
								<li>
									<input type="checkbox" class="lg_star" id="2star" value="2"/>
									<label class="lg_star_icon unchecked_lg_star" for="2star">2★</label>
								</li>
								<li>
									<input type="checkbox" class="lg_star" id="1star" value="1"/>
									<label class="lg_star_icon unchecked_lg_star" for="1star">1★</label>
								</li>
							</ul>
							<input type="hidden" name="lg_star" value="" />
						</div>
					</div>
					
					<div id="filter_rating">
						<span>고객 평점</span>
						<div>
							<ul>
								<li>
									<input type="radio" id="rating_all" name="rating" value=""/>
									<label for="rating_all">전체</label>
								</li>
								<li>
									<input type="radio" id="rating_best" name="rating"  value="9"/>
									<label for="rating_best">최고 좋음 9+</label>
								</li>
								<li>
									<input type="radio" id="rating_great" name="rating"  value="8"/>
									<label for="rating_great">매우 좋음 8+</label>
								</li>
								<li>
									<input type="radio" id="rating_good" name="rating"  value="7"/>
									<label for="rating_good">좋음 7+</label>
								</li>
							</ul>
						</div>
					</div>
				
					<div id="filter_lodge_type">
						<span>숙박시설 유형</span>
						<div>
							<ul>
								<li>
									<input type="checkbox" class="lodge_type" id="lodge_hotel" value="0"/>
									<label for="lodge_hotel">호텔</label>
								</li>
								<li>
									<input type="checkbox" class="lodge_type" id="lodge_motel" value="1"/>
									<label for="lodge_motel">모텔</label>
								</li>
								<li>
									<input type="checkbox" class="lodge_type" id="lodge_apartment" value="2"/>
									<label for="lodge_apartment">아파트식호텔(레지던스)</label>
								</li>
								<li>
									<input type="checkbox" class="lodge_type" id="lodge_resort" value="3"/>
									<label for="lodge_resort">리조트</label>
								</li>
								<li>
									<input type="checkbox" class="lodge_type" id="lodge_pension" value="4"/>
									<label for="lodge_pension">펜션</label>
								</li>
							</ul>
							<input type="hidden" name="lodge_type" value="" />
						</div>
					</div>
					
					<div id="filter_amenities">
						<span>편의시설/서비스</span>
						<div>
							<ul>
								<li>
									<input type="checkbox" id="breakfast" class="amenities" name="breakfast" value="on"/>
									<label for="breakfast">조식</label>
								</li>
								<li>
									<input type="checkbox" id="pool" class="amenities" name="pool" value="on"/>
									<label for="pool">수영장</label>
								</li>
								<li>
									<input type="checkbox" id="wifi" class="amenities" name="wifi" value="on"/>
									<label for="wifi">WiFi 포함</label>
								</li>
								<li>
									<input type="checkbox" id="seaView" class="amenities" name="seaView" value="on"/>
									<label for="seaView">바다 전망</label>
								</li>
								<li>
									<input type="checkbox" id="pet" class="amenities" name="pet" value="on"/>
									<label for="pet">반려동물 동반 가능</label>
								</li>
								<li>
									<input type="checkbox" id="spa" class="amenities" name="spa" value="on"/>
									<label for="spa">스파</label>
								</li>
								<li>
									<input type="checkbox" id="parking" class="amenities" name="parking" value="on"/>
									<label for="parking">주차</label>
								</li>
								<li>
									<input type="checkbox" id="kitchen" class="amenities" name="kitchen" value="on"/>
									<label for="kitchen">주방</label>
								</li>
								<li>
									<input type="checkbox" id="aircon" class="amenities" name="aircon" value="on"/>
									<label for="aircon">에어컨</label>
								</li>
								<li>
									<input type="checkbox" id="restaurant"  id=""class="amenities" name="restaurant" value="on"/>
									<label for="restaurant">레스토랑</label>
								</li>
								<li>
									<input type="checkbox" id="babyBed" class="amenities" name="babyBed" value="on"/>
									<label for="babyBed">유아용 침대</label>
								</li>
								<li>
									<input type="checkbox" id="washerDryer" class="amenities" name="washerDryer" value="on"/>
									<label for="washerDryer">세탁기 및 건조기</label>
								</li>
								<li>
									<span class="read_more">더 보기</span>
								</li>
								<li>
									<span class="read_less">간단히 보기</span>
								</li>
							</ul>
						</div>
					</div>
						
				</div>
				<!-- 재훈 : 검색된 내용 필터   끝 -->
				
				<!-- 재훈 : 검색된 내용 보여주기 시작 -->
				<div id="search_item">
					<!-- 정렬 필터 -->
					<div id="search_sort">
					
						<div id="search_sort_desc">
							<div>300여 개 숙박 시설</div>
							<div>저희에게 지불되는 금액이 정렬 순서에 영향을 미칩니다</div>
						</div>
						
						<div id="search_sort_form">
							
							<label for="sort_select" >정렬 기준</label>
							<select id="sort_select" name="sort">
								<option class="sort_item" value="Recommended">추천</option>
								<option class="sort_item" value="LowToHigh">낮은가격순</option>
								<option class="sort_item" value="HighToLow">높은가격순</option>
								<option class="sort_item" value="ReviewRating">평점순</option>
							</select>
							
						</div>
						
					</div>
					
					<div id="search_item_list">
						<!-- Ajax로 보여주는 페이지 -->
					</div>
				</div>
				<!-- 재훈 : 검색된 내용 보여주기   끝 -->
			</div>
		</form>
		<!-- 재훈 : 검색내용 본문   끝 -->
	</div>
	
	<form name="go_detail_frm">
		<input type="hidden" name="lodge_id" />
		<input type="hidden" name="startDate" />
		<input type="hidden" name="endDate" />
		<input type="hidden" name="guest" />
		<input type="hidden" name="adults" />
		<input type="hidden" name="childs" />
		<input type="hidden" name="room" value="1" />
	</form>
</body>