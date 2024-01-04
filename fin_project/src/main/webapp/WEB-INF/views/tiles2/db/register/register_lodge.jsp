<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>

<link type="text/css" rel="stylesheet" href="<%= ctxPath%>/resources/css/db/register_lodge.css" />
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>


<script type="text/javascript">

	$(document).ready(function(){
		
		$(".submit_check").hide();
		$(".hidden").hide();
		$(".error").hide();
		
		// "예" "아니오" 버튼 태그 다음 div 숨김
		$("div.y_btn_after").hide();
		
		// 셀프체크인 방법 설명 p 숨김
		$("p.fk_self_checkin_p").hide();
		
		// 시간 선택지 숨기기
		$("div.use_time").hide();
		$("div.use_time").find("select").prop("disabled",true);
		$("div.use_time").find("input").prop("disabled",true);
		
		
		// 숙박시설ID -- lodge_id  -시작-
		$("input#front_id").bind("keyup", function(){
			// 영문이 아닌값 변환
			let front_id = $("input#front_id").val().replace(/[^A-Za-z]/ig, '');
			// 대문자로 전환
			front_id = front_id.toUpperCase();
			// 값 다시 입력
			$("input#front_id").val(front_id);
			
			// 뒤에 문자
			let back_id = $("input#back_id").val();
			// 숙박시설 ID
			let lodge_id = front_id + back_id;
			// 숙박시설 ID 입력
			$("input[name='lodge_id']").val(lodge_id);
			
			$(this).parent().parent().find(".submit_check").hide();
			$(this).parent().parent().find(".error").hide();
			lodgeID_check();
		});	// end of front_id 
		
		$("input#back_id").bind("keyup", function(){
			// 영문이 아닌값 변환
			let back_id = $("input#back_id").val().replace(/[^0-9]/g, '');
			// 값 다시 입력
			$("input#back_id").val(back_id);
			
			// 뒤에 문자
			let front_id = $("input#front_id").val();
			// 숙박시설 ID
			let lodge_id = front_id + back_id;
			// 숙박시설 ID 입력
			$("input[name='lodge_id']").val(lodge_id);
			
			$(this).parent().parent().find(".submit_check").hide();
			$(this).parent().parent().find(".error").hide();
			lodgeID_check();
		});	// end of back_id
		// 숙박시설ID -- lodge_id  -끝-
	
		
		// 호텔명 입력시 에러 감추기
		let lg_name = $("input[name='lg_name']");
			
		lg_name.keyup(function(){
			$(this).parent().parent().find(".error").hide();
			$(this).parent().parent().find(".submit_check").hide();
		}); // end of lg_name.keyup(function(){
		
		// 호텔 영문명 입력시 에러 감추기
		let lg_en_name = $("input[name='lg_en_name']");
		
		lg_en_name.keyup(function(){
			$(this).parent().parent().find(".error").hide();
			$(this).parent().parent().find(".submit_check").hide();
		}); // end of lg_name.keyup(function(){
		
		// "예"	"아니오"를 누르면 에러 문구 숨김	
		$("div.btn_div > button").click(function(){
			$(this).parent().parent().find(".submit_check").hide();
			$(this).parent().parent().find(".error").hide();
		}); //  end of $("div.btn_div > button").click(function()

		// 옵션 체크 박스 체크시 에러 숨김
		$("input.checkbox_text").click(function(){
			$(this).parent().parent().parent().find(".submit_check").hide();
			$(this).parent().parent().parent().find(".error").hide();			
		}); // end of $("input.checkbox_text").click(function()
		
		// 호텔 유형 선택
		$("select[name='fk_lodge_type']").change(function(){
			$(this).parent().parent().find(".submit_check").hide();
			$(this).parent().parent().find(".error").hide();
		}); // end of $("select[name='fk_lodge_type']").change(function()
		
		// 호텔 등급
		$("select[name='lg_hotel_star']").change(function(){
			$(this).parent().parent().find(".submit_check").hide();
			$(this).parent().parent().find(".error").hide();
		}); // end of $("select[name='lg_hotel_star']").change(function()
		
		// 객실수 입력시 에러 숨김
		$("input[name='lg_qty']").keyup(function(){
			$(this).parent().parent().find(".submit_check").hide();
			$(this).parent().parent().find(".error").hide();
		}); // end of $("input[name='lg_qty']").change(function()
				
		// 환불 정책 에러 숨김
		$("select[name='fk_cancel_opt']").change(function(){
			$(this).parent().parent().find(".submit_check").hide();
			$(this).parent().parent().find(".error").hide();
		}); // end of $("select[name='fk_cancel_opt']").change(function()
		
		// 셀프체크인 에러 숨김
		$("select[name='fk_s_checkin_type']").change(function(){
			$(this).parent().parent().find(".submit_check").hide();
			$(this).parent().parent().find(".error").hide();
		}); // end of $("select[name='fk_s_checkin_type']").change(function()

				
		// 체크인 시간 에러 숨김
		$("select[name='lg_checkin_end_time']").change(function(){
			$(this).parent().parent().find(".submit_check").hide();
			$(this).parent().parent().find(".error").hide();
		}); // end of $("select[name='lg_checkin_end_time']").change(function()
			
		// 체크아웃 시간 에러 숨김
		$("select[name='lg_checkout_time']").change(function(){
			$(this).parent().parent().find(".submit_check").hide();
			$(this).parent().parent().find(".error").hide();
		}); // end of $("select[name='lg_checkout_time']").change(function()
		
		// 나이 제한 에러 숨김
		$("select[name='lg_age_limit']").change(function(){
			$(this).parent().parent().find(".submit_check").hide();
			$(this).parent().parent().find(".error").hide();
		}); // end of $("select[name='lg_checkout_time']").change(function()
		
		
		// 스파 종류 에러 숨김
		$("select[name='fk_spa_type']").change(function(){
			$(this).parent().parent().find(".submit_check").hide();
			$(this).parent().parent().find(".error").hide();
		}); // end of $("select[name='lg_checkout_time']").change(function()
		
		// 수영장 운영 시간 에러 숨김 "end_tiem"
		$("div.fk_pool_opt_no select.end_time").change(function(){
			$(this).parent().parent().find(".submit_check").hide();
			$(this).parent().parent().find(".error").hide();
		}); // end of $("div.lg_pool_time > select.end_time").click(function(){
		
		// 수영장 운영 시간 에러 숨김 "24시간"
		$("div.use_time > input:checkbox").click(function(){
			$(this).parent().find(".submit_check").hide();
			$(this).parent().find(".error").hide();
		}); // end of $("div.lg_pool_time > select.end_time").click(function(){
			
		// 반려동물 요금 
		$("input[name='lg_pet_fare']").keyup(function(){
			const petFare = $("input[name='lg_pet_fare']");
			
			petFare.parent().parent().find(".submit_check").hide();
			petFare.parent().parent().find(".error").hide();
			
			if(petFare.val().indexOf("0") == 0){
				petFare.val(petFare.val().substr(1));
			}

			if(petFare.val().length > 9) {
				petFare.val(petFare.val().substr(0,9));	
			}
			
		}); // end of $("input[name='lg_pet_fare']").keyup(function(){
			
			
		// === 셀프체크인 === //
		
		// 셀프체크인 이 바뀌면 해당되는 설명(p태그) 보여주기
		$("select[name='fk_s_checkin_type']").change(function(){
			// 셀프체크인 방법 설명 p 숨김
			$("p.fk_self_checkin_p").hide();
			
			const select_val = $(this).val()
			
			$.each($("p.fk_self_checkin_p"), function(index, item){
				// 선택된 select 태그의 value 와 p태그의 class가 같다면 보여주어라 
				if( $(item).attr("id") == select_val ) {
					$(item).show();
				}
				
			});// end of $.each($("p.fk_self_checkin_p"), function(index, item)
			
		}); // end of $("select[name='fk_self_checkin']").change(function()

		$("select.start_time").val("1").trigger("change");
		
		
		// 24 시간 클릭시
		$("input:checkbox.all_time_").click(function(){
			
			if( $(this).prop("checked") ) {
			// 체크를 한 경우
				$(this).next().next().val("24시간"); // 24시간
				$(this).parent().find("select").prop("disabled", true); // select 태그 잠금
			}
			else {
			// 체크를 해제한 경우
				$(this).parent().find("select").prop("disabled", false); // select 태그 해제
				
				const start_time = $(this).parent().find("select.start_time option:selected").text();
				const end_time = $(this).parent().find("select.end_time option:selected").text();
				$(this).next().next().val(start_time+" ~ "+end_time);
			}
			
		});// end of $("input:checkbox").click(function() ----- 프런트 데스크 24시간 클릭 이벤트
		
		
	//	console.log("$(window).height() => ", $(window).height() );
	//	console.log("$(window).width() => ", $(window).width() );
		
		// == 스크롤 시 발생하는 이벤트 (위도, 경도, 지역명) -시작- == //	
		$(window).scroll(function(){
		//	console.log("$(window).scrollTop() => ", $(window).scrollTop() );
			const scroll = $(window).scrollTop();
			
			$("div.out_step_text").removeClass("current_step");
			
			let lodge_info_a_x = $("h2#lodge_info_a").offset().top;
			let set_lodge_a_x = $("div#set_lodge_a").offset().top;
			let facilty_a_x = $("div#facilty_a").offset().top;
			
//			console.log(lodge_info_a_x);
//			console.log(set_lodge_a_x);
//			console.log(facilty_a_x);
			
			
			if( scroll >= 0 && scroll < set_lodge_a_x) {
				$("div.step_1").addClass("current_step");
			}
			else if ( scroll >= lodge_info_a_x && scroll < facilty_a_x-1) {
				$("div.step_2").addClass("current_step");
			}
			else if ( scroll >= facilty_a_x-1 ) {
				$("div.step_3").addClass("current_step");
			}
			 
			
			// 등록하기 버튼 전  (위도,경도, 지역명 잘라서 넣기) //
			if( $(window).scrollTop() >= 2220) {
			//	alert("바뀜");
				const address = $("input#address").val();
				
				if(address != "") {
					// 위도 경도
					func_geocoder(address);
					
					// 주소 키워드
					let address_arr = address.split(" ");
				//	console.log("address_arr => ", address_arr);
				//	console.log("address_arr =>[0] ", address_arr[0]);
				//	console.log("address_arr =>[1] ", address_arr[1]);
					
					$("input#lg_area").val(address_arr[0]);
					$("input#lg_area_2").val(address_arr[1]);
				}
			}// end of $(window).scroll(function() ------
			
		});
		// == 스크롤 시 발생하는 이벤트 (위도, 경도, 지역명) -끝- == //
		
		
		 
		// 수영장 유무에 따른 수영장 운영시간 -시작- //
		const fk_pool_type_tag = $("select[name='fk_pool_type']");
		fk_pool_type_tag.parent().parent().next("div").hide();
		
		fk_pool_type_tag.change(function(){
			
			if( $(this).val() != 0 ){
			// 수영장 있음
				$(this).parent().parent().next("div").show();
				$(this).parent().parent().next("div").find("select").prop("disabled", false);
				
				if( $(this).parent().parent().next("div").find("input:checkbox").prop("checked") ) {
				// 24시간 체크가 되어있다면
					$(this).parent().parent().next("div").find("input").val("24시간");
				}
				else {
				// 24시간 체크 안됨
					const start_time = $(this).parent().parent().next("div").find("select.start_time option:selected").text();
					const end_time = $(this).parent().parent().next("div").find("select.end_time option:selected").text();
					
					$(this).parent().parent().next("div").find("input.submit_input").val(start_time+" ~ "+end_time);
				}
				
			}
			else if( $(this).val() == 0 ) {
			// 수영장 없음
				$(this).parent().parent().next("div").hide();
				$(this).parent().parent().next("div").find("select").prop("disabled", true);
				$(this).parent().parent().next("div").find("input.submit_input").val("없음");
				
			}
			
		});// end of $("select.fk_pool_type").change(function()
		// 수영장 유무에 따른 수영장 운영시간 -끝- //
		
		
		
		// 호텔 등급 (1성급 2성급) 선택하기
		$("div.select_hotel_star").hide();
		
		$("select[name='fk_lodge_type']").change(function(){
			
		//	$("div.select_hotel_star").hide();
			$("div.select_hotel_star").find("select[name='lg_hotel_star']").prop("disabled",true);
			console.log($(this).val());
			if( $(this).val() != "" && $(this).val() == 0 ) {
			// 호텔을 선택한 경우 등급을 선택할 수 있다.
				$("div.select_hotel_star").show();
				$("div.select_hotel_star").find("select[name='lg_hotel_star']").prop("disabled",false);
			}
			
		}); // end of $("select[name='fk_lodge_type']").change(function() ----
		
				
		// 시간 선택지 숨기기
		$("input:checkbox.checkbox_text").click(function(e){
			console.log($(e.target).is(":checked"));
			
			if( $(e.target).is(":checked") ) {
				$(e.target).next().next("div.use_time").show();
				$(e.target).next().next("div.use_time").find("select").prop("disabled",false);
				$(e.target).next().next("div.use_time").find("input").prop("disabled",false);
			} 
			else {
				$(e.target).next().next("div.use_time").hide();
				$(e.target).next().next("div.use_time").find("select").prop("disabled",true);
				$(e.target).next().next("div.use_time").find("input").prop("disabled",true);
			}
			
		});// end of $("input:checkbox.checkbox_text").click(function() -------
				
		
	}); // end of $(document).ready(function() -------------------
			
	
	// == 숙박시설 ID 중복 체크 ajax == //
	function lodgeID_check() {
		const lodge_id = $("input[name='lodge_id']").val();
		
		if( lodge_id.length == 8 ) {
			
			$.ajax({
				url:"<%=ctxPath%>/compareLodgeId.exp",
				data: {"lodge_id":lodge_id},
				async: false,
				dataType:"json",
				success:function(json){
				//	console.log(JSON.stringify(json));
					
					if(json.IdCheck == "1") {
						$("span.lodgeId_error").text("사용 가능한  시설ID 입니다.");
						$("span.lodgeId_error").css({"color":"#04aa6d", "font-size":"11pt"});
						$("span.lodgeId_error").addClass("ok_check");
						$("span.lodgeId_error").parent().find(".submit_check").hide();
						$("span.lodgeId_error").show();
					}
					else {
						$("span.lodgeId_error").text("이미 사용중인 숙박시설 ID입니다.");
						$("span.lodgeId_error").css({"color":"red", "font-size":"10pt"});
						$("span.lodgeId_error").removeClass("ok_check");
						$("span.lodgeId_error").parent().find(".submit_check").show();
						$("span.lodgeId_error").show();
					}
					
				},
				error: function(request, status, error){
               		alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
              	}
				
			}); // end of $.ajax -------------
			
		}// end of if( lodge_id.length == 8)
		else if(lodge_id.length < 8) {
			$("span.lodgeId_error").hide();
		}
		
	} // == 숙박시설 ID ajax 체크 == //
	
			
	// == 숫자 제한 (객실수) == // 
	function lg_qty_limit(e) {
		
		if (e.value.length > e.maxLength){
	 	     //object.maxLength : 매게변수 오브젝트의 maxlength 속성 값입니다.
		      e.value = e.value.slice(0, e.maxLength);
		    }
		
	}// end of function lg_qty_limit() ----------------

	
	
	// == 체크인 시간 == //
	// 시간대 선택
	function func_select_time(e) {
		
		let anytime = "0";
		if( $(e).hasClass("anytime__") ) {
		// end_time 언제든지를 포함시키고 싶다.
			anytime = "1";
		}
	//	console.log("anytime => ",anytime);
		
		
		const select_timeLine = $(e).parent();
		// 시작 시간
		const start_time = select_timeLine.find("select.start_time option:selected").text();
		
		// 시작 시간에 따라서 끝나는 시간이 바뀌어야 한다.
		if( $(e).hasClass("start_time") ) {
			
			const start_time_val = select_timeLine.find("select.start_time").val();
			
			$.ajax({
				url:"<%=ctxPath%>/getEndTime.exp",
				data: {"start_time_val":start_time_val,
					   "anytime":anytime},
				async: false,
				dataType:"json",
				success:function(json){
					
					let html = `<option value="">--선택--</option>`;
					
					$.each(json, function(index, item) {
						html += `<option>\${item.text_time}</option>`;
						
					}); // end of $.each(json, function(index, item) 
					
					select_timeLine.find("select.end_time").html(html);			
					
				},
				error: function(request, status, error){
               		alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
              	}
			}); // end of $.ajax -------------
			
		}
		// 끝나는 시간
		const end_time = select_timeLine.find("select.end_time option:selected").text();
		
		select_timeLine.find("input").val(start_time);
		select_timeLine.parent().find("input.submit_input").val(start_time+" ~ "+end_time);
		
	}// end of function func_select_time(e)
			
			
			
	// "예" "아니오" 버튼 클릭시
	function btn_click_e(e) {
		
		// 누른 버튼의 값
		const btn_val = $(e).val();
		
		// 누른 버튼의 부모 태그
		const e_par = $(e).parent();
		
	//	console.log($(e).parent().find("button"));
		e_par.find("button").each(function(index, item){
			// 누른 버튼의 형제 버튼의 "click_btn" 클래스 제거
			$(item).removeClass("click_btn");
		})
		
		// "click_btn 클래스를 추가해 준다.
		$(e).addClass("click_btn");
		// 값은 input태그에 넣어준다.
		e_par.find("input").val(btn_val);
		
		const submit_val = e_par.find("input").val();
	//	console.log(btn_val);
	//	console.log(submit_val);
		// lg_pet_fare
		if(submit_val == 1){
		// "예"
			e_par.parent().next("div.y_btn_after").show();
			e_par.parent().next("div.y_btn_after").find("select.start_time").val("1").trigger("change");
			
			e_par.parent().next("div.y_btn_after").find(".use_time .all_time_").prop("checked",false);
			e_par.parent().next("div.y_btn_after").find("#fontdesc_all_time").prop("checked",false);
			
			e_par.parent().next("div.y_btn_after").find("input").prop("disabled",false);
			e_par.parent().next("div.y_btn_after").find("select").prop("disabled",false);
			e_par.parent().next("div.y_btn_after").find("div.checkbox_div").find("div.use_time").find("input[name='pool_use_time']").prop("disabled",true);
			e_par.parent().next("div.y_btn_after").find("div.checkbox_div").find("input[name='fk_pool_opt_no']").prop("checked",false);
			e_par.parent().next("div.y_btn_after").find("div.checkbox_div").find(".use_time").hide();
		}
		else{
		// "아니오" 
			e_par.parent().next("div.y_btn_after").hide();
			e_par.parent().next("div.y_btn_after").find(".use_time").hide();
			
			e_par.parent().next("div.y_btn_after").find("input").prop("disabled",true);
			e_par.parent().next("div.y_btn_after").find("input").val("");
			e_par.parent().next("div.y_btn_after").find("select").prop("disabled",true);
			e_par.parent().next("div.y_btn_after").find("input:checkbox").prop("checked",false);
			
		}
		
	//	console.log(e_par.parent().next("div.y_btn_after").find("input.submit_input").val());
		// "없음" "24시간" "01:00 AM ~ 02:00 AM"
	} // end of function btn_click_e(this)
			
			
	
	// == 숙박시설 정보 DB에 insert == //	
	function lodge_register() {
	
		// 시설ID 체크
		const lodge_id = $("input[name='lodge_id']");
		let n1 = 0; 
		
		if( lodge_id.val().length < 8 ) {
		// 여덟글자보다 적다.
			lodge_id.parent().parent().find(".submit_check").show();
			lodge_id.parent().parent().find(".error").show().text("영문 4자리 숫자 4자리를 입력해 주세요.");
		} 
		else {
		// 여덟글자 이상
			if( $("span.lodgeId_error").hasClass("ok_check") ) {
			// ok_check 클래스가 있으면
				lodge_id.parent().parent().find(".error").hide().text("");
				n1 = 1;
			}
		}
		
		// 숙박시설 이름
		const lg_name = $("input[name='lg_name']");
		let n2 = 0;
		
		if( lg_name.val().trim().length > 0 ) {
		// 공백 체크
			lg_name.parent().parent().find(".submit_check").hide();
			lg_name.parent().parent().find(".error").hide().text("");
			lg_name.val(lg_name.val().trim()); // 공백을 제거한 값을 다시 넣어주기
			n2 = 1; // 중복체크
		}
		else {
			lg_name.parent().parent().find(".submit_check").show();
			lg_name.parent().parent().find(".error").show().text("공백은 시설 명으로 사용할 수 없습니다.");
		}
		
		// 숙박시설 영문명
		const lg_en_name = $("input[name='lg_en_name']");
		let n3 = 0;
		
		if( lg_en_name.val().trim().length > 0 ) {
		// 공백 체크 
			lg_en_name.parent().parent().find(".submit_check").hide();
			lg_en_name.parent().parent().find(".error").hide().text("");
			lg_en_name.val(lg_en_name.val().trim()); // 공백을 제거한 값을 다시 넣어주기
			n3 = 1; // 중복체크
		}
		else {
			lg_en_name.parent().parent().find(".submit_check").show();
			lg_en_name.parent().parent().find(".error").show().text("공백은 시설 명으로 사용할 수 없습니다.");
		}
		
		// 우편번호
		const lg_postcode = $("input[name='lg_postcode']");
		let n4 = 0;
		
		if( lg_postcode.val().trim().length > 0 ) {
		// 통과
			lg_postcode.parent().parent().find(".submit_check").hide();
			lg_postcode.parent().parent().find(".error").hide().text("");
			n4 = 1; // 중복체크
		}
		else {
		// 거절
			lg_postcode.parent().parent().find(".submit_check").show();
			lg_postcode.parent().parent().find(".error").show().text("우편번호를 입력해 주세요.");
		}
		
		
		// 숙박시설 유형 체크
		const fk_lodge_type = $("select[name='fk_lodge_type']");
		let n5 = 0;
		
		if( fk_lodge_type.val() != "" ) {
		// 선택을 한경우
			fk_lodge_type.parent().parent().find(".submit_check").hide();
			fk_lodge_type.parent().parent().find(".error").hide().text("");
			
			if(fk_lodge_type.val() == '0'){
			// 호텔 인 경우
				const lg_hotel_star = $("select[name='lg_hotel_star']");
				
				if(lg_hotel_star.val() == "") {
				// 호텔 등급을 선택하지 않은 경우
					lg_hotel_star.parent().parent().find(".submit_check").show();
					lg_hotel_star.parent().parent().find(".error").show().text("호텔 등급을 선택해 주세요.");
				}
				else{
				// 호텔 등급을 선택한 경우
					lg_hotel_star.parent().parent().find(".submit_check").hide();
					lg_hotel_star.parent().parent().find(".error").hide().text("");
					n5 = 1;
				}
			}
			else {
			// 호텔이 아닌경우			
				n5 = 1;
			}
			 
		}
		else {
		// 선택을 하지 않은경우
			fk_lodge_type.parent().parent().find(".submit_check").show();
			fk_lodge_type.parent().parent().find(".error").show().text("숙박시설 유형을 선택해 주세요.");
		}
		
		
		
		// 객실 수 체크
		const lg_qty = $("input[name='lg_qty']");
		let n6 = 0;
		
		if( lg_qty.val() > 0 ) {
		// 선택을 한경우
			lg_qty.parent().parent().find(".submit_check").hide();
			lg_qty.parent().parent().find(".error").hide().text("");
			n6 = 1; 
		}
		else {
		// 선택을 하지 않은경우
			lg_qty.parent().parent().find(".submit_check").show();
			lg_qty.parent().parent().find(".error").show().text("객실 수를 입력해 주세요.");
		}
		
		// 환불정책 체크
		const fk_cancel_opt = $("select[name='fk_cancel_opt']");
		let n7 = 0;
		
		if( fk_cancel_opt.val() != "" ) {
		// 선택을 한경우
			fk_cancel_opt.parent().parent().find(".submit_check").hide();
			fk_cancel_opt.parent().parent().find(".error").hide().text("");
			n7 = 1; 
		}
		else {
		// 선택을 하지 않은경우
			fk_cancel_opt.parent().parent().find(".submit_check").show();
			fk_cancel_opt.parent().parent().find(".error").show().text("환불 정책을 선택해 주세요.");
		}
		
		
		// 프론트 데스크 체크
		const fd_status = $("input[name='fd_status']");
		let n8 = 0;
		
		if( fd_status.val() != "" ) {
		// 선택을 한경우
			fd_status.parent().parent().find(".submit_check").hide();
			fd_status.parent().parent().find(".error").hide().text("");
		
			if(fd_status.val() == "0") {
			// 프론트 데스크 없는 경우
				fd_status.parent().parent().find(".submit_check").hide();
				fd_status.parent().parent().find(".error").hide().text("");
				n8 = 1;
			}
			else{
			// 프론트 데스크가 있는 경우
				const y_btn_after = fd_status.parent().parent().next(".y_btn_after");
			
				const fd_time = y_btn_after.find(".submit_input").val();
				
				if( fd_time.indexOf("선택") > 0) {
				// 프론트 데스크 운영시간을 선택하지 않은 경우
					y_btn_after.find(".submit_check").show();
					y_btn_after.find(".error").show().text("운영시간을 선택해 주세요.");
				}
				else {
				// 프론트 데스크 운영시간을 선택한 경우
					y_btn_after.find(".submit_check").hide();
					y_btn_after.find(".error").hide().text("");
					n8 = 1;	
				}
			} // end of if(fd_status.val() == "0") else --------------------
			
		}
		else {
		// 선택을 하지 않은경우
			fd_status.parent().parent().find(".submit_check").show();
			fd_status.parent().parent().find(".error").show().text("프런트 데스크 유무를 선택해 주세요.");
		}
		
		
		// 셀프 체크인 방법 체크
		const fk_s_checkin_type = $("select[name='fk_s_checkin_type']");
		let n9 = 0;
		
		if( fk_s_checkin_type.val() != "" ) {
		// 선택을 한경우
			fk_s_checkin_type.parent().parent().find(".submit_check").hide();
			fk_s_checkin_type.parent().parent().find(".error").hide().text("");
			n9 = 1; 
		}
		else {
		// 선택을 하지 않은경우
			fk_s_checkin_type.parent().parent().find(".submit_check").show();
			fk_s_checkin_type.parent().parent().find(".error").show().text("셀프 체크인 방법을 선택해 주세요.");
		}
		
		// 체크인 시간 체크
		const lg_checkin_end_time = $("select[name='lg_checkin_end_time']");
		let n10 = 0;
		
		if( lg_checkin_end_time.val() == "") {
		// 체크인 시간 선택 안함
			lg_checkin_end_time.parent().parent().find(".submit_check").show();
			lg_checkin_end_time.parent().parent().find(".error").show().text("체크인 시간대를 선택해주세요.");
		}
		else {
		// 체크인 시간 선택 함
			lg_checkin_end_time.parent().parent().find(".submit_check").hide();
			lg_checkin_end_time.parent().parent().find(".error").hide().text("");
			n10 = 1;
		}
		
		// 체크아웃 시간 체크
		const lg_checkout_time = $("select[name='lg_checkout_time']");
		let n11 = 0;
		
		if( lg_checkout_time.val() == "") {
		// 체크 아웃 시간 선택 안함
			lg_checkout_time.parent().parent().find(".submit_check").show();
			lg_checkout_time.parent().parent().find(".error").show().text("체크아웃 시간을 선택해주세요.");
		}
		else {
		// 체크 아웃 시간 선택 함
			lg_checkout_time.parent().parent().find(".submit_check").hide();
			lg_checkout_time.parent().parent().find(".error").hide().text("");
			n11 = 1;
		}
		
		// 나이 제한
		const lg_age_limit = $("select[name='lg_age_limit']");
		let n12 = 0;
		
		if( lg_age_limit.val() == "") {
		// 나이 제한 선택 안함
			lg_age_limit.parent().parent().find(".submit_check").show();
			lg_age_limit.parent().parent().find(".error").show().text("나이 제한을 선택해 주세요.");
		}
		else {
		// 나이 제한 선택 함
			lg_age_limit.parent().parent().find(".submit_check").hide();
			lg_age_limit.parent().parent().find(".error").hide().text("");
			n12 = 1;
		}	
		
		// 인터넷 제공 체크
		const lg_internet_yn = $("input[name='lg_internet_yn']");
		let n13 = 0;		
		
		if( lg_internet_yn.val() != "" ) {
		// "예" "아니오" 선택한 경우
			lg_internet_yn.parent().parent().find(".submit_check").hide();
			lg_internet_yn.parent().parent().find(".error").hide().text("");
			
			if(lg_internet_yn.val() == "0") {
			// 인터넷 제공 "아니오"
				lg_internet_yn.parent().parent().find(".submit_check").hide();
				lg_internet_yn.parent().parent().find(".error").hide().text("");
				n13 = 1;
			}
			else{
			// 인터넷 제공 "예"
				const y_btn_after = lg_internet_yn.parent().parent().next(".y_btn_after");
			
				const checkbox_text = y_btn_after.find(".checkbox_text");
				
				$.each(checkbox_text, function(index, item){
				// 체크박스 반복문
					if( $(item).is(":checked") ) {
					// 인터넷 옵션 체크박스에 체크를 했다.
						n13 = 1;
						y_btn_after.find(".submit_check").hide();
						y_btn_after.find(".error").hide().text("");
						
						return false; // 체크를 했으므로 반복문을 중단한다.
					}
					else {
					// 인터넷 옵션 체크박스에 체크를 하지 않았다.
						y_btn_after.find(".submit_check").show();
						y_btn_after.find(".error").show().text("인터넷 옵션을 선택해 주세요.");
					}
						
				}); // end of $.each(checkbox_text, function()
				
			} // end of if(lg_internet_yn.val() == "0") else --------------------
			
		}
		else {
		// "예" "아니오" 선택하지 않은 경우
			lg_internet_yn.parent().parent().find(".submit_check").show();
			lg_internet_yn.parent().parent().find(".error").show().text("인터넷 제공 유무를 선택해 주세요.");
		}		
		
		// 주차장 유무 체크 -- 주차장이 있나요?
		const lg_park_yn = $("input[name='lg_park_yn']");
		let n14 = 0;		
		
		if( lg_park_yn.val() != "" ) {
		// "예" "아니오" 선택한 경우
			lg_park_yn.parent().parent().find(".submit_check").hide();
			lg_park_yn.parent().parent().find(".error").hide().text("");
		
			if(lg_park_yn.val() == "0") {
			// 주차장 유무 "아니오"
				lg_park_yn.parent().parent().find(".submit_check").hide();
				lg_park_yn.parent().parent().find(".error").hide().text("");
				n14 = 1;
			}
			else{
			// 주차장 유무 "예"
				const y_btn_after = lg_park_yn.parent().parent().next(".y_btn_after");
			
				const checkbox_text = y_btn_after.find(".checkbox_text");
				
				$.each(checkbox_text, function(index, item){
				// 체크박스 반복문
					if( $(item).is(":checked") ) {
					// 주차장 옵션 체크박스에 체크를 했다.
						n14 = 1;
						y_btn_after.find(".submit_check").hide();
						y_btn_after.find(".error").hide().text("");
						return false; // 체크를 했으므로 반복문을 중단한다.
					}
					else {
					// 주차장 옵션 체크박스에 체크를 하지 않았다.
						y_btn_after.find(".submit_check").show();
						y_btn_after.find(".error").show().text("주차장 옵션을 선택해 주세요.");
					}
						
				}); // end of $.each(checkbox_text, function()
				
			} // end of if(lg_park_yn.val() == "0") else --------------------
			
		}
		else {
		// "예" "아니오" 선택하지 않은 경우
			lg_park_yn.parent().parent().find(".submit_check").show();
			lg_park_yn.parent().parent().find(".error").show().text("주차장 유무를 선택해 주세요.");
		}
			
		
		// 아침식사가 제공되나요? "예" "아니오"
		const lg_breakfast_yn = $("input[name='lg_breakfast_yn']");
		let n15 = 0;
		
		if( lg_breakfast_yn.val() == "") {
		// 선택 안함
			lg_breakfast_yn.parent().parent().find(".submit_check").show();
			lg_breakfast_yn.parent().parent().find(".error").show().text("아침식사 제공 유무를 선택해 주세요.");
		}
		else {
		// "예" "아니오" 선택
			lg_breakfast_yn.parent().parent().find(".submit_check").hide();
			lg_breakfast_yn.parent().parent().find(".error").hide().text("");
			n15 = 1;
		}
		
		
		// 다이닝 장소가 있나요? "예" "아니오" 체크박스
		const lg_dining_place_yn = $("input[name='lg_dining_place_yn']");
		let n16 = 0;		
		
		if( lg_dining_place_yn.val() != "" ) {
		// "예" "아니오" 선택한 경우
			lg_dining_place_yn.parent().parent().find(".submit_check").hide();
			lg_dining_place_yn.parent().parent().find(".error").hide().text("");
		
			if(lg_dining_place_yn.val() == "0") {
			// 다이닝장소 유무 "아니오"
				lg_dining_place_yn.parent().parent().find(".submit_check").hide();
				lg_dining_place_yn.parent().parent().find(".error").hide().text("");
				n16 = 1;
			}
			else{
			// 다이닝장소 유무 "예"
				const y_btn_after = lg_dining_place_yn.parent().parent().next(".y_btn_after");
			
				const checkbox_text = y_btn_after.find(".checkbox_text");
				
				$.each(checkbox_text, function(index, item){
				// 체크박스 반복문
					if( $(item).is(":checked") ) {
					// 다이닝 옵션 체크박스에 체크를 했다.
						n16 = 1;
						y_btn_after.find(".submit_check").hide();
						y_btn_after.find(".error").hide().text("");
						return false; // 체크를 했으므로 반복문을 중단한다.
					}
					else {
					// 다이닝 옵션 체크박스에 체크를 하지 않았다.
						y_btn_after.find(".submit_check").show();
						y_btn_after.find(".error").show().text("다이닝 장소를 선택해 주세요.");
					}
						
				}); // end of $.each(checkbox_text, function()
				
			} // end of if(lg_dining_place_yn.val() == "0") else --------------------
			
		}
		else {
		// "예" "아니오" 선택하지 않은 경우
			lg_dining_place_yn.parent().parent().find(".submit_check").show();
			lg_dining_place_yn.parent().parent().find(".error").show().text("다이닝 장소 유무를 선택해 주세요.");
		}
		
		
		//asdf
		
		// 수영장을 이용할 수 있나요? "예" "아니오" 체크박스 / 시간선택
		const lg_pool_yn = $("input[name='lg_pool_yn']");
		let n17 = 0;		
		
		if( lg_pool_yn.val() != "" ) {
		// "예" "아니오" 선택한 경우
			lg_pool_yn.parent().parent().find(".submit_check").hide();
			lg_pool_yn.parent().parent().find(".error").hide().text("");
		
			if(lg_pool_yn.val() == "0") {
			// 수영장 유무 "아니오"
				lg_pool_yn.parent().parent().find(".submit_check").hide();
				lg_pool_yn.parent().parent().find(".error").hide().text("");
				n17 = 1;
			}
			else{
			// 수영장 유무 "예"
				const y_btn_after = lg_pool_yn.parent().parent().next(".y_btn_after");
			
				const checkbox_text = y_btn_after.find(".checkbox_text");
				let check_flag = false; // 체크 유무 
				$.each(checkbox_text, function(index, item){
				// 체크박스 반복문
					if( $(item).is(":checked") ) {
						check_flag = true;
					}
				
					if( $(item).is(":checked") ) {
					// 수영장 옵션 체크박스에 체크를 했다.
						
						console.log(y_btn_after.find(".use_time").eq(index).find("input[name='pool_use_time']").val());
					
						let pool_use_time = y_btn_after.find(".use_time").eq(index).find("input[name='pool_use_time']");
						
						if( pool_use_time.val().indexOf("선택") > 0 ) {
						// 체크박스에는 체크를 했지만 시간은 선택하지 않은경우 / 안됨
							y_btn_after.find(".use_time").eq(index).find(".submit_check").show();
							y_btn_after.find(".use_time").eq(index).find(".error").show().text("이용 시간대를 선택해 주세요.");
						}
						else {
						// 체크박스에 체크를하고 시간도 선택한 경우 / 됨
							y_btn_after.find(".use_time").eq(index).find(".submit_check").hide();
							y_btn_after.find(".use_time").eq(index).find(".error").hide().text("");
							n17 = 1;
						}
						
					}
					else {
					// 수영장 옵션 체크박스에 체크를 하지 않았다.
						if( check_flag == false ) {
						// 체크박스 체크 없음
							y_btn_after.children("div.div_sub").find(".submit_check").show();
							y_btn_after.children("div.div_sub").find(".error").show().text("수영장 옵션을 선택해 주세요.");
						}
						else {
						// 체크박스 체크 있음
							y_btn_after.children("div.div_sub").find(".submit_check").hide();
							y_btn_after.children("div.div_sub").find(".error").hide().text("");
						}
					}
						
				}); // end of $.each(checkbox_text, function()
				
			} // end of if(lg_pool_yn.val() == "0") else --------------------
			
		}
		else {
		// "예" "아니오" 선택하지 않은 경우
			lg_pool_yn.parent().parent().find(".submit_check").show();
			lg_pool_yn.parent().parent().find(".error").show().text("수영장 유무를 선택해 주세요.");
		}
		
		
		// 스파 서비스가 있나요? select
		const fk_spa_type = $("select[name='fk_spa_type']");
		let n18 = 0;
		
		if(fk_spa_type.val() != "") {
		// 스파 서비스 종류 선택함
			fk_spa_type.parent().parent().find(".submit_check").hide();
			fk_spa_type.parent().parent().find(".error").hide().text("");
			n18 = 1;		
		}
		else {
		// 스파 서비스 종류 선택 안함
			fk_spa_type.parent().parent().find(".submit_check").show();
			fk_spa_type.parent().parent().find(".error").show().text("스파 서비스 유무를 선택해 주세요.");
		}
		
		
		// 반려동물 동반이 허용되나요? 
		const lg_pet_yn = $("input[name='lg_pet_yn']");
		let n19 = 0;
		
		if(lg_pet_yn.val() != "") {
		// 반려동물 동반 여부 선택함
			lg_pet_yn.parent().parent().find(".submit_check").hide();
			lg_pet_yn.parent().parent().find(".error").hide().text("");
		
			const y_btn_after = lg_pet_yn.parent().parent().next(".y_btn_after");
			
			if(lg_pet_yn.val() == "0") {
			// 반려 동물 동반 여부 "안됨"
				y_btn_after.find(".submit_check").hide();
				y_btn_after.find(".error").hide().text("");
				n19 = 1;
			}
			else {
			// 반려 동물 동반 여부 "됨" --> 되는 경우는 금액 체크  0 이상의 금액이 입력되어야 한다.
				
				if( y_btn_after.find("input.submit_input").val() != "" ) {
				// 반려 동물 요금이 정해졌다.
					y_btn_after.find(".submit_check").hide();
					y_btn_after.find(".error").hide().text("");
					n19 = 1;
				}
				else {
				// 요금이 정해지지 않았다.
					y_btn_after.find(".submit_check").show();
					y_btn_after.find(".error").show().text("금액을 입력해 주세요.");
				}
			} // end of if(lg_pet_yn.val() == "0") -- 반려 동물 동반 여부 "됨"
		}
		else {
		// 반려동물 동반 여부 선택 안함
			lg_pet_yn.parent().parent().find(".submit_check").show();
			lg_pet_yn.parent().parent().find(".error").show().text("반려동물 동반 여부를 선택해 주세요.");
		}				
		
		
		// 숙박 시설에 장애인 편의 시설이 있나요? "예" "아니오" 체크박스
		const lg_fac_yn = $("input[name='lg_fac_yn']");
		let n20 = 0;		
		
		if( lg_fac_yn.val() != "" ) {
		// "예" "아니오" 선택한 경우
			lg_fac_yn.parent().parent().find(".submit_check").hide();
			lg_fac_yn.parent().parent().find(".error").hide().text("");
		
			if(lg_fac_yn.val() == "0") {
			// 장애인 편의시설 유무 "아니오"
				lg_fac_yn.parent().parent().find(".submit_check").hide();
				lg_fac_yn.parent().parent().find(".error").hide().text("");
				n20 = 1;
			}
			else{
			// 장애인 편의시설 유무 "예"
				const y_btn_after = lg_fac_yn.parent().parent().next(".y_btn_after");
			
				const checkbox_text = y_btn_after.find(".checkbox_text");
				
				$.each(checkbox_text, function(index, item){
				// 체크박스 반복문
					if( $(item).is(":checked") ) {
					// 장애인 편의시설 옵션 체크박스에 체크를 했다.
						n20 = 1;
						y_btn_after.find(".submit_check").hide();
						y_btn_after.find(".error").hide().text("");
						return false; // 체크를 했으므로 반복문을 중단한다.
					}
					else {
					// 장애인 편의시설 옵션 체크박스에 체크를 하지 않았다.
						y_btn_after.find(".submit_check").show();
						y_btn_after.find(".error").show().text("장애인 편의시설 옵션을 선택해주세요.");
					}
						
				}); // end of $.each(checkbox_text, function()
				
			} // end of if(lg_fac_yn.val() == "0") else --------------------
			
		}
		else {
		// "예" "아니오" 선택하지 않은 경우
			lg_fac_yn.parent().parent().find(".submit_check").show();
			lg_fac_yn.parent().parent().find(".error").show().text("장애인 시설 유무를 선택해 주세요.");
		}
		
		
		// 고객을 위한 서비스가 있나요? "예" "아니오" 체크박스
		const lg_service_yn = $("input[name='lg_service_yn']");
		let n21 = 0;		
		
		if( lg_service_yn.val() != "" ) {
		// "예" "아니오" 선택한 경우
			lg_service_yn.parent().parent().find(".submit_check").hide();
			lg_service_yn.parent().parent().find(".error").hide().text("");
			
			if(lg_service_yn.val() == "0") {
			// 고객서비스 유무 "아니오"
				lg_service_yn.parent().parent().find(".submit_check").hide();
				lg_service_yn.parent().parent().find(".error").hide().text("");
				n21 = 1;
			}
			else{
			// 고객서비스 유무 "예"
				const y_btn_after = lg_service_yn.parent().parent().next(".y_btn_after");
			
				const checkbox_text = y_btn_after.find(".checkbox_text");
				
				$.each(checkbox_text, function(index, item){
				// 체크박스 반복문
					if( $(item).is(":checked") ) {
					// 고객서비스 옵션 체크박스에 체크를 했다.
						n21 = 1;
						y_btn_after.find(".submit_check").hide();
						y_btn_after.find(".error").hide().text("");
						return false; // 체크를 했으므로 반복문을 중단한다.
					}
					else {
					// 고객서비스 옵션 체크박스에 체크를 하지 않았다.
						y_btn_after.find(".submit_check").show();
						y_btn_after.find(".error").show().text("고객서비스 옵션을 선택해 주세요.");
					}
						
				}); // end of $.each(checkbox_text, function()
				
			} // end of if(lg_service_yn.val() == "0") else --------------------
			
		}
		else {
		// "예" "아니오" 선택하지 않은 경우
			lg_service_yn.parent().parent().find(".submit_check").show();
			lg_service_yn.parent().parent().find(".error").show().text("고객서비스 유무를 선택해 주세요.");
		}
		
		
		// 룸에서 이용가능한 서비스가 있나요? "예" "아니오" "체크박스"
		const lg_rm_service_yn = $("input[name='lg_rm_service_yn']");
		let n22 = 0;
		
		if( lg_rm_service_yn.val() != "" ) {
		// "예" "아니오" 선택한 경우
			lg_rm_service_yn.parent().parent().find(".submit_check").hide();
			lg_rm_service_yn.parent().parent().find(".error").hide().text("");
			
			if(lg_rm_service_yn.val() == "0") {
			// 룸서비스 유무 "아니오"
				lg_rm_service_yn.parent().parent().find(".submit_check").hide();
				lg_rm_service_yn.parent().parent().find(".error").hide().text("");
				n22 = 1;
			}
			else{
			// 룸서비스 유무 "예"
				const y_btn_after = lg_rm_service_yn.parent().parent().next(".y_btn_after");
			
				const checkbox_text = y_btn_after.find(".checkbox_text");
				
				$.each(checkbox_text, function(index, item){
				// 체크박스 반복문
					if( $(item).is(":checked") ) {
					// 룸서비스 옵션 체크박스에 체크를 했다.
						n22 = 1;
						y_btn_after.find(".submit_check").hide();
						y_btn_after.find(".error").hide().text("");
						return false; // 체크를 했으므로 반복문을 중단한다.
					}
					else {
					// 룸서비스 옵션 체크박스에 체크를 하지 않았다.
						y_btn_after.find(".submit_check").show();
						y_btn_after.find(".error").show().text("룸 서비스 옵션을 선택해주세요.");
					}
						
				}); // end of $.each(checkbox_text, function()
				
			} // end of if(lg_rm_service_yn.val() == "0") else --------------------
			
		}
		else {
		// "예" "아니오" 선택하지 않은 경우
			lg_rm_service_yn.parent().parent().find(".submit_check").show();
			lg_rm_service_yn.parent().parent().find(".error").show().text("룸 서비스 제공 유무를 선택해 주세요.");
		}		
		
		
		// 근처에 해변이 있나요? "예" "아니오"
		const lg_beach_yn = $("input[name='lg_beach_yn']");
		let n23 = 0;
		
		if( lg_beach_yn.val() == "") {
		// 선택 안함
			lg_beach_yn.parent().parent().find(".submit_check").show();
			lg_beach_yn.parent().parent().find(".error").show().text("근처에 이용 가능한 해변이 있는지 선택해 주세요.");
		}
		else {
		// "예" "아니오" 선택
			lg_beach_yn.parent().parent().find(".submit_check").hide();
			lg_beach_yn.parent().parent().find(".error").hide().text("");
			n23 = 1;
		}
		
		
		// 흡연구역이 있나요? "예" "아니오"
		const lg_smoke_yn = $("input[name='lg_smoke_yn']");
		let n24 = 0;
		
		if( lg_smoke_yn.val() == "") {
		// 선택 안함
			lg_smoke_yn.parent().parent().find(".submit_check").show();
			lg_smoke_yn.parent().parent().find(".error").show().text("흡연구역 유무를 선택해 주세요.");
		}
		else {
		// "예" "아니오" 선택
			lg_smoke_yn.parent().parent().find(".submit_check").hide();
			lg_smoke_yn.parent().parent().find(".error").hide().text("");
			n24 = 1;
		}
		
		
		// 비즈니스를 위한 공간이 있나요? "예" "아니오" 체크박스
		const lg_business_yn = $("input[name='lg_business_yn']");
		let n25 = 0;
		
		if( lg_business_yn.val() != "" ) {
		// "예" "아니오" 선택한 경우
			lg_business_yn.parent().parent().find(".submit_check").hide();
			lg_business_yn.parent().parent().find(".error").hide().text("");
			
			if(lg_business_yn.val() == "0") {
			// 비즈니스 유무 "아니오"
				lg_business_yn.parent().parent().find(".submit_check").hide();
				lg_business_yn.parent().parent().find(".error").hide().text("");
				n25 = 1;
			}
			else{
			// 비즈니스 유무 "예"
				const y_btn_after = lg_business_yn.parent().parent().next(".y_btn_after");
			
				const checkbox_text = y_btn_after.find(".checkbox_text");
				
				$.each(checkbox_text, function(index, item){
				// 체크박스 반복문
					if( $(item).is(":checked") ) {
					// 비즈니스 옵션 체크박스에 체크를 했다.
						n25 = 1;
						y_btn_after.find(".submit_check").hide();
						y_btn_after.find(".error").hide().text("");
						return false; // 체크를 했으므로 반복문을 중단한다.
					}
					else {
					// 비즈니스 옵션 체크박스에 체크를 하지 않았다.
						y_btn_after.find(".submit_check").show();
						y_btn_after.find(".error").show().text("비즈니스 옵션을 선택해주세요.");
					}
						
				}); // end of $.each(checkbox_text, function()
				
			} // end of if(lg_business_yn.val() == "0") else --------------------
			
		}
		else {
		// "예" "아니오" 선택하지 않은 경우
			lg_business_yn.parent().parent().find(".submit_check").show();
			lg_business_yn.parent().parent().find(".error").show().text("인터넷 제공 유무를 선택해 주세요.");
		}
		
		
		// 가족을 위한 시설이 있나요?  "예" "아니오" 체크박스
		const lg_fa_travel_yn = $("input[name='lg_fa_travel_yn']");
		let n26 = 0;
		
		if( lg_fa_travel_yn.val() != "" ) {
		// "예" "아니오" 선택한 경우
			lg_fa_travel_yn.parent().parent().find(".submit_check").hide();
			lg_fa_travel_yn.parent().parent().find(".error").hide().text("");
			
			if(lg_fa_travel_yn.val() == "0") {
			// 가족시설 유무 "아니오"
				lg_fa_travel_yn.parent().parent().find(".submit_check").hide();
				lg_fa_travel_yn.parent().parent().find(".error").hide().text("");
				n26 = 1;
			}
			else{
			// 가족시설 유무 "예"
				const y_btn_after = lg_fa_travel_yn.parent().parent().next(".y_btn_after");
			
				const checkbox_text = y_btn_after.find(".checkbox_text");
				
				$.each(checkbox_text, function(index, item){
				// 체크박스 반복문
					if( $(item).is(":checked") ) {
					// 가족시설 옵션 체크박스에 체크를 했다.
						n26 = 1;
						y_btn_after.find(".submit_check").hide();
						y_btn_after.find(".error").hide().text("");
						return false; // 체크를 했으므로 반복문을 중단한다.
					}
					else {
					// 가족시설 옵션 체크박스에 체크를 하지 않았다.
						y_btn_after.find(".submit_check").show();
						y_btn_after.find(".error").show().text("가족시설 옵션을 선택해주세요.");
					}
						
				}); // end of $.each(checkbox_text, function()
				
			} // end of if(lg_fa_travel_yn.val() == "0") else --------------------
			
		}
		else {
		// "예" "아니오" 선택하지 않은 경우
			lg_fa_travel_yn.parent().parent().find(".submit_check").show();
			lg_fa_travel_yn.parent().parent().find(".error").show().text("가족시설 유무를 선택해 주세요.");
		}
		
		
		// n1,  n2,  n3,  n4,  n5,  n6,  n7,  n8,  n9,  n10
		// n11, n12, n13, n14, n15, n16, n17, n18, n19, n20
		// n21, n22, n23, n24, n25, n26
		
		if( confirm("시설을 등록하시겠습니까?") ) {
			let a1 = n1*n2*n3*n4*n5;
			let a2 = n6*n7*n8*n9*n10;
			let a3 = n11*n12*n13*n14*n15;
			let a4 = n16*n17*n18*n19*n20;
			let a5 = n21*n22*n23*n24*n25*n26;
			
			let pass = a1*a2*a3*a4*a5;
			
			console.log(a1 ,a2, a3, a4, a5);
			console.log("a1 => ", n1, n2, n3, n4, n5);
			console.log("a2 => ", n6, n7, n8, n9, n10);
			console.log("a3 => ", n11, n12, n13, n14, n15);
			console.log("a4 => ", n16, n17, n18, n19, n20);
			console.log("a5 => ", n21, n22, n23, n24, n25, n26);
			
			if(pass == 1) {
				const frm = document.lodge_info_Frm;
				frm.method = "post";
				frm.action = "<%=ctxPath%>/lodge_register.exp";
				frm.submit();	
			} else {
				alert("입력한 정보를 다시 확인해 주세요.");
			}
			
		}// end of if( confirm("시설을 등록하시겠습니까?") )
		
	}// end of lodge_register()


	
	// === "우편번호 찾기" 를 클릭했을 때 이벤트 처리하기 === //
	$(document).on("click","input:text[name='lg_postcode']", function(){
		
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
				if (data.userSelectedType === 'R') {
					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
					}
					// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					if (extraAddr !== '') {
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
		
		$(this).parent().parent().find(".submit_check").hide();
		$(this).parent().parent().find(".error").hide().text("");
		// qwer
	}); // end of $("img#zipcodeSearch").click(function(){})--------------------

	
	
	// 검색된 지도 위도경도 받아오기	
	function func_geocoder(address) {
      	var geocoder = new kakao.maps.services.Geocoder();
	      // 주소-좌표 변환 객체를 생성한다

      	geocoder.addressSearch(address, function(result, status) {

         	if (status === kakao.maps.services.Status.OK) {
	             // 주소가 정상적으로 검색이 완료됐으면
       		//	console.log(result[0].y, result[0].x);
	             
             	$("input#latitude").val(result[0].y); // result[0].y ==> 위도
             	$("input#longitude").val(result[0].x); // result[0].x ==> 경도
         	} 
   		});
	      
   	}// end of function func_geocoder(address) -----------------------
   	
   	// 영어만 입력하게 하기
   	function enCheck(e) {
   		e.value = e.value.replace(/[^A-Za-z\s]/ig, '');
   	} //  end of function enCheck() {
</script>

<title>숙박시설 등록</title>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5e11a8711f36b9b65dd79e84a1083337&libraries=services"></script>

<div style="inline-size: 100%; margin: auto; max-inline-size: 75rem; padding: 50px 0;">

	<div class="register_body">
		<div id="fixed_step">
			<div class="middle_po">
				<div class="step_num">
					
					<div class="out_num">
						<div class="__num">
							1
						</div>
					</div>
					<div class="out_step_text step_1">
						<div class="step_text">
							<a href="#lodge_info_a">시설 정보</a>
						</div>
					</div>
				</div>
				
				<div class="step_num">
					<div class="out_num">
						<div class="__num">
							2
						</div>
					</div>
					<div class="out_step_text step_2">
						<div class="step_text">
							<a href="#set_lodge_a">정책 및 설정</a>
						</div>
					</div>
				</div>
				
				<div class="step_num">
					<div class="out_num">
						<div class="__num">
							3
						</div>
					</div>
					<div class="out_step_text step_3">
						<div class="step_text">
							<a href="#facilty_a">시설 내 편의 시설</a>
						</div>
					</div>
				</div>
			</div>
		</div>	
		
		<div id="lodge_info">
			<div id="form_info">
				
				<h2 id="lodge_info_a">
					<svg xmlns="http://www.w3.org/2000/svg" height="35" width="35" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path d="M0 32C0 14.3 14.3 0 32 0H480c17.7 0 32 14.3 32 32s-14.3 32-32 32V448c17.7 0 32 14.3 32 32s-14.3 32-32 32H304V464c0-26.5-21.5-48-48-48s-48 21.5-48 48v48H32c-17.7 0-32-14.3-32-32s14.3-32 32-32V64C14.3 64 0 49.7 0 32zm96 80v32c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16V112c0-8.8-7.2-16-16-16H112c-8.8 0-16 7.2-16 16zM240 96c-8.8 0-16 7.2-16 16v32c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16V112c0-8.8-7.2-16-16-16H240zm112 16v32c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16V112c0-8.8-7.2-16-16-16H368c-8.8 0-16 7.2-16 16zM112 192c-8.8 0-16 7.2-16 16v32c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16V208c0-8.8-7.2-16-16-16H112zm112 16v32c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16V208c0-8.8-7.2-16-16-16H240c-8.8 0-16 7.2-16 16zm144-16c-8.8 0-16 7.2-16 16v32c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16V208c0-8.8-7.2-16-16-16H368zM328 384c13.3 0 24.3-10.9 21-23.8c-10.6-41.5-48.2-72.2-93-72.2s-82.5 30.7-93 72.2c-3.3 12.8 7.8 23.8 21 23.8H328z"/></svg>
					숙박 시설 정보
				</h2>
				<p>나중에 언제든지 더 추가하실 수 있습니다.</p>
			</div>
			
			<div id="form_data">
				<form name="lodge_info_Frm">
					
					<div class="__data">
						<div class="div_sub">
							<c:if test="${empty requestScope.fk_lodge_id}">
								<span class="sub">숙박시설 ID를 입력하여 주세요.</span><svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="lodgeId_error"></span><span class="error"></span>
							</c:if>
							<c:if test="${not empty requestScope.fk_lodge_id}">
								<span class="sub">숙박시설 ID를 입력하여 주세요.</span><svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="lodgeId_error ok_check"></span><span class="error"></span>
							</c:if>
						</div>
						<div class="lodge_id">
							<c:if test="${empty requestScope.fk_lodge_id}">
								<input id="front_id" type="text" size="6" maxlength="4" placeholder="예)AAAA" />-
								<input id="back_id" type="text" size="6" maxlength="4" placeholder="예)0000" />
								<input type="hidden" name="lodge_id" /><!-- n1 -->
								<p class="__ex">영문4개와 숫자4개를 입력하세요</p>
							</c:if>
							<c:if test="${not empty requestScope.fk_lodge_id}">
								<input id="front_id" type="text" size="6" maxlength="4" value="${requestScope.front_id}" disabled />-
								<input id="back_id" type="text" size="6" maxlength="4"  value="${requestScope.back_id}" disabled />
								<input type="hidden" name="lodge_id" value="${requestScope.fk_lodge_id}"/>
							</c:if> 
						</div>
					</div>
					
					<div class="__data hidden">
						<div class="div_sub">
							<span class="sub">등록자ID</span>
						</div>
						<div class="fk_h_userid"> <%-- 회원가입시 사용한 값 가져오면됨 --%> 
							<input type="text" name="fk_h_userid" value="sinho3004@naver.com" readonly />
						</div>
					</div>
					
					<div class="__data">
						<div class="div_sub">
							<span class="sub">숙박시설 이름을 입력해 주세요.</span><svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span>
						</div>
						<div class="lg_name"><!-- n2 -->
							<input type="text" id="lg_name" name="lg_name" size="40" maxlength="40" />
						</div>
					</div>
					
					<div class="__data">
						<div class="div_sub">
							<span class="sub">숙박시설 영문명을 입력해 주세요.</span><svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span>
						</div>
						<div class="lg_en_name"> <!-- n3 -->
							<input type="text" id="lg_en_name" name="lg_en_name" size="40" maxlength="80" placeholder="" oninput="enCheck(this)"/>
						</div>
					</div>
					
					
					
					<div class="_br"></div>
					
		<%-- ,lg_postcode            Nvarchar2(5)        not null            -- 우편번호 / 12345 02134  --%>
					<div class="__data">
						<div class="div_sub">
							<svg xmlns="http://www.w3.org/2000/svg" height="16" width="18" viewBox="0 0 576 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#6b6b6b" d="M302.8 312C334.9 271.9 408 174.6 408 120C408 53.7 354.3 0 288 0S168 53.7 168 120c0 54.6 73.1 151.9 105.2 192c7.7 9.6 22 9.6 29.6 0zM416 503l144.9-58c9.1-3.6 15.1-12.5 15.1-22.3V152c0-17-17.1-28.6-32.9-22.3l-116 46.4c-.5 1.2-1 2.5-1.5 3.7c-2.9 6.8-6.1 13.7-9.6 20.6V503zM15.1 187.3C6 191 0 199.8 0 209.6V480.4c0 17 17.1 28.6 32.9 22.3L160 451.8V200.4c-3.5-6.9-6.7-13.8-9.6-20.6c-5.6-13.2-10.4-27.4-12.8-41.5l-122.6 49zM384 255c-20.5 31.3-42.3 59.6-56.2 77c-20.5 25.6-59.1 25.6-79.6 0c-13.9-17.4-35.7-45.7-56.2-77V449.4l192 54.9V255z"/></svg>
							<span>우편번호</span><svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span>
						</div>
						<div>
							<input type="text" name="lg_postcode" id="postcode" size="6" maxlength="5" readonly />&nbsp; &nbsp;
							<%-- 우편번호 찾기 --%> <!-- n4 -->
						</div>
					</div>
		<%--
					,lg_address             Nvarchar2(50)       not null            -- 주소 
					,lg_detailaddress       Nvarchar2(30)                           -- 상세주소
					,lg_extraaddress        Nvarchar2(30)                           -- 참고항목 
		 --%>			
		 			<div class="__data">
						<div class="div_sub">
							<svg xmlns="http://www.w3.org/2000/svg" height="16" width="18" viewBox="0 0 576 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#6b6b6b" d="M302.8 312C334.9 271.9 408 174.6 408 120C408 53.7 354.3 0 288 0S168 53.7 168 120c0 54.6 73.1 151.9 105.2 192c7.7 9.6 22 9.6 29.6 0zM416 503l144.9-58c9.1-3.6 15.1-12.5 15.1-22.3V152c0-17-17.1-28.6-32.9-22.3l-116 46.4c-.5 1.2-1 2.5-1.5 3.7c-2.9 6.8-6.1 13.7-9.6 20.6V503zM15.1 187.3C6 191 0 199.8 0 209.6V480.4c0 17 17.1 28.6 32.9 22.3L160 451.8V200.4c-3.5-6.9-6.7-13.8-9.6-20.6c-5.6-13.2-10.4-27.4-12.8-41.5l-122.6 49zM384 255c-20.5 31.3-42.3 59.6-56.2 77c-20.5 25.6-59.1 25.6-79.6 0c-13.9-17.4-35.7-45.7-56.2-77V449.4l192 54.9V255z"/></svg>
							<span>주소</span>
						</div>
						<div>
							<input type="text" name="lg_address" id="address" size="40" maxlength="200" placeholder="주소" readonly /><br>
							<input type="hidden" name="lg_detailaddress" id="detailAddress" size="40" maxlength="200" placeholder="상세주소" readonly />
							<input type="hidden" name="lg_extraaddress" id="extraAddress" size="40" maxlength="200" placeholder="기타사항" />
						</div>
					</div>
		<%--
			,lg_latitude            Nvarchar2(20)       not null            -- 지역위도 / 123.41235521251
			,lg_longitude           Nvarchar2(20)       not null            -- 지역경도 / 55.2315234124
		 --%>	
		 			<div class="__data hidden">
		 				<div class="div_sub">
			 				<span>위도경도</span>
			 			</div>
						<div>
							<input type="hidden" name="lg_latitude" id="latitude" size="40" maxlength="200" placeholder="지역위도" /><br>
							<input type="hidden" name="lg_longitude" id="longitude" size="40" maxlength="200" placeholder="지역경도" />&nbsp;
						</div>
					</div>
		<%-- ,lg_area                Nvarchar2(10)       not null            -- 지역명 / 서울   --%>
					<div class="__data hidden">
						<div class="div_sub">
							<span>지역명</span>
						</div>	
						<div>
							<input type="text" name="lg_area" id="lg_area" size="40" maxlength="200" placeholder="지역명" /><br>
						</div>
					</div>
					
					<div class="__data hidden">
						<div class="div_sub">
							<span>지역명_2</span>
						</div>	
						<div>
							<input type="text" name="lg_area_2" id="lg_area_2" size="40" maxlength="200" placeholder="지역명" /><br>
						</div>
					</div>
					
					
					<div class="_br"></div>				
				
			<%-- ,fk_lodge_type          Nvarchar2(1)        not null            -- 숙박시설유형 / 0,1,2,3,4,5 --%>
			
					<div class="__data">
						<div class="div_sub">
							<span class="sub" >숙박시설 유형을 선택해 주세요.</span><svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span>
						</div>	
						<div id="fk_lodge_type_div" class="fk_lodge_type">
							<select name="fk_lodge_type"> <!-- n5 -->
									<option value="">--선택--</option>
								<c:forEach var="lodgeTypeMap" items="${requestScope.lodgeTypeMapList}">
									<option value="${lodgeTypeMap.lodge_type}">${lodgeTypeMap.lodge_content}</option>
								</c:forEach>			
							</select>
						</div>
					</div>
					
					<div class="__data select_hotel_star">
						<div class="div_sub">
							<span class="sub" >호텔 등급</span><svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span>
						</div>	
						<div id="lg_hotel_star_div" class="lg_hotel_star">
							<select name="lg_hotel_star">
									<option value="">--선택--</option>
									<option>1성급</option>
									<option>2성급</option>
									<option>3성급</option>
									<option>4성급</option>
									<option>5성급</option>
							</select>
						</div>
					</div>
					
			<%-- ,lg_qty                 Nvarchar2(2)        not null            -- 객실수 / 숫자 --%>
					<div class="__data">
						<div class="div_sub">
							<span class="sub" >객실 수를 입력해 주세요.</span><svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span>
						</div>
						<div class="lg_qty">			
							<input type="number" id="lg_qty" name="lg_qty" maxlength="5" oninput="lg_qty_limit(this)" />
						</div>
					</div>
					
					<div class="_br" id="set_lodge_a" ></div>
			<%-- ,fk_cancel_opt          Nvarchar2(2)        not null            -- 취소정책옵션번호 / 0,1,2,3 --%>
			
					<div class="__data">
						<div class="div_sub">
							<span class="sub">환불 정책이 어떻게 되나요?</span><svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span>
						</div>
						<div class="fk_cancel_opt">
							<select name="fk_cancel_opt">
									<option value="">--선택--</option>
								<c:forEach var="CancelOptionMap" items="${requestScope.CancelOptionMapList}">
									<option value="${CancelOptionMap.cancel_opt}">${CancelOptionMap.cancel_opt_content}</option>
								</c:forEach>			
							</select>
						</div>
					</div>
					
		<!-- ,fd_status              Nvarchar2(2)        not null        -- 프런트데스크 / 0:없음, 1:있음 -->
					<div class="__data __flex">
						<div class="div_sub __flex">
							<span class="sub" >프런트 데스크가 있나요?<svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span></span>
						</div>
						<div class="btn_div __flex">
							<button class="y_btn" type="button" onclick="btn_click_e(this)" value="1">예</button>
							<button class="n_btn" type="button" onclick="btn_click_e(this)" value="0">아니요</button>
							<input type="hidden" name="fd_status" />
						</div>
					</div>
					
		<%-- ,fd_time       Nvarchar2(20)        -- 프런트데스크운영시간 / 없음 or 시작시간 ~ 마감시간 예) 09:00 ~ 18:00 or 24시간 --%>
					<div class="__data y_btn_after">
						<div class="div_sub">
							<span class="sub" >프런트 데스크 운영시간을 선택해 주세요.</span><svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span>
						</div>
						<div class="fd_time">
							<select class="start_time" onchange="func_select_time(this)">
								<c:forEach var="timesMap" items="${requestScope.timesMapList}">
									<option value="${timesMap.time}">${timesMap.text_time}</option>
								</c:forEach>
							</select>
							&nbsp;~&nbsp;
							<select class="end_time" onchange="func_select_time(this)">
								<%-- ajax 들어오는  --%>
							</select>
						</div>
						<input id="fontdesc_all_time" class="all_time_" type="checkbox" value="없음" /><label for="fontdesc_all_time">24시간</label>
						<input type="hidden" class="submit_input" name="fd_time" />
					</div>
					
					<div class="_br"></div>
	
			<%-- ,fk_s_checkin_type        Nvarchar2(2)        not null  - 셀프체크인방법 / 0,1,2,3,4,5 --%>
					<div class="__data">
						<div class="div_sub __flex">
							<span class="sub" >셀프 체크인을 이용할 수 있나요?<svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span></span>
						</div>
						<div class="fk_self_checkin">	
							<select name="fk_s_checkin_type">
								<option value="">--선택--	</option>
								<c:forEach var="selfCheckinOptionMap" items="${requestScope.selfCheckinOptionMapList}">
									<option value="${selfCheckinOptionMap.s_checkin_type}">${selfCheckinOptionMap.s_checkin_content}</option>
								</c:forEach>
							</select>
							<c:forEach var="selfCheckinOptionMap" items="${requestScope.selfCheckinOptionMapList}">
								<p class="fk_self_checkin_p" id="${selfCheckinOptionMap.s_checkin_type}">${selfCheckinOptionMap.s_checkin_info}</p>
							</c:forEach>
						</div>
					</div>
					
		<%-- ,lg_checkin_time        Nvarchar2(10)       not null     -- 체크인시간(가능) / 시작시간 ~ 마감시간 예) 09:00 ~ 18:00 --%>
					<div class="__data">
						<div class="div_sub">
							<span class="sub">언제 체크인할 수 있나요?</span><svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span>
						</div>
						<div class="lg_checkin_time_div">		
							<select class="start_time anytime__" onchange="func_select_time(this)">
								<c:forEach var="timesMap" items="${requestScope.timesMapList}">
									<option value="${timesMap.time}">${timesMap.text_time}</option>
								</c:forEach>
							</select >
							<input type="hidden" name="lg_checkin_start_time" /> 
							&nbsp;~&nbsp;
							<select class="end_time" name="lg_checkin_end_time" onchange="func_select_time(this)">
							<%-- ajax 들어오는  --%>
							</select>
						</div>
					</div>
					
		<%-- ,lg_checkout_time       Nvarchar2(20)       not null      -- 체크아웃 (가능)시간 / 01:00 24:00 / 1시간 간격 --%>
					<div class="__data">
						<div class="div_sub">
							<span class="sub" >언제 체크아웃해야 하나요?</span><svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span>
						</div>
						<div class="lg_checkout_time">
							<select name="lg_checkout_time">
								<option value="">--선택--</option>
								<c:forEach var="timesMap" items="${requestScope.timesMapList}">
									<option>${timesMap.text_time}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="_br"></div>
	
	<%-- ,lg_age_limit      Nvarchar2(4)        not null        -- 나이 제한 / <select>15~25</select> 부터 이용가능 --%>
					<div class="__data">
						<div class="div_sub">
							<span class="sub" >나이 제한</span><svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span>
						</div>				
						<div class="lg_age_limit">			
							<select name="lg_age_limit">
								<option value="">--선택--</option>
								<c:forEach var="limitAge" items="${requestScope.limitAgeRangeList}">
									<option>${limitAge}</option>
								</c:forEach>	
							</select>
						</div>
					</div>
					
					<div class="_br" id="facilty_a"></div>
					
		<%-- ,lg_wifi                Nvarchar2(1)        not null            -- 인터넷 / 0:아니오, 1:예 --%>
					<div class="__data __flex">
						<div class="div_sub __flex">
							<svg xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 640 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#6b6b6b" d="M54.2 202.9C123.2 136.7 216.8 96 320 96s196.8 40.7 265.8 106.9c12.8 12.2 33 11.8 45.2-.9s11.8-33-.9-45.2C549.7 79.5 440.4 32 320 32S90.3 79.5 9.8 156.7C-2.9 169-3.3 189.2 8.9 202s32.5 13.2 45.2 .9zM320 256c56.8 0 108.6 21.1 148.2 56c13.3 11.7 33.5 10.4 45.2-2.8s10.4-33.5-2.8-45.2C459.8 219.2 393 192 320 192s-139.8 27.2-190.5 72c-13.3 11.7-14.5 31.9-2.8 45.2s31.9 14.5 45.2 2.8c39.5-34.9 91.3-56 148.2-56zm64 160a64 64 0 1 0 -128 0 64 64 0 1 0 128 0z"/></svg>
							<span class="sub" >인터넷이 제공되나요?<svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span></span>
						</div>		
						<div class="btn_div __flex">
							<button class="y_btn" type="button" onclick="btn_click_e(this)" value="1">예</button>
							<button class="n_btn" type="button" onclick="btn_click_e(this)" value="0">아니요</button>
							<input type="hidden" name="lg_internet_yn" />
						</div>
					</div>
					
				<%-- 값은  다른 참조이블에서 가져온다. tbl_inet_opt테이블 inet_opt_no 0,1,2,3
													   		   inet_opt_desc 설명 --%>
					<div class="__data y_btn_after">
						<div class="div_sub">
							<span class="sub" >인터넷 옵션</span><svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span>
						</div>
						<div class="fk_inet_opt_no">
							<c:forEach var="internetOption" items="${requestScope.internetOptionMapList}">
							<div class="checkbox_div">
								<input class="checkbox_text" name="fk_inet_opt_no" id="fk_inet_opt_no_${internetOption.inet_opt_no}" type="checkbox" value="${internetOption.inet_opt_no}" ></input>
								<label class="checkbox_input_box" for="fk_inet_opt_no_${internetOption.inet_opt_no}">${internetOption.inet_opt_desc}</label>
							</div>
							</c:forEach>
						</div>
					</div>	
					
					<div class="_br"></div>
	
		<!-- ,lg_park_yn      Nvarchar2(2)     not null        -- 주차장 / 0:없음, 1:있음  이후 체크박스 선택 -->
					<div class="__data __flex">
						<div class="div_sub __flex">
							<svg xmlns="http://www.w3.org/2000/svg" height="16" width="14" viewBox="0 0 448 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#6b6b6b" d="M64 32C28.7 32 0 60.7 0 96V416c0 35.3 28.7 64 64 64H384c35.3 0 64-28.7 64-64V96c0-35.3-28.7-64-64-64H64zM192 256h48c17.7 0 32-14.3 32-32s-14.3-32-32-32H192v64zm48 64H192v32c0 17.7-14.3 32-32 32s-32-14.3-32-32V288 168c0-22.1 17.9-40 40-40h72c53 0 96 43 96 96s-43 96-96 96z"/></svg>
							<span class="sub" >주차장이 있나요?<svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span></span>
						</div>		
						<div class="btn_div __flex">
							<button class="y_btn" type="button" onclick="btn_click_e(this)" value="1">예</button>
							<button class="n_btn" type="button" onclick="btn_click_e(this)" value="0">아니요</button>
							<input type="hidden" name="lg_park_yn" />
						</div>
					</div>
					
					<div class="__data y_btn_after">
						<div class="div_sub">
							<span class="sub" >주차장 옵션</span><svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span>
						</div>
						<div class="fk_park_opt_no">
							<c:forEach var="parkOption" items="${requestScope.parkOptionMapList}">
							<div class="checkbox_div">
								<input class="checkbox_text" name="fk_park_opt_no" id="fk_park_opt_no_${parkOption.park_opt_no}" type="checkbox" value="${parkOption.park_opt_no}" ></input>
								<label class="checkbox_input_box" for="fk_park_opt_no_${parkOption.park_opt_no}">${parkOption.park_opt_desc}</label>
							</div>
							</c:forEach>
						</div>
					</div>	
					
					<div class="_br"></div>
					
		<%-- ,lg_breakfast           Nvarchar2(2)        not null            -- 아침식사 / 0:제공안됨, 1:제공됨 --%>
					<div class="__data __flex">
						<div class="div_sub __flex">
							<span class="sub" >아침식사가 제공되나요?<svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span></span>
						</div>
						<div class="btn_div __flex">
							<button class="y_btn" type="button" onclick="btn_click_e(this)" value="1">예</button>
							<button class="n_btn" type="button" onclick="btn_click_e(this)" value="0">아니요</button>
							<input type="hidden" name="lg_breakfast_yn" />
						</div>
					</div>
					
					<div class="_br"></div>
					
					
	<!-- ,lg_dining_place_yn     Nvarchar2(2)        not null    -- 다이닝 장소 / 0:없음, 1:있음 -> 이후 체크박스 선택 -->
					<div class="__data __flex">
						<div class="div_sub __flex">
							<svg xmlns="http://www.w3.org/2000/svg" height="16" width="14" viewBox="0 0 448 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#6b6b6b" d="M416 0C400 0 288 32 288 176V288c0 35.3 28.7 64 64 64h32V480c0 17.7 14.3 32 32 32s32-14.3 32-32V352 240 32c0-17.7-14.3-32-32-32zM64 16C64 7.8 57.9 1 49.7 .1S34.2 4.6 32.4 12.5L2.1 148.8C.7 155.1 0 161.5 0 167.9c0 45.9 35.1 83.6 80 87.7V480c0 17.7 14.3 32 32 32s32-14.3 32-32V255.6c44.9-4.1 80-41.8 80-87.7c0-6.4-.7-12.8-2.1-19.1L191.6 12.5c-1.8-8-9.3-13.3-17.4-12.4S160 7.8 160 16V150.2c0 5.4-4.4 9.8-9.8 9.8c-5.1 0-9.3-3.9-9.8-9L127.9 14.6C127.2 6.3 120.3 0 112 0s-15.2 6.3-15.9 14.6L83.7 151c-.5 5.1-4.7 9-9.8 9c-5.4 0-9.8-4.4-9.8-9.8V16zm48.3 152l-.3 0-.3 0 .3-.7 .3 .7z"/></svg>
							<span class="sub" >다이닝 장소가 있나요?<svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span></span>
						</div>		
						<div class="btn_div __flex">
							<button class="y_btn" type="button" onclick="btn_click_e(this)" value="1">예</button>
							<button class="n_btn" type="button" onclick="btn_click_e(this)" value="0">아니요</button>
							<input type="hidden" name="lg_dining_place_yn" />
						</div>
					</div>
					
					<div class="__data y_btn_after">
						<div class="div_sub">
							<span class="sub" >다이닝 장소 종류</span><svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span>
						</div>
						<div class="fk_din_opt_no">
							<c:forEach var="diningPlace" items="${requestScope.diningPlaceMapList}">
							<div class="checkbox_div">
								<input class="checkbox_text" name="fk_din_opt_no" id="fk_din_opt_no_${diningPlace.din_opt_no}" type="checkbox" value="${diningPlace.din_opt_no}" ></input>
								<label class="checkbox_input_box" for="fk_din_opt_no_${diningPlace.din_opt_no}">${diningPlace.din_opt_desc}</label>
							</div>
							</c:forEach>
						</div>
					</div>
					
					<div class="_br"></div>
					
	<!-- ,lg_pool_yn     Nvarchar2(2)         not null     - 수영장타입 / 0:없음, 1:있음  이후 체크박스 선택 -->
					<div class="__data __flex">
						<div class="div_sub __flex">
							<svg xmlns="http://www.w3.org/2000/svg" height="16" width="18" viewBox="0 0 576 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#6b6b6b" d="M309.5 178.4L447.9 297.1c-1.6 .9-3.2 2-4.8 3c-18 12.4-40.1 20.3-59.2 20.3c-19.6 0-40.8-7.7-59.2-20.3c-22.1-15.5-51.6-15.5-73.7 0c-17.1 11.8-38 20.3-59.2 20.3c-10.1 0-21.1-2.2-31.9-6.2C163.1 193.2 262.2 96 384 96h64c17.7 0 32 14.3 32 32s-14.3 32-32 32H384c-26.9 0-52.3 6.6-74.5 18.4zM160 160A64 64 0 1 1 32 160a64 64 0 1 1 128 0zM306.5 325.9C329 341.4 356.5 352 384 352c26.9 0 55.4-10.8 77.4-26.1l0 0c11.9-8.5 28.1-7.8 39.2 1.7c14.4 11.9 32.5 21 50.6 25.2c17.2 4 27.9 21.2 23.9 38.4s-21.2 27.9-38.4 23.9c-24.5-5.7-44.9-16.5-58.2-25C449.5 405.7 417 416 384 416c-31.9 0-60.6-9.9-80.4-18.9c-5.8-2.7-11.1-5.3-15.6-7.7c-4.5 2.4-9.7 5.1-15.6 7.7c-19.8 9-48.5 18.9-80.4 18.9c-33 0-65.5-10.3-94.5-25.8c-13.4 8.4-33.7 19.3-58.2 25c-17.2 4-34.4-6.7-38.4-23.9s6.7-34.4 23.9-38.4c18.1-4.2 36.2-13.3 50.6-25.2c11.1-9.4 27.3-10.1 39.2-1.7l0 0C136.7 341.2 165.1 352 192 352c27.5 0 55-10.6 77.5-26.1c11.1-7.9 25.9-7.9 37 0z"/></svg>
							<span class="sub" >수영장을 이용할 수 있나요?<svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span></span>
						</div>		
						<div class="btn_div __flex">
							<button class="y_btn" type="button" onclick="btn_click_e(this)" value="1">예</button>
							<button class="n_btn" type="button" onclick="btn_click_e(this)" value="0">아니요</button>
							<input type="hidden" name="lg_pool_yn" />
						</div>
					</div>
					
					<div class="__data y_btn_after">
						<div class="div_sub">
							<span class="sub">수영장 옵션</span><svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span>
						</div>
						<div class="fk_pool_opt_no">
							<c:forEach var="poolType" items="${requestScope.poolTypeMapList}">
							<div class="checkbox_div">
								<input class="checkbox_text" name="fk_pool_opt_no" id="fk_pool_opt_no_${poolType.pool_opt_no}" type="checkbox" value="${poolType.pool_opt_no}" ></input>
								<label class="checkbox_input_box" for="fk_pool_opt_no_${poolType.pool_opt_no}">${poolType.pool_opt_desc}</label>
								<div class="use_time">
									<div class="div_sub">
										<span class="sub" >운영시간</span><svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span>
									</div>
									
									<div class="lg_pool_time">			
										<select class="start_time" onchange="func_select_time(this)">
											<c:forEach var="timesMap" items="${requestScope.timesMapList}">
												<option value="${timesMap.time}">${timesMap.text_time}</option>
											</c:forEach>
										</select>
										&nbsp;~&nbsp;
										<select class="end_time" onchange="func_select_time(this)">
											<%-- ajax 들어오는  --%>
										</select>
									</div>
									<input id="fk_pool_opt_no_${poolType.pool_opt_no}_all_time" class="all_time_" type="checkbox" value="없음" /><label for="fk_pool_opt_no_${poolType.pool_opt_no}_all_time">24시간</label>
									<input type="hidden" class="submit_input" name="pool_use_time" />
								</div>
							</div>
							</c:forEach>
						</div>
					</div>					

					<div class="_br"></div>
					
	<%-- ,fk_spa_type         Nvarchar2(1)        not null            -- 스파 서비스 / 0:없음, 1:있음 --%>
					<div class="__data">
						<div class="div_sub __flex">
							<span class="sub" >스파 서비스가 있나요?<svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span></span>
						</div>
						<div class="fk_spa_type">	
							<select name="fk_spa_type">
								<option value="">--선택--	</option>
								<c:forEach var="spaType" items="${requestScope.spaTypeMapList}">
									<option value="${spaType.spa_type}">${spaType.spa_desc}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					
					<div class="_br"></div>
					
	<%-- ,lg_pet_yn          Nvarchar2(1)        not null            -- 반려동물 / 0:불가, 1:허용 --%>
					<div class="__data __flex">
						<div class="div_sub __flex">
							<svg xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#6b6b6b" d="M226.5 92.9c14.3 42.9-.3 86.2-32.6 96.8s-70.1-15.6-84.4-58.5s.3-86.2 32.6-96.8s70.1 15.6 84.4 58.5zM100.4 198.6c18.9 32.4 14.3 70.1-10.2 84.1s-59.7-.9-78.5-33.3S-2.7 179.3 21.8 165.3s59.7 .9 78.5 33.3zM69.2 401.2C121.6 259.9 214.7 224 256 224s134.4 35.9 186.8 177.2c3.6 9.7 5.2 20.1 5.2 30.5v1.6c0 25.8-20.9 46.7-46.7 46.7c-11.5 0-22.9-1.4-34-4.2l-88-22c-15.3-3.8-31.3-3.8-46.6 0l-88 22c-11.1 2.8-22.5 4.2-34 4.2C84.9 480 64 459.1 64 433.3v-1.6c0-10.4 1.6-20.8 5.2-30.5zM421.8 282.7c-24.5-14-29.1-51.7-10.2-84.1s54-47.3 78.5-33.3s29.1 51.7 10.2 84.1s-54 47.3-78.5 33.3zM310.1 189.7c-32.3-10.6-46.9-53.9-32.6-96.8s52.1-69.1 84.4-58.5s46.9 53.9 32.6 96.8s-52.1 69.1-84.4 58.5z"/></svg>
							<span class="sub" >반려동물 동반이 허용되나요?<svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span></span>
						</div>
						<div class="btn_div __flex">
							<button class="y_btn" type="button" onclick="btn_click_e(this)" value="1">예</button>
							<button class="n_btn" type="button" onclick="btn_click_e(this)" value="0">아니요</button>
							<input type="hidden" name="lg_pet_yn" />
						</div>
					</div>
					
	<%-- ,lg_pet_fare        Nvarchar2(10)       not null     -- 반려동물 요금 / 0, 1마리당 요금 <input> ex) 30000 --%>
					<div class="__data y_btn_after">
						<div class="div_sub">
							<span class="sub" >반려동물 요금</span><svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span>
						</div>
						<div class="lg_pet_fare">
							<div>한마리당 추가 요금</div>
							<input type="number" class="submit_input" name="lg_pet_fare" />원
						</div>
					</div>
					
					<div class="_br"></div>
			
			
<!-- ,lg_fac_yn       Nvarchar2(2)         not null     -- 장애인 편의시설타입 / 0:없음,1:있음 -> 이후 체크박스 선택 -->
					<div class="__data __flex">
						<div class="div_sub __flex">
							<svg xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#6b6b6b" d="M192 96a48 48 0 1 0 0-96 48 48 0 1 0 0 96zM120.5 247.2c12.4-4.7 18.7-18.5 14-30.9s-18.5-18.7-30.9-14C43.1 225.1 0 283.5 0 352c0 88.4 71.6 160 160 160c61.2 0 114.3-34.3 141.2-84.7c6.2-11.7 1.8-26.2-9.9-32.5s-26.2-1.8-32.5 9.9C240 440 202.8 464 160 464C98.1 464 48 413.9 48 352c0-47.9 30.1-88.8 72.5-104.8zM259.8 176l-1.9-9.7c-4.5-22.3-24-38.3-46.8-38.3c-30.1 0-52.7 27.5-46.8 57l23.1 115.5c6 29.9 32.2 51.4 62.8 51.4h5.1c.4 0 .8 0 1.3 0h94.1c6.7 0 12.6 4.1 15 10.4L402 459.2c6 16.1 23.8 24.6 40.1 19.1l48-16c16.8-5.6 25.8-23.7 20.2-40.5s-23.7-25.8-40.5-20.2l-18.7 6.2-25.5-68c-11.7-31.2-41.6-51.9-74.9-51.9H282.2l-9.6-48H336c17.7 0 32-14.3 32-32s-14.3-32-32-32H259.8z"/></svg>
							<span class="sub" >숙박 시설에 장애인 편의 시설이 있나요?<svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span></span>
						</div>		
						<div class="btn_div __flex">
							<button class="y_btn" type="button" onclick="btn_click_e(this)" value="1">예</button>
							<button class="n_btn" type="button" onclick="btn_click_e(this)" value="0">아니요</button>
							<input type="hidden" name="lg_fac_yn" />
						</div>
					</div>

					<div class="__data y_btn_after">
						<div class="div_sub">
							<span class="sub" >편의 시설 종류</span><svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span>
						</div>
						<div class="fk_fac_opt_no">
							<c:forEach var="facilityInfo" items="${requestScope.facilityInfoMapList}">
							<div class="checkbox_div">
								<input class="checkbox_text" name="fk_fac_opt_no" id="fk_fac_opt_no_${facilityInfo.fac_opt_no}" type="checkbox" value="${facilityInfo.fac_opt_no}" ></input>
								<label class="checkbox_input_box" for="fk_fac_opt_no_${facilityInfo.fac_opt_no}">${facilityInfo.fac_opt_desc}</label>
							</div>
							</c:forEach>
						</div>
					</div>					

					<div class="_br"></div>
					
	<!-- ,lg_service_yn     Nvarchar2(2)      not null       -- 고객서비스 / 0:없음,1:있음 -> 이후 체크박스 선택 -->				
					<div class="__data __flex">
						<div class="div_sub __flex">
							<span class="sub" >고객을 위한 서비스가 있나요?<svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span></span>
						</div>		
						<div class="btn_div __flex">
							<button class="y_btn" type="button" onclick="btn_click_e(this)" value="1">예</button>
							<button class="n_btn" type="button" onclick="btn_click_e(this)" value="0">아니요</button>
							<input type="hidden" name="lg_service_yn" />
						</div>
					</div>		
					
					<div class="__data y_btn_after">
						<div class="div_sub">
							<span class="sub" >고객서비스 종류</span><svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span>
						</div>
						<div class="fk_cs_opt_no">
							<c:forEach var="consumerService" items="${requestScope.consumerServiceTypeMapList}">
							<div class="checkbox_div">
								<input class="checkbox_text" name="fk_cs_opt_no" id="fk_cs_opt_no_${consumerService.cs_opt_no}" type="checkbox" value="${consumerService.cs_opt_no}" ></input>
								<label class="checkbox_input_box" for="fk_cs_opt_no_${consumerService.cs_opt_no}">${consumerService.cs_opt_desc}</label>
							</div>
							</c:forEach>
						</div>
					</div>
					
					
		
<!-- ,lg_rm_service_yn      Nvarchar2(2)     not null  - 객실 용품 및 서비스 / 0:없음,1:있음 > 이후 체크박스 선택 -->
					<div class="__data __flex">
						<div class="div_sub __flex">
							<span class="sub" >룸에서 이용가능한 서비스가 있나요?<svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span></span>
						</div>		
						<div class="btn_div __flex">
							<button class="y_btn" type="button" onclick="btn_click_e(this)" value="1">예</button>
							<button class="n_btn" type="button" onclick="btn_click_e(this)" value="0">아니요</button>
							<input type="hidden" name="lg_rm_service_yn" />
						</div>
					</div>
					
					<div class="__data y_btn_after">
						<div class="div_sub">
							<span class="sub" >서비스 종류</span><svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span>
						</div>
						<div class="fk_rmsvc_opt_no">
							<c:forEach var="roomService" items="${requestScope.roomServiceMapList}">
							<div class="checkbox_div">
								<input class="checkbox_text" name="fk_rmsvc_opt_no" id="fk_rmsvc_opt_no_${roomService.rmsvc_opt_no}" type="checkbox" value="${roomService.rmsvc_opt_no}" ></input>
								<label class="checkbox_input_box" for="fk_rmsvc_opt_no_${roomService.rmsvc_opt_no}">${roomService.rmsvc_opt_desc}</label>
							</div>
							</c:forEach>
						</div>
					</div>					
					
					<div class="_br"></div>
					
	<!--  ,lg_beach_yn      Nvarchar2(2)        not null    / 0:없음,1:있음	 -->			
					<div class="__data __flex">
						<div class="div_sub __flex">
							<span class="sub" >근처에 해변이 있나요?<svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span></span>
						</div>
						<div class="btn_div __flex">
							<button class="y_btn" type="button" onclick="btn_click_e(this)" value="1">예</button>
							<button class="n_btn" type="button" onclick="btn_click_e(this)" value="0">아니요</button>
							<input type="hidden" name="lg_beach_yn" />
						</div>
					</div>
					
					<div class="_br"></div>
					
		<!-- ,lg_smoke_yn   Nvarchar2(2)     not null - 흡연구역 / 0:없음, 1:있음 -->
					<div class="__data __flex">
						<div class="div_sub __flex">
							<svg xmlns="http://www.w3.org/2000/svg" height="16" width="20" viewBox="0 0 640 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#6b6b6b" d="M448 32V43c0 38.2 15.2 74.8 42.2 101.8l21 21c21 21 32.8 49.5 32.8 79.2v11c0 17.7-14.3 32-32 32s-32-14.3-32-32V245c0-12.7-5.1-24.9-14.1-33.9l-21-21C405.9 151.1 384 98.1 384 43V32c0-17.7 14.3-32 32-32s32 14.3 32 32zM576 256V245c0-38.2-15.2-74.8-42.2-101.8l-21-21c-21-21-32.8-49.5-32.8-79.2V32c0-17.7 14.3-32 32-32s32 14.3 32 32V43c0 12.7 5.1 24.9 14.1 33.9l21 21c39 39 60.9 91.9 60.9 147.1v11c0 17.7-14.3 32-32 32s-32-14.3-32-32zM0 416c0-35.3 28.7-64 64-64H416c17.7 0 32 14.3 32 32v96c0 17.7-14.3 32-32 32H64c-35.3 0-64-28.7-64-64V416zm224 0v32H384V416H224zm288-64c17.7 0 32 14.3 32 32v96c0 17.7-14.3 32-32 32s-32-14.3-32-32V384c0-17.7 14.3-32 32-32zm96 0c17.7 0 32 14.3 32 32v96c0 17.7-14.3 32-32 32s-32-14.3-32-32V384c0-17.7 14.3-32 32-32z"/></svg>
							<span class="sub" >흡연구역이 있나요?<svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span></span>
						</div>
						<div class="btn_div __flex">
							<button class="y_btn" type="button" onclick="btn_click_e(this)" value="1">예</button>
							<button class="n_btn" type="button" onclick="btn_click_e(this)" value="0">아니요</button>
							<input type="hidden" name="lg_smoke_yn" />
						</div>
					</div>
						
					<div class="_br"></div>

<!-- ,lg_business_yn         Nvarchar2(2)       not null    -- 비즈니스 / 0:없음,1:있음 -> 이후 체크박스 선택 -->
					<div class="__data __flex">
						<div class="div_sub __flex">
							<svg xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#6b6b6b" d="M184 48H328c4.4 0 8 3.6 8 8V96H176V56c0-4.4 3.6-8 8-8zm-56 8V96H64C28.7 96 0 124.7 0 160v96H192 320 512V160c0-35.3-28.7-64-64-64H384V56c0-30.9-25.1-56-56-56H184c-30.9 0-56 25.1-56 56zM512 288H320v32c0 17.7-14.3 32-32 32H224c-17.7 0-32-14.3-32-32V288H0V416c0 35.3 28.7 64 64 64H448c35.3 0 64-28.7 64-64V288z"/></svg>
							<span class="sub" >비즈니스를 위한 공간이 있나요?<svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span></span>
						</div>		
						<div class="btn_div __flex">
							<button class="y_btn" type="button" onclick="btn_click_e(this)" value="1">예</button>
							<button class="n_btn" type="button" onclick="btn_click_e(this)" value="0">아니요</button>
							<input type="hidden" name="lg_business_yn" />
						</div>
					</div>
					
					<div class="__data y_btn_after">
						<div class="div_sub">
							<span class="sub" >비즈니스 공간종류</span><svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span>
						</div>
						<div class="fk_bsns_opt_no">
							<c:forEach var="businessType" items="${requestScope.businessTypeMapList}">
							<div class="checkbox_div">
								<input class="checkbox_text" name="fk_bsns_opt_no" id="fk_bsns_opt_no_${businessType.bsns_opt_no}" type="checkbox" value="${businessType.bsns_opt_no}" ></input>
								<label class="checkbox_input_box" for="fk_bsns_opt_no_${businessType.bsns_opt_no}">${businessType.bsns_opt_desc}</label>
							</div>
							</c:forEach>
						</div>
					</div>
					
					<div class="_br"></div>
<!-- ,lg_fa_travel_yn        Nvarchar2(2)       not null   -- 가족여행 / 0:없음,1:있음 - 이후 체크박스 선택 -->					
					<div class="__data __flex">
						<div class="div_sub __flex">
							<svg xmlns="http://www.w3.org/2000/svg" height="16" width="20" viewBox="0 0 640 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#6b6b6b" d="M160 0a64 64 0 1 1 0 128A64 64 0 1 1 160 0zM88 480V400H70.2c-10.9 0-18.6-10.7-15.2-21.1l31.1-93.4L57.5 323.3c-10.7 14.1-30.8 16.8-44.8 6.2s-16.8-30.7-6.2-44.8L65.4 207c22.4-29.6 57.5-47 94.6-47s72.2 17.4 94.6 47l58.9 77.7c10.7 14.1 7.9 34.2-6.2 44.8s-34.2 7.9-44.8-6.2l-28.6-37.8L265 378.9c3.5 10.4-4.3 21.1-15.2 21.1H232v80c0 17.7-14.3 32-32 32s-32-14.3-32-32V400H152v80c0 17.7-14.3 32-32 32s-32-14.3-32-32zM480 0a64 64 0 1 1 0 128A64 64 0 1 1 480 0zm-8 384v96c0 17.7-14.3 32-32 32s-32-14.3-32-32V300.5L395.1 321c-9.4 15-29.2 19.4-44.1 10s-19.4-29.2-10-44.1l51.7-82.1c17.6-27.9 48.3-44.9 81.2-44.9h12.3c33 0 63.7 16.9 81.2 44.9L619.1 287c9.4 15 4.9 34.7-10 44.1s-34.7 4.9-44.1-10L552 300.5V480c0 17.7-14.3 32-32 32s-32-14.3-32-32V384H472z"/></svg>						
							<span class="sub" >가족을 위한 시설이 있나요?<svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span></span>
						</div>		
						<div class="btn_div __flex">
							<button class="y_btn" type="button" onclick="btn_click_e(this)" value="1">예</button>
							<button class="n_btn" type="button" onclick="btn_click_e(this)" value="0">아니요</button>
							<input type="hidden" name="lg_fa_travel_yn" />
						</div>
					</div>
					
					<div class="__data y_btn_after">
						<div class="div_sub">
							<span class="sub" >시설 종류</span><svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span>
						</div>
						<div class="fk_fasvc_opt_no">
							<c:forEach var="familyService" items="${requestScope.familyServiceTypeMapList}">
							<div class="checkbox_div">
								<input class="checkbox_text" name="fk_fasvc_opt_no" id="fk_fasvc_opt_no_${familyService.fasvc_opt_no}" type="checkbox" value="${familyService.fasvc_opt_no}" ></input>
								<label class="checkbox_input_box" for="fk_fasvc_opt_no_${familyService.fasvc_opt_no}">${familyService.fasvc_opt_desc}</label>
							</div>
							</c:forEach>
						</div>
					</div>
					
				</form>
			</div>
				
			<div class="hadan">
				<button id="lodge_register" type="button" onclick="lodge_register()">등록하기</button>
			</div>
		
		</div>
	</div> <%-- register_body end --%>

</div> 