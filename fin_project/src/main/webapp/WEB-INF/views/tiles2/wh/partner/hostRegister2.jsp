<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<title>회원가입 페이지</title>

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
	
		$("button#registerEnd").on("click", function(){
			goRegister();
			
		});// end of $("button#registerEnd").on("click", function(){}-------------------------------
		
		// 비밀번호 에러 메시지 숨김처리
		$("div.error_pw_notice").hide();	
		// 공백으로 둘 수 없습니다 메시지 숨김처리
		$("span.error").hide();
		$("span.duplication_error").hide();
		$("span.pwCheck_error").hide();
		
		// 숫자/문자/특수문자 포함 형태의 8~20 자리 이내의 암호 정규표현식 객체 생성
		const regExp_pw = new RegExp(/^.*(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
		
		
		
	
		// 비밀번호 유효성 검사 후 잘못 됐을 시, 오류메시지 및 빨간보더
		$("input#pw").bind("blur", function(e){
			
			const pw = $(e.target).val().trim();	
			if(pw == "") {
				// 입력하지 않거나 공백만 입력한 경우

				$("input#pw").prop("disabled", true);
				$(e.target).prop("disabled", false);
				$(e.target).css({"border": "2px solid red"});
				

				$(e.target).parent().parent().parent().find("span.error").show();
			
				$(e.target).val("").focus();
			}
			else {
				$("input#pw").prop("disabled", false);
				$(e.target).css({"border": "1px solid #d9e2e7"});
				$(e.target).parent().parent().parent().find("span.error").hide();
			}
			
			
			
			const bool = regExp_pw.test($(e.target).val());
			
			
			if(!bool) {
				  $("div.error_pw_notice").show();
				  $(e.target).parent().css("border","2px solid red");
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
		  
		   
			const pwCheck = $(e.target).val().trim();	
			
			if(pwCheck == "") {
				// 입력하지 않거나 공백만 입력한 경우
			
				$("input#pwCheck").prop("disabled", true);
				$(e.target).prop("disabled", false);
				$(e.target).css({"border": "2px solid red"});
				
			
				$(e.target).parent().parent().parent().find("span.error").show();
			
				$(e.target).val("").focus();
			}
			else {
				$("input#pwCheck").prop("disabled", false);
				$(e.target).css({"border": "1px solid #d9e2e7"});
				$(e.target).parent().parent().parent().find("span.error").hide();
			}		   
				   
		   
		   
		   
			if( $(e.target).val() != $("input#pw").val() ) {
   	  
				$(e.target).css({"border": "2px solid red"});
				$(e.target).parent().parent().parent().find("span.pwCheck_error").show();
	  
				b_pwdCheck=false;
			}
	
    
    
			else {
				b_pwdCheck=true;
				
				$(e.target).css({"border": "1px solid #d9e2e7"});
				$(e.target).parent().parent().parent().find("span.pwCheck_error").hide();
			}
		}); 
		
		
		$("input#name").blur((e)=>{ 
			
			const name = $(e.target).val().trim();
			if(name == "") {
				// 입력하지 않거나 공백만 입력한 경우

				$("input#name").prop("disabled", true);
				$(e.target).prop("disabled", false);
				$(e.target).css({"border": "2px solid red"});
				

				$(e.target).parent().parent().parent().find("span.error").show();
			
				$(e.target).val("").focus();
			}
			else {
				$("input#name").prop("disabled", false);
				$(e.target).css({"border": "1px solid #d9e2e7"});
				$(e.target).parent().parent().parent().find("span.error").hide();
			}
			
		}); // 아이디가 name 인 것을 포커스를 잃어버렸을 경우(blur) 이벤트 처리해주는 것이다.				
		
	
	
		$("input#mobile").blur((e)=>{ 
			
			const mobile = $(e.target).val().trim();
			if(mobile == "") {
				// 입력하지 않거나 공백만 입력한 경우

				$("input#mobile").prop("disabled", true);
				$(e.target).prop("disabled", false);
				$(e.target).css({"border": "2px solid red"});
				

				$(e.target).parent().parent().parent().find("span.error").show();
			
				$(e.target).val("").focus();
			}
			else {
				$("input#mobile").prop("disabled", false);
				$(e.target).css({"border": "1px solid #d9e2e7"});
				$(e.target).parent().parent().parent().find("span.error").hide();
			}
			
		}); // 아이디가 mobile 인 것을 포커스를 잃어버렸을 경우(blur) 이벤트 처리해주는 것이다.				
		
	
	
		$("input#email").blur((e)=>{ 
			
			const email = $(e.target).val().trim();
			if(email == "") {
				// 입력하지 않거나 공백만 입력한 경우

				$("input#email").prop("disabled", true);
				$(e.target).prop("disabled", false);
				$(e.target).css({"border": "2px solid red"});
				

				$(e.target).parent().parent().parent().find("span.error").show();
			
				$(e.target).val("").focus();
			}
			else {
				$("input#email").prop("disabled", false);
				$(e.target).css({"border": "1px solid #d9e2e7"});
				$(e.target).parent().parent().parent().find("span.error").hide();
			}
			
		}); // 아이디가 email 인 것을 포커스를 잃어버렸을 경우(blur) 이벤트 처리해주는 것이다.				
		
	
	
		$("input#email").blur((e)=>{ 
			
			const email = $(e.target).val().trim();
			if(email == "") {
				// 입력하지 않거나 공백만 입력한 경우

				$("input#email").prop("disabled", true);
				$(e.target).prop("disabled", false);
				$(e.target).css({"border": "2px solid red"});
				

				$(e.target).parent().parent().parent().find("span.error").show();
			
				$(e.target).val("").focus();
			}
			else {
				$("input#email").prop("disabled", false);
				$(e.target).css({"border": "1px solid #d9e2e7"});
				$(e.target).parent().parent().parent().find("span.error").hide();
			}
			
		}); // 아이디가 email 인 것을 포커스를 잃어버렸을 경우(blur) 이벤트 처리해주는 것이다.				
	
	
		$("input#legalName").blur((e)=>{ 
			
			const legalName = $(e.target).val().trim();
			if(legalName == "") {
				// 입력하지 않거나 공백만 입력한 경우

				$("input#legalName").prop("disabled", true);
				$(e.target).prop("disabled", false);
				$(e.target).css({"border": "2px solid red"});
				

				$(e.target).parent().parent().parent().find("span.error").show();
			
				$(e.target).val("").focus();
			}
			else {
				$("input#legalName").prop("disabled", false);
				$(e.target).css({"border": "1px solid #d9e2e7"});
				$(e.target).parent().parent().parent().find("span.error").hide();
			}
			
		}); // 아이디가 legalName 인 것을 포커스를 잃어버렸을 경우(blur) 이벤트 처리해주는 것이다.			
	   
		
		$("input#businessNo").blur((e)=>{ 
			
			const businessNo = $(e.target).val().trim();
			if(businessNo == "") {
				// 입력하지 않거나 공백만 입력한 경우

				$("input#businessNo").prop("disabled", true);
				$(e.target).prop("disabled", false);
				$(e.target).css({"border": "2px solid red"});
				

				$(e.target).parent().parent().parent().find("span.error").show();
			
				$(e.target).val("").focus();
			}
			else {
				$("input#businessNo").prop("disabled", false);
				$(e.target).css({"border": "1px solid #d9e2e7"});
				$(e.target).parent().parent().parent().find("span.error").hide();
			}
			
		}); // 아이디가 businessNo 인 것을 포커스를 잃어버렸을 경우(blur) 이벤트 처리해주는 것이다.			
	
	})// end of $(document).ready(function(){})---------------------------------



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
		
		

// "회원가입" 버튼 눌렀을 때 호출되는 함수
function goRegister() {
	
	// 아이디 중복확인 하는 과정
	$.ajax({
		url:"<%= ctxPath%>/useridDuplicateCheck.exp",
		data:{"userid":$("input#userid").val() },	
		type:"post",		// method : 와 혼동하면 안됨. type을 생략하면 기본 get 타입 이다.
		
		async:true,		      // async:true 가 비동기 방식을 말한다. async 을 생략하면 기본값이 비동기 방식인 async:true 이다.
                                 // async:false 가 동기 방식이다. 지도를 할때는 반드시 동기방식인 async:false 을 사용해야만 지도가 올바르게 나온다.  
		
		dataType:"json", 	 // Javascript Standard Object Notation.  dataType은 /MyMVC/member/emailDuplicateCheck.up 로 부터 실행되어진 결과물을 받아오는 데이터타입을 말한다.
                                // 만약에 dataType:"xml" 으로 해주면 /MyMVC/member/emailDuplicateCheck.up 로 부터 받아오는 결과물은 xml 형식이어야 한다. 
                                // 만약에 dataType:"json" 으로 해주면 /MyMVC/member/emailDuplicateCheck.up 로 부터 받아오는 결과물은 json 형식이어야 한다.
		
		
		success:function(json){
		
		
			if(json.isExists == 1) {
				// 입력한 userid 가 이미 사용중이라면 
				
				$("input#userid").parent().parent().parent().find("span.duplication_error").show();
				$(e.target).css({"border": "2px solid red"});
				$("input#userid").val("");
			}
			else {
				// 입력한 userid 가 DB에 존재하지 않는 경우라면 
				$("input#userid").parent().parent().parent().find("span.duplication_error").hide();
				$("input#userid").css({"border": "1px solid #d9e2e7"});
			}
		
		
		}, 
		
		error: function(request, status, error){
             	   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
           }
	
	
	});
		
		
		
		
		
		
		
		// *** 모두 입력이 되었는지 검사하기(공백시, 빨간보더) 시작  *** //
		let b_requiredInfo = false;
		
		$("input.required").each(function(index, elmt){
			const data = $(elmt).val().trim();
	      
			if(data == ""){
				b_requiredInfo = false;
				$(elmt).parent().parent().parent().find("span.error").show()
				$(elmt).css({"border": "2px solid red"});
			}
			else {
				b_requiredInfo = true;
				$(elmt).css({"border": "1px solid #d9e2e7"});
				$(elmt).parent().parent().parent().find("span.error").hide();
			}
	      
	   });
	  
	   
	   if (b_requiredInfo == false) {
		   return false;
	   }
	   // *** 모두 입력이 되었는지 검사하기(공백시, 빨간보더) 끝  *** //
	   
	 
	  
	   
	   
	  	


	     
	     
		// *** 아이디 중복 검사 *** //    
		if(b_requiredInfo) {
	
			const frm = document.registerFrm;
		  	frm.action = "<%= ctxPath%>/registerEnd.exp";
		  	frm.method = "post";
		    frm.submit();
		}
		
} // end of function goRegister() {}-----------------	
	


	


	



</script>

 
<div id="container" style=" inline-size: 100%; margin: auto; max-inline-size: 75rem; padding: 50px 0;">
	<div class="err_banner">
	  		<span id="err_msg"></span>
	</div>
	  
	
	<form name="registerFrm" autocomplete="off">
		
		<div class="section_inner signup" style="width:40%; border: solid 0px blue; margin: 0 auto; height:800px;" >
			
			<div id="subtitle">2/2단계</div>	
			<h1 style="margin-bottom: 6%;">
               	<b style="font-size: 27px;">계정 생성</b>
            </h1>
			
			<div class="input_userid container" style="">
                  <!-- 아이디 -->
                   <div class="label_wrap userid">
                    <label class="input_wrap userid" style="">
                       <span class="subtitle" >아이디</span>
                       <input id="userid" name="userid" class="required" type="text" value="" style="" maxlength=15 />
                    </label>
                   </div>
                   <span class="error">공백으로 둘 수 없습니다.</span>
                   <span class="duplication_error">중복된 아이디입니다. 다른 아이디를 입력하세요.</span>
			</div>					
			
			<div class="input_pw container" style="">
                  <!-- 비밀번호 -->
                   <div class="label_wrap pw">
                    <label class="input_wrap pw" style="">
                       <span class="subtitle" >비밀번호</span>
                       <input id="pw" name="pw" class="required" type="password" value="" style="" maxlength=20 required/>
                    </label>
                   </div>
                   <span class="error">공백으로 둘 수 없습니다.</span>
			</div>					
			
			<div class="input_pw container" style="">
                  <!-- 비밀번호 확인-->
                   <div class="label_wrap pwCheck">
                    <label class="input_wrap pwCheck" style="">
                       <span class="subtitle" >비밀번호 확인</span>
                       <input id="pwCheck" name="pwCheck" class="required" type="password" value="" style="" maxlength=20 required/>
                    </label>
                   </div>
                   <span class="error">공백으로 둘 수 없습니다.</span>
                   <span class="pwCheck_error">비밀번호를 확인하세요.</span>
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
                       <input id="name" name="name" class="required" type="text" value="" style="" required/>
                    </label>
                   </div>
                   <span class="error">공백으로 둘 수 없습니다.</span>
			</div>			
			
			<div class="input_mobile container" style="">
                  <!-- 연락처 내용 -->
                   <div class="label_wrap mobile">
                    <label class="input_wrap mobile" style="">
                       <span class="subtitle" >연락처</span>
                       <input type="text" id="mobile" name="mobile" class="required" pattern="[0-9]*" maxlength="13" oninput="onInputHandler_tel()" required>
                    </label>
                   </div>
				   <span class="error">공백으로 둘 수 없습니다.</span>
			</div>			
			
			
			<div class="input_email container" style="">
                  <!-- 이메일 주소 -->
                   <div class="label_wrap email">
                    <label class="input_wrap email" style="">
                       <span class="subtitle" >이메일 주소</span>
                       <input id="email" name="email" class="required" type="text" value="" style="" required/>
                    </label>
                   </div>
                   <span class="error">공백으로 둘 수 없습니다.</span>
			</div>			
			
            <div class="input_legalName container" style="">
                  <!-- 사업자 법인명 내용 -->
                   <div class="label_wrap">
                    <label class="input_wrap" style="">
                       <span class="subtitle" >사업자 법인명</span>
                       <input id="legalName" name="legalName" class="required" type="text" value="" style="" required/>
                    </label>
                   </div>
                   <span class="error">공백으로 둘 수 없습니다.</span>
			</div>			
			
			<div class="input_businessNo container" style="">
                  <!-- 사업자번호 내용 -->
                   <div class="label_wrap">
                    <label class="input_wrap" style="">
                       <span class="subtitle" >사업자등록번호</span>
                       <input id="businessNo" name="businessNo" class="required" type="text" pattern="[0-9]*" maxlength="12" value="" style="" oninput="onInputHandler_bno()" required/>
                    </label>
                   </div>
                   <span class="error">공백으로 둘 수 없습니다.</span>
			</div>	    
           
				
				<input type="hidden" name="lodgename" value="${requestScope.lodgename}">		
				<input type="hidden" name="address" value="${requestScope.address}">		
				<input type="hidden" name="detailAddress" value="${requestScope.detailAddress}">		
				<input type="hidden" name="extraAddress" value="${requestScope.extraAddress}">		
				<input type="hidden" name="postcode" value="${requestScope.postcode}">
				
				
				
				
												
				
				<button id="registerEnd" type="button" style="width:100%; background-color: #000099; color: #fff; height:48px; margin-top:5%; text-align:center;">회원가입</button>
				
			 
			
			
			</div>
			
				
	</form>	

		

</div>