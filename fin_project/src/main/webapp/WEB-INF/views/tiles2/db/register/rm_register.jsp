<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>

<link type="text/css" rel="stylesheet" href="<%= ctxPath%>/resources/css/db/rm_register.css" />

<script type="text/javascript">

	$(document).ready(function(){
		
		$(".submit_check").hide(); // 오류 아이콘
		$(".error").hide(); // 오류 문구 
		
		// "예" "아니오" 버튼 태그 다음 div 숨김
		$("div.y_btn_after").hide(); // 체크박스

		
		// 객실 크기 입력 이벤트
		let rm_size_meter = $("input[name='rm_size_meter']");
		let rm_size_pyug = $("input[name='rm_size_pyug']");
		
		rm_size_meter.keyup(function(){
			let meter = $(this).val();
			
			if(Number(meter) <= 0 ) {
				rm_size_meter.val("");
				rm_size_pyug.val("");
				
			}
			rm_size_meter.parent().parent().parent().parent().find(".submit_check").hide();
			rm_size_meter.parent().parent().parent().parent().find(".error").hide().text("");
			rm_size_pyug.val(Math.round(Number(meter)*0.3025*100)/100); 
			// 제곱 미터  평 으로 계산
			
		}); // end of rm_size_meter.keydown(function(){
		
		rm_size_pyug.keyup(function(){
			let pyug = Number($(this).val());
			
			if(Number(pyug) <= 0 ) {
				rm_size_meter.val("");
				rm_size_pyug.val("");
				
			}
			rm_size_pyug.parent().parent().parent().parent().find(".submit_check").hide();
			rm_size_pyug.parent().parent().parent().parent().find(".error").hide().text("");
			rm_size_meter.val(Math.round(Number(pyug)*3.3058*100)/100); 
			// 평 제곱미터로 계산
			
		}); // end of rm_size_pyug.keydown(function()
		
				
		// 침실개수 2자리수 제한 -- rm_bedrm_cnt
		let rm_bedrm_cnt = $("input[name='rm_bedrm_cnt']");
		
		rm_bedrm_cnt.keyup(function(){
		
			rm_bedrm_cnt.parent().parent().find(".submit_check").hide();
			rm_bedrm_cnt.parent().parent().find(".error").hide().text("");
			
			if( rm_bedrm_cnt.val().length > 0 ){
				rm_bedrm_cnt.val(rm_bedrm_cnt.val().substr(0,2));
			}
			else if(rm_bedrm_cnt.val().length < 0) {
				rm_bedrm_cnt.val("");
			}
						
			if(rm_bedrm_cnt.val().indexOf("00") == 0 ) {
				rm_bedrm_cnt.val(rm_bedrm_cnt.val().substr(1,2));
			}
				
		}); // end of rm_bedrm_cnt.keyup(function(){
		
		// 전용욕실개수 1자리수 제한 -- rm_bathroom_cnt
		let rm_bathroom_cnt = $("input[name='rm_bathroom_cnt']");
		
		rm_bathroom_cnt.keyup(function(){
		
			rm_bathroom_cnt.parent().parent().find(".submit_check").hide();
			rm_bathroom_cnt.parent().parent().find(".error").hide().text("");
			
			if( rm_bathroom_cnt.val().length > 0 ){
				rm_bathroom_cnt.val(rm_bathroom_cnt.val().substr(0,1));
			}
			else if(rm_bathroom_cnt.val().length < 0) {
				rm_bathroom_cnt.val("");
			}
			
			if(rm_bathroom_cnt.val() > 0) {
				rm_bathroom_cnt.parent().parent().next(".y_btn_after").show();
				rm_bathroom_cnt.parent().parent().next(".y_btn_after").find("input").prop("checked",false);
			}
			else {
				rm_bathroom_cnt.parent().parent().next(".y_btn_after").hide();
				rm_bathroom_cnt.parent().parent().next(".y_btn_after").find("input").prop("checked",false);
			}
			
			
		}); // end of rm_bedrm_cnt.keyup(function(){
			
			
		
		// 객실이름을 입력해 주세요. - rm_type
		let rm_type = $("input[name='rm_type']");
		
		rm_type.bind("keydown", function(){
			rm_type.parent().parent().find(".submit_check").hide();
			rm_type.parent().parent().find(".error").hide().text("");
			
		}); // end of rm_type.bind("keydown", function()
		
		// 객실수을 입력해 주세요. -- rm_cnt
		let rm_cnt = $("input[name='rm_cnt']");
		
		rm_cnt.bind("keydown", function(){
			rm_cnt.parent().parent().find(".submit_check").hide();
			rm_cnt.parent().parent().find(".error").hide().text("");
			
		}); // end of rm_type.bind("keydown", function()
		
		
		// 투숙가능인원 2자리수 제한 -- rm_guest_cnt
		let rm_guest_cnt = $("input[name='rm_guest_cnt']");
		
		rm_guest_cnt.keyup(function(){
		
			rm_guest_cnt.parent().parent().find(".submit_check").hide();
			rm_guest_cnt.parent().parent().find(".error").hide().text("");
			
			if( rm_guest_cnt.val().length > 0 ){
				rm_guest_cnt.val(rm_guest_cnt.val().substr(0,2));
			}
			else if(rm_guest_cnt.val().length < 0) {
				rm_guest_cnt.val("");
			}
			
		}); // end of rm_guest_cnt.keyup(function(){
		
			
		// 숙박요금 10자리수 제한 -- rm_price
		let rm_price = $("input[name='rm_price']");
		
		rm_price.keyup(function(){
		
			rm_price.parent().parent().find(".submit_check").hide();
			rm_price.parent().parent().find(".error").hide().text("");
			
			if( rm_price.val().length > 0 ){
				rm_price.val(rm_price.val().substr(0,10));
			}
			else if(rm_price.val().length < 0) {
				rm_price.val("");
			}
			
		}); // end of rm_price.keyup(function(){
		
		// 전망옵션 에러 숨김
		$("select[name='fk_view_no']").change(function(){
			$(this).parent().parent().find(".submit_check").hide();
			$(this).parent().parent().find(".error").hide();
		}); // end of $("select[name='fk_s_checkin_type']").change(function()
			
			
		// "예" "아니오" 클릭시 에러 숨김
		$("div.btn_div > button").click(function(){
			$(this).parent().parent().find(".submit_check").hide();
			$(this).parent().parent().find(".error").hide().text("");
		}); // end of $("div.btn_div > button").click(function()
		
		
		// 옵션 체크 박스 체크시 에러 숨김
		$("input.checkbox_text").click(function(){
			$(this).parent().parent().parent().find(".submit_check").hide();
			$(this).parent().parent().parent().find(".error").hide();			
		}); // end of $("input.checkbox_text").click(function()
		
				
				
	}); // end of $(document).ready(function() -------------------
			
			
	// == 숙박시설 정보 DB에 insert == //	
	function room_register() {
		
		// 객실 이름 체크
		const rm_type = $("input[name='rm_type']");
		let n1 = 0;
		
		if( rm_type.val().trim().length == 0 ) {
		// 글자가 없는 경우
			rm_type.parent().parent().find(".submit_check").show();
			rm_type.parent().parent().find(".error").show();
			rm_type.parent().parent().find(".error").text("사용할 수 없는 이름입니다.");
		} 
		else {
		// 글자가 있는 경우
			rm_type.val(rm_type.val().trim());
			
			// 기존에 입력된 객실이름을 가지고 와서 비교한다.
			$.ajax({
				url:"<%=ctxPath%>/checkRm_type.exp",
				data: {"fk_lodge_id":$("input[name='fk_lodge_id']").val()},
				async: false,
				dataType:"json",
				success:function(json){
					console.log(JSON.stringify(json));
					
					$.each(json, function(index, item){
						
						if(item.rm_type == rm_type.val()){
						// 현재 입력한 rm_type과  기존에 입력된 rm_type이 중복되는 경우이다.
							rm_type.parent().parent().find(".submit_check").show();
							rm_type.parent().parent().find(".error").show().text("해당 이름을 가진 객실이 이미 존재합니다.");
							n1 = 0;
							return false;
						}
						else {
							rm_type.parent().parent().find(".submit_check").hide();
							rm_type.parent().parent().find(".error").text("").hide();
							n1 = 1;
						}
						
					}); // end of $.each(json, function(index, item){
					
				},
				error: function(request, status, error){
               		alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
              	}
				
			}); // end of $.ajax ------------- 
			
		}// end of 객실 이름 체크 -------- 글자가 있는 경우
		
		
		// 객실수 체크
		const rm_cnt = $("input[name='rm_cnt']");
		let n2 = 0;
		
		if( rm_cnt.val().trim().length > 0 ) {
		// 객실수가 공백이 아닌 경우		
			rm_cnt.parent().parent().find(".submit_check").hide();
			rm_cnt.parent().parent().find(".error").show();
			n2 = 1; // 중복체크
		}
		else {
		// 객실수가 공백인 경우		
			rm_cnt.parent().parent().find(".submit_check").show();
			rm_cnt.parent().parent().find(".error").show().text("객실 수를 입력해 주세요.");
		}
		
		
		// 객실크기 체크
		const rm_size_meter = $("input[name='rm_size_meter']");
		const rm_size_pyug = $("input[name='rm_size_pyug']");
		let n3 = 0;
		
		if( rm_size_meter.val().trim().length > 0 && rm_size_pyug.val().trim().length > 0 ) {
		// 크기(제곱)이 비어 있지 않은 경우		
			rm_size_meter.parent().parent().parent().parent().find(".submit_check").hide();
			rm_size_meter.parent().parent().parent().parent().find(".error").hide();
			n3 = 1; // 중복체크
		}
		else {
		// 크기(제곱)이 비어 있는 경우
			rm_size_meter.parent().parent().parent().parent().find(".submit_check").show();
			rm_size_meter.parent().parent().parent().parent().find(".error").show().text("객실 크기를 입력해 주세요.");
		}

		
		// 침실개수 -- rm_bedrm_cnt
		const rm_bedrm_cnt = $("input[name='rm_bedrm_cnt']");
		let n4 = 0;
		
		if( rm_bedrm_cnt.val() > 0 ) {
		// 침실 개수를 입력
			rm_bedrm_cnt.parent().parent().find(".submit_check").hide();
			rm_bedrm_cnt.parent().parent().find(".error").hide().text("");
			n4=1;
		}
		else {
		// 침실 개수를 입력하지 않음
			rm_bedrm_cnt.parent().parent().find(".submit_check").show();
			rm_bedrm_cnt.parent().parent().find(".error").show().text("침실 개수를 입력해 주세요.");
		}
		
		
		// 침대 추가 가능여부 -- rm_extra_bed_yn
		const rm_extra_bed_yn = $("input[name='rm_extra_bed_yn']");
		let n5 = 0;
		
		if( rm_extra_bed_yn.val().length > 0 ) {
		// "예" "아니오" 선택함
			rm_extra_bed_yn.parent().parent().find(".submit_check").hide();
			rm_extra_bed_yn.parent().parent().find(".error").hide().text("");
			n5=1;
		}
		else {
		// "예" "아니오" 선택을 하지 않음
			rm_extra_bed_yn.parent().parent().find(".submit_check").show()
			rm_extra_bed_yn.parent().parent().find(".error").show().text("침대 추가 가능여부를 선택해주세요.");
		}
		
		
		
		// 전용욕실갯수 -- rm_bathroom_cnt
		const rm_bathroom_cnt = $("input[name='rm_bathroom_cnt']");
		let n6 = 0;
		
		if( rm_bathroom_cnt.val().length > 0 ) {
		// 숫자를 입력한 경우
			let rm_bathroom_cnt_val = rm_bathroom_cnt.val();
			rm_bathroom_cnt.parent().parent().find(".submit_check").hide();
			rm_bathroom_cnt.parent().parent().find(".error").hide().text("");
			
			if(rm_bathroom_cnt_val > 0) {
			// 전용 욕실 개수가 1개 이상이다. --> 옵션을 선택한다.
				let y_btn_after = rm_bathroom_cnt.parent().parent().next(".y_btn_after");
				let checkbox_text = y_btn_after.find("input.checkbox_text");
				
				$.each(checkbox_text, function(index, item){
				// 체크박스 반복문
					if( $(item).is(":checked") ) {
					// 체크박스를 체크했다.
						n6 = 1;
						y_btn_after.find(".submit_check").hide();
						y_btn_after.find(".error").hide().text("");
						return false; // 체크를 했으므로 반복문을 중단한다.
					}
					else {
					// 체크 박스를 체크하지 않았다.
						y_btn_after.find(".submit_check").show();
						y_btn_after.find(".error").show().text("옵션을 선택하셔야 합니다.");
					}
						
				}); // end of $.each(checkbox_text, function()
			}
			else {
			// 전용 욕실이 없다 옵션이 없어도 된다. 
				n6=1;	
			}
			
		}
		else {
		// 숫자를 입력하지 않은 경우
			rm_bathroom_cnt.parent().parent().find(".submit_check").show()
			rm_bathroom_cnt.parent().parent().find(".error").show().text("전용 욕실 개수를 입력해 주세요.");
		}		
		
		
		// 공용욕실 유무 -- rm_p_bathroom_yn
		const rm_p_bathroom_yn = $("input[name='rm_p_bathroom_yn']");
		let n7 = 0;
		
		if( rm_p_bathroom_yn.val().length > 0 ) {
		// "예" "아니오" 선택함
			rm_p_bathroom_yn.parent().parent().find(".submit_check").hide();
			rm_p_bathroom_yn.parent().parent().find(".error").hide().text("");
			n7=1;
		}
		else {
		// "예" "아니오" 선택을 하지 않음
			rm_p_bathroom_yn.parent().parent().find(".submit_check").show()
			rm_p_bathroom_yn.parent().parent().find(".error").show().text("공용욕실 유무를 선택해 주세요.");
		}
		
		
		// 주방(조리시설)유무 -- rm_kitchen_yn
		const rm_kitchen_yn = $("input[name='rm_kitchen_yn']");
		let n8 = 0;		
		
		if( rm_kitchen_yn.val() != "" ) {
		// "예" "아니오" 선택한 경우
			rm_kitchen_yn.parent().parent().find(".submit_check").hide();
			rm_kitchen_yn.parent().parent().find(".error").hide().text("");
		
			if(rm_kitchen_yn.val() == "0") {
			//  "아니오"
				rm_kitchen_yn.parent().parent().find(".submit_check").hide();
				rm_kitchen_yn.parent().parent().find(".error").hide().text("");
				n8 = 1;
			}
			else{
			//  "예"
				const y_btn_after = rm_kitchen_yn.parent().parent().next(".y_btn_after");
			
				const checkbox_text = y_btn_after.find(".checkbox_text");
				
				$.each(checkbox_text, function(index, item){
				// 체크박스 반복문
					if( $(item).is(":checked") ) {
					// 옵션 체크박스에 체크를 했다.
						n8 = 1;
						y_btn_after.find(".submit_check").hide();
						y_btn_after.find(".error").hide().text("");
						return false; // 체크를 했으므로 반복문을 중단한다.
					}
					else {
					// 옵션 체크박스에 체크를 하지 않았다.
						y_btn_after.find(".submit_check").show();
						y_btn_after.find(".error").show().text("옵션을 선택하셔야 합니다.");
					}
						
				}); // end of $.each(checkbox_text, function()
				
			} // end of if(rm_kitchen_yn.val() == "0") else --------------------
			
		}
		else {
		// "예" "아니오" 선택하지 않은 경우
			rm_kitchen_yn.parent().parent().find(".submit_check").show();
			rm_kitchen_yn.parent().parent().find(".error").show().text("주방(조리시설) 유무를 선택해 주세요.");
		}
		
		
		
		// 객실 내 다과 -- rm_snack_yn
		const rm_snack_yn = $("input[name='rm_snack_yn']");
		let n9 = 0;		
		
		if( rm_snack_yn.val() != "" ) {
		// "예" "아니오" 선택한 경우
			rm_snack_yn.parent().parent().find(".submit_check").hide();
			rm_snack_yn.parent().parent().find(".error").hide().text("");
		
			if(rm_snack_yn.val() == "0") {
			//  "아니오"
				rm_snack_yn.parent().parent().find(".submit_check").hide();
				rm_snack_yn.parent().parent().find(".error").hide().text("");
				n9 = 1;
			}
			else{
			//  "예"
				const y_btn_after = rm_snack_yn.parent().parent().next(".y_btn_after");
			
				const checkbox_text = y_btn_after.find(".checkbox_text");
				
				$.each(checkbox_text, function(index, item){
				// 체크박스 반복문
					if( $(item).is(":checked") ) {
					// 옵션 체크박스에 체크를 했다.
						n9 = 1;
						y_btn_after.find(".submit_check").hide();
						y_btn_after.find(".error").hide().text("");
						return false; // 체크를 했으므로 반복문을 중단한다.
					}
					else {
					// 옵션 체크박스에 체크를 하지 않았다.
						y_btn_after.find(".submit_check").show();
						y_btn_after.find(".error").show().text("옵션을 선택하셔야 합니다.");
					}
						
				}); // end of $.each(checkbox_text, function()
				
			} // end of if(rm_snack_yn.val() == "0") else --------------------
			
		}
		else {
		// "예" "아니오" 선택하지 않은 경우
			rm_snack_yn.parent().parent().find(".submit_check").show();
			rm_snack_yn.parent().parent().find(".error").show().text("객실 내 다과 유무를 선택해 주세요.");
		}
		
		
		// 객실 내 엔터테인먼트 -- rm_ent_yn
		const rm_ent_yn = $("input[name='rm_ent_yn']");
		let n10 = 0;		
		
		if( rm_ent_yn.val() != "" ) {
		// "예" "아니오" 선택한 경우
			rm_ent_yn.parent().parent().find(".submit_check").hide();
			rm_ent_yn.parent().parent().find(".error").hide().text("");
		
			if(rm_ent_yn.val() == "0") {
			//  "아니오"
				rm_ent_yn.parent().parent().find(".submit_check").hide();
				rm_ent_yn.parent().parent().find(".error").hide().text("");
				n10 = 1;
			}
			else{
			//  "예"
				const y_btn_after = rm_ent_yn.parent().parent().next(".y_btn_after");
			
				const checkbox_text = y_btn_after.find(".checkbox_text");
				
				$.each(checkbox_text, function(index, item){
				// 체크박스 반복문
					if( $(item).is(":checked") ) {
					// 옵션 체크박스에 체크를 했다.
						n10 = 1;
						y_btn_after.find(".submit_check").hide();
						y_btn_after.find(".error").hide().text("");
						return false; // 체크를 했으므로 반복문을 중단한다.
					}
					else {
					// 옵션 체크박스에 체크를 하지 않았다.
						y_btn_after.find(".submit_check").show();
						y_btn_after.find(".error").show().text("옵션을 선택하셔야 합니다.");
					}
						
				}); // end of $.each(checkbox_text, function()
				
			} // end of if(rm_ent_yn.val() == "0") else --------------------
			
		}
		else {
		// "예" "아니오" 선택하지 않은 경우
			rm_ent_yn.parent().parent().find(".submit_check").show();
			rm_ent_yn.parent().parent().find(".error").show().text("객실 내 엔터테인먼트 유무를 선택해 주세요.");
		}
		
		
		
		// 온도조절기 -- rm_tmp_ctrl_yn
		const rm_tmp_ctrl_yn = $("input[name='rm_tmp_ctrl_yn']");
		let n11 = 0;		
		
		if( rm_tmp_ctrl_yn.val() != "" ) {
		// "예" "아니오" 선택한 경우
			rm_tmp_ctrl_yn.parent().parent().find(".submit_check").hide();
			rm_tmp_ctrl_yn.parent().parent().find(".error").hide().text("");
		
			if(rm_tmp_ctrl_yn.val() == "0") {
			//  "아니오"
				rm_tmp_ctrl_yn.parent().parent().find(".submit_check").hide();
				rm_tmp_ctrl_yn.parent().parent().find(".error").hide().text("");
				n11 = 1;
			}
			else{
			//  "예"
				const y_btn_after = rm_tmp_ctrl_yn.parent().parent().next(".y_btn_after");
			
				const checkbox_text = y_btn_after.find(".checkbox_text");
				
				$.each(checkbox_text, function(index, item){
				// 체크박스 반복문
					if( $(item).is(":checked") ) {
					// 옵션 체크박스에 체크를 했다.
						n11 = 1;
						y_btn_after.find(".submit_check").hide();
						y_btn_after.find(".error").hide().text("");
						return false; // 체크를 했으므로 반복문을 중단한다.
					}
					else {
					// 옵션 체크박스에 체크를 하지 않았다.
						y_btn_after.find(".submit_check").show();
						y_btn_after.find(".error").show().text("옵션을 선택하셔야 합니다.");
					}
						
				}); // end of $.each(checkbox_text, function()
				
			} // end of if(rm_tmp_ctrl_yn.val() == "0") else --------------------
			
		}
		else {
		// "예" "아니오" 선택하지 않은 경우
			rm_tmp_ctrl_yn.parent().parent().find(".submit_check").show();
			rm_tmp_ctrl_yn.parent().parent().find(".error").show().text("온도조절기 유무를 선택해 주세요.");
		}
		
		
		// 흡연유무 -- rm_smoke_yn
		const rm_smoke_yn = $("input[name='rm_smoke_yn']");
		let n12 = 0;
		
		if( rm_smoke_yn.val().length > 0 ) {
		// "예" "아니오" 선택함
			rm_smoke_yn.parent().parent().find(".submit_check").hide();
			rm_smoke_yn.parent().parent().find(".error").hide().text("");
			n12 = 1;
		}
		else {
		// "예" "아니오" 선택을 하지 않음
			rm_smoke_yn.parent().parent().find(".submit_check").show()
			rm_smoke_yn.parent().parent().find(".error").show().text("흡연 가능여부를 선택해주세요.");
		}
		
		
		// 전망옵션 -- fk_view_no
		const fk_view_no = $("select[name='fk_view_no']");
		let n13 = 0;
		
		if( fk_view_no.val().length > 0 ) {
		// "예" "아니오" 선택함
			fk_view_no.parent().parent().find(".submit_check").hide();
			fk_view_no.parent().parent().find(".error").hide().text("");
			n13 = 1;
		}
		else {
		// "예" "아니오" 선택을 하지 않음
			fk_view_no.parent().parent().find(".submit_check").show()
			fk_view_no.parent().parent().find(".error").show().text("전망을 선택해주세요.");
		}
		
		
		
		// 휠체어이용가능유무 -- rm_wheelchair_yn
		const rm_wheelchair_yn = $("input[name='rm_wheelchair_yn']");
		let n14 = 0;
		
		if( rm_wheelchair_yn.val().length > 0 ) {
		// "예" "아니오" 선택함
			rm_wheelchair_yn.parent().parent().find(".submit_check").hide();
			rm_wheelchair_yn.parent().parent().find(".error").hide().text("");
			n14 = 1;
		}
		else {
		// "예" "아니오" 선택을 하지 않음
			rm_wheelchair_yn.parent().parent().find(".submit_check").show()
			rm_wheelchair_yn.parent().parent().find(".error").show().text("휠체어 이용 가능 유무를 선택해 주세요.");
		}
		
		
		
		// 투숙가능인원 -- rm_guest_cnt
		const rm_guest_cnt = $("input[name='rm_guest_cnt']");
		let n15 = 0;
		
		if( rm_guest_cnt.val() > 0 ) {
		// 침실 개수를 입력
			rm_guest_cnt.parent().parent().find(".submit_check").hide();
			rm_guest_cnt.parent().parent().find(".error").hide().text("");
			n15 = 1;
		}
		else {
		// 침실 개수를 입력하지 않음
			rm_guest_cnt.parent().parent().find(".submit_check").show();
			rm_guest_cnt.parent().parent().find(".error").show().text("투숙 가능 인원을 입력해 주세요.");
		}
		
		
		
		// 숙박요금 -- rm_price
		const rm_price = $("input[name='rm_price']");
		let n16 = 0;
		
		if( rm_price.val() > 0 ) {
		// 침실 개수를 입력
			rm_price.parent().parent().find(".submit_check").hide();
			rm_price.parent().parent().find(".error").hide().text("");
			n16 = 1;
		}
		else {
		// 침실 개수를 입력하지 않음
			rm_price.parent().parent().find(".submit_check").show();
			rm_price.parent().parent().find(".error").show().text("숙박요금을 입력해 주세요.");
		}
		
		
		
		// 조식포함 유무 -- rm_breakfast_yn
		const rm_breakfast_yn = $("input[name='rm_breakfast_yn']");
		let n17 = 0;
		
		if( rm_breakfast_yn.val() > 0 ) {
		// 침실 개수를 입력
			rm_breakfast_yn.parent().parent().find(".submit_check").hide();
			rm_breakfast_yn.parent().parent().find(".error").hide().text("");
			n17 = 1;
		}
		else {
		// 침실 개수를 입력하지 않음
			rm_breakfast_yn.parent().parent().find(".submit_check").show();
			rm_breakfast_yn.parent().parent().find(".error").show().text("조식 유무를 선택해 주세요.");
		}
		
		
		if( confirm("시설을 등록하시겠습니까?") ) {
			let a1 = n1*n2*n3*n4*n5;
			let a2 = n6*n7*n8*n9*n10;
			let a3 = n11*n12*n13*n14*n15;
			let a4 = n16*n17;
		
			let pass = a1*a2*a3*a4;
			
			console.log(a1 ,a2, a3, a4);
			console.log("a1 => ", n1, n2, n3, n4, n5);
			console.log("a2 => ", n6, n7, n8, n9, n10);
			console.log("a3 => ", n11, n12, n13, n14, n15);
			console.log("a4 => ", n16, n17);
			
			if(pass == 1) {
				const frm = document.room_info_Frm;
				frm.method = "post";
				frm.action = "<%=ctxPath%>/rm_register.exp";
				frm.submit();	
			} else {
				alert("입력한 정보를 다시 확인해 주세요.");
			}

		}// end of if( confirm("시설을 등록하시겠습니까?") )
	
		// n1,  n2,  n3,  n4,  n5,  n6,  n7,  n8,  n9,  n10
		// n11, n12, n13, n14, n15, n16, n17
		
	}// end of room_register()

	
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
			e_par.parent().next("div.y_btn_after").find("input").prop("disabled",false);
			e_par.parent().next("div.y_btn_after").find("select").prop("disabled",false);
			
		}
		else{
		// "아니오" 
			e_par.parent().next("div.y_btn_after").hide();
			e_par.parent().next("div.y_btn_after").find("input").prop("disabled",true);
			e_par.parent().next("div.y_btn_after").find("input").val("");
			e_par.parent().next("div.y_btn_after").find("select").prop("disabled",true);
			e_par.parent().next("div.y_btn_after").find("input:checkbox").prop("checked",false);
		}
		
	} // end of function btn_click_e(this)


	
</script>

<title>객실 등록</title>

<div style="inline-size: 100%; margin: auto; max-inline-size: 75rem; padding: 50px 0;">

	<div class="register_body">
		
		<div id="room_info">
			<div id="form_info">
				
				<h2>
					객실 정보 등록
				</h2>
				<p>나중에 언제든지 더 추가하실 수 있습니다.</p>
			</div>
			
			<div id="form_data">
				<form name="room_info_Frm">
					
					<div class="__data">
						<div class="div_sub">
							<span>정보</span>
						</div>	
						<div>
							<select name="update_room_seq" >
								<option value="0">객실 추가하기</option>
								<c:if test="${empty requestScope.updateRmInfoMapList}">
									<option value="">등록된 객실이 없습니다.</option>
								</c:if>
								<c:forEach var="updateRmInfo" items="${requestScope.updateRmInfoMapList}">
									<option value="${updateRmInfo.rm_seq}">${updateRmInfo.rm_type}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					
					<div class="_br"></div>
					
					<div class="__data">
						<div class="div_sub">
						</div>
						<div class="fk_lodge_id">			
							<input type="hidden" name="fk_lodge_id" value="${requestScope.fk_lodge_id}" size="15" />
						</div>
					</div>
					
					
					<div class="__data">
						<div class="div_sub">
							<span class="sub">객실이름을 입력해 주세요.</span><svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span>
						</div>
						<div class="rm_type">			
							<input type="text" id="rm_type" name="rm_type"  size="40" placeholder="예) 디럭스 트윈룸" />
						</div>
					</div>
					
					<div class="__data">
						<div class="div_sub">
							<span class="sub">객실 수</span><svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span>
						</div>
						<div class="rm_cnt">
							<input type="number" id="rm_cnt" name="rm_cnt" size="7" maxlength="5" />
						</div>
					</div>
					
					<div class="_br"></div>
					
		 			<div class="__data">
						<div class="div_sub">
							<span>객실크기</span><svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span>
						</div>
						<div class="rm_size">
							<div>
								<div class="size_unit_type">크기(제곱미터)</div>
								<div><input type="text" name="rm_size_meter" id="rm_size_meter" size="10" maxlength="7" /></div>
							</div>
							<div>
								<div class="size_unit_type">크기(평)</div>
								<div><input type="text" name="rm_size_pyug" id="rm_size_pyug" size="10" maxlength="7" /></div>
							</div>
						</div>
					</div>

					<div class="__data">
						<div class="div_sub">
							<span class="sub">침실개수</span><svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span>
						</div>
						<div class="rm_bedrm_cnt">
							<input type="number" id="rm_bedrm_cnt" name="rm_bedrm_cnt" />
						</div>
					</div>
					
		<!--    rm_extra_bed_yn   -->			
					<div class="__data __flex">
						<div class="div_sub __flex">
							<span class="sub" >침대 추가 가능여부<svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span></span>
						</div>
						<div class="btn_div __flex">
							<button class="y_btn" type="button" onclick="btn_click_e(this)" value="1">예</button>
							<button class="n_btn" type="button" onclick="btn_click_e(this)" value="0">아니요</button>
							<input type="hidden" name="rm_extra_bed_yn" />
						</div>
					</div>

					<div class="__data">
						<div class="div_sub">
							<span>싱글침대</span>
						</div>	
						<div>
							<select name="rm_single_bed">
								<c:forEach begin="0" end="20" varStatus="status">
									<option>${status.index}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					
					<div class="__data">
						<div class="div_sub">
							<span>슈퍼싱글침대</span>
						</div>	
						<div>
							<select name="rm_ss_bed">
								<c:forEach begin="0" end="20" varStatus="status">
									<option>${status.index}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					
					<div class="__data">
						<div class="div_sub">
							<span>더블침대</span>
						</div>	
						<div>
							<select name="rm_double_bed">
								<c:forEach begin="0" end="20" varStatus="status">
									<option>${status.index}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					
					<div class="__data">
						<div class="div_sub">
							<span>퀸사이즈침대</span>
						</div>	
						<div>
							<select name="rm_queen_bed">
								<c:forEach begin="0" end="20" varStatus="status">
									<option>${status.index}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					
					<div class="__data">
						<div class="div_sub">
							<span>킹사이즈침대</span>
						</div>	
						<div>
							<select name="rm_king_bed">
								<c:forEach begin="0" end="20" varStatus="status">
									<option>${status.index}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					
					<div class="_br"></div>
					
		<!-- rm_bathroom_cnt   전용욕실갯수 	0 보다 크면 옵션 체크-->
					<div class="__data">
						<div class="div_sub">
							<span class="sub">전용 욕실 개수</span><svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span>
						</div>
						<div class="rm_bathroom_cnt">
							<input type="number" id="rm_bathroom_cnt" name="rm_bathroom_cnt" />
						</div>
					</div>
					
		<!-- tbl_bath_opt 으로 체크박스 ==>  tbl_bath 테이블에 insert  -->
					<div class="__data y_btn_after">
						<div class="div_sub">
							<span class="sub" >욕실시설 옵션</span><svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span>
						</div>
						<div class="fk_bath_opt_no">
							<c:forEach var="bathOpt" items="${requestScope.bathOptMapList}">
							<div class="checkbox_div">
								<input class="checkbox_text" name="fk_bath_opt_no" id="fk_bath_opt_no_${bathOpt.bath_opt_no}" type="checkbox" value="${bathOpt.bath_opt_no}" ></input>
								<label class="checkbox_input_box" for="fk_bath_opt_no_${bathOpt.bath_opt_no}">${bathOpt.bath_opt_desc}</label>
							</div>
							</c:forEach>
						</div>
					</div>
					
			<!-- rm_p_bathroom_yn	공용욕실유무 	"예" "아니오" -->		
					<div class="__data __flex">
						<div class="div_sub __flex">
							<span class="sub" >공용욕실유무<svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span></span>
						</div>		
						<div class="btn_div __flex">
							<button class="y_btn" type="button" onclick="btn_click_e(this)" value="1">예</button>
							<button class="n_btn" type="button" onclick="btn_click_e(this)" value="0">아니요</button>
							<input type="hidden" name="rm_p_bathroom_yn" />
						</div>
					</div>
					
		<!-- rm_kitchen_yn  "예" "아니오" 이후에  체크박스 		0	조리도구, 접시, 주방 기구
														1	식기세척기
														2	냉장고
														3	오븐
														4	전자레인지
														5	밥솥
														6	토스터
														7	양념/향신료
																				-->	
					<div class="__data __flex">
						<div class="div_sub __flex">
							<span class="sub" >주방(조리시설)유무<svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span></span>
						</div>		
						<div class="btn_div __flex">
							<button class="y_btn" type="button" onclick="btn_click_e(this)" value="1">예</button>
							<button class="n_btn" type="button" onclick="btn_click_e(this)" value="0">아니요</button>
							<input type="hidden" name="rm_kitchen_yn" />
						</div>
					</div>
					
		<!-- tbl_kt_opt 으로 체크박스 ==>  tbl_kitchen 테이블에 insert  -->
					<div class="__data y_btn_after">
						<div class="div_sub">
							<span class="sub" >주방(조리시설) 종류</span><svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span>
						</div>
						<div class="fk_kt_opt_no">
							<c:forEach var="kitchenOpt" items="${requestScope.kitchenOptMapList}">
							<div class="checkbox_div">
								<input class="checkbox_text" name=fk_kt_opt_no id="fk_kt_opt_no_${kitchenOpt.kt_opt_no}" type="checkbox" value="${kitchenOpt.kt_opt_no}" ></input>
								<label class="checkbox_input_box" for="fk_kt_opt_no_${kitchenOpt.kt_opt_no}">${kitchenOpt.kt_opt_desc}</label>
							</div>
							</c:forEach>
						</div>
					</div> 
					
		<!-- rm_snack_yn  "예" "아니오" 이후에  체크박스 		0	무료 생수
														1	커피/티/에스프레소 메이커
														2	미니바
														3	바 
														-->	
					
					<div class="__data __flex">
						<div class="div_sub __flex">
							<span class="sub" >객실 내 다과<svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span></span>
						</div>		
						<div class="btn_div __flex">
							<button class="y_btn" type="button" onclick="btn_click_e(this)" value="1">예</button>
							<button class="n_btn" type="button" onclick="btn_click_e(this)" value="0">아니요</button>
							<input type="hidden" name="rm_snack_yn" />
						</div>
					</div>
					
		<!-- tbl_snk_opt 으로 체크박스 ==>  tbl_snack 테이블에 insert  -->
					<div class="__data y_btn_after">
						<div class="div_sub">
							<span class="sub" >객실내다과 옵션</span><svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span>
						</div>
						<div class="fk_snk_opt_no">
							<c:forEach var="snackOpt" items="${requestScope.snackOptMapList}">
							<div class="checkbox_div">
								<input class="checkbox_text" name="fk_snk_opt_no" id="fk_snk_opt_no_${snackOpt.snk_opt_no}" type="checkbox" value="${snackOpt.snk_opt_no}" ></input>
								<label class="checkbox_input_box" for="fk_snk_opt_no_${snackOpt.snk_opt_no}">${snackOpt.snk_opt_desc}</label>
							</div>
							</c:forEach>
						</div>
					</div>
					
					
					<!-- rm_ent_yn  "예" "아니오" 이후에  체크박스 		0	TV
																1	IPTV
																2	OTT 이용 가능
																3	컴퓨터 또는 태블릿
																4	음성 인식 스마트 스피커 
																-->	
					<div class="__data __flex">
						<div class="div_sub __flex">
							<span class="sub" >객실 내 엔터테인먼트<svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span></span>
						</div>		
						<div class="btn_div __flex">
							<button class="y_btn" type="button" onclick="btn_click_e(this)" value="1">예</button>
							<button class="n_btn" type="button" onclick="btn_click_e(this)" value="0">아니요</button>
							<input type="hidden" name="rm_ent_yn" />
						</div>
					</div>
					
		<!-- tbl_ent_opt 으로 체크박스 ==>  tbl_ent테이블에 insert  -->
					<div class="__data y_btn_after">
						<div class="div_sub">
							<span class="sub" >객실 내 엔터테인먼트 옵션</span><svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span>
						</div>
						<div class="fk_ent_opt_no">
							<c:forEach var="entertainmentOpt" items="${requestScope.entertainmentOptMapList}">
							<div class="checkbox_div">
								<input class="checkbox_text" name="fk_ent_opt_no" id="fk_ent_opt_no_${entertainmentOpt.ent_opt_no}" type="checkbox" value="${entertainmentOpt.ent_opt_no}" ></input>
								<label class="checkbox_input_box" for="fk_ent_opt_no_${entertainmentOpt.ent_opt_no}">${entertainmentOpt.ent_opt_desc}</label>
							</div>
							</c:forEach>
						</div>
					</div>
					
					<div class="_br"></div>
					
					
				<!-- rm_tmp_ctrl_yn 온도조절기 "예" "아니오" 이후 			0	에어컨
																	1	선풍기
																	2	난방 		 체크박스     -->
					<div class="__data __flex">
						<div class="div_sub __flex">
							<span class="sub" >온도조절기 유무<svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span></span>
						</div>		
						<div class="btn_div __flex">
							<button class="y_btn" type="button" onclick="btn_click_e(this)" value="1">예</button>
							<button class="n_btn" type="button" onclick="btn_click_e(this)" value="0">아니요</button>
							<input type="hidden" name="rm_tmp_ctrl_yn" />
						</div>
					</div>
					
		<!-- tbl_tmp_opt으로 체크박스 ==>  tbl_tmp테이블에 insert  -->
					<div class="__data y_btn_after">
						<div class="div_sub">
							<span class="sub" >온도조절기 종류</span><svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span>
						</div>
						<div class="fk_tmp_opt_no">
							<c:forEach var="temperatureControllerOpt" items="${requestScope.temperatureControllerOptMapList}">
							<div class="checkbox_div">
								<input class="checkbox_text" name="fk_tmp_opt_no" id="fk_tmp_opt_no_${temperatureControllerOpt.tmp_opt_no}" type="checkbox" value="${temperatureControllerOpt.tmp_opt_no}" ></input>
								<label class="checkbox_input_box" for="fk_tmp_opt_no_${temperatureControllerOpt.tmp_opt_no}">${temperatureControllerOpt.tmp_opt_desc}</label>
							</div>
							</c:forEach>
						</div>
					</div>
					
					<div class="_br"></div>
					
			<!-- rm_smoke_yn 흡연유무 "예" "아니오" 끝 -->
			
					<div class="__data __flex">
						<div class="div_sub __flex">
							<span class="sub" >흡연유무<svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span></span>
						</div>		
						<div class="btn_div __flex">
							<button class="y_btn" type="button" onclick="btn_click_e(this)" value="1">예</button>
							<button class="n_btn" type="button" onclick="btn_click_e(this)" value="0">아니요</button>
							<input type="hidden" name="rm_smoke_yn" />
						</div>
					</div>
					
					<div class="_br"></div>
					
			<!-- fk_view_no 전망옵션 		6	호수 전망		select 태그
										0	전망없음
										1	해변 전망
										2	산 전망
										3	강 전망
										4	시내 전망
										5	공원 전망 
													-->
					<div class="__data">
						<div class="div_sub">
							<span class="sub">전망옵션</span><svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span>
						</div>
						<div class="fk_view_no">
							<select name="fk_view_no">
									<option value="">--선택--</option>
								<c:forEach var="viewOpt" items="${requestScope.viewOptMapList}">
									<option value="${viewOpt.view_no}">${viewOpt.view_desc}</option>
								</c:forEach>			
							</select>
						</div>
					</div>
					
					
				<!--    rm_wheelchair_yn   휠체어이용가능유무 "예" "아니오" 끝 -->			
					<div class="__data __flex">
						<div class="div_sub __flex">
							<span class="sub" >휠체어이용가능유무<svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span></span>
						</div>
						<div class="btn_div __flex">
							<button class="y_btn" type="button" onclick="btn_click_e(this)" value="1">예</button>
							<button class="n_btn" type="button" onclick="btn_click_e(this)" value="0">아니요</button>
							<input type="hidden" name="rm_wheelchair_yn" />
						</div>
					</div>
					
					<div class="_br"></div>				
					
			<!-- rm_guest_cnt 투숙가능인원 input:number-->
					<div class="__data">
						<div class="div_sub">
							<span class="sub">투숙가능인원</span><svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span>
						</div>
						<div class="rm_guest_cnt"> <!-- n3 -->
							<input type="number" id="rm_guest_cnt" name="rm_guest_cnt" size="5" />
						</div>
					</div>
	
					<div class="_br"></div>
					
		<!-- rm_price 숙박요금  input:number -->			
					<div class="__data">
						<div class="div_sub">
							<span class="sub">숙박요금</span><svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span>
						</div>
						<div class="rm_price">
							<input type="number" id="rm_price" name="rm_price" size="15" />원
						</div>
					</div>
					
					<div class="_br"></div>
					
		<!-- rm_breakfast_yn 조식 포함 유무 	"예" "아니오" -->
					<div class="__data __flex">
						<div class="div_sub __flex">
							<span class="sub" >조식포함 유무<svg class="submit_check" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a01313" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm0-384c13.3 0 24 10.7 24 24V264c0 13.3-10.7 24-24 24s-24-10.7-24-24V152c0-13.3 10.7-24 24-24zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"/></svg><span class="error"></span></span>
						</div>
						<div class="btn_div __flex">
							<button class="y_btn" type="button" onclick="btn_click_e(this)" value="1">예</button>
							<button class="n_btn" type="button" onclick="btn_click_e(this)" value="0">아니요</button>
							<input type="hidden" name="rm_breakfast_yn" />
						</div>
					</div>
					
				</form>
			</div>
				
			<div class="hadan">
				<button id="room_register" type="button" onclick="room_register()">등록하기</button>
			</div>
		
		</div>
	</div> <%-- register_body end --%>

</div> 