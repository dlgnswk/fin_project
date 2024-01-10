<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<title>로그인</title>    
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<%
	String ctxPath = request.getContextPath();
    //      /expedia
%>  

<style>

	div#btn_id_field,
	div#btn_pwd_field {
	   display: flex; 
	   align-items: center;
	}
	
	div#btn_id_field:hover,
	div#btn_pwd_field:hover {
	   cursor: text;
	}
	
	input {
	   margin: 0; 
	   font-size: 16px; 
	   border: none; 
	   width:100%;
	}
	
	input:focus {
		outline:none;
	}

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		
		
		$("button#btnLOGIN").click(function(){
			func_Login();
		});
		
		$("input:password[name='pwd']").keydown(function(e){
			
			if(e.keyCode == 13) { // 엔터를 했을 경우
				func_Login();
			}
			
		});
		
		
		
		
	});// end of $(document).ready(function(){}--------------------------------------------
	

	// Function Declaration
	function func_Login() {

		const userid = $("input#userid").val();
		const pwd = $("input#pwd").val();

		if (userid.trim() == "") {
			alert("아이디를 입력하세요!!");
			$("input#userid").val("");
			$("input#userid").focus();
			return; // 종료 
		}

		if (pwd.trim() == "") {
			alert("비밀번호를 입력하세요!!");
			$("input#pwd").val("");
			$("input#pwd").focus();
			return; // 종료 
		}

		const frm = document.loginFrm;
		
		frm.action  = "<%= ctxPath%>/partnerIndex.exp";
		frm.method = "post";
		frm.submit();
		
	}// end of function func_Login()-------------------------------------------------------

	

	
	
	
</script>


<div style="background: linear-gradient(rgba(0, 0, 153, 0.72), rgba(0, 0, 153, 0.72)), url('https://www.expediapartnercentral.com/Account/Logon/static/images/Chicago.jpeg') no-repeat center / 100%; background-size: cover;">

<div id="container" style="inline-size: 100%; margin: auto; max-inline-size: 75rem; padding: 50px 0;">

	<div style="width:40%; margin:auto; border:solid 0px gray; text-align:center;">
		
		<div style="margin:5% auto;">
			<img src="https://www.expediapartnercentral.com/Account/Logon/static/images/eg_logo_2x.png" style="width:250px; height:60px;"/>
		</div>
		
         <form name="loginFrm" class="mt-5" style="margin:5% auto;" >
	      <div id="btn_id_field" style="background-color:white; width: 55%; margin: 0 auto;">
                  <!-- 이메일 아이콘 -->
                  <div style="width:30px; margin: 0 10px;">
                     <svg class="uitk-icon" xmlns="http://www.w3.org/2000/svg" height="24" width="24" viewBox="0 0 512 512">
                     <path d="M399 384.2C376.9 345.8 335.4 320 288 320H224c-47.4 0-88.9 25.8-111 64.2c35.2 39.2 86.2 63.8 143 63.8s107.8-24.7 143-63.8zM0 256a256 256 0 1 1 512 0A256 256 0 1 1 0 256zm256 16a72 72 0 1 0 0-144 72 72 0 1 0 0 144z"/>
                     </svg>
                  </div>
                  
                  <!-- 이메일 내용 -->
                  <div>
                     <div style="display: inline-block;">
                        <div style="font-size: 12px; margin:0; text-align:left; color:gray;">아이디</div>
                       	<input id="userid" name="userid" type="text" value="" style="" />
                     	</div>
                  </div>
           </div>
           
           <div id="btn_pwd_field" style="background-color:white; width: 55%; margin: 2% auto; ">
                  <!-- 비밀번호 아이콘 -->
                  <div style="width:30px; margin: 0 10px;">
					<svg class="uitk-icon" xmlns="http://www.w3.org/2000/svg" height="24" width="18" viewBox="0 0 448 512">
						<path d="M144 144v48H304V144c0-44.2-35.8-80-80-80s-80 35.8-80 80zM80 192V144C80 64.5 144.5 0 224 0s144 64.5 144 144v48h16c35.3 0 64 28.7 64 64V448c0 35.3-28.7 64-64 64H64c-35.3 0-64-28.7-64-64V256c0-35.3 28.7-64 64-64H80z"/>
					</svg>
                  </div>
                  
                  <!-- 비밀번호 내용 -->
                  <div>
                     <div style="display: inline-block;">
                        <div style="font-size: 12px; margin:0; text-align:left; color:gray;">비밀번호</div>
                        	<input id="pwd" name="pwd" type="password" value="" style="" />
                     </div>
                  </div>
           </div>
         </form>
         
         
      
      <div class="col-md-8 col-md-offset-2" style="margin: auto; display: flex; border: solid 0px blue;">
         <div style="margin: auto; border: solid 0px blue;">
            <button style="width: 150px; height: 40px;" class="btn btn-primary" type="button" id="btnLOGIN">로그인</button>
         	<button style="width: 150px; height: 40px;" class="btn btn-danger" type="button" id="btnRegister" onclick="location.href='<%= ctxPath%>/hostRegister1.exp'">회원가입</button>
         </div>
      </div>
   </div>
		
		
	
	
	
</div>
</div>

