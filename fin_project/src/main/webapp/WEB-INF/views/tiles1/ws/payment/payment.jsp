<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	String ctxPath = request.getContextPath();
    //      /expedia
%> 

<title>결제페이지</title>

<style type="text/css">
	select[name='customerName']{
		background-color:#104ba2;
		border-radius: 0.5rem;
		color:white;
	}
	
	.cursor_target{
		cursor:pointer;
	}
	
	.check_span{
		color:#616161;
		font-weight:bold;
	}
	
	.shading_input{
		box-shadow: inset 0 1px 0 rgba(0,0,0,.1), inset 0 1px 1px rgba(0,0,0,.05);
		border-radius: 0.3rem;
	}
	
	input{
		border-width: 1px;
	}
	
	.common_box_size{
		height:37px;
	}
	
	.text-gray{
		color:#616161;
	}
	
	.checkbox_wid_hei{
		width:15px;
		height:15px;
	}
	
</style>

<script type="text/javascript">

	//필수사항을 모두 입력했는지 안했는지 알아보기 위한 용도 ============================== 시작
	
	var b_myName_input = false;
	var b_mobile1_input = false;
	var b_mobile2_input = false;
	var b_mobile3_input = false;
	var b_myEmail_input = false;
	
	var b_agreement_click = false;
	
	
	// 필수사항을 모두 입력했는지 안했는지 알아보기 위한 용도 ============================== 끝

	$(document).ready(function(){
		var check_boolean1 = false;
		var check_boolean2 = false;
		var check_boolean3 = false;
		var check_boolean4 = false;
		

		
		const max_point = $("input.point_input").attr("max");
		
		$("input.point_input").blur(function(){
			if($("input.point_input").val() > Number(max_point)){
				alert("보유 포인트보다 많은 값은 입력할 수 없습니다.");
				
				$("input.point_input").val($("span.point_hover").text());
				$("input.point_input").focus();
				const sum_price = Number($("input[name='sum_price']").val());
				const numberStr = $("input.point_input").val();
				const minus_number = Number(numberStr.replace(/,/g, ""));
				$("input[name='total__price']").val(sum_price - minus_number);
				
				var go_sum_priceEnd = sum_price-minus_number;
				$("span.sum_priceEnd").text(go_sum_priceEnd.toLocaleString("en"));
				
				$("input[name='used_point']").val($("input.point_input").val());
			}
		});
		
		
		// 유효성검사 알림 가리기
		$("div.checkdiv").hide();
		
		
		$("div.sel_name").click(function(){
			$("select[name='customerName']").focus();
		});
		
		// 이름 자동 포커스
		$("div.inp_name").click(function(){
			$("input.name_inp").focus();
		});
		
		// span 클릭시 input으로 포커스
		$("div.sel_mobile").click(function(){
			$("input.name_inp").focus();
		});
		
		
		// span 클릭시 input으로 포커스
		$("div.inp_email").click(function(){
			$("input.email_inp").focus();
		});
		
		// 휴대폰 유효성 검사  ============================================= 시작
		$("input.mobile1_inp").blur(function(e){
			var regMobile1 = /^01([0|1|6|7|8|9])$/;
			var result = regMobile1.test($(e.target).val());
			
			if(!result){
				$(e.target).focus();
				$("div.mobile_result").show();
				$("input.mobile2_inp").css("border","solid 2px #d60000");
				$("input.mobile3_inp").css("border","solid 2px #d60000");
			}
			else{
				$("div.mobile_result").hide();
				$("input.mobile2_inp").css("border","");
				$("input.mobile3_inp").css("border","");
			}
		});
		
		$("input.mobile2_inp").blur(function(e){
			var regMobile2 = /^([0-9]{3,4})$/;
			var result = regMobile2.test($(e.target).val());
			
			if(!result){
				$(e.target).focus();
				$("div.mobile_result").show();
				$("input.mobile1_inp").css("border","solid 2px #d60000");
				$("input.mobile3_inp").css("border","solid 2px #d60000");
			}
			else{
				$("div.mobile_result").hide();
				$("input.mobile1_inp").css("border","");
				$("input.mobile3_inp").css("border","");
			}
		});

		$("input.mobile3_inp").blur(function(e){
			var regMobile3 = /^([0-9]{4})$/;
			var result = regMobile3.test($(e.target).val());
			
			if(!result){
				$(e.target).focus();
				$("div.mobile_result").show();
				$("input.mobile1_inp").css("border","solid 2px #d60000");
				$("input.mobile2_inp").css("border","solid 2px #d60000");
			}
			else{
				$("div.mobile_result").hide();
				$("input.mobile1_inp").css("border","");
				$("input.mobile2_inp").css("border","");
			}
		});
		// 휴대폰 유효성 검사  ============================================= 끝
		
		// 휴대폰 번호 입력시 자동 다음 input으로 이동  ============================================= 시작
		$("input.mobile1_inp").keyup(function(){
			if(this.maxLength == this.value.length){
				$(this).next(".mobile2_inp").focus();
			}
		});
		
		$("input.mobile2_inp").keyup(function(){
			if(this.maxLength == this.value.length){
				$(this).next(".mobile3_inp").focus();
			}
		});
		
		
		// 휴대폰 번호 입력시 자동 다음 input으로 이동  ============================================= 끝
			
		
		// 이메일 유효성 검사 
		$("input.email_inp").blur(function(e){
			var regEmail = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
			var result = regEmail.test($(e.target).val());
			
			if(!result){
				$(e.target).focus();
				b_myEmail_input = false;
				$("div.checkEmail").show();
			}
			else{
				$("div.checkEmail").hide();
				$("input[name='email']").val($("input.email_inp").val());
				
				if($("input[name='email']").val().trim().length > 0){
					b_myEmail_input = true;
				}
			}
		}); 
		
		

		// 모두선택 체크박스 check 유무
		const checkbox_agreement_list = document.querySelectorAll("input[name='agreement']");
		
		for(let checkbox of checkbox_agreement_list){
			
			checkbox.addEventListener('click',()=>{
				
				if(!checkbox.checked){
					document.querySelector("input[id='checkAll']").checked = false;
				}
				else{
					let is_check_all = true;
					for(let checkbox_agreement of checkbox_agreement_list){
						if(!checkbox_agreement.checked){
							is_check_all = false;
							break;
						}
					} // end of for---------
					
					if(is_check_all){
						document.querySelector("input[id='checkAll']").checked = true;
						b_agreement_click = true;
					}
				}
				
			});
		}
		
		
		
		
		
		
		
		
		
		// display:none인 userid에 아이디 넣기
		$("input[name='userid']").val('${sessionScope.loginuser.userid}');
		
		
		
		
		
		//====================필수 입력사항 확인하기===========================시작
		
		// 이름
		$("input[name='myName']").blur(function(){
			$("input[name='name']").val($("input[name='myName']").val());
			
			if($("input[name='name']").val().trim().length == 0){
				$("div.myName_result").show();
				$("input[name='myName']").focus();
				b_myName_input = false;
			}
			
			if($("input[name='name']").val().trim().length > 0){
				$("div.myName_result").hide();
				b_myName_input = true;
			}
		});

		
		//====================필수 입력사항 확인하기===========================끝
		
		
		
		
		//====================form에 값을 넣기===========================시작
		
		// display:none인 name에 이름 넣기
		$("select[name='customerName']").change(function(){
			if($(this).val() == "name"){
				$("input[name='myName']").val($(this).find("option[value='name']").text());
				$("input[name='name']").val($(this).find("option[value='name']").text());
				$("input[name='myName']").attr("disabled", true);
			}
			else{
				$("input[name='myName']").val('');
				$("input[name='name']").val('');
				$("input[name='myName']").attr("disabled", false);
			}
		});
		
		
		
		// display:none인 mobile에 전화번호 넣기
		$("input[name='mobile1']").blur(function(){
			const mobile = $("input[name='mobile1']").val() + "-" + $("input[name='mobile2']").val() + "-" + $("input[name='mobile3']").val();
		
			$("input[name='mobile']").val(mobile);
			
			if($("input[name='mobile1']").val().trim().length < 3){
				b_mobile1_input = false;
			}
			
			if($("input[name='mobile1']").val().trim().length == 3){
				b_mobile1_input = true;
			}
		})
		$("input[name='mobile2']").blur(function(){
			const mobile = $("input[name='mobile1']").val() + "-" + $("input[name='mobile2']").val() + "-" + $("input[name='mobile3']").val();
		
			$("input[name='mobile']").val(mobile);
			
			if($("input[name='mobile2']").val().trim().length < 4){
				b_mobile2_input = false;
			}
			
			if($("input[name='mobile2']").val().trim().length == 4){
				b_mobile2_input = true;
			}
		});
		$("input[name='mobile3']").blur(function(){
			const mobile = $("input[name='mobile1']").val() + "-" + $("input[name='mobile2']").val() + "-" + $("input[name='mobile3']").val();
		
			$("input[name='mobile']").val(mobile);
			
			if($("input[name='mobile3']").val().trim().length < 4){
				b_mobile3_input = false;
			}
			
			if($("input[name='mobile3']").val().trim().length == 4){
				b_mobile3_input = true;
			}
		});
		
		
		
		// display:none인 point에 포인트 넣기 / "포인트 선할인" 변동
		$("input[name='point']").val(Number($("input.myPoint").val()));
		$("input[name='inp_myPoint']").change(function(){
			if($(this).is(":checked")){
				$("input[name='point']").val("");
				$("span#change_span").text("할인");
				
				$("input[name='to_insert_point']").val(Number($("input.myPoint").val()));
				
				$("input[name='total__price']").val($("input[name='total__price']").val() - $("input.myPoint").val());
				$("input[name='sum_price']").val($("input[name='sum_price']").val() - $("input.myPoint").val());
				
				var go_sum_priceEnd = Number($("input[name='total__price']").val());
				$("span.sum_priceEnd").text(go_sum_priceEnd.toLocaleString("en"));
			}
			else{
				$("input[name='point']").val(Number($("input.myPoint").val()));
				$("span#change_span").text("적립");
				$("input[name='total__price']").val(Number($("input[name='total__price']").val()) + Number($("input.myPoint").val()));
				$("input[name='sum_price']").val(Number($("input[name='sum_price']").val()) + Number($("input.myPoint").val()));
				
				$("input[name='to_insert_point']").val("");
				
				var go_sum_priceEnd = Number($("input[name='total__price']").val());
				$("span.sum_priceEnd").text(go_sum_priceEnd.toLocaleString("en"));
			}
		});
		
		
		// 포인트 사용 관리
		$("span.point_hover").mouseover(function(){
			$(this).css({'text-decoration':'underline','color':'#ff9900'});
		});
		$("span.point_hover").mouseout(function(){
			$(this).css({'text-decoration':'','color':'black'});
		});
		
		
		
		
		$("span.point_hover").click(function(){
			$("input.point_input").val($(this).text());
			$("input.point_input").focus();
			const sum_price = Number($("input[name='sum_price']").val());
			const numberStr = $("input.point_input").val();
			const minus_number = Number(numberStr.replace(/,/g, ""));
			$("input[name='total__price']").val(sum_price - minus_number);
			
			var go_sum_priceEnd = sum_price-minus_number;
			$("span.sum_priceEnd").text(go_sum_priceEnd.toLocaleString("en"));
			
			$("input[name='used_point']").val(minus_number);
		});

		
		// 보유포인트 사용시 total_price 변동
		$("input.point_input").keyup(function(){
			//var total = $("input[name='total__price']").val();
			var total = Number($("input[name='sum_price']").val());
			var numberStr = $("input.point_input").val();
			var minus_number = Number(numberStr.replace(/,/g, ""));
			
			$("input[name='total__price']").val(total-minus_number);
			
			var go_sum_priceEnd = total-minus_number;
			$("span.sum_priceEnd").text(go_sum_priceEnd.toLocaleString("en"));
			
			$("input[name='used_point']").val(minus_number);
		});
		
		
		
		
		
		// total_price에 값 넣기
		$("input[name='total__price']").val(Number($("input.total_priceEnd").val()));
		$("input[name='sum_price']").val(Number($("input.total_priceEnd").val()));
		
		var go_sum_priceEnd = Number($("input.total_priceEnd").val());
		$("span.sum_priceEnd").text(go_sum_priceEnd.toLocaleString("en"));
		
		//====================form에 값을 넣기===========================끝
		
		
		
		
		
	}); // end of $(document).ready(function(){------------------
		
		
		
	// 영어만 입력 가능한 input
	function handleOnInput(e)  {
	  e.value = e.value.replace(/[^A-Za-z]/ig, '');
	}	
	
	
	// 모두선택 모두해제 모드
	function selectAll(agreeAll)  {
	  const checkboxes = document.querySelectorAll("input[name='agreement']");
	  
	  checkboxes.forEach((checkbox) => {
	  	checkbox.checked = agreeAll.checked;
	  });
	  if(agreeAll.checked){
		  b_agreement_click = true;
	  }
	  else{
		  b_agreement_click = false;
	  }
	}
	
	
	
	// 필수입력사항을 모두 입력했는지 확인하는 메소드
	function is_all_check(){
		 //&&  && b_mobile2_input && b_mobile3_input && b_myEmail_input   b_agreement_click
		if(!b_myName_input){
			$("div.myName_result").show();
			$("input[name='myName']").focus();
			return 0;
		}
		
		 if(!b_mobile1_input){
			$("div.mobile_result").show();
			$("input[name='mobile1']").focus();
			return 0;
		 }
		 
		 if(!b_mobile2_input){
			$("div.mobile_result").show();
			$("input[name='mobile2']").focus();
			return 0;
		 }
		 
		 if(!b_mobile3_input){
			$("div.mobile_result").show();
			$("input[name='mobile3']").focus();
			return 0;
		 }
		 
		 if(!b_myEmail_input){
			$("div.checkEmail").show();
			$("input[name='myEmail']").focus();
			return 0;
		 }
		 
		 if(!b_agreement_click){
			alert("동의사항을 모두 체크해 주세요.");
			return 0;
		 }
		 
		 if(b_myName_input && b_mobile1_input && b_mobile2_input && b_mobile3_input && b_myEmail_input && b_agreement_click){
		 	return 1;
		 }
		
		
	}
	
	
	
	
	// 결제하기	
	function goPayment(ctx_Path){
		
		var n = is_all_check();
		
		if(n==0){
			return;
		}
		
		const price = $("input[name='price']").val();
		const userid = $("input[name='userid']").val();
		
		const url =`\${ctx_Path}/payment/paymentEnd.exp?price=\${price}&userid=\${userid}`;   
 		var title  = "paymentPopup";
 		
 		const width = 800;
	   	const height = 680;
 		const left = Math.ceil((window.screen.width - width)/2);
	   	const top = Math.ceil((window.screen.height - height)/2);
	   	
	  	var status = `toolbar=no,scrollbars=no,resizable=yes,status=no,menubar=no,width=800, height=680, top=\${top},left=\${left}`; 
	  	window.open("", title,status); 		//window.open(url,title,status); window.open 함수에 url을 앞에와 같이
		                                       //인수로  넣어도 동작에는 지장이 없으나 form.action에서 적용하므로 생략
	  	const frm = document.frm_payment_exp;                //가능합니다.
  		frm.target = title;                    		//form.target 이 부분이 빠지면 form값 전송이 되지 않습니다. 
  		frm.action = url;                    		//form.action 이 부분이 빠지면 action값을 찾지 못해서 제대로 된 팝업이 뜨질 않습니다.
  		frm.method = "post";
  		frm.submit();  
	}
	
	
	
	// 결제 성공하면 각각의 method로 보내주기
	function successPayment(){
		
		// DB tbl_reservation에 예약내역 isnert 하기 
		goReservation_DB_Update();
		
		// 결제 완료페이지로 이동
		gopaymentConfirm();
		
	} // end of successPayment()-----------------
	
	
	
	
	// DB tbl_reservation에 예약내역 isnert 하기
	// tbl_point에 insert 하기
	function goReservation_DB_Update(){
		
		const queryString = $("form[name='frm_payment_exp']").serialize();
	       
			$("form[name='frm_payment_exp']").ajaxForm({
	    		url:"<%= ctxPath%>/payment/reservation.exp",
				data:queryString,
				type:"get",
			 	async:true,			 
			 	dataType:"json",
			 	enctype:"multipart/form-data",
				success:function(json){
					alert(JSON.stringify(json)); 
				 
			 	},
			 
			 	error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			 	}
			});

	       $("form[name='frm_payment_exp']").submit();
	       
	} // end of goReservation_DB_Update()
	

	// 결제 완료페이지로 이동
	function gopaymentConfirm(){
		
		const frm = document.frm_goPaymentConfirm_exp;
		frm.method = "GET";
		frm.action = "<%= ctxPath%>/payment/paymentConfirm.exp";
		frm.submit();
		
	} // end of function gopaymentConfirm()
	
	
</script>



<c:if test="${empty requestScope.myUserInfo || empty requestScope.roomInfoList || empty requestScope.lodgeInfo || empty requestScope.cancelDateInfo}">
	<div class="right_section" style="background-color:#f3f3f5; height: 2100px;  width:100%;">
		<div style="display:flex;">
			<div style="margin: 10px auto;width:76.1%;background-color:#ffffff; height:72px; display:flex;">
				<div style="margin:15px 17px;">
					예약관련 데이터가 존재하지 않습니다.
				</div>
				
			</div>
		</div>
	</div>
</c:if>


<c:if test="${not empty requestScope.myUserInfo}">	
<c:forEach var="myUser" items="${requestScope.myUserInfo}">

<c:if test="${not empty requestScope.roomInfoList}">	
<c:forEach var="roomInfo" items="${requestScope.roomInfoList}">

<c:if test="${not empty requestScope.lodgeInfo}">	
<c:forEach var="lodgeInfo" items="${requestScope.lodgeInfo}">

<c:forEach var="cancelInfo" items="${requestScope.cancelDateInfo}">

	<fmt:parseDate value="${requestScope.paraMap.startDate}" pattern="yyyy-MM-dd" var="startDate" /> 
	<fmt:parseDate value="${requestScope.paraMap.endDate}" pattern="yyyy-MM-dd" var='endDate' />
	
	<fmt:formatDate value="${startDate}" pattern="yyyy-MM-dd(E)" var="startDate_D" />
	<fmt:formatDate value="${endDate}" pattern="yyyy-MM-dd(E)" var="endDate_D" />
	
	<div class="right_section" style="background-color:#f3f3f5; height: 2000px;  width:100%;">
		<h4 style="font-weight:bold;padding: 13px 0 0 190px;">확인하고 예약하기</h4>
		
		<div style="display:flex;">
			<div style="margin: 10px auto;width:76.1%;background-color:#ffffff; height:72px; display:flex;">

					<fmt:parseDate value="${cancelInfo.currentTime}" pattern="yyyy-MM-dd HH:mm:ss" var="cancelCurrentTime" /> 
					<fmt:parseDate value="${cancelInfo.B_1}" var='cancelB_1' pattern="yyyy-MM-dd HH:mm:ss" scope="page"/>
					<fmt:parseDate value="${cancelInfo.B_24}" var='cancelB_24' pattern="yyyy-MM-dd HH:mm:ss" scope="page"/>
					<fmt:parseDate value="${cancelInfo.B_48}" var='cancelB_48' pattern="yyyy-MM-dd HH:mm:ss" scope="page"/>
					<fmt:parseDate value="${cancelInfo.B_72}" var='cancelB_72' pattern="yyyy-MM-dd HH:mm:ss" scope="page"/>
					
					<fmt:formatDate value="${cancelCurrentTime}" pattern="yyyy-MM-dd HH:mm:ss" var="currentTime" />
					<fmt:formatDate value="${cancelB_1}" pattern="yyyy-MM-dd HH:mm:ss" var="B_1" />
					<fmt:formatDate value="${cancelB_24}" pattern="yyyy-MM-dd HH:mm:ss" var="B_24" />
					<fmt:formatDate value="${cancelB_48}" pattern="yyyy-MM-dd HH:mm:ss" var="B_48" />
					<fmt:formatDate value="${cancelB_72}" pattern="yyyy-MM-dd HH:mm:ss" var="B_72" />
					
					<fmt:formatDate value="${cancelCurrentTime}" pattern="yyyy-MM-dd HH:mm:ss" var="currentTime_D" /> 
					<fmt:formatDate value="${cancelCurrentTime}" pattern="yyyy-MM-dd(E)" var="CurrentTime_D" /> 
					<fmt:formatDate value="${cancelB_1}" pattern="yyyy-MM-dd HH:mm:ss" var="B_1_D" />
					<fmt:formatDate value="${cancelB_24}" pattern="yyyy-MM-dd HH:mm:ss" var="B_24_D" />
					<fmt:formatDate value="${cancelB_48}" pattern="yyyy-MM-dd HH:mm:ss" var="B_48_D" />
					<fmt:formatDate value="${cancelB_72}" pattern="yyyy-MM-dd(E)" var="B_72_D" />
					
<%-- 취소정책 0 일때 --%>
					<c:if test="${lodgeInfo.fk_cancel_opt == '0'}">
						<!--
						< : lt
						> : gt
						<= : le
						>= : ge
						-->						
						<c:choose>
							<c:when test="${currentTime lt B_72}">
								<div style="margin:15px 17px;">
									<image src="<%=ctxPath%>/resources/images/ws/payment/paymentIcon.png" style="width:46px;"></image>
								</div>
								<span style="font-size:10pt; display:inline-block; margin:15px 0;">
									<span style="font-weight:bold;">${B_72.substring(5,7)}월 ${B_72.substring(8,10)}일
									 (${B_72_D.substring(11,12)}) ${B_72.substring(11,16)}(숙박 시설 현지 시간) 전 전액 환불 가능 </span>
									<br>여행 계획 변경 시 이 예약을 변경하거나 취소하고 전액 환불받으실 수 있어요. 계획 변경도 안심하세요.
								</span>
							</c:when> 
							<c:when test="${currentTime lt B_48}">
								<div style="margin:15px 17px;">
									<image src="<%=ctxPath%>/resources/images/ws/payment/paymentIcon.png" style="width:46px;"></image>
								</div>
								<span style="font-size:10pt; display:inline-block; margin:15px 0;">
									<span style="font-weight:bold;">${B_48.substring(5,7)}월 ${B_48.substring(8,10)}일
									(${B_48_D.substring(11,12)}) ${B_48.substring(11,16)}(숙박 시설 현지 시간) 전 75% 환불 가능</span>
									<br>예약을 변경하거나 취소하실 경우 75% 환불받으실 수 있어요. 계획 변경에 유의하세요.
								</span>
							</c:when>
							<c:when test="${currentTime lt B_24}">
								<div style="margin:15px 17px;">
									<image src="<%=ctxPath%>/resources/images/ws/payment/paymentIcon.png" style="width:46px;"></image>
								</div>
								<span style="font-size:10pt; display:inline-block; margin:15px 0;">
									<span style="font-weight:bold;">${B_24.substring(5,7)}월 ${B_24.substring(8,10)}일
									(${B_24_D.substring(11,12)}) ${B_24.substring(11,16)}(숙박 시설 현지 시간) 전 50% 환불 가능</span>
									<br>예약을 변경하거나 취소하실 경우 50% 환불받으실 수 있어요. 계획 변경에 유의하세요.
								</span>
							</c:when>
							<c:otherwise>
								<div style="margin:15px 17px;">
									<image src="<%=ctxPath%>/resources/images/ws/payment/notice.png" style="width:50px;"></image>
								</div>
								<span style="color:red; font-size:10pt; display:inline-block; margin:15px 0;">
									<span style="font-weight:bold;">이 요금은 환불되지 않습니다.</span>
									<br>예약을 변경하거나 취소하실 경우 환불 또는 향후 숙박에 사용할 수 있는 크레딧이 제공되지 않습니다. 이 정책은 코로나19에 관계 없이 적용됩니다.
								</span>
							</c:otherwise>
							
						</c:choose>
					</c:if> 
					
<%-- 취소정책 1 일때 --%>
					<c:if test="${lodgeInfo.fk_cancel_opt == '1'}">
					
						<c:choose>
							<c:when test="${currentTime lt B_48}">
								<div style="margin:15px 17px;">
									<image src="<%=ctxPath%>/resources/images/ws/payment/paymentIcon.png" style="width:46px;"></image>
								</div>
								<span style="font-size:10pt; display:inline-block; margin:15px 0;">
									<span style="font-weight:bold;">${B_48.substring(5,7)}월 ${B_48.substring(8,10)}일
									(${B_48_D.substring(11,12)}) ${B_48.substring(11,16)}(숙박 시설 현지 시간) 전 100% 환불 가능</span>
									<br>여행 계획 변경 시 이 예약을 변경하거나 취소하고 전액 환불받으실 수 있어요. 계획 변경도 안심하세요.
								</span>
							</c:when>
							<c:when test="${currentTime lt B_24}">
								<div style="margin:15px 17px;">
									<image src="<%=ctxPath%>/resources/images/ws/payment/paymentIcon.png" style="width:46px;"></image>
								</div>
								<span style="font-size:10pt; display:inline-block; margin:15px 0;">
									<span style="font-weight:bold;">${B_24.substring(5,7)}월 ${B_24.substring(8,10)}일
									(${B_24_D.substring(11,12)}) ${B_24.substring(11,16)}(숙박 시설 현지 시간) 전 75% 환불 가능</span>
									<br>예약을 변경하거나 취소하실 경우 75% 환불받으실 수 있어요. 계획 변경에 유의하세요.
								</span>
							</c:when>
							<c:otherwise>
								<div style="margin:15px 17px;">
									<image src="<%=ctxPath%>/resources/images/ws/payment/notice.png" style="width:50px;"></image>
								</div>
								<span style="color:red; font-size:10pt; display:inline-block; margin:15px 0;">
									<span style="font-weight:bold;">이 요금은 환불되지 않습니다.</span>
									<br>예약을 변경하거나 취소하실 경우 환불 또는 향후 숙박에 사용할 수 있는 크레딧이 제공되지 않습니다. 이 정책은 코로나19에 관계 없이 적용됩니다.
								</span>
							</c:otherwise>
							
						</c:choose>
					</c:if>
					
<%-- 취소정책 2 일때 --%>
					<c:if test="${lodgeInfo.fk_cancel_opt == '2'}">
				
						<c:choose>
							
							<c:when test="${currentTime lt B_24}">
								<div style="margin:15px 17px;">
									<image src="<%=ctxPath%>/resources/images/ws/payment/paymentIcon.png" style="width:46px;"></image>
								</div>
								<span style="font-size:10pt; display:inline-block; margin:15px 0;">
									<span style="font-weight:bold;">${B_24.substring(5,7)}월 ${B_24.substring(8,10)}일
									(${B_24_D.substring(11,12)}) ${B_24.substring(11,16)}(숙박 시설 현지 시간) 전 100% 환불 가능</span>
									<br>여행 계획 변경 시 이 예약을 변경하거나 취소하고 전액 환불받으실 수 있어요. 계획 변경도 안심하세요.
								</span>
							</c:when>
							<c:otherwise>
								<div style="margin:15px 17px;">
									<image src="<%=ctxPath%>/resources/images/ws/payment/notice.png" style="width:50px;"></image>
								</div>
								<span style="color:red; font-size:10pt; display:inline-block; margin:15px 0;">
									<span style="font-weight:bold;">이 요금은 환불되지 않습니다.</span>
									<br>예약을 변경하거나 취소하실 경우 환불 또는 향후 숙박에 사용할 수 있는 크레딧이 제공되지 않습니다. 이 정책은 코로나19에 관계 없이 적용됩니다.
								</span>
							</c:otherwise>
							
						</c:choose>
					</c:if>
					
<%-- 취소정책 3 일때 --%>
					<c:if test="${lodgeInfo.fk_cancel_opt == '3'}">				
						<c:choose>
							
							<c:when test="${currentTime lt B_1}">
								<div style="margin:15px 17px;">
									<image src="<%=ctxPath%>/resources/images/ws/payment/paymentIcon.png" style="width:46px;"></image>
								</div>
								<span style="font-size:10pt; display:inline-block; margin:15px 0;">
									<span style="font-weight:bold;">${B_1.substring(5,7)}월 ${B_1.substring(8,10)}일
									(${B_1_D.substring(11,12)}) ${B_1.substring(11,16)}(숙박 시설 현지 시간) 전 100% 환불 가능</span>
									<br>여행 계획 변경 시 이 예약을 변경하거나 취소하고 전액 환불받으실 수 있어요. 계획 변경도 안심하세요.
								</span>
							</c:when>
							<c:otherwise>
								<div style="margin:15px 17px;">
									<image src="<%=ctxPath%>/resources/images/ws/payment/notice.png" style="width:50px;"></image>
								</div>
								<span style="color:red; font-size:10pt; display:inline-block; margin:15px 0;">
									<span style="font-weight:bold;">이 요금은 환불되지 않습니다.</span>
									<br>예약을 변경하거나 취소하실 경우 환불 또는 향후 숙박에 사용할 수 있는 크레딧이 제공되지 않습니다. 이 정책은 코로나19에 관계 없이 적용됩니다.
								</span>
							</c:otherwise>
							
						</c:choose>
					</c:if>
					
				
				
				
			</div>
		</div>
		
		<div>
			<%-- left side--%>
		<div style="width:76.1%; margin:auto; display:flex;" >
				<div style="width:65.5%; height: 90px; background-color:#ffffff;">
					<div style="display:flex;">
	
						<div style="display:inline; padding:7px 14px 5px 17px;">
							<svg xmlns="http://www.w3.org/2000/svg" height="40" width="25" viewBox="0 0 640 512"><path fill="#000000" d="M224 256A128 128 0 1 0 224 0a128 128 0 1 0 0 256zm-45.7 48C79.8 304 0 383.8 0 482.3C0 498.7 13.3 512 29.7 512H392.6c-5.4-9.4-8.6-20.3-8.6-32V352c0-2.1 .1-4.2 .3-6.3c-31-26-71-41.7-114.6-41.7H178.3zM528 240c17.7 0 32 14.3 32 32v48H496V272c0-17.7 14.3-32 32-32zm-80 32v48c-17.7 0-32 14.3-32 32V480c0 17.7 14.3 32 32 32H608c17.7 0 32-14.3 32-32V352c0-17.7-14.3-32-32-32V272c0-44.2-35.8-80-80-80s-80 35.8-80 80z"/></svg>
						</div>
						<div style="display:inline; padding-top:7px;">
							<div><span style="font-size:10pt;">현재 로그인ID:</span></div>
							<div><span style="font-size:12pt;">${sessionScope.loginuser.userid}</span></div>

							<div>
								<span style="font-size:10pt; color:green;">익스피디아 리워드 <span style="text-decoration: underline;">
								<c:if test="${myUser.user_lvl == '블루'}">
									<fmt:formatNumber pattern="#,###">${roomInfo.rm_price * 0.01}</fmt:formatNumber>
								</c:if>
								
								<c:if test="${myUser.user_lvl == '실버'}">
									<fmt:formatNumber pattern="#,###">${roomInfo.rm_price * 0.02}</fmt:formatNumber>
								</c:if>
								
								<c:if test="${myUser.user_lvl == '골드'}">
									<fmt:formatNumber pattern="#,###">${roomInfo.rm_price * 0.03}</fmt:formatNumber>
								</c:if>
								</span> 포인트가 적립됩니다.</span>
							</div>
						</div>
					</div>
					
					<div style="height: 400px; background-color:#ffffff; margin-top:3%;">
						<div style="padding:17px;">
							<h5 style="font-weight:bold; margin-bottom:2%;">체크인 고객 정보</h5>
							
							<div>
								<span style="font-weight:bold;">객실정보 : </span>
								
								<span>성인 ${roomInfo.rm_guest_cnt}명, </span>
								
								<c:if test="${not empty roomInfo.rm_single_bed}">
									<span>싱글사이즈침대 ${roomInfo.rm_single_bed}개, </span>
								</c:if>
								<c:if test="${not empty roomInfo.rm_ss_bed}">
									<span>슈퍼싱글사이즈침대 ${roomInfo.rm_ss_bed}개, </span>
								</c:if>
								<c:if test="${not empty roomInfo.rm_double_bed}">
									<span>더블사이즈침대 ${roomInfo.rm_double_bed}개, </span>
								</c:if>
								<c:if test="${not empty roomInfo.rm_queen_bed}">
									<span>퀸사이즈침대 ${roomInfo.rm_queen_bed}개, </span>
								</c:if>
								<c:if test="${not empty roomInfo.rm_king_bed}">
									<span>킹사이즈침대 ${roomInfo.rm_king_bed}개, </span>
								</c:if>
								
								<c:if test="${roomInfo.rm_smoke_yn == 0}">
									<span>금연</span>
								</c:if>
								
								<c:if test="${roomInfo.rm_smoke_yn == 1}">
									<span>흡연가능</span>
								</c:if>
								
							</div>
							
							<c:if test="${lodgeInfo.lg_park_yn == 1}" >
								<svg xmlns="http://www.w3.org/2000/svg" height="16" width="14" viewBox="0 0 448 512"><path fill="#2f7000" d="M438.6 105.4c12.5 12.5 12.5 32.8 0 45.3l-256 256c-12.5 12.5-32.8 12.5-45.3 0l-128-128c-12.5-12.5-12.5-32.8 0-45.3s32.8-12.5 45.3 0L160 338.7 393.4 105.4c12.5-12.5 32.8-12.5 45.3 0z"/></svg>
								<span style="font-size:10pt;color:#2f7000;">무료 주차</span>
							</c:if>
							<c:if test="${lodgeInfo.lg_internet_yn == 1}" >
								<svg xmlns="http://www.w3.org/2000/svg" height="16" width="14" viewBox="0 0 448 512"><path fill="#2f7000" d="M438.6 105.4c12.5 12.5 12.5 32.8 0 45.3l-256 256c-12.5 12.5-32.8 12.5-45.3 0l-128-128c-12.5-12.5-12.5-32.8 0-45.3s32.8-12.5 45.3 0L160 338.7 393.4 105.4c12.5-12.5 32.8-12.5 45.3 0z"/></svg>
								<span style="font-size:10pt;color:#2f7000;">무료 WiFi</span>
							</c:if>
							
							
							<div style="font-size:10pt; margin:2% 0 1% 0;" class="sel_name cursor_target"><span class="check_span">여행객 이름</span> <span class="notice_check" style="color:#d60000;"> *</span></div>	
							<select name="customerName" class="common_box_size">
								<optgroup style="background-color:#f5f5f5;color:black;" label="새 여행객">
									<option value="newName">새 여행객 추가</option>
								</optgroup>
								<optgroup style="background-color:#f5f5f5;color:black;" label="내 계정에서 선택">
									<option value="name">${myUser.name}</option>
								</optgroup>
							</select>
							<div style="font-size:10pt; margin:2% 0 1% 0;" class="cursor_target inp_name"><span class="check_span">이름입력</span><span class="notice_check" style="color:#d60000;"> *</span></div>	
							<input type="text" name="myName" placeholder="(예: 홍길동)" class="name_inp shading_input common_box_size" style="padding:10px;" autofocus="autofocus"/>
							<div style="color:#d60000; font-size:10pt;" class="myName_result checkdiv">이름을 입력해주세요.</div>
							
							<div style="font-size:10pt; margin:2% 0 1% 0;" class="cursor_target sel_mobile"><span class="check_span">휴대폰 번호</span><span class="notice_check" style="color:#d60000;"> *</span></div>	
							<input type="text" name="mobile1" class="mobile1_inp shading_input common_box_size" style="padding:10px; width:14%;" maxlength="3"/>
							<input type="text" name="mobile2" class="mobile2_inp shading_input common_box_size" style="padding:10px; width:14%;" maxlength="4"/>
							<input type="text" name="mobile3" class="mobile3_inp shading_input common_box_size" style="padding:10px; width:14%;" maxlength="4"/>
							<div style="color:#d60000; font-size:10pt;" class="mobile_result checkdiv">유효한 전화번호를 입력해주세요.</div>
						</div>
					</div>
					
					
					<div style=" background-color:#ffffff; margin-top:2.5%;">
						<div style="padding:17px;">
							<h5 style="font-weight:bold; margin-bottom:2%;">내 예약 관리</h5>
							
							<h6 style="font-weight:bold;">확인 이메일</h6>
							<div><span class="text-gray" style="font-size:10pt;">예약하신 일정의 확인 메일을 받을 이메일 주소를 입력해 주세요.</span></div>
							<div style="font-size:10pt; margin:2% 0 1% 0;" class="inp_email cursor_target"><span class="check_span">이메일 주소</span><span class="notice_check" style="color:#d60000;"> *</span></div>
							<input type="text" name="myEmail" class="email_inp shading_input common_box_size" style="padding:10px;" maxlength="60" size="49"/>
							<div style="color:#d60000; font-size:10pt;" class="checkEmail checkdiv">이메일 주소 형식이 아닙니다.</div>
							
							
						</div>	
					</div>
					
					
					
					<div style=" background-color:#ffffff; margin-top:2.5%;">
						<div style="padding:17px;">
							<h5 style="font-weight:bold; margin-bottom:2%;">취소정책</h5>
							
							
							<c:if test="${lodgeInfo.fk_cancel_opt == '0'}">
								<c:choose>
									<c:when test="${currentTime lt B_72}">
										<ul style="padding:0 23px 0 23px;">
											<li class="text-gray" style="color:#2f7000; font-size:9.5pt;">${B_72.substring(5,7)}월 ${B_72.substring(8,10)}일(${B_72_D.substring(11,12)})전 <span style="font-weight:bold;">전액 환불 가능</span></li>
											<li class="text-gray" style="font-size:9.5pt;">${B_72.substring(0,4)}년 ${B_72.substring(5,7)}월 ${B_72.substring(8,10)}일  ${B_72.substring(11,16)}(숙박 시설 현지 시간) 후에 취소 또는 변경하거나 노쇼의 경우 예약에 대해 결제하신 총 금액의 100%에 해당하는 숙박 시설 수수료가 부과됩니다.</li>
										</ul>
									</c:when> 
									<c:when test="${currentTime lt B_48}">
										<ul style="padding:0 23px 0 23px;">
											<li class="text-gray" style="color:#2f7000; font-size:9.5pt;">${B_48.substring(5,7)}월 ${B_48.substring(8,10)}일(${B_48_D.substring(11,12)})전 <span style="font-weight:bold;">75% 환불 가능</span></li>
											<li class="text-gray" style="font-size:9.5pt;">${B_48.substring(0,4)}년 ${B_48.substring(5,7)}월 ${B_48.substring(8,10)}일  ${B_48.substring(11,16)}(숙박 시설 현지 시간) 후에 취소 또는 변경하거나 노쇼의 경우 예약에 대해 결제하신 총 금액의 100%에 해당하는 숙박 시설 수수료가 부과됩니다.</li>
										</ul>
									</c:when>
									<c:when test="${currentTime lt B_24}">
										<ul style="padding:0 23px 0 23px;">
											<li class="text-gray" style="color:#2f7000; font-size:9.5pt;">${B_24.substring(5,7)}월 ${B_24.substring(8,10)}일(${B_24.substring(11,12)})전 <span style="font-weight:bold;">50% 환불 가능</span></li>
											<li class="text-gray" style="font-size:9.5pt;">${B_24.substring(0,4)}년 ${B_24.substring(5,7)}월 ${B_24.substring(8,10)}일  ${B_24.substring(11,16)}(숙박 시설 현지 시간) 후에 취소 또는 변경하거나 노쇼의 경우 예약에 대해 결제하신 총 금액의 100%에 해당하는 숙박 시설 수수료가 부과됩니다.</li>
										</ul>
									</c:when>
									<c:otherwise>
										<ul style="padding:0 23px 0 23px;">
											<li style="color:red; font-size:9.5pt;"><span style="font-weight:bold;">이 요금은 환불되지 않습니다.</span></li>
											<li style="color:red; font-size:9.5pt;">지금 예약을 진행할 경우 환불가능 시점을 지난 시점이므로, 이 경우 예약에 대해 결제하신 총 금액의 100%에 해당하는 숙박 시설 수수료가 부과됩니다.</li>
											<li class="text-gray" style=" font-size:9.5pt;">정해진 시간보다 늦게 체크인하거나 일찍 체크아웃하실 경우 환불되지 않습니다.</li>
											<li class="text-gray" style=" font-size:9.5pt;">숙박을 연장하려면 새로 예약하셔야 합니다.</li>
										</ul>
									</c:otherwise>
									
								</c:choose>
								
							</c:if>
							
							<c:if test="${lodgeInfo.fk_cancel_opt == '1'}">
								<c:choose>
									
									<c:when test="${currentTime lt B_48}">
										<ul style="padding:0 23px 0 23px;">
											<li class="text-gray" style="color:#2f7000; font-size:9.5pt;">${B_48.substring(5,7)}월 ${B_48.substring(8,10)}일(${B_48_D.substring(11,12)})전 <span style="font-weight:bold;">100% 환불 가능</span></li>
											<li class="text-gray" style="font-size:9.5pt;">${B_48.substring(0,4)}년 ${B_48.substring(5,7)}월 ${B_48.substring(8,10)}일  ${B_48.substring(11,16)}(숙박 시설 현지 시간) 후에 취소 또는 변경하거나 노쇼의 경우 예약에 대해 결제하신 총 금액의 100%에 해당하는 숙박 시설 수수료가 부과됩니다.</li>
										</ul>
									</c:when>
									<c:when test="${currentTime lt B_24}">
										<ul style="padding:0 23px 0 23px;">
											<li class="text-gray" style="color:#2f7000; font-size:9.5pt;">${B_24.substring(5,7)}월 ${B_24.substring(8,10)}일(${B_24.substring(11,12)})전 <span style="font-weight:bold;">75% 환불 가능</span></li>
											<li class="text-gray" style="font-size:9.5pt;">${B_24.substring(0,4)}년 ${B_24.substring(5,7)}월 ${B_24.substring(8,10)}일  ${B_24.substring(11,16)}(숙박 시설 현지 시간) 후에 취소 또는 변경하거나 노쇼의 경우 예약에 대해 결제하신 총 금액의 100%에 해당하는 숙박 시설 수수료가 부과됩니다.</li>
										</ul>
									</c:when>
									<c:otherwise>
										<ul style="padding:0 23px 0 23px;">
											<li style="color:red; font-size:9.5pt;"><span style="font-weight:bold;">이 요금은 환불되지 않습니다.</span></li>
											<li style="color:red; font-size:9.5pt;">지금 예약을 진행할 경우 환불가능 시점을 지난 시점이므로, 이 경우 예약에 대해 결제하신 총 금액의 100%에 해당하는 숙박 시설 수수료가 부과됩니다.</li>
											<li class="text-gray" style=" font-size:9.5pt;">정해진 시간보다 늦게 체크인하거나 일찍 체크아웃하실 경우 환불되지 않습니다.</li>
											<li class="text-gray" style=" font-size:9.5pt;">숙박을 연장하려면 새로 예약하셔야 합니다.</li>
										</ul>
									</c:otherwise>
								</c:choose>
							</c:if>
							
							<c:if test="${lodgeInfo.fk_cancel_opt == '2'}">
								<c:choose>
									
									<c:when test="${currentTime lt B_24}">
										<ul style="padding:0 23px 0 23px;">
											<li class="text-gray" style="color:#2f7000; font-size:9.5pt;">${B_24.substring(5,7)}월 ${B_24.substring(8,10)}일(${B_24.substring(11,12)})전 <span style="font-weight:bold;">100% 환불 가능</span></li>
											<li class="text-gray" style="font-size:9.5pt;">${B_24.substring(0,4)}년 ${B_24.substring(5,7)}월 ${B_24.substring(8,10)}일  ${B_24.substring(11,16)}(숙박 시설 현지 시간) 후에 취소 또는 변경하거나 노쇼의 경우 예약에 대해 결제하신 총 금액의 100%에 해당하는 숙박 시설 수수료가 부과됩니다.</li>
										</ul>
									</c:when>
									<c:otherwise>
										<ul style="padding:0 23px 0 23px;">
											<li style="color:red; font-size:9.5pt;"><span style="font-weight:bold;">이 요금은 환불되지 않습니다.</span></li>
											<li style="color:red; font-size:9.5pt;">지금 예약을 진행할 경우 환불가능 시점을 지난 시점이므로, 이 경우 예약에 대해 결제하신 총 금액의 100%에 해당하는 숙박 시설 수수료가 부과됩니다.</li>
											<li class="text-gray" style=" font-size:9.5pt;">정해진 시간보다 늦게 체크인하거나 일찍 체크아웃하실 경우 환불되지 않습니다.</li>
											<li class="text-gray" style=" font-size:9.5pt;">숙박을 연장하려면 새로 예약하셔야 합니다.</li>
										</ul>
									</c:otherwise>
								</c:choose>
							</c:if>
							
							<c:if test="${lodgeInfo.fk_cancel_opt == '3'}">
								<c:choose>
									<c:when test="${currentTime lt B_1}">
										<ul style="padding:0 23px 0 23px;">
											<li class="text-gray" style="color:#2f7000; font-size:9.5pt;">${B_1.substring(5,7)}월 ${B_24.substring(8,10)}일(${B_1.substring(11,12)})전 <span style="font-weight:bold;">100% 환불 가능</span></li>
											<li class="text-gray" style="font-size:9.5pt;">${B_1.substring(0,4)}년 ${B_1.substring(5,7)}월 ${B_1.substring(8,10)}일  ${B_1.substring(11,16)}(숙박 시설 현지 시간) 후에 취소 또는 변경하거나 노쇼의 경우 예약에 대해 결제하신 총 금액의 100%에 해당하는 숙박 시설 수수료가 부과됩니다.</li>
										</ul>
									</c:when>
									<c:otherwise>
										<ul style="padding:0 23px 0 23px;">
											<li style="color:red; font-size:9.5pt;"><span style="font-weight:bold;">이 요금은 환불되지 않습니다.</span></li>
											<li style="color:red; font-size:9.5pt;">지금 예약을 진행할 경우 환불가능 시점을 지난 시점이므로, 이 경우 예약에 대해 결제하신 총 금액의 100%에 해당하는 숙박 시설 수수료가 부과됩니다.</li>
											<li class="text-gray" style=" font-size:9.5pt;">정해진 시간보다 늦게 체크인하거나 일찍 체크아웃하실 경우 환불되지 않습니다.</li>
											<li class="text-gray" style=" font-size:9.5pt;">숙박을 연장하려면 새로 예약하셔야 합니다.</li>
										</ul>
									</c:otherwise>
								</c:choose>
							</c:if>

						</div>	
					</div>
					
					
					<div style=" background-color:#ffffff; margin-top:2.5%;">
						<div style="padding:17px;">
							<h5 style="font-weight:bold; margin-bottom:2%;">중요정보</h5>
							<ul style="padding:0 23px 0 23px; margin:0;">
								<li class="text-gray" style="font-size:9.5pt;">도착 시 프런트 데스크 직원이 도와드립니다. 자세한 내용은 예약 확인 메일에 나와 있는 연락처 정보로 숙박 시설에 문의해 주시기 바랍니다. </li>
								<li class="text-gray" style="font-size:9.5pt;">숙박 시설에서는 최근 여행 내역(여권 이민국 도장 등) 서류를 제시하거나 건강 신고서를 작성해 줄 것을 고객께 요청할 수 있습니다.</li>
								<li class="text-gray" style="font-size:9.5pt;">이그제큐티브 라운지는 월요일 ~ 금요일 06:30 ~ 10:00(토요일, 일요일, 공휴일 06:30 ~ 10:30)에는 아침 식사, 15:30 ~ 17:00에는 애프터눈 티, 18:00 ~ 22:00에는 해피아워를 운영합니다. 간단한 스낵은 제공하지 않습니다.</li>
								<li class="text-gray" style="font-size:9.5pt;">이 숙박 시설의 실내 수영장은 매일 06:00 ~ 22:00에 운영됩니다.</li>
								<li class="text-gray" style="font-size:9.5pt;">익스피디아및 호텔에서는 세금 계산서를 발행하지 않습니다. 거래용 상업 영수증이 제공됩니다.</li>
							</ul>
							<br>
								
								<hr style="margin-bottom:17px; width:100%;">
								<div style="display:flex;">
									<div style="display:inline;">
										<div style="width:100%;">
											<span class="text-gray" style="font-weight:bold; font-size:9.5pt;">체크인:</span>
										</div>
										<div style="width:100%;">
											<span class="text-gray" style="font-size:9.5pt;">${requestScope.paraMap.inMonth}월 ${requestScope.paraMap.inDay}일(${startDate_D.substring(11,12)}) ${B_1.substring(11,16)}</span>
										</div>
									</div>
									
									<div style="display:inline; margin-left:20%;">
										<div style="width:100%;">
											<span class="text-gray" style="font-weight:bold; font-size:9.5pt;">체크아웃:</span>
										</div>
										<div style="width:100%;">
											<span class="text-gray" style="font-size:9.5pt;">${requestScope.paraMap.outMonth}월 ${requestScope.paraMap.outDay}일(${endDate_D.substring(11,12)}) ${cancelInfo.checkout_time} ( ${requestScope.paraMap.daysGap}박 )</span>
										</div>
									</div>
								</div>
								<hr style="margin:17px 0; width:100%;">
								
								<div id="checkbox_container">
									<input type="checkbox" id="checkAll" onclick="selectAll(this)" class="checkbox_wid_hei" /><label for="checkAll" style="position:relative; bottom:3px; left:5px; font-size:10pt;" class="cursor_target text-gray">아래에 모두 동의합니다.</label>
									<div style="padding-left:17px;">
									
										<div style="display:flex;width:680px;">
											<div>
												<input type="checkbox" name="agreement" id="agreement1" class="checkbox_wid_hei" />
											</div>
											<div style="position:relative; bottom:13px; left:5px;">	
												<label for="agreement1" style="font-size:10pt; margin:2% 0 1% 0;" class="cursor_target"><span class="text-gray">본인은 만 18세 이상이며 이용약관, 규정 및 제한 사항 및 여행에 대한 정부 권고 사항을 읽었고 이에 동의합니다(필수).</span><span class="notice_check" style="color:#d60000;"> *</span></label>
											</div>
										</div>
										
										<div style="display:flex;">
											<div>
												<input type="checkbox" name="agreement" id="agreement2" class="checkbox_wid_hei" />
											</div>	
											<div style="position:relative; bottom:9px; left:5px;">
												<label for="agreement2" style="font-size:10pt; margin:2% 0 1% 0;" class="cursor_target"><span class="text-gray">개인정보 보호정책에 설명된 대로 개인정보 수집 및 사용에 동의합니다(필수).</span><span class="notice_check" style="color:#d60000;"> *</span></label>	
											</div>
										</div>	
										
										
										<div style="display:flex;">
											<div>
												<input type="checkbox" name="agreement" id="agreement3" class="checkbox_wid_hei" />
											</div>
											<div style="position:relative; bottom:13px; left:5px;">
												<label for="agreement3" style="font-size:10pt; margin:2% 0 1% 0;" class="cursor_target"><span class="text-gray">개인정보 보호정책에 설명된 대로 국내 또는 해외에서 제3자(선택한 여행 공급업체 포함)에게 개인정보를 제공하는 데 동의합니다(필수).</span><span class="notice_check" style="color:#d60000;"> *</span></label>
											</div>
										</div>
										
										
									</div>
								</div>
								
								<button type="button" id="submit_payment" onclick="goPayment('<%= ctxPath%>')" style="border-radius: 0.5rem; height:48px;width:200px;border:0;background-color:#1668e3;">
									<span style="font-size:13pt; color:white; font-weight:bold;">동의 및 결제 완료</span><svg style="width:25px;padding-bottom:3.5px;" fill="white" aria-describedby="chevron_right-description" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><desc id="chevron_right-description">chevron</desc><path d="M10 6 8.59 7.41 13.17 12l-4.58 4.59L10 18l6-6-6-6z"></path></svg>
								</button>
							
							<div style="display:flex;">
								<svg xmlns="http://www.w3.org/2000/svg" height="48"; width="17" viewBox="0 0 448 512"><path fill="#616161" d="M144 144v48H304V144c0-44.2-35.8-80-80-80s-80 35.8-80 80zM80 192V144C80 64.5 144.5 0 224 0s144 64.5 144 144v48h16c35.3 0 64 28.7 64 64V448c0 35.3-28.7 64-64 64H64c-35.3 0-64-28.7-64-64V256c0-35.3 28.7-64 64-64H80z"/></svg>		
								<div style="display:inline; padding-left:14px;">
									<div class="text-gray" style="font-size:10pt;padding:15px 0 15px 0;">저희는 고객님의 개인 정보 보호를 위해 보안 전송 및 암호화된 저장 방식을 사용합니다.</div>
									<div class="text-gray" style="font-size:10pt;">결제는 한국에서 처리됩니다. 단, 여행 공급업체(항공사/호텔 등)가 한국 외 지역에서 결제를 처리할 때는 적용되지 않으며 이 경우 카드 발급사에서 해외 거래 수수료를 부과할 수 있습니다.</div>	
								</div>
							</div>
						</div>
					</div>
				</div>
			
			
	
				
				
				
<%-- right side--%>
			<div style="width:33.5%; margin-left:1%">
				<div style=" background-color:#ffffff; height:412px; padding-bottom:17px;" >
					<div style="position:relative;">
						<div>
							<image src="<%=ctxPath%>/resources/images/ws/payment/ImageTest.png" style="width:100%; height:160px;  filter: brightness(70%)"></image>
						</div>
						<div style="position:absolute;left:2.2%;bottom:6%;">
							<span style="color:white; font-size:12pt; font-weight:bold;">${lodgeInfo.lg_name}</span>
						</div>
					</div>
					
					<div ></div>
					
					
					<div class="container" style="padding:0 17px;">
						<div style="display:flex;padding-top:15px;">
						
							<div style="width:35px; height:27px; background-color: #2e6d00; border-radius: 0.25rem; display:flex;">
								<div style="color:white;margin:auto;font-weight:bold;">9.4</div>
							</div>
							<div style="position:relative; bottom:10px;left:10px;">
								<span style="font-weight:bold;">훌륭해요!</span><br>
								<span style="font-size:13px;position:relative; bottom:4px;">(이용 후기 1,002개)</span>
							</div>
						
						</div>
						
						<span class="text-gray" style="font-size:10pt"><span class="check_span">객실 1개: </span> ${roomInfo.rm_type}</span>
						<br><br>
						<div style="display:flex;">
							<div>
								<span class="text-gray" style="font-size:10pt"><span class="check_span">체크인: </span> ${requestScope.paraMap.inMonth}월 ${requestScope.paraMap.inDay}일(${startDate_D.substring(11,12)})</span><br>
								<span class="text-gray" style="font-size:10pt"><span class="check_span">체크아웃: </span> ${requestScope.paraMap.outMonth}월 ${requestScope.paraMap.outDay}일(${endDate_D.substring(11,12)})</span>
							</div>
							<span class="text-gray" style="padding:10px 0 0 60px; font-size:10pt"><span class="check_span">총: </span> ${requestScope.paraMap.daysGap}박</span>
						</div>
		
						<hr>
						
						<div style="display:flex;">
							<div style="width:40px; margin-right:20px;">
								<div style="background-color:#191e3b; border-radius:100rem; width:35px;height:35px; color:white; font-weight:bold; display:flex;">
									<div style="margin:auto;">VIP</div>
								</div>
							</div>	
							<div class="text-gray" style="font-size:10pt;">이 VIP Access 숙박 시설은 높은 평점을 받았으며 뛰어난 서비스를 기대하실 수 있어요.</div>
						</div>
					</div>
				</div>
				
	
				<div style=" background-color:#ffffff; margin-top:2.5%; padding:16px; height:81px;">
					<svg xmlns="http://www.w3.org/2000/svg" height="16" width="14" viewBox="0 0 448 512"><path fill="#2f7000" d="M438.6 105.4c12.5 12.5 12.5 32.8 0 45.3l-256 256c-12.5 12.5-32.8 12.5-45.3 0l-128-128c-12.5-12.5-12.5-32.8 0-45.3s32.8-12.5 45.3 0L160 338.7 393.4 105.4c12.5-12.5 32.8-12.5 45.3 0z"/></svg>
					<span style="font-size:10pt;color:#2f7000;"> 잘 선택하셨어요! 다른 사람이 예약하기 전에 지금 바로 예약하세요.</span>
				</div>
				
				
				<div style=" background-color:#ffffff; margin-top:5%;">
					<h5 style="font-weight:bold; padding:17px 17px 0 17px;">요금 세부 정보</h5>
					<hr>
					
					<div style="padding:0 17px 17px 17px;">
						<c:if test="${myUser.user_lvl == '블루'}">
							<div>
								<span style="font-size:12pt; font-weight:600;">객실 1개 x <span>${requestScope.paraMap.daysGap}</span> 박</span>
								<span style="float:right; font-size:12pt;">₩<span> <fmt:formatNumber pattern="#,###">${roomInfo.rm_price * requestScope.daysGap * 0.9}</fmt:formatNumber></span></span>
							</div>
						
							<div style="border-radius: 0.3rem; margin:2% 0;font-weight:bold; background-color:#fddb32;width:40%; font-size:9pt;width:125px;">
								<image src="<%=ctxPath%>/resources/images/ws/payment/태그.png" style="margin:0 0 2px 5px; height:15px;width:15px;"/>
								<span>회원가 10% 할인</span>
							</div>
								
							<span style="font-size:9pt;">₩ <span><fmt:formatNumber pattern="#,###">${roomInfo.rm_price}</fmt:formatNumber></span> - 1박 평균</span>
		
							<br>
							<br>
							
							<div>
								<span style="font-size:12pt; font-weight:600;">포인트 선할인</span>
								<span style="float:right; font-size:11pt;"><input name="inp_myPoint" type="checkbox"/>
									<c:if test="${myUser.user_lvl == '블루'}">
										<input type="hidden" class="myPoint" value="${roomInfo.rm_price * 0.01}" />
										<fmt:formatNumber pattern="#,###">${roomInfo.rm_price * 0.01}</fmt:formatNumber>
									</c:if>
									
									<c:if test="${myUser.user_lvl == '실버'}">
										<input type="hidden" class="myPoint" value="${roomInfo.rm_price * 0.02}" />
										<fmt:formatNumber pattern="#,###">${roomInfo.rm_price * 0.02}</fmt:formatNumber>
									</c:if>
									
									<c:if test="${myUser.user_lvl == '골드'}">
										<input type="hidden" class="myPoint" value="${roomInfo.rm_price * 0.03}" />
										<fmt:formatNumber pattern="#,###">${roomInfo.rm_price * 0.03}</fmt:formatNumber>
									</c:if> 원 <span id="change_span">적립</span>
								</span>
							</div>
			
							<div>
								<span style="font-size:12pt; font-weight:600;">포인트 사용</span>
								<span style="float:right; font-size:11pt;"><input type="text" max="${myUser.point}" class="point_input" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" style="text-align:right; padding-right:20px; width:80px;"/> <span style="color:#999999; font-size:11pt;position:relative; right:10%;top:1%;">원</span>(보유 포인트 <span id="point_to_use" class="cursor_target point_hover" style=""><fmt:formatNumber pattern="#,###">${myUser.point}</fmt:formatNumber></span> 원)</span>	
							</div>																				
												
							<br>
		
							<div>
								<span style="font-size:12pt; font-weight:600;">세금</span>
								<span style="float:right; font-size:12pt;">₩ <fmt:formatNumber pattern="#,###">${roomInfo.rm_price * requestScope.daysGap * 0.9 * 0.1}</fmt:formatNumber></span>
							</div>
							
							<hr>
							
							<span style="font-weight:bold;">합계</span>
							<span style="float:right; font-weight:bold;">₩ <span class="sum_priceEnd"></span></span>
	
						</c:if>

						
						<c:if test="${myUser.user_lvl == '실버'}">
							<div>
								<span style="font-size:12pt; font-weight:600;">객실 1개 x <span>${requestScope.paraMap.daysGap}</span> 박</span>
								<span style="float:right; font-size:12pt;">₩<span> ${roomInfo.rm_price * requestScope.daysGap * 0.85}</span></span>
							</div>
						
							<div style="border-radius: 0.3rem; margin:2% 0;font-weight:bold; background-color:#fddb32;width:40%; font-size:9pt;width:125px;">
								<image src="<%=ctxPath%>/resources/images/ws/payment/태그.png" style="margin:0 0 2px 5px; height:15px;width:15px;"/>
								<span>회원가 15% 할인</span>
							</div>
								
							<span style="font-size:9pt;">₩ <span><fmt:formatNumber pattern="#,###">${roomInfo.rm_price}</fmt:formatNumber></span> - 1박 평균</span>
		
							<br>
							<br>
							
							<div>
								<span style="font-size:12pt; font-weight:600;">포인트 선할인</span>
								<span style="float:right; font-size:11pt;"><input type="checkbox"/><fmt:formatNumber pattern="#,###">1716</fmt:formatNumber> 원 적립<span id="change_span">/할인</span></span>
							</div>
			
							<div>
								<span style="font-size:12pt; font-weight:600;">포인트 사용</span>
								<span style="float:right; font-size:11pt;"><input type="text" class="point_input" style="text-align:right; padding-right:20px; width:80px;"/> <span style="color:#999999; font-size:11pt;position:relative; right:10%;top:1%;">원</span>(보유 포인트 <span class="cursor_target point_hover" style=""><fmt:formatNumber pattern="#,###">${myUser.point}</fmt:formatNumber></span> 원)</span>	
							</div>
												
							<br>
		
							<div>
								<span style="font-size:12pt; font-weight:600;">세금</span>
								<span style="float:right; font-size:12pt;">₩66,000</span>
							</div>
							
							<hr>
							
							<span style="font-weight:bold;">합계</span>
							<span style="float:right; font-weight:bold;">₩726,000</span>
	
						</c:if>
						
						<c:if test="${myUser.user_lvl == '골드'}">
							<div>
								<span style="font-size:12pt; font-weight:600;">객실 1개 x <span>${requestScope.paraMap.daysGap}</span> 박</span>
								<span style="float:right; font-size:12pt;">₩<span> ${roomInfo.rm_price * requestScope.daysGap * 0.8}</span></span>
							</div>
						
							<div style="border-radius: 0.3rem; margin:2% 0;font-weight:bold; background-color:#fddb32;width:40%; font-size:9pt;width:125px;">
								<image src="<%=ctxPath%>/resources/images/ws/payment/태그.png" style="margin:0 0 2px 5px; height:15px;width:15px;"/>
								<span>회원가 20% 할인</span>
							</div>
								
							<span style="font-size:9pt;">₩ <span><fmt:formatNumber pattern="#,###">${roomInfo.rm_price}</fmt:formatNumber></span> - 1박 평균</span>
		
							<br>
							<br>
							
							<div>
								<span style="font-size:12pt; font-weight:600;">포인트 선할인</span>
								<span style="float:right; font-size:11pt;"><input type="checkbox"/><fmt:formatNumber pattern="#,###">1716</fmt:formatNumber> 원 적립<span id="change_span">/할인</span></span>
							</div>
			
							<div>
								<span style="font-size:12pt; font-weight:600;">포인트 사용</span>
								<span style="float:right; font-size:11pt;"><input type="text" class="point_input" style="text-align:right; padding-right:20px; width:80px;"/> <span style="color:#999999; font-size:11pt;position:relative; right:10%;top:1%;">원</span>(보유 포인트 <span class="cursor_target point_hover" style=""><fmt:formatNumber pattern="#,###">${myUser.point}</fmt:formatNumber></span> 원)</span>	
							</div>
												
							<br>
		
							<div>
								<span style="font-size:12pt; font-weight:600;">세금</span>
								<span style="float:right; font-size:12pt;">₩66,000</span>
							</div>
							
							<hr>
							
							<span style="font-weight:bold;">합계</span>
							<span style="float:right; font-weight:bold;">₩726,000</span>
	
						</c:if>

					</div>
					
				</div>
				
				
				
				
				
			</div>
			
		
			
		
		</div>
			<form name="frm_payment_exp">
				<input type="text" name="userid"/>
				<input type="text" name="name" />
				<input type="text" name="mobile" />
				<input type="text" name="email" />
				<input type="text" name="point" />
				<input type="text" name="to_insert_point" />
				<input type="text" name="used_point" />
				
				<input type="text" name="rm_seq" value="${requestScope.paraMap.rm_seq}" />
				<input type="text" name="total__price" />
				<input type="text" name="startDate" value="${requestScope.paraMap.startDate}" />
				<input type="text" name="endDate" value="${requestScope.paraMap.endDate}" />
				<input type="text" name="h_userid" value="${requestScope.paraMap.h_userid}" />
				<input type="text" name="paytype" value="${requestScope.paraMap.payType}" />
				<input type="text" name="guest_cnt" value="${requestScope.paraMap.guest_cnt}" />
				
				<input type="text" name="currentTimeD" value="${CurrentTime_D}" />
				<input type="text" name="checkinTime" value="${cancelInfo.checkin_time}" />
				<input type="text" name="checkoutTime" value="${cancelInfo.checkout_time}" />
			</form>
		</div>		
	</div>
	
	<input type="text" name="sum_price" />
	<input type="text" class="total_priceEnd" value="${roomInfo.rm_price * requestScope.daysGap * 0.9 * 1.1}"/>
	
	
	<form name="frm_goPaymentConfirm_exp">
		<input type="text" name="email" />
	</form>
	
	
	</c:forEach>
	</c:forEach>
	</c:if>
	</c:forEach>
	</c:if>
	</c:forEach>
	</c:if>