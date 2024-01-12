<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% 
   String ctxPath = request.getContextPath(); 
   //    /board
%>    
<style type="text/css">

	table#schedule{
		margin-top: 70px;
	}
	
	table#schedule th, td{
	 	padding: 10px 5px;
	 	vertical-align: middle;
	}
	
	select.schedule{
		height: 30px;
	}
	
	input#joinUserName:focus{
		outline: none;
	}
	
	span.plusUser{
			float:left; 
			background-color:#737373; 
			color:white;
			border-radius: 10%;
			padding: 8px;
			margin: 3px;
			transition: .8s;
			margin-top: 6px;
	}
	
	span.plusUser > i {
		cursor: pointer;
	}
	
	.ui-autocomplete {
		max-height: 100px;
		overflow-y: auto;
	}
	  
	button.btn_normal{
		border: none;
		color: white;
		width: 70px;
		height: 30px;
		font-size: 12pt;
		padding: 3px 0px;
		border-radius: 10%;
	}

	input.form-control:focus {
		outline:none;
		box-shadow: none;
	}


</style>


<script type="text/javascript">

	$(document).ready(function(){
		
		// 캘린더 소분류 카테고리 숨기기
		$("select.small_category").hide();
		
		// === *** 달력(type="date") 관련 시작 *** === //
		// 시작시간, 종료시간		
		var html="";
		for(var i=0; i<24; i++){
			if(i<10){
				html+="<option value='0"+i+"'>0"+i+"</option>";
			}
			else{
				html+="<option value="+i+">"+i+"</option>";
			}
		}// end of for----------------------
		
		$("select#startHour").html(html);
		$("select#endHour").html(html);
		
		// 시작분, 종료분 
		html="";
		for(var i=0; i<60; i=i+5){
			if(i<10){
				html+="<option value='0"+i+"'>0"+i+"</option>";
			}
			else {
				html+="<option value="+i+">"+i+"</option>";
			}
		}// end of for--------------------
		html+="<option value="+59+">"+59+"</option>"
		
		$("select#startMinute").html(html);
		$("select#endMinute").html(html);
		// === *** 달력(type="date") 관련 끝 *** === //
		
		// '종일' 체크박스 클릭시
		$("input#allDay").click(function() {
			var bool = $('input#allDay').prop("checked");
			
			if(bool == true) {
				$("select#startHour").val("00");
				$("select#startMinute").val("00");
				$("select#endHour").val("23");
				$("select#endMinute").val("59");
				$("select#startHour").prop("disabled",true);
				$("select#startMinute").prop("disabled",true);
				$("select#endHour").prop("disabled",true);
				$("select#endMinute").prop("disabled",true);
			} 
			else {
				$("select#startHour").prop("disabled",false);
				$("select#startMinute").prop("disabled",false);
				$("select#endHour").prop("disabled",false);
				$("select#endMinute").prop("disabled",false);
			}
		});
		
				
		// 내캘린더,사내캘린더 선택에 따른 서브캘린더 종류를 알아와서 select 태그에 넣어주기 
		
			var fk_h_userid = $("input[name=fk_h_userid]").val();  // 로그인 된 판매자아이디
			
			
			$.ajax({
				url: "<%= ctxPath%>/schedule/selectSmallCategory.exp",
				data: {"fk_h_userid":fk_h_userid},
				dataType: "json",
				success:function(json){
					var html ="";
					var v_html ="";
					if(json.length>0){
						
						$.each(json, function(index, item){
							html+="<option value='"+item.rm_seq+"'>"+item.rm_type+"</option>";
							
							
						});
						$("select.small_category").html(html);
						$("select.small_category").show();
						
						// select 태그 변경 시 이벤트 핸들러
						$("select.schedule").on('change', function() {
						    var selectedValue = $(this).val(); // 선택된 옵션 값 가져오기

						    // JSON 데이터에서 선택된 값에 해당하는 rm_price 찾기
						    var selectedPrice = "";
						    $.each(json, function(index, item) {
						        if (item.rm_seq == selectedValue) {
						            selectedPrice = item.rm_price;
						            return false; // 반복문 종료
						        }
						    });

						    // 찾은 가격을 화면에 출력
						    $("input[name='rm_price']").val(selectedPrice);
						});
						
						
						
						
					}
				},
				error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});
			
		
		
		
		
		
		

		
		
		// 등록 버튼 클릭
		$("button#register").click(function(){
		
			// 일자 유효성 검사 (시작일자가 종료일자 보다 크면 안된다!!)
			var startDate = $("input#startDate").val();	
	    	var sArr = startDate.split("-");
	    	startDate= "";	
	    	for(var i=0; i<sArr.length; i++){
	    		startDate += sArr[i];
	    	}
	    	
	    	var endDate = $("input#endDate").val();	
	    	var eArr = endDate.split("-");   
	     	var endDate= "";
	     	for(var i=0; i<eArr.length; i++){
	     		endDate += eArr[i];
	     	}
			
	     	var startHour= $("select#startHour").val();
	     	var endHour = $("select#endHour").val();
	     	var startMinute= $("select#startMinute").val();
	     	var endMinute= $("select#endMinute").val();
	        
	     	// 조회기간 시작일자가 종료일자 보다 크면 경고
	        if (Number(endDate) - Number(startDate) < 0) {
	         	alert("종료일이 시작일 보다 작습니다."); 
	         	return;
	        }
	        
	     	// 시작일과 종료일 같을 때 시간과 분에 대한 유효성 검사
	        else if(Number(endDate) == Number(startDate)) {
	        	
	        	if(Number(startHour) > Number(endHour)){
	        		alert("종료일이 시작일 보다 작습니다."); 
	        		return;
	        	}
	        	else if(Number(startHour) == Number(endHour)){
	        		if(Number(startMinute) > Number(endMinute)){
	        			alert("종료일이 시작일 보다 작습니다."); 
	        			return;
	        		}
	        		else if(Number(startMinute) == Number(endMinute)){
	        			alert("시작일과 종료일이 동일합니다."); 
	        			return;
	        		}
	        	}
	        }// end of else if---------------------------------
	    	
			// 객실 수 유효성 검사
			var rm_cnt = $("input#rm_cnt").val().trim();
	        if(rm_cnt==""){
				alert("객실 수를 입력하세요."); 
				return;
			}
	        
			// 예약자명 유효성 검사
			var rs_name = $("input#rs_name").val().trim();
	        if(rs_name==""){
				alert("예약자명을 입력하세요."); 
				return;
			}
	        
			// 예약자 연락처 유효성 검사
			var rs_mobile = $("input#rs_mobile").val().trim();
	        if(rs_mobile==""){
				alert("연락처를 입력하세요."); 
				return;
			}
	        
			// 예약자 이메일 유효성 검사
			var rs_email = $("input#rs_email").val().trim();
	        if(rs_email==""){
				alert("이메일을 입력하세요."); 
				return;
			}
	        
			// 투숙인원 유효성 검사
			var rs_quest_cnt = $("input#rs_quest_cnt").val();
	        if(rs_quest_cnt==""){
				alert("투숙 인원을 입력하세요."); 
				return;
			}
	        
	     	// 예약자 아이디의 입력한 값이 실제로 tbl_user에 존재하는지 확인하기
			let b_useridCheck = false;
			const fk_userid = $("input#fk_userid").val(); 
			
			$.ajax({
				url: "<%= ctxPath%>/schedule/confilctFk_userid.exp",
				data: {"fk_userid":fk_userid},
				dataType: "json",
				success:function(json){
					var html ="";
					if(json.length == 0){
						b_useridCheck = false;
						alert("존재하지 않는 회원 ID입니다. 다시 입력바랍니다.");
						return;
					}
					else {
						b_useridCheck = true;
					}
				},
				error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});
	        
	        
	        
	        
	        
	        
	        
			
			// 달력 형태로 만들어야 한다.(시작일과 종료일)
			// 오라클에 들어갈 date 형식(년월일시분초)으로 만들기
			var sdate = startDate+$("select#startHour").val()+$("select#startMinute").val()+"00";
			var edate = endDate+$("select#endHour").val()+$("select#endMinute").val()+"00";
			
			$("input[name=startdate]").val(sdate);
			$("input[name=enddate]").val(edate);
		
		//	console.log("캘린더 소분류 번호 => " + $("select[name=fk_smcatgono]").val());
			/*
			      캘린더 소분류 번호 => 1 OR 캘린더 소분류 번호 => 2 OR 캘린더 소분류 번호 => 3 OR 캘린더 소분류 번호 => 4 
			*/
			
		//  console.log("색상 => " + $("input#color").val());
			
			
			
			var frm = document.scheduleFrm;
			frm.action="<%= ctxPath%>/schedule/registerSchedule_end.exp";
			frm.method="post";
			frm.submit();

		});// end of $("button#register").click(function(){})--------------------
		
		
		
		
		
		
		
		
	}); // end of $(document).ready(function(){}-----------------------------------


	
	
		

</script>

<body style="background-color:white;">
	<div style="inline-size: 100%; margin: auto; max-inline-size: 75rem; padding: 50px 0;">
	
		<div style="width:70%; margin:auto; border:solid 0px gray;">

		<h2 >예약 일정등록</h2>

		<form name="scheduleFrm">
			<table id="schedule" class="table table-bordered">
				<tr>
					<th>예약 일정</th>
					<td>
						<input type="date" id="startDate" value="${requestScope.chooseDate}" style="height: 30px;"/>&nbsp; 
						<select id="startHour" class="schedule"></select> 시
						<select id="startMinute" class="schedule"></select> 분
						- <input type="date" id="endDate" value="${requestScope.chooseDate}" style="height: 30px;"/>&nbsp;
						<select id="endHour" class="schedule"></select> 시
						<select id="endMinute" class="schedule"></select> 분&nbsp;
						<input type="checkbox" id="allDay"/>&nbsp;<label for="allDay">종일</label>
						
						<input type="hidden" name="startdate"/>
						<input type="hidden" name="enddate"/>
					</td>
				</tr>
				
				<tr>
					<th>객실등급</th>
					<td>
						<select class="small_category schedule" name="fk_rm_seq"></select>
					</td>
				</tr>
				
				
				
				
				<tr>
					<th>객실 수</th>
					<td><input type="text" id="rm_cnt" name="rm_cnt" class="form-control"/></td>
				</tr>
				
				<tr>
					<th>예약자명</th>
					<td><input type="text" id="rs_name" name="rs_name" class="form-control"/></td>
				</tr>
				
				<tr>
					<th>예약자 아이디</th>
					<td><input type="text" id="fk_userid" name="fk_userid" class="form-control"/></td>
				</tr>
				
				<tr>
					<th>예약자 연락처</th>
					<td><input type="text" id="rs_mobile" name="rs_mobile" class="form-control"/></td>
				</tr>
				
				<tr>
					<th>예약자 이메일</th>
					<td><input type="text" id="rs_email" name="rs_email" class="form-control"/></td>
				</tr>
				
				<tr>
					<th>투숙 인원</th>
					<td><input type="text" id="rs_guest_cnt" name="rs_guest_cnt" class="form-control"/></td>
				</tr>
				
				<tr>
					<th>결제방식</th>
					<td>
						<input type="radio" id="rs_payType" name="rs_payType" value="0"><label for="rs_payType">현장결제</label>
						<input type="radio" id="rs_payType" name="rs_payType" value="1"><label for="rs_payType">예약결제</label>
					</td>
				</tr>
			
				
			
			
				
				
			</table>
			<input type="hidden" value="${sessionScope.loginhost.h_userid}" name="fk_h_userid"/>
			<input type="hidden" value="" name="rm_price"/>
		
			<button type="button" id="register" class="btn_normal" style="margin-right: 10px; background-color: #0071bd;">등록</button>
			<button type="button" class="btn_normal" style="background-color: #990000;" onclick="javascript:location.href='<%= ctxPath%>/schedule/scheduleManagement.exp'">취소</button> 
		
		</form>
	
		
			
	
		
		</div>
	</div>
</body>
