let b_pwdCheck = false;
// "비밀번호"와 "비밀번호 확인"이 올바른지 확인하기 위한 용도

let b_telCheck = false;
// 연락처 인증이 완료됐는지 확인하기위한 용도

let b_emailCheck = false;
// 이메일 인증이 완료됐는지 확인하기위한 용도

$(document).ready(function() {
	$("div.email_check").hide();
	// 이메일 선택시 뒷부분 자동입력
	
	$("select#email-select").bind("change", (e) => {
		
		const div_email = $("input#userid_email");
		
		if($(e.target).val() == "direct") {
			div_email.val("");
			div_email.prop('readonly',false);
			div_email.focus();
			
		}
		else {
			div_email.prop('readonly',true).val($(e.target).val());
			
			
		}
	})
	
	// 아이디 인증하기의 "재전송" 버튼 클릭 시 이벤트 처리
	$("button#resendCode_email").bind("click", function () {
		const result = confirm($("input#userid_f").val() +"@" + $("input#userid_email").val()+' 로 인증번호를 재발송 하시겠습니까?\n"확인"을 누를 시, 해당 메일로 인증번호가 발송됩니다.');
	    if(result) {
			sendEmail();
		}// end of if(result) {}----------------------
	}); // end of $("button#resendCode_email").bind("click", function () {})------------
	
	// 아이디(이메일) 인증하기의 "인증하기" 버튼 클릭 시 이벤트 처리
	$("button#checkCode_email").bind("click", function () {
		
		 const input_confirmCode_email = $("input:text[name='input_confirmCode_email']").val().trim(); 
	  					   
		  if( $("input#input_confirmCode_email").val().trim() != ""){
			  
			  $.ajax({
		    	url:"verifyCertification.tam", // <- 상대경로. 혹은 절대경로 http://localhost:9090/MyMVC/member/emailDuplicateCheck.up 로도 가능
		//	    속성명:"벨류값"
		   		data:{"inputCode":input_confirmCode_email}, // data 속성은 http://localhost:9090/MyMVC/member/emailDuplicateCheck.up 로 전송해야할 데이터를 말한다.
		   		// "email" 는 $("input#email").val() 이 값을 받아와야한다. 그래서 EmailDuplicateCheckAction 클래스에서 key값을 email 로 하여
		   		// request.getParameter("email") 로 $("input#email").val() 이 값을 받아온다.
		   		type:"post", // method 아님!. type 을 생략하면 type:"get" 이다.
		   
		   		async:true, // async:true => 비동기 방식. async 을 생략하면 기본값이 비동기 방식인 async:true 이다.
	                        // async:false => 동기 방식. 지도를 할때는 반드시 동기방식인 async:false 을 사용해야만 지도가 올바르게 나온다.
	            
	            dataType:"json",
	            // !!!! ★★★★★ 대문자 T 인거 잊지말자 ★★★★★ !!!!      
		   
		   		success:function(json){
				   
				   // 성공했을때!!  readonly로 변경 재전송버튼 비활성화
				   if(json.isMatch_e) { 
				       // 인증코드가 맞을 경우
					   alert("이메일 인증이 완료되었습니다.");
					   $("input#input_confirmCode_email").prop("readonly",true);
					   $("select#email-select").prop("disabled",true);
					   $("button#checkCode_email").prop("disabled",true);
					   $("button#resendCode_email").prop("disabled",true);
					   b_emailCheck = true;
					   const userid_full = $("input#userid_f").val() +"@"+ $("input#userid_email").val();
						$("input#userid_full").val(userid_full);
						console.log($("input#userid_full").val());
				   }
				   else {
					   alert("인증번호가 일치하지 않습니다.");
				   }
			    },
			    error: function(request, status, error){
	               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            }		
			})  
		  }  
			 
		  else {
			  alert("인증코드를 입력해주세요!");
			  return;
		  }
		   
		});// end of $("button#checkCode_email").bind("click", function () {})------------------
	
	// 비밀번호 에러 메시지 숨김처리
	$("div.error_pwd_notice").hide();
	
	// 인증하기 숨김처리
	$("div.telCheck").hide();
	
	
	// 숫자/문자/특수문자 포함 형태의 8~20 자리 이내의 암호 정규표현식 객체 생성
	const regExp_pwd = new RegExp(/^.*(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
	
	// 아이디가 pwd인 것의 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것
	// 비밀번호 유효성 검사 후 잘못 됐을 시, 오류메시지 및 빨간보더
	$("input#pwd").bind("blur", (e) =>{
		
	  const bool = regExp_pwd.test($(e.target).val());
      
      
      if(!bool) {
		  $("div.error_pwd_notice").show();
		  $(e.target).parent().css("border","1px solid #d12b2b");
		  b_pwdCheck=false;
		  }
	  else {
		  b_pwdCheck=true;
		  $(e.target).parent().css("border","");
		  $("div.error_pwd_notice").hide();
	  }
   }); 

	// 아이디가 pwdCheck 인 것의 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것.
   $("input#pwdCheck").bind("blur", (e) =>{
	   
      if( $(e.target).val() != $("input#pwd").val() ) {
		  $(e.target).parent().css("border","1px solid #d12b2b");
		  b_pwdCheck=false;
	  }
	  else {
		  b_pwdCheck=true;
		  $(e.target).parent().css("border","");
	  }
   }); 
   
   
   // *** 키다운 됐을 때, input 박스 빨강 -> 검정 시작 ***//
   
   // 아이디 키다운 됐을 때 이벤트
   $("input#userid_f").bind("keydown", (e) => {
	   
	   if ( $(e.target).val().trim() != "" ) {
		   $(e.target).parent().css("border","");
		   
		   if( $("input#userid_email").val().trim() != "" ) {
		   		$("input#userid_email").parent().css("border","");
	   	   }
	   }
   });
   
    // 이메일 change 됐을 때 이벤트
    $("select#email-select").bind("change", () => {
   		if ( $("input#userid_email").val().trim() != "" ) {
			$("input#userid_email").parent().css("border","");
		}
    });
    // 이메일 직접입력 시, border 원상복구
    $("input#userid_email").bind("keyup", () => {
   		$("input#userid_email").parent().css("border","");
    });
    // 성별 change 됐을 때 이벤트 (입력시)
    $("select#gender").bind("change", (e) => {
	   if ( $(e.target).val() != null ) {
		   $(e.target).parent().css("border","");
	   }
    });
    // 이름 키다운 됐을 때 이벤트
    $("input#name").bind("keydown", (e) => {
	   if ( $(e.target).val().trim() != "" ) {
		   $(e.target).parent().css("border","");
	   }
	});
	// 인증코드 키다운 됐을 때
   	$("input#input_confirmCode").bind("keydown",(e) => {
	   if ( $(e.target).val().trim() != "" ) {
		   $(e.target).parent().css("border","");
	   }
	});
   	// 연락처 키다운 됐을 때
   	$("input#mobile").bind("keydown",(e) => {
	   if ( $(e.target).val().trim() != "" ) {
		   $(e.target).parent().css("border","");
   	   }
    });
    // 생년월일 키다운 됐을 때
   	$("input#birthday").bind("keydown",(e) => {
	   if ( $(e.target).val().trim() != "" ) {
		   $(e.target).parent().css("border","");
   	   }
    });
   
   // *** 키다운 됐을 때, input 박스 빨강 -> 검정 끝 ***//
   
   
    // === 연락처 "인증하기" 버튼 클릭시 이벤트 처리해주기 === //
   $("button#checkCode").bind("click", () => {
	  
	   const input_confirmCode_mobile = $("input:text[name='input_confirmCode']").val().trim(); 
	  
	  if( input_confirmCode_mobile != ""){
		  
		  $.ajax({
	    	url:"verifyCertification.tam", // <- 상대경로. 혹은 절대경로 http://localhost:9090/MyMVC/member/emailDuplicateCheck.up 로도 가능
	//	    속성명:"벨류값"
	   		data:{"inputCode":input_confirmCode_mobile}, // data 속성은 http://localhost:9090/MyMVC/member/emailDuplicateCheck.up 로 전송해야할 데이터를 말한다.
	   		// "email" 는 $("input#email").val() 이 값을 받아와야한다. 그래서 EmailDuplicateCheckAction 클래스에서 key값을 email 로 하여
	   		// request.getParameter("email") 로 $("input#email").val() 이 값을 받아온다.
	   		type:"post", // method 아님!. type 을 생략하면 type:"get" 이다.
	   
	   		async:true, // async:true => 비동기 방식. async 을 생략하면 기본값이 비동기 방식인 async:true 이다.
                        // async:false => 동기 방식. 지도를 할때는 반드시 동기방식인 async:false 을 사용해야만 지도가 올바르게 나온다.
            
            dataType:"json",
            // !!!! ★★★★★ 대문자 T 인거 잊지말자 ★★★★★ !!!!      
	   
	   		success:function(json){
			   
			   // 성공했을때!!  readonly로 변경 재전송버튼 비활성화
			   if(json.isMatch_m) { 
			       // 인증코드가 맞을 경우
				   alert("연락처 인증이 완료되었습니다.");
				   $("input#input_confirmCode_mobile").prop("readonly",true);
				   b_telCheck = true;
				   $("button#checkCode").prop("disabled",true);
				   $("button#resendCode").prop("disabled",true);
				   $("input#input_confirmCode").prop("readonly",true);
			   }
			   else {
				   alert("인증번호가 일치하지 않습니다.");
			   }
		    },
		    error: function(request, status, error){
               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }		
		}); // end of $.ajax({})--------
	  }  
		 
	  else {
		  alert("인증코드를 입력해주세요!");
		  return;
	  }
	   
   });
   
}); // end of docu

// 연락처 숫자만 입력 가능 + 하이픈 추가 함수
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

// 날짜 숫자만 입력 가능 + 하이픈 추가 함수
function onInputHandler_birth() {
	let text_birth = $("input:text[id='birthday']");
	let birth_val = text_birth.val().replace(/\D/g, "");
	let birth_len = birth_val.length;
	let result = "";

	// 4번째 입력 숫자까지 그대로 출력
    if(birth_len < 5) result = birth_val;
    // 5번째에 "." 추가 후 숫자입력
    else if( birth_val.substring(4,5) !="." && birth_len < 8){
	  	result += birth_val.substring(0,4);
	    result += ".";
	    result += birth_val.substring(4);
    // 9번째에 "-" 추가 후 숫자입력
    } else{
	  	result += birth_val.substring(0,4);
	    result += ".";
	    result += birth_val.substring(4,6);
	    result += ".";
	    result += birth_val.substring(6);
    }
	
	// 결과를 값으로 출력
	text_birth.val(result);	
	
}


// === 체크박스 전체선택/전체해제 === //
function func_allCheck(bool){
	
	const checkbox_list = document.querySelectorAll("input[name='agree']");
	
	for(let checkbox of checkbox_list) {
		checkbox.checked = bool;
	}// end of for()---------------------

	
}// end of function func_allCheck(bool) {}--------------------




// == 체크박스 전체선택 / 전체해제 에서 
//    하위 체크박스에 체크가 1개라도 체크가 해제되면 체크박스 전체선택/전체해제 체크박스도 체크가 해제되고
//    하위 체크박스에 체크가 모두 체크가 되어지면 체크박스 전체선택/전체해제 체크박스도 체크가 되어지도록 하는 것 == // 
function func_agreeCheck() {	
	
	  $("input:checkbox[name='agree']").click( (e) => {
      //  name이 agree인 체크박스에 대해서 클릭하면 발생하는 이벤트이다.
      
      const bool = $(e.target).prop("checked");
      // 클릭한 체크박스의 체크유무를 알아온다.
      
      
      if(bool) {
      // 클릭한 체크박스가 체크가 되어진 상태이라면
      
         // === [name='agree'] 인 모든 체크박스를 검사해서 모두 체크가 되어진 상태인지 알아온다.
         let b_all_checked = true;
         $("input:checkbox[name='agree']").each( (i, elt) => {
         // $(elt)이 $("div#firstDiv input:checkbox[name='agree']") 중 반복되어지는
         // 하나의 요소이다.
            const b_checked = $(elt).prop("checked");
            // 반복을 돌면서 클릭할때마다 모든 체크박스가 체크가 되었는지 안되었는지 알아온다.
            if(!b_checked){
            // 체크가 되어있지 않은 체크박스를 발견했다. 그렇다면 그 다음에 오는 체크박스를 
            // 확인할 필요가 없다.
               b_all_checked = false;
               return false; // Jquery문의 반복문 탈출 break를 말한다.
            }
            
         }); // end of each()-------------------
         
         if(b_all_checked) {
          // name이 person인 모든 체크박스를 하나하나씩 체크유무 검사를 마쳤을 때
          // 모든 체크박스가 체크가 되어진 상태이라면
             $("input:checkbox[id='agreeAll']").prop("checked", true);
            // "전체선택 / 전체해제 체크박스" 에 체크를한다.
         }
         
	     }
	     else {
	     	// 클릭한 체크박스가 체크가 해제가 되어진 상태라면
	        $("input:checkbox[id='agreeAll']").prop("checked", false);
	        // "전체선택 / 전체해제 체크박스" 에 체크를 해제한다.
	     }
      
   }); // end of $("div#firstDiv input:checkbox[name='person']").click( -----------
	
	
}// end of function func_usaCheck() {}----------------------------


// "가입하기" 버튼 눌렀을 때 호출되는 함수
function goRegister() {
	
   let b_nameCheck = false;
   let b_birthCheck = false;
	
	// *** 필수입력사항에 모두 입력이 되었는지 검사하기(공백시, 빨간보더) 시작  *** //
   let b_requiredInfo = false;
	
   $("input.required").each(function(index, elmt){
      const data = $(elmt).val().trim();
      
      if(data == ""){
		  b_requiredInfo = false;
		  $(elmt).parent().css("border","1px solid #d12b2b"); 
		  if(index==0) {
			 $("div.input_email").css("border","1px solid #d12b2b");			 
		  }
		   	         
      }
      else {
		  b_requiredInfo = true;
	  }
      
   });
   
   if ( $("select#gender").val() == null ) {
	   $("select#gender").parent().css("border","1px solid #d12b2b");
	   b_requiredInfo = false;
   }
   
   if (b_requiredInfo == false) {
	   showBanner(); // 공백있으면 빨간 바 보여주고 리턴
	   $("span#err_msg").html(`필수 입력사항을 확인해주세요!`);
	   return false;
   }
   // *** 필수입력사항에 모두 입력이 되었는지 검사하기(공백시, 빨간보더) 끝  *** //
   
   //*** 아이디 인증 완료 유무 검사하기 ***/
   if(!b_emailCheck) {
	   showBanner();
	   $("span#err_msg").html(`아이디 인증을 완료해주세요!`);
	   $("input#userid_f").parent().css("border","solid 1px #d12b2b");
	   $("input#userid_email").parent().css("border","solid 1px #d12b2b");
	   return false;
   }
  
   // *** 연락처 인증 완료 유무 검사하기(안했을때, 빨간보더) *** //
   if(!b_telCheck) {
	   showBanner(); // 공백있으면 빨간 바 보여주고 리턴
	   $("div#div_input_confirmCode").css("border","solid 1px #d12b2b");
	   $("div#div_input_tel").css("border","solid 1px #d12b2b");
	   $("span#err_msg").html(`연락처 인증을 완료해주세요!`);
	   return false;
   }
   
   
   // *** 입력정보 유효성 검사 후 안맞는 거 빨간배너에 메시지 + 보더 빨갛게  시작  *** //
  	
   // 아이디, 이메일, 이름, 생년월일 유효성 검사 통과시  true 반환  == 시작 == //


	
     // *** 이름 정규식 *** //
     var regExp_name = /^[가-힣]{2,4}|[a-zA-Z]{2,10}\s[a-zA-Z]{2,10}$/;     
     if ( regExp_name.test($("input#name").val()) ){
	   b_nameCheck = true; // 정규식에 잘 맞았음.
     }
   
     // *** 생년월일 날짜 유효성 검사 후 만 14세 이상 확인 *** //
   	 val_birth = $("input#birthday").val();
	 if ( checkValidDate(val_birth) ){
   		b_birthCheck = true;
     }
     // 아이디, 이메일, 이름, 생년월일 유효성 검사 통과시  true 반환  == 끝 == //
     
     
     // 유효성 false 시, 빨간 보더 == 시작 == //
      
   	
	 
	 if(!b_pwdCheck) {
		$("input#pwd").parent().css("border","1px solid #d12b2b");
		showBanner(); // 공백있으면 빨간 바 보여주고 리턴
	   	$("span#err_msg").html(`비밀번호를 확인하세요!`);
	    return false;
     }
     else {
	    $("input#pwd").parent().css("border","");
	    $("input#pwdCheck").parent().css("border","");
	 }
   	 if(b_nameCheck == false) {
		$("input#name").parent().css("border","1px solid #d12b2b");
		showBanner(); // 공백있으면 빨간 바 보여주고 리턴
	   	$("span#err_msg").html(`정확한 성함을 입력해주세요!`);
		return false;
	 }
	 else {
		 $("input#name").parent().css("border","");
	 }
   	 if(b_birthCheck == false) {
		$("input#birthday").parent().css("border","1px solid #d12b2b");
		showBanner(); // 공백있으면 빨간 바 보여주고 리턴
	   	$("span#err_msg").html(`날짜 형식에 맞게 입력해주세요`);
		return false;
	 }
	 else {
		$("input#birthday").parent().css("border","");
	 }
	 
	 // 유효성 false 시, 빨간 보더 == 끝 == //
     // *** 입력정보 유효성 검사 후 안맞는 거 빨간배너에 메시지 + 보더 빨갛게  끝!!  *** //
   	
     // *** 필수 동의 사항에 모두 체크 되었는지 검사하기 시작 *** //
     let b_requiredAgree = true;
     $("input:checkbox[name='agree']").each(function(index, elt) {
		
		const agree_check = $(elt).prop('checked');
		console.log(agree_check)
		if(!agree_check) {
			b_requiredAgree = false;
		}
	 });
     if(!b_requiredAgree) {
	    showBanner(); // 공백있으면 빨간 바 보여주고 리턴
	   	$("span#err_msg").html(`필수 동의 사항을 확인해주세요`);
	   return false;
     }
     // *** 필수 동의 사항에 모두 체크 되었는지 검사하기 끝 *** //
     
     
     // *** 아이디 중복 검사 *** //    
     if(b_requiredInfo) {
	
		   const frm = document.registerFrm;
	       frm.action = "userRegister.tam";
		   frm.method = "post";
		   frm.submit();
     }
	
} // end of function goRegister() {}-----------------


// 연락처 "인증하기" 버튼 눌렀을 때 호출되는 함수
function sendMsgTel() {
	const mobile = $("input#mobile").val();
	let regPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
	if(regPhone.test(mobile)) {
		
		const result = confirm(mobile+" 전화번호로 인증번호를 발송하시겠습니까?\n 확인을 누르시면 인증번호가 발송됩니다.");
		
		if(result){
			$("div.telCheck").show();
			$("div#div_send_code").hide();
			$("input#mobile").prop("readonly",true);// 연락처 부분 회색박스로 바뀌어야함 ㅠㅠ
			
			// 인증키 발송 후 인증 완료시 b_telCheck = true;로 변환		  
		  
		    $.ajax({
			  url:"http://localhost:9090/tempSemi/smsSend.tam",
			  type:"post",
			  data:{"mobile":$('input#mobile').val()},
			  dataType:"json",
			  success:function(json){
				  // json 은 {"group_id":"R2GWPBT7UoW308sI","success_count":1,"error_count":0} 처럼 된다.
				  
				  if(json.success_count == 1) {
					  alert("문자전송이 완료되었습니다.\n인증번호를 입력해주세요.")
					  $("input#mobile").prop("readyonly",true);
					  b_telCheck = true;
				  }
				  else if (json.error_count != 0) {
					  alert("문자전송이 실패되었습니다.\n잠시후 재시도해주세요.")
				  }
				  
			  },
			  error:function(request, status, error){
	                 alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	          }
			   
		  });
		  
		}
				
	}
	else {
		showBanner();
		$("span#err_msg").html(`올바르지 않은 연락처 입니다.`)
	}
}// end of function sendMsgTel()--------------

// "재전송" 버튼 눌렀을 때 호출되는 함수
function resendMsgTel() {
	
	const mobile = $("input#mobile").val();
	const result = confirm("연락처를 수정하시겠습니까?\n 아니오를 누르시면 "+mobile+" 번호로 인증번호가 재발송됩니다.");
		
		if(result){
			$("input#mobile").prop("readyonly",false);
			const mobile = $("input#mobile").val();
			let regPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
			if(regPhone.test(mobile)) {
				$("div.telCheck").hide();
				$("div#div_send_code").show();
			}
			else {
				alert("올바르지 않은 연락처 입니다.")
			}
		}
		else {
			alert("기존번호로 문자 전송을 완료했습니다.\n인증번호를 입력하여주세요.")
			 /*
		    $.ajax({
			  url:"smsSend.tam",
			  type:"post",
			  data:{"mobile":$('input#mobile').val()},
			  dataType:"json",
			  success:function(json){
				  // json 은 {"group_id":"R2GWPBT7UoW308sI","success_count":1,"error_count":0} 처럼 된다.
				  
				  if(json.success_count == 1) {
					  alert("문자전송이 완료되었습니다.\n인증번호를 입력해주세요.")
					  $("input#mobile").prop("readyonly",true);
				  }
				  else if (json.error_count != 0) {
					  alert("문자전송이 실패되었습니다.\n잠시후 재시도해주세요.")
				  }
				  
			  },
			  error:function(request, status, error){
	                 alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	          }
			   
		  });
		  */
			
		}
}

function searchAddress () {
	
	b_searchAdd_click = true;
		// "우편번호찾기"를 클릭했는지 안했는지 여부를 알아오기 위한 용도.
		
        // 주소를 쓰기 가능으로 만들기
        $("input#address").removeAttr("readonly");
        
		
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
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("extraaddress").value = extraAddr;
            
            } else {
                document.getElementById("extraaddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById("address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("detailaddress").focus();
        }
	}).open();		
		
		
		// 주소를 읽기전용(readonly) 로 만들기
        $("input#address").attr("readonly", true);
        
        
	
}





// 최상단(nav상단)에 빨간 오류메시지 띄워주기위한 함수 //

function showBanner() {
	
	$("div.err_banner").addClass('show');
	$("div.err_banner").removeClass('hide');	
  		
  		setTimeout(() => {
			 
    		$("div.err_banner").removeClass('show');
    		$("div.err_banner").addClass('hide');
    		
  		}, 1500)
 
 	
/* 	
	$("div.err_banner").show();
    showBanner();
    이렇게 호출하여 사용하면 됨
*/
}// end of function showBanner()--------


// *** 날짜 정규식 함수 *** //
function checkValidDate(value) {
	var result = true;
	try {
	    var date = value.split(".");
	    var y = parseInt(date[0], 10),
	        m = parseInt(date[1], 10),
	        d = parseInt(date[2], 10);
	    
	    var dateRegex = /^(?=\d)(?:(?:31(?!.(?:0?[2469]|11))|(?:30|29)(?!.0?2)|29(?=.0?2.(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00)))(?:\x20|$))|(?:2[0-8]|1\d|0?[1-9]))([-.\/])(?:1[012]|0?[1-9])\1(?:1[6-9]|[2-9]\d)?\d\d(?:(?=\x20\d)\x20|$))?(((0?[1-9]|1[012])(:[0-5]\d){0,2}(\x20[AP]M))|([01]\d|2[0-3])(:[0-5]\d){1,2})?$/;
	    result = dateRegex.test(d+'-'+m+'-'+y);
	} catch (err) {
		result = false;
	}    
    return result;
}// end of function checkValidDate(value) {}---------------------


function goSendEmail() {
	
	let b_idCheck = false;
    let b_emailCheck = false;
	
	// 아이디 유효성 검사
	var regExp_id = /^[a-z]+[a-z0-9]{4,19}$/g;; // 소문자 영문자로 시작하는 영문자 또는 숫자 6~20 자
	
	if ( regExp_id.test($("input#userid_f").val()) ) {
		b_idCheck = true; // 정규식 통과
	}
	
	// 이메일 유효성 검사
	 var regExp_email = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	 
	 const userid = $("input#userid_f").val() +"@" + $("input#userid_email").val();
	 
	 if ( regExp_email.test(userid) ) {
		b_emailCheck = true; // 정규식 통과
	 }
	
	  if(b_idCheck == false) {
		$("input#userid_f").parent().css("border","1px solid #d12b2b");
		showBanner(); // 공백있으면 빨간 바 보여주고 리턴
	   	$("span#err_msg").html(`아이디는 소문자 영문자로 시작하는 영문자 또는 숫자 6~20 자여야 합니다.`);
	 }
	 else {
		 $("input#userid_f").parent().css("border","");
	 }
   	 if(b_emailCheck == false) {
		$("input#userid_f").parent().css("border","1px solid #d12b2b");
		$("input#userid_email").parent().css("border","1px solid #d12b2b");
		showBanner(); // 공백있으면 빨간 바 보여주고 리턴
	   	$("span#err_msg").html(`이메일 형식에 맞지 않습니다`);
	 }
	 else {
		$("input#userid_f").parent().css("border","");
		$("input#userid_email").parent().css("border","");
	 }	 
	if (b_idCheck && b_emailCheck) {
		const result = confirm(userid+' 로 인증 하시겠습니까?\n"확인"을 누를 시, 해당 메일로 인증번호가 발송됩니다.');
	    if(result) {
			sendEmail();
		}// end of if(result) {}----------------------
	}
	
	
}// end of function sendEmail() {}----------------

function sendEmail() {
	
	$.ajax({
		
    	url:"idDuplicateCheck.tam", // <- 상대경로. 혹은 절대경로 http://localhost:9090/MyMVC/member/emailDuplicateCheck.up 로도 가능
   		data:{"userid":$("input#userid_f").val() +"@" + $("input#userid_email").val()}, // data 속성은 http://localhost:9090/MyMVC/member/emailDuplicateCheck.up 로 전송해야할 데이터를 말한다.
   		type:"post", // method 아님!. type 을 생략하면 type:"get" 이다.
   
   		async:true, // async:true => 비동기 방식. async 을 생략하면 기본값이 비동기 방식인 async:true 이다.
                    // async:false => 동기 방식. 지도를 할때는 반드시 동기방식인 async:false 을 사용해야만 지도가 올바르게 나온다.
        
        dataType:"json",
        // !!!! ★★★★★ 대문자 T 인거 잊지말자 ★★★★★ !!!!      
   
   		success:function(json){
		   
		   
			   if(json.isExists) { // .표기법을 씀. 참고로 []표기법 => 변수에 띄어쓰기가 있을 경우, 변수가 상수일경우에 쓰임.
				   // 입력한 email 이 이미 사용중일 경우
				   showBanner();
				   $("span#err_msg").html(`이미 사용중인 아이디 입니다!`);
				   return false;
				   
			   }
			   else {
				   // 입력한 userid 가 존재하지 않는 경우 email 발송		   
				   alert("인증번호가 발송되었습니다.")
				   $("div#sendEmail_btn_wrap").hide();
				   $("div.email_check").show();
				   $("input#userid_f").prop("readonly",true);
				   $("input#userid_email").prop("readonly",true);
				   $("select#email-select").prop("disabled",true);
			   }
			   
	    },
	    error: function(request, status, error){
           alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        }		   
	   
   }); 
}

