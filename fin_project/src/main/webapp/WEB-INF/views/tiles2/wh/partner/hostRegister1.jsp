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
	input:focus {
	outline:none;
	border: solid 3px blue;
}
</style>

<script>
$(document).ready(function(){
	$("span.error").hide();
	

	
	<%--
	$('input.required').each(function(index, elmt) {
		
		const val = $(elmt).val().trim();
		
		if(val == "") {
			
			$(elmt).css({"border": "2px solid red"});
			$(elmt).parent().parent().parent().find("span.error").show();
			
		}
		
		else {
			
			$(elmt).css({"border": "1px solid #d9e2e7"});
			$(elmt).parent().parent().parent().find("span.error").hide();
			
		}
		
		
	}); 
	
	$('input.required').on("input", function(){
		
		
	});
	--%>
	
	
	
	
	

$("input#lodgename").blur((e)=>{ 
	
	const lodgename = $(e.target).val().trim();
	if(lodgename == "") {
		// 입력하지 않거나 공백만 입력한 경우

		$("input#lodgename").prop("disabled", true);
		$(e.target).prop("disabled", false);
		$(e.target).css({"border": "2px solid red"});
		

		$(e.target).parent().parent().parent().find("span.error").show();
	
		$(e.target).val("").focus();
	}
	else {
		$("input#lodgename").prop("disabled", false);
		$(e.target).css({"border": "1px solid #d9e2e7"});
		$(e.target).parent().parent().parent().find("span.error").hide();
	}
	
}); // 아이디가 lodgename 인 것을 포커스를 잃어버렸을 경우(blur) 이벤트 처리해주는 것이다.
	

$("input#postcode").blur((e)=>{ 
	
	const postcode = $(e.target).val().trim();
	if(postcode == "") {
		// 입력하지 않거나 공백만 입력한 경우

		$("input#postcode").prop("disabled", true);
		$(e.target).prop("disabled", false);
		$(e.target).css({"border": "2px solid red"});
		

		$(e.target).parent().parent().parent().find("span.error").show();
	
		$(e.target).val("").focus();
	}
	else {
		$("input#postcode").prop("disabled", false);
		$(e.target).css({"border": "1px solid #d9e2e7"});
		$(e.target).parent().parent().parent().find("span.error").hide();
	}
	
}); // 아이디가 lodgename 인 것을 포커스를 잃어버렸을 경우(blur) 이벤트 처리해주는 것이다.



	$("button#next_level").on("click",function(){
		goNextlevel();

	});

});// end of $(document).ready(function(){})---------------------------------

function goNextlevel() {
	  
	
	// *** 숙박 시설 이름 값을 입력했는지 검사하기 시작 *** //
	const lodgename = $("input#lodgename").val().trim();
	
	if(lodgename == "" ){
		
		$("input#lodgename").parent().parent().parent().find("span.error").show();
		$("input#lodgename").css({"border": "2px solid red"});
		$("input#lodgename").val("").focus();
		
		return; // goRegister() 함수 종료 
	}
	
	
	
	
	// *** 우편번호 및 주소에 값을 입력했는지 검사하기 시작 *** //
	const postcode = $("input#postcode").val().trim();
	const address = $("input#address").val().trim();
	
	if(postcode == "" || address == "" ){
		$("input#postcode").parent().parent().parent().find("span.error").show();
		$("input#postcode").css({"border": "2px solid red"});
		$("input#postcode").val("").focus();
		
		$("input#address").parent().parent().parent().find("span.error").show();
		$("input#address").css({"border": "2px solid red"});
		$("input#address").val("").focus();
		
		
		
		return; // goRegister() 함수 종료 
	}
	
	else{
		
		$("input#postcode").css({"border": "1px solid #d9e2e7"});
		$("input#postcode").parent().parent().parent().find("span.error").hide();
		
		$("input#address").css({"border": "1px solid #d9e2e7"});
		$("input#address").parent().parent().parent().find("span.error").hide();
		
	}
	
	
	
	const frm = document.registerFrm;
	frm.action  = "<%=ctxPath%>/hostRegister2.exp";
	frm.method = "post";
	frm.submit();

	
	
		
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
	

	
</script>

 
<div id="container" style=" inline-size: 100%; margin: auto; max-inline-size: 75rem; padding: 50px 0;">
	
	  
	
	<form name="registerFrm" autocomplete="off">
		
		<div class="section_inner signup" style="width:40%; border: solid 0px blue; margin: 0 auto; height:800px;" >
			
			<div id="subtitle">1/2단계</div>		
			<h1 style="margin-bottom: 6%;">
               	<b style="font-size: 27px;">기본 정보 등록부터 시작해 보겠습니다! </b>
               </h1>
                 
               <h2 style="margin-bottom: 1%; font-weight: 700; font-size: 22px;">숙박 시설 이름</h2>
               
               <p style="font-size: 16px;">숙박 시설의 웹사이트에서 사용하는 이름 등의 공식 명칭을 입력해주세요. </p>
			
			
			<div class="input_name container">
                  <!-- 숙박시설이름 내용 -->
                   <div class="label_wrap">
                    <label class="input_wrap">
                       <span class="subtitle" >숙박 시설 이름</span>
                       <input id="lodgename" name="lodgename" class="required" type="text" value=""/>
                    </label>
                   </div>
                   <span class="error">공백으로 둘 수 없습니다.</span>
			</div>								
			
			
			
                  
                <h2 style="margin-top: 6%; margin-bottom: 1%; font-weight: 700; font-size: 22px;">숙박 시설 주소</h2>
                
                <p style="font-size: 16px;">주소를 입력해 주세요. </p>
				
				
				<div style="display:flex; height:48px;">
					<div class="input_address container">
		                  <!-- 숙박시설 주소 -->
	                    <div class="label_wrap address">
		                    <label class="input_wrap address" for="postcode">
		                       <span class="subtitle" >주소</span>
		                       <input type="text" id="address" name="address" class="required" maxlength="15" onclick="searchAddress()" readonly/>
		                    </label>
	                    </div>
	                    <span class="error">공백으로 둘 수 없습니다.</span>
					</div>
					
					<button type="button" class="btn_item" id="search_add" onclick="searchAddress()">검  색</button>
				</div>
				
				
				
				<div style="display:flex;">
					<div class="input_detailaddress container" >
		                  <!-- 숙박시설 상세주소 -->
	                    <div class="label_wrap detailaddress">
		                    <label class="input_wrap detailaddress">
		                       <span class="subtitle" >상세주소</span>
		                       <input type="text" id="detailaddress" name="detailAddress" size="40" maxlength="200"  />
		                       <input type="hidden" id="extraaddress" name="extraAddress" size="40" maxlength="200"  />
		                    </label>
	                    </div>
					</div>
					
					<div class="input_postcode container">
					 	<!-- 우편번호 상세주소 -->
					 	<div class="label_wrap postcode">
		                    <label class="input_wrap postcode">
		                       <span class="subtitle" >우편번호</span>
		                       <input type="text" id="postcode" name="postcode" class="required" size="6" maxlength="5" required/>
		                    </label>
	                    </div>
					<span class="error">공백으로 둘 수 없습니다.</span>
					</div>
				</div>
												
				
				<button id="next_level" type="button"  style="width:100%; background-color: #000099; color: #fff; height:48px; margin-top:5%; text-align:center;">다음</button>
				
			 
			
			
			
			</div>
			
				
	</form>	
		
	
		

</div>