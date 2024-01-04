<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<title>회원정보 수정</title>

<%
	String ctxPath = request.getContextPath();
	//	   /tempSemi
%>

<%-- register 전용 CSS --%>

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/css/wh/common.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/css/wh/userRegister.css" />


<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<style>
	div.error_pwd_notice {
		margin: 10% 0;
		color:#707070;
	}
	
	ul {
		list-style-type: none;
		padding: 0px;
		font-size: 10px;
	}
	
	ul > li {
		margin: 3% 0;
	}
	
</style>

<script>
	
let b_pwdCheck = false;
//"비밀번호"와 "비밀번호 확인"이 올바른지 확인하기 위한 용도
	

	
	$(document).ready(function(){
	
		$("button#editEnd").on("click", function(){
			goEdit();
			
		});// end of $("button#registerEnd").on("click", function(){}-------------------------------
		
		// 비밀번호 에러 메시지 숨김처리
		$("div.error_pw_notice").hide();	
		
		
		// 숫자/문자/특수문자 포함 형태의 8~20 자리 이내의 암호 정규표현식 객체 생성
		const regExp_pw = new RegExp(/^.*(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
		
		
		
	
		// 비밀번호 유효성 검사 후 잘못 됐을 시, 오류메시지 및 빨간보더
		$("input#pw").bind("blur", function(e){
			
		  const bool = regExp_pw.test($(e.target).val());
	      
	      
	      if(!bool) {
			  $("div.error_pw_notice").show();
			  $(e.target).parent().css("border","1px solid #d12b2b");
			  b_pwdCheck=false;
			  }
		  else {
			  b_pwdCheck=true;
			  $(e.target).parent().css("border","");
			  $("div.error_pw_notice").hide();
		  }
	   }); 
			
		// 아이디가 pwdCheck 인 것의 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것.
	   $("input#pwCheck").bind("blur", (e) =>{
		   
	      if( $(e.target).val() != $("input#pw").val() ) {
			  $(e.target).parent().css("border","1px solid #d12b2b");
			  b_pwdCheck=false;
		  }
		  else {
			  b_pwdCheck=true;
			  $(e.target).parent().css("border","");
		  }
	   }); 
		
		
		// *** 키다운 됐을 때, input 박스 빨강 -> 검정 시작 *** //
		   
			// 아이디 키다운 됐을 때 이벤트
			$("input#userid").bind("keydown", function(e) {
			   
				if ( $(e.target).val().trim() != "" ) {
					$(e.target).parent().css("border","");
				   
					}
			});
		   
			// 비밀번호 키다운 됐을 때 이벤트
			$("input#pw").bind("keydown", function(e) {
			   
				if ( $(e.target).val().trim() != "" ) {
					$(e.target).parent().css("border","");
				   
					}
			});
		
			// 사업자명 키다운 됐을 때 이벤트
		    $("input#name").bind("keydown", function(e) {
			   if ( $(e.target).val().trim() != "" ) {
				   $(e.target).parent().css("border","");
			   }
			});
			
			// 연락처 키다운 됐을 때
		   	$("input#mobile").bind("keydown",function(e) {
			   if ( $(e.target).val().trim() != "" ) {
				   $(e.target).parent().css("border","");
		   	   }
		    });
			
		    // 이메일 키다운 됐을 때 이벤트
			$("input#email").bind("keydown",function(e) {
			   if ( $(e.target).val().trim() != "" ) {
				   $(e.target).parent().css("border","");
		   	   }
		    });
		   
			// 법인명 키다운 됐을 때 이벤트
			$("input#legalName").bind("keydown",function(e) {
			   if ( $(e.target).val().trim() != "" ) {
				   $(e.target).parent().css("border","");
		   	   }
		    });
		   
			// 사업자번호 키다운 됐을 때 이벤트
			$("input#businessNo").bind("keydown",function(e) {
			   if ( $(e.target).val().trim() != "" ) {
				   $(e.target).parent().css("border","");
		   	   }
		    });
		   
		   
		   // *** 키다운 됐을 때, input 박스 빨강 -> 검정 끝 *** //
		
			
		
		
	
	
	
	
})// end of $(document).ready(function(){})---------------------------------

function showBanner() {
	
	$("div.err_banner").addClass('show');
	$("div.err_banner").removeClass('hide');	
  		
  		setTimeout(function() {
			 
    		$("div.err_banner").removeClass('show');
    		$("div.err_banner").addClass('hide');
    		
  		}, 1500)

	}

//연락처 숫자만 입력 가능 + 하이픈 추가 함수
function onInputHandler_tel() {
	
	let text_tel = $("input:text[id='mobile']");
	let tel_val = text_tel.val().replace(/\D/g, "");
	let tel_len = tel_val.length;
	let result = "";
	
	// 세번째 입력 숫자까지 그대로 출력
    if(tel_len < 4) result = tel_val;
    // 4번째에 "-" 추가 후 숫자입력
    else if(tel_len < 8){
	  	result += tel_val.substring(0,3);
	    result += "-";
	    result += tel_val.substring(3);
    // 9번째에 "-" 추가 후 숫자입력
    } else{
	  	result += tel_val.substring(0,3);
	    result += "-";
	    result += tel_val.substring(3,7);
	    result += "-";
	    result += tel_val.substring(7);
    }
	
	// 결과를 값으로 출력
	text_tel.val(result);
	
}

function onInputHandler_bno() {
	
	let text_bno = $("input:text[id='businessNo']");
	let bno_val = text_bno.val().replace(/\D/g, "");
	let bno_len = bno_val.length;
	let result = "";
	
	// 세번째 입력 숫자까지 그대로 출력
    if(bno_len < 4) result = bno_val;
    // 4번째에 "-" 추가 후 숫자입력
    else if(bno_len < 6){
	  	result += bno_val.substring(0,3);
	    result += "-";
	    result += bno_val.substring(3);
    // 7번째에 "-" 추가 후 숫자입력
    } else{
	  	result += bno_val.substring(0,3);
	    result += "-";
	    result += bno_val.substring(3,5);
	    result += "-";
	    result += bno_val.substring(5);
    }
	
	// 결과를 값으로 출력
	text_bno.val(result);
	
}		
		
		

	// "수정 완료" 버튼 눌렀을 때 호출되는 함수
	function goEdit() {
		
	   let b_nameCheck = false;
		
		// *** 필수입력사항에 모두 입력이 되었는지 검사하기(공백시, 빨간보더) 시작  *** //
	   let b_requiredInfo = true;
		
	   $("input.required").each(function(index, elmt){
	      const data = $(elmt).val().trim();
	      
	      if(data == ""){
			  b_requiredInfo = false;
			  $(elmt).parent().css("border","1px solid #d12b2b"); 
			   	         
	      }
	      else {
			  b_requiredInfo = true;
		  }
	      
	   });
	  
	   
	   if (b_requiredInfo == false) {
		   showBanner(); // 공백있으면 빨간 바 보여주고 리턴
		   $("span#err_msg").html(`필수 입력사항을 확인해주세요!`);
		   return false;
	   }
	   // *** 필수입력사항에 모두 입력이 되었는지 검사하기(공백시, 빨간보더) 끝  *** //
	   
	 
	  
	   
	   
	   // *** 입력정보 유효성 검사 후 안맞는 거 빨간배너에 메시지 + 보더 빨갛게  시작  *** //
	  	
	   // 아이디, 이메일, 이름, 생년월일 유효성 검사 통과시  true 반환  == 시작 == //


		
	     // *** 이름 정규식 *** //
	     var regExp_name = /^[가-힣]{2,4}|[a-zA-Z]{2,10}\s[a-zA-Z]{2,10}$/;     
	     if ( regExp_name.test($("input#name").val()) ){
		   b_nameCheck = true; // 정규식에 잘 맞았음.
	     }
	   
	    
	     // 아이디, 이메일, 이름, 생년월일 유효성 검사 통과시  true 반환  == 끝 == //
	     
	     
	     // 유효성 false 시, 빨간 보더 == 시작 == //
	      
	   	
		 
		 if(!b_pwdCheck) {
			$("input#pw").parent().css("border","1px solid #d12b2b");
			showBanner(); // 공백있으면 빨간 바 보여주고 리턴
		   	$("span#err_msg").html(`비밀번호를 확인하세요!`);
		    return false;
	     }
	     else {
		    $("input#pw").parent().css("border","");
		    $("input#pwCheck").parent().css("border","");
		 }
	   	 /*
	     if(b_nameCheck == false) {
			$("input#name").parent().css("border","1px solid #d12b2b");
			showBanner(); // 공백있으면 빨간 바 보여주고 리턴
		   	$("span#err_msg").html(`정확한 성명을 입력해주세요!`);
			return false;
		 }
	   	 
		 else {
			 $("input#name").parent().css("border","");
		 }
	   	*/
		 
		 
		 // 유효성 false 시, 빨간 보더 == 끝 == //
	     // *** 입력정보 유효성 검사 후 안맞는 거 빨간배너에 메시지 + 보더 빨갛게  끝!!  *** //
	   	
	     
	     
	     // *** 아이디 중복 검사 *** //    
	     if(b_requiredInfo) {
		
	    		 const frm = document.editFrm;
			  	frm.action = "<%= ctxPath%>/editEnd.exp";
			  	frm.method = "post";
			    frm.submit();
	     }
		
	} // end of function goRegister() {}-----------------	
	


	


	



</script>

 
<div id="container" style=" inline-size: 100%; margin: auto; max-inline-size: 75rem; padding: 50px 0;">
	<div class="err_banner">
	  		<span id="err_msg"></span>
	</div>
	  
	
	<form name="editFrm" autocomplete="off">
		
		<div class="section_inner signup" style="width:40%; border: solid 0px blue; margin: 0 auto; height:800px;" >
			
			<div id="subtitle">2/2단계</div>	
			
			
			<div class="input_pw container" style="">
                  <!-- 비밀번호 -->
                   <div class="label_wrap pw">
                    <label class="input_wrap pw" style="">
                       <span class="subtitle" >비밀번호</span>
                       <input id="pw" name="pw" type="password" value="${sessionScope.loginhost.h_pw}" style="" maxlength=20 required/>
                    </label>
                   </div>
			</div>					
			
			<div class="input_pw container" style="">
                  <!-- 비밀번호 확인-->
                   <div class="label_wrap pwCheck">
                    <label class="input_wrap pwCheck" style="">
                       <span class="subtitle" >비밀번호 확인</span>
                       <input id="pwCheck" name="pwCheck" type="password" value="${sessionScope.loginhost.h_pw}" style="" maxlength=20 required/>
                    </label>
                   </div>
			</div>					
			
			<div class="error_pw_notice">
				<ul>
                 <li class="member-notice__item">· 영문 대소문자는 구분이 되며, 최소 1개의 대문자, 특수문자, 숫자가 포함 된 비밀번호를 사용 하셔야 됩니다.</li>
                 <li class="member-notice__item">· 사용 가능한 특수문자: ! @ # $ % ^ &amp; * ( ) - + / &lt; &gt; , .</li>
                </ul>
			</div>
			
			<div class="input_name container" style="">
                  <!-- 판매자명 내용 -->
                   <div class="label_wrap">
                    <label class="input_wrap" style="">
                       <span class="subtitle" >성명</span>
                       <input id="name" name="name" type="text" value="${sessionScope.loginhost.h_name}" style="" required/>
                    </label>
                   </div>
			</div>			
			
			<div class="input_mobile container" style="">
                  <!-- 연락처 내용 -->
                   <div class="label_wrap mobile">
                    <label class="input_wrap mobile" style="">
                       <span class="subtitle" >연락처</span>
                       <input type="text" id="mobile" name="mobile" pattern="[0-9]*" maxlength="13" oninput="onInputHandler_tel()" value="${sessionScope.loginhost.h_mobile}" required>
                    </label>
                   </div>
			</div>			
			
			
			<div class="input_email container" style="">
                  <!-- 이메일 주소 -->
                   <div class="label_wrap email">
                    <label class="input_wrap email" style="">
                       <span class="subtitle" >이메일 주소</span>
                       <input id="email" name="email" type="text" value="${sessionScope.loginhost.h_email}" style="" required/>
                    </label>
                   </div>
			</div>			
			
            <div class="input_legalName container" style="">
                  <!-- 사업자 법인명 내용 -->
                   <div class="label_wrap">
                    <label class="input_wrap" style="">
                       <span class="subtitle" >사업자 법인명</span>
                       <input id="legalName" name="legalName" type="text" value="${sessionScope.loginhost.h_legalName}" style="" required/>
                    </label>
                   </div>
			</div>			
			
			<div class="input_businessNo container" style="">
                  <!-- 사업자번호 내용 -->
                   <div class="label_wrap">
                    <label class="input_wrap" style="">
                       <span class="subtitle" >사업자등록번호</span>
                       <input id="businessNo" name="businessNo" type="text" pattern="[0-9]*" maxlength="12" value="${sessionScope.loginhost.h_businessNo}" style="" oninput="onInputHandler_bno()" required/>
                    </label>
                   </div>
			</div>	    
           
				
				<input type="hidden" name="lodgename" value="${requestScope.lodgename}">		
				<input type="hidden" name="address" value="${requestScope.address}">		
				<input type="hidden" name="detailAddress" value="${requestScope.detailAddress}">		
				<input type="hidden" name="extraAddress" value="${requestScope.extraAddress}">		
				<input type="hidden" name="postcode" value="${requestScope.postcode}">
				<input type="hidden" name="userid" value="${sessionScope.loginhost.h_userid}">
				
				
				
				
												
				
				<button id="editEnd" type="button" style="width:100%; background-color: #000099; color: #fff; height:48px; margin-top:5%; text-align:center;">수정</button>
				
			 
			
			
			</div>
			
				
	</form>	

		

</div>