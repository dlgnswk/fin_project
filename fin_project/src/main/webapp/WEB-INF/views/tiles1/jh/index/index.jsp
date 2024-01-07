<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<%
	String ctxPath = request.getContextPath();
    //      /board
%>  

<style type="text/css">

	.highcharts-figure,
	.highcharts-data-table table {
	    min-width: 320px;
	    max-width: 800px;
	    margin: 1em auto;
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

</style>

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/css/jh/index/index.css" />

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>

<script src="<%= ctxPath%>/resources/Highcharts-10.3.3/code/highcharts.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.3/code/modules/wordcloud.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.3/code/modules/exporting.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.3/code/modules/export-data.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.3/code/modules/accessibility.js"></script>

<script type="text/javascript">
	
	$(document).ready(function(){
		
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
						// console.log(JSON.stringify(json))
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
		var dateSelector = document.querySelector('.dateSelector');dateSelector.flatpickr({
		    mode: "range",
		    enable: [{from: "${requestScope.date_map.today_date}", to: "${requestScope.date_map.after_1year_date}"}],
		    dateFormat: "Y-m-d",
		    defaultDate: ["${requestScope.date_map.today_date}", "${requestScope.date_map.after_tommorrow_date}"]
		});
		// 2023-12-05 ~ 2023-12-06 형식으로 나옴.

		
		// 재훈 : 페이지 로드시 인원 선택창 가리기
		$("div#travler_select").hide();
	
		// 재훈 : 인원 선택창 클릭시 선택화면 보이기
		$("div#box_travler").click(function(e) {
			$("div#travler_select").show();
		});
	
		// 재훈 : 인원 선택창 클릭시 선택화면 보이기
		$("button[name='btn_travler']").click(function(e) {
			$("div#travler_select").hide();
			$("span#total_travler").text($("input[name='travlers']").val());
		});
		
		// 재훈 : 페이지 로드시 인원 선택 버튼 클래스 추가
		$("button[name='btn_travler']").addClass("btn_travler_ok");

		// 재훈 : 페이지 로드시 span#total_travler의 기본 인원수를 hidden input[name='travlers']에 넣어주기
		$("input[name='travlers']").val($("span#total_travler").text());
		
		// 재훈 : 페이지 로드시 인원선택창에 기본값을 띄워주기
		$("input.adult_cnt_select").val($("input[name='travlers']").val());
		$("input.kid_cnt_select").val("0");

		// 재훈 : 페이지 로드시 adult, kid의 기본 인원수를 넣어주기
		$("input[name='adult']").val($("input.adult_cnt_select").val());
		$("input[name='kid']").val($("input.kid_cnt_select").val());

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
			frm.action = "<%= ctxPath%>/lodgeSearch.action";  
			frm.submit(); 
			
		});
		
		// 재훈 : 클릭할 경우 wordcloud 보여주기 시작
		$("div.show_wordcloud").text("통계보기");
		
		$(document).on("click", "div.show_wordcloud", function(){
			
			if($("div.show_wordcloud").text() == "통계보기"){
				show_wordcloud();
				$("div.show_wordcloud").text("통계숨기기");
			}
			else{
				$("div#chart_container").text("");
				$("div.show_wordcloud").text("통계보기");
			}
			
		});
		
		
		// 재훈 : 검색창에 x 클릭할경우 검색내용 지워주기
		$("button#search_clear").click(function(){
			$("input#input_destination_search").val("");
		})
		
		
		// 재훈 : 페이지 로드시 날짜 히든 인풋에 값 넣어주기
		var date_val = $("input#input_date").val();
		var date_val_arr = date_val.split(" ~ ");
		// 2023-12-05 ~ 2023-12-06
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

		$("input[name='check_in']").val(start_date);
		$("input[name='check_out']").val(finish_date);
		
		// 재훈 : 날짜변경시 날짜 히든 인풋에 값 넣어주기
		$("input#input_date").change(function(){
			
			var date_val = $("input#input_date").val();
			var date_val_arr = date_val.split(" ~ ");
			// 2023-12-05 ~ 2023-12-06
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

			$("input[name='check_in']").val(start_date);
			$("input[name='check_out']").val(finish_date);
			
		})
		
		
		//
		$(document).on("click", ".filter_icon_button", function(){
			
			var filter = $(this).attr("name");
			var check_in = $("input[name='check_in']").val();
			var check_out = $("input[name='check_out']").val();
			
			var travlers = $("input[name='travlers']").val();
			var adult = $("input[name='adult']").val();
			var kid = $("input[name='kid']").val();
			
			location.href="<%= ctxPath%>/lodgeSearch.action?lg_name=&lg_area_2=&lg_area=&check_in=" + check_in + "&check_out=" + check_out + "&travlers=" + travlers + "&adult=" + adult + "&kid=" + kid + "&" + filter + "=on";
		})
		
		// 재훈 : 검색창에 x 클릭할경우 검색내용 지워주기
		$("button#search_clear").click(function(){
			$("input#input_destination").val("");
			$("input#input_destination_search").val("");
			
		});
			
	}); // end of $(document).ready(function(){});
	
	// Function Declarationfunction
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

	
	// =========== 숙소 검색하기 클릭시 검색화면 활성화 시키기 시작 =========== //
	function click_destination(){
		$("div#div_destination_search").show();
		$("input#input_destination_search").val($("input#input_destination").val());
		$("input#input_destination_search").focus();
	};
	// =========== 숙소 검색하기 클릭시 검색화면 활성화 시키기   끝 =========== //
	
	
	// =========== wordcloud 보여주기 시작 =========== //
	function show_wordcloud(){
		
		$.ajax({
			url:"<%=ctxPath%>/index/wordCloud.action",
			dataType:"text",
			success:function(search_result){
				
				const text = search_result,
			    lines = text.replace(/[():'?0-9]+/g, '').split(/[,]+/g),
			    data = lines.reduce((arr, word) => {
					let obj = Highcharts.find(arr, obj => obj.name === word);
					
					
					if (obj) {
						obj.weight += 1;
					} 
					else {
						obj = {
							name: word,
							weight: 1
						}
						arr.push(obj);
					}
					
					return arr;
				}, []);
				
				Highcharts.seriesTypes.wordcloud.prototype.deriveFontSize = function (relativeWeight) {
					var maxFontSize = 25;
					// Will return a fontSize between 0px and 25px.
					return Math.floor(maxFontSize * relativeWeight);
				};
				
				//////////////////////////////////////////////////////////////////
				Highcharts.chart('chart_container', {
				    accessibility: {
				        screenReaderSection: {
				            beforeChartFormat: "<div class='chart_title'><h5>{chartTitle}</h5></div>" +
				                "<div class='chart_subtitle'>{chartSubtitle}</div>" +
				                '<div>{chartLongdesc}</div>' +
				                '<div>{viewTableButton}</div>'
				        }
				    },
				    series: [{
				        type: 'wordcloud',
				        data,
				        name: 'Occurrences'
				    }],
				    title: {
				        text: '익스피디아 회원들은 지금 이곳을 검색하고 있어요!',
				        align: 'left'
				    },
				    subtitle: {
				        text: '최근 일주일간의 검색 통계를 통해 작성되었습니다.',
				        align: 'left'
				    },
				    tooltip: {
				        headerFormat: '<span style="font-size: 16px"><b>{point.key}</b></span><br>'
				    },
				    colors: [
				    	'#FDDF4B',
				    	'#083a5f',
				    	'#1E233E'
				    ],

			    	plotOptions: {
			    	    column: {
			    	        colorByPoint: true
			    	    }
			    	}
				});

		
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		}); // end of $.ajax({});
		
	}
	// =========== wordcloud 보여주기    끝 =========== //
	
	
</script>

<title>Expedia Travel</title>

<body style="background-color: white;">
	<div style="inline-size: 100%; margin: auto; max-inline-size: 75rem; padding: 50px 0;">
		
		<!-- 재훈 : 검색 박스 만들기 시작 -->
		<div id="search_box">
			<form name="searchFrm">
				<div id="div_search_box">
					<div id="div_search_box_align">
					
						<!-- 재훈 : 목적지 검색 시작 -->
						<div id="btn_destination">
							
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
										<input id="input_destination" type="text" placeholder="클릭해서 검색하세요." autocomplete="off"/>
										<%--
										<input name="nation" type="hidden"/>
										--%>
										<input name="lg_area" type="hidden"/>
										<input name="lg_area_2" type="hidden"/>
										<input name="lg_name" type="hidden"/>
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
						<div id="btn_date">
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
						<div id="box_travler">
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
										
										<input class="travler_cnt adult_cnt_select" />
										
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
										
										<input class="travler_cnt kid_cnt_select" />
										
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
						
						<button name="btn_search" type="button">검색</button>
						
					</div>
				</div>
			</form>
		</div>
		<!-- 재훈 : 검색 박스 만들기 끝 -->
		
		
		<!-- 재훈 : 필터 넣기 아이콘 시작 -->
		<div class="filter_search">
			<div class="filter_icon_title">마음에 꼭 맞는 새로운 숙소를 찾아보세요!</div>
			
			<div class="filter_icon_content">
				
				<%-- 수영장 --%>
				<div class="filter_icon" class="uitk-layout-grid uitk-layout-grid-has-auto-columns uitk-layout-grid-has-space uitk-layout-grid-display-grid uitk-layout-grid-justify-items-center" style="--uitk-layoutgrid-auto-columns:minmax(var(--uitk-layoutgrid-egds-size__0x), 1fr);--uitk-layoutgrid-column-gap:var(--uitk-layoutgrid-space-two);--uitk-layoutgrid-row-gap:var(--uitk-layoutgrid-space-two)">
					<button name="pool" tabindex="-1" type="button" class="filter_icon_button uitk-button uitk-button-medium uitk-button-only-icon uitk-button-secondary button-secondary-custom-class">
						<svg class="filter_icon_svg uitk-icon uitk-icon uitk-icon-leading" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
							<path d="M9.82 11.64h.01a4.15 4.15 0 0 1 4.36 0h.01c.76.46 1.54.47 2.29 0l.41-.23L10.48 5C8.93 3.45 7.5 2.99 5 3v2.5c1.82-.01 2.89.39 4 1.5l1 1-3.25 3.25c.27.1.52.25.77.39.75.47 1.55.47 2.3 0z"></path>
							<path fill-rule="evenodd" d="M21.98 16.5c-1.1 0-1.71-.37-2.16-.64h-.01a2.08 2.08 0 0 0-2.29 0 4.13 4.13 0 0 1-4.36 0h-.01a2.08 2.08 0 0 0-2.29 0 4.13 4.13 0 0 1-4.36 0h-.01a2.08 2.08 0 0 0-2.29 0l-.03.02c-.47.27-1.08.62-2.17.62v-2c.56 0 .78-.13 1.15-.36a4.13 4.13 0 0 1 4.36 0h.01c.76.46 1.54.47 2.29 0a4.13 4.13 0 0 1 4.36 0h.01c.76.46 1.54.47 2.29 0a4.13 4.13 0 0 1 4.36 0h.01c.36.22.6.36 1.14.36v2z" clip-rule="evenodd"></path>
							<path d="M19.82 20.36c.45.27 1.07.64 2.18.64v-2a1.8 1.8 0 0 1-1.15-.36 4.13 4.13 0 0 0-4.36 0c-.75.47-1.53.46-2.29 0h-.01a4.15 4.15 0 0 0-4.36 0h-.01c-.75.47-1.55.47-2.3 0a4.15 4.15 0 0 0-4.36 0h-.01A1.8 1.8 0 0 1 2 19v2c1.1 0 1.72-.36 2.18-.63l.01-.01a2.07 2.07 0 0 1 2.3 0c1.39.83 2.97.82 4.36 0h.01a2.08 2.08 0 0 1 2.29 0h.01c1.38.83 2.95.83 4.34.01l.02-.01a2.08 2.08 0 0 1 2.29 0h.01zM19 5.5a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0z"></path>
						</svg>
					</button>
					<div class="filter_icon_text">수영장</div>
				</div>
				
				<%-- 스파 --%>
				<div class="filter_icon" class="uitk-layout-grid uitk-layout-grid-has-auto-columns uitk-layout-grid-has-space uitk-layout-grid-display-grid uitk-layout-grid-justify-items-center" style="--uitk-layoutgrid-auto-columns:minmax(var(--uitk-layoutgrid-egds-size__0x), 1fr);--uitk-layoutgrid-column-gap:var(--uitk-layoutgrid-space-two);--uitk-layoutgrid-row-gap:var(--uitk-layoutgrid-space-two)">
					<button name="spa" tabindex="-1" type="button" class="filter_icon_button uitk-button uitk-button-medium uitk-button-only-icon uitk-button-secondary button-secondary-custom-class filter_icon_button">
						<svg class="filter_icon_svg uitk-icon uitk-icon uitk-icon-leading" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
							<path fill-rule="evenodd" d="M12.06 2a11.8 11.8 0 0 1 3.43 7.63A14.36 14.36 0 0 0 12 12.26a13.87 13.87 0 0 0-3.49-2.63A12.19 12.19 0 0 1 12.06 2zM2 10a12.17 12.17 0 0 0 10 12 12.17 12.17 0 0 0 10-12c-4.18 0-7.85 2.17-10 5.45A11.95 11.95 0 0 0 2 10z" clip-rule="evenodd"></path>
						</svg>
					</button>
					<div class="filter_icon_text">스파</div>
				</div>
				
				<%-- 반려동물 --%>
				<div class="filter_icon" class="uitk-layout-grid uitk-layout-grid-has-auto-columns uitk-layout-grid-has-space uitk-layout-grid-display-grid uitk-layout-grid-justify-items-center" style="--uitk-layoutgrid-auto-columns:minmax(var(--uitk-layoutgrid-egds-size__0x), 1fr);--uitk-layoutgrid-column-gap:var(--uitk-layoutgrid-space-two);--uitk-layoutgrid-row-gap:var(--uitk-layoutgrid-space-two)">
					<button name="pet" tabindex="-1" type="button" class="filter_icon_button uitk-button uitk-button-medium uitk-button-only-icon uitk-button-secondary button-secondary-custom-class filter_icon_button">
						<svg class="filter_icon_svg uitk-icon uitk-icon uitk-icon-leading" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
							<path d="M9 8a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5zm-4.5 4a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5zm13-6.5a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0zm2 6.5a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5zm-9.7-.61-5.15 5.58A3 3 0 0 0 6.85 22h.65l1.19-.13a30 30 0 0 1 6.62 0l1.19.13h.65a3 3 0 0 0 2.2-5.03l-5.15-5.58a3 3 0 0 0-4.4 0z"></path>
						</svg>
					</button>
					<div class="filter_icon_text">반려동물</div>
				</div>
				
				<%-- 오션뷰 --%>
				<div class="filter_icon" class="uitk-layout-grid uitk-layout-grid-has-auto-columns uitk-layout-grid-has-space uitk-layout-grid-display-grid uitk-layout-grid-justify-items-center" style="--uitk-layoutgrid-auto-columns:minmax(var(--uitk-layoutgrid-egds-size__0x), 1fr);--uitk-layoutgrid-column-gap:var(--uitk-layoutgrid-space-two);--uitk-layoutgrid-row-gap:var(--uitk-layoutgrid-space-two)">
					<button name="seaView" tabindex="-1" type="button" class="filter_icon_button uitk-button uitk-button-medium uitk-button-only-icon uitk-button-secondary button-secondary-custom-class filter_icon_button">
						<svg class="filter_icon_svg uitk-icon uitk-icon uitk-icon-leading" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
							<path d="M21.98 14H22h-.02ZM5.35 13c1.19 0 1.42 1 3.33 1 1.95 0 2.09-1 3.33-1 1.19 0 1.42 1 3.33 1 1.95 0 2.09-1 3.33-1 1.19 0 1.4.98 3.31 1v-2c-1.19 0-1.42-1-3.33-1-1.95 0-2.09 1-3.33 1-1.19 0-1.42-1-3.33-1-1.95 0-2.09 1-3.33 1-1.19 0-1.42-1-3.33-1-1.95 0-2.09 1-3.33 1v2c1.9 0 2.17-1 3.35-1Zm13.32 2c-1.95 0-2.09 1-3.33 1-1.19 0-1.42-1-3.33-1-1.95 0-2.1 1-3.34 1-1.24 0-1.38-1-3.33-1-1.95 0-2.1 1-3.34 1v2c1.95 0 2.11-1 3.34-1 1.24 0 1.38 1 3.33 1 1.95 0 2.1-1 3.34-1 1.19 0 1.42 1 3.33 1 1.94 0 2.09-1 3.33-1 1.19 0 1.42 1 3.33 1v-2c-1.24 0-1.38-1-3.33-1ZM5.35 9c1.19 0 1.42 1 3.33 1 1.95 0 2.09-1 3.33-1 1.19 0 1.42 1 3.33 1 1.95 0 2.09-1 3.33-1 1.19 0 1.4.98 3.31 1V8c-1.19 0-1.42-1-3.33-1-1.95 0-2.09 1-3.33 1-1.19 0-1.42-1-3.33-1-1.95 0-2.09 1-3.33 1-1.19 0-1.42-1-3.33-1C3.38 7 3.24 8 2 8v2c1.9 0 2.17-1 3.35-1Z"></path>
						</svg>
					</button>
					<div class="filter_icon_text">오션뷰</div>
				</div>
				
				<%-- 레스토랑 --%>
				<div class="filter_icon" class="uitk-layout-grid uitk-layout-grid-has-auto-columns uitk-layout-grid-has-space uitk-layout-grid-display-grid uitk-layout-grid-justify-items-center" style="--uitk-layoutgrid-auto-columns:minmax(var(--uitk-layoutgrid-egds-size__0x), 1fr);--uitk-layoutgrid-column-gap:var(--uitk-layoutgrid-space-two);--uitk-layoutgrid-row-gap:var(--uitk-layoutgrid-space-two)">
					<button name="restaurant" tabindex="-1" type="button" class="filter_icon_button uitk-button uitk-button-medium uitk-button-only-icon uitk-button-secondary button-secondary-custom-class filter_icon_button">
						<svg class="filter_icon_svg_2 uitk-icon uitk-icon uitk-icon-leading" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512">
							<path d="M416 0C400 0 288 32 288 176V288c0 35.3 28.7 64 64 64h32V480c0 17.7 14.3 32 32 32s32-14.3 32-32V352 240 32c0-17.7-14.3-32-32-32zM64 16C64 7.8 57.9 1 49.7 .1S34.2 4.6 32.4 12.5L2.1 148.8C.7 155.1 0 161.5 0 167.9c0 45.9 35.1 83.6 80 87.7V480c0 17.7 14.3 32 32 32s32-14.3 32-32V255.6c44.9-4.1 80-41.8 80-87.7c0-6.4-.7-12.8-2.1-19.1L191.6 12.5c-1.8-8-9.3-13.3-17.4-12.4S160 7.8 160 16V150.2c0 5.4-4.4 9.8-9.8 9.8c-5.1 0-9.3-3.9-9.8-9L127.9 14.6C127.2 6.3 120.3 0 112 0s-15.2 6.3-15.9 14.6L83.7 151c-.5 5.1-4.7 9-9.8 9c-5.4 0-9.8-4.4-9.8-9.8V16zm48.3 152l-.3 0-.3 0 .3-.7 .3 .7z"/>
						</svg>
					</button>
					<div class="filter_icon_text">레스토랑</div>
				</div>
				
				<%-- 주차가능 --%>
				<div class="filter_icon" class="uitk-layout-grid uitk-layout-grid-has-auto-columns uitk-layout-grid-has-space uitk-layout-grid-display-grid uitk-layout-grid-justify-items-center" style="--uitk-layoutgrid-auto-columns:minmax(var(--uitk-layoutgrid-egds-size__0x), 1fr);--uitk-layoutgrid-column-gap:var(--uitk-layoutgrid-space-two);--uitk-layoutgrid-row-gap:var(--uitk-layoutgrid-space-two)">
					<button name="parking" tabindex="-1" type="button" class="filter_icon_button uitk-button uitk-button-medium uitk-button-only-icon uitk-button-secondary button-secondary-custom-class filter_icon_button">
						<svg class="filter_icon_svg_2 uitk-icon uitk-icon uitk-icon-leading" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512">
							<path d="M64 32C28.7 32 0 60.7 0 96V416c0 35.3 28.7 64 64 64H384c35.3 0 64-28.7 64-64V96c0-35.3-28.7-64-64-64H64zM192 256h48c17.7 0 32-14.3 32-32s-14.3-32-32-32H192v64zm48 64H192v32c0 17.7-14.3 32-32 32s-32-14.3-32-32V288 168c0-22.1 17.9-40 40-40h72c53 0 96 43 96 96s-43 96-96 96z"/>
						</svg>
					</button>
					<div class="filter_icon_text">주차장</div>
				</div>
				
				<%-- 인터넷 --%>
				<div class="filter_icon" class="uitk-layout-grid uitk-layout-grid-has-auto-columns uitk-layout-grid-has-space uitk-layout-grid-display-grid uitk-layout-grid-justify-items-center" style="--uitk-layoutgrid-auto-columns:minmax(var(--uitk-layoutgrid-egds-size__0x), 1fr);--uitk-layoutgrid-column-gap:var(--uitk-layoutgrid-space-two);--uitk-layoutgrid-row-gap:var(--uitk-layoutgrid-space-two)">
					<button name="wifi" tabindex="-1" type="button" class="filter_icon_button uitk-button uitk-button-medium uitk-button-only-icon uitk-button-secondary button-secondary-custom-class filter_icon_button">
						<svg class="filter_icon_svg_2 uitk-icon uitk-icon uitk-icon-leading" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512">
							<path d="M54.2 202.9C123.2 136.7 216.8 96 320 96s196.8 40.7 265.8 106.9c12.8 12.2 33 11.8 45.2-.9s11.8-33-.9-45.2C549.7 79.5 440.4 32 320 32S90.3 79.5 9.8 156.7C-2.9 169-3.3 189.2 8.9 202s32.5 13.2 45.2 .9zM320 256c56.8 0 108.6 21.1 148.2 56c13.3 11.7 33.5 10.4 45.2-2.8s10.4-33.5-2.8-45.2C459.8 219.2 393 192 320 192s-139.8 27.2-190.5 72c-13.3 11.7-14.5 31.9-2.8 45.2s31.9 14.5 45.2 2.8c39.5-34.9 91.3-56 148.2-56zm64 160a64 64 0 1 0 -128 0 64 64 0 1 0 128 0z"/>
						</svg>
					</button>
					<div class="filter_icon_text">인터넷</div>
				</div>
				
			</div>
		</div>
		
		
		<!-- 재훈 : 로그인 할인 광고 -->
		<div class="login_discount">
			<div class="login_discount_image">
				<div class="login_discount_title">익스피디아 리워드로 즉시 할인</div>
				<div class="login_discount_content">수천 개 호텔에서 평균 15% 할인되는 회원가 등의 특전을 누리실 수 있어요. 이용약관이 적용될 수 있습니다.</div>
				<div>
					<c:if test="${sessionScope.loginuser == null}">
						<a class="login_discount_button" href="<%= ctxPath%>/login.exp">로그인하고 할인받기</a>
					</c:if>
					<c:if test="${sessionScope.loginuser != null}">
						<a class="login_discount_button" href="#headerOfheader" onclick="click_destination()">숙소 검색하기</a>
					</c:if>
				</div>
				<img alt="Travel Sale Activity deals" class="image_thumnail" src="https://a.travel-assets.com/travel-assets-manager/cmct-5255/POSa-HP-Hero-D-928x398.jpg?impolicy=fcrop&amp;w=1400&amp;h=600&amp;q=mediumHigh">
			</div>
		</div>
		
		
		<!-- 재훈 : 검색 통계 만들기 시작 -->
		<div class="chart_title">
			<div class='chart_title_text1'>완벽한 숙소를 찾고 계세요?</div>
			<div class='chart_title_text2'>다른 여행객이 확인한 숙박 시설을 확인해 보세요.</div>
			<div class='chart_content'>
				<div class="show_wordcloud"></div>
				
				<svg class="uitk-icon uitk-link-icon-medium uitk-icon-directional uitk-icon-xsmall" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
					<path d="m12 4-1.41 1.41L16.17 11H4v2h12.17l-5.58 5.59L12 20l8-8-8-8z"></path>
				</svg>
			</div>
			
			<div id="chart_container"></div>
		</div>
		<!-- 재훈 : 검색 통계 만들기    끝 -->
		
	</div>
</body>