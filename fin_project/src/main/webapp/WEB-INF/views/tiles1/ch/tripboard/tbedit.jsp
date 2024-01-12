<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<%
	String ctxPath = request.getContextPath();
    //      /board
%>  

<style type="text/css">

  td {
    height: 3.75rem; /* 60px → 3.75rem 변환 */
    padding: 0 1.25rem; /* 20px → 1.25rem 변환 */
    line-height: 1.5625rem; /* 25px → 1.5625rem 변환 */
    border-bottom: 0.0625rem solid #ddd; /* 1px → 0.0625rem 변환 */
    letter-spacing: -0.02em;
  }


.table {
    width: 100%;
    margin-bottom: 1rem;
    color: #212529;
    border-collapse: collapse;
    border-top: solid 1px black;
}
#select_box > div > div > form > table > tbody > tr:nth-child(1) {
	border-top: 2px solid black;
	border-bottom: 1px
}

th {
	height: 3.75rem; /* 60px → 3.75rem 변환 */
    padding: 0 1.25rem; /* 20px → 1.25rem 변환 */
    border-bottom: 0.0625rem solid #ddd; /* 1px → 0.0625rem 변환 */
    background: #f7f7f7;
    color: #222;
    font-weight: bold;
	color:rgba(0, 0, 0, 0.57);
	font-size: 14px;
}

.table tr {
    padding: 0.75rem;
    border-bottom: 0.0625rem solid #ddd
}

#select_box > div > div > form > table > tbody > tr:nth-child(1) > td > input[type=text],
#select_box > div > div > form > table > tbody > tr:nth-child(2) > td > input[type=text] {
  height: 2rem; /* 32px → 2rem 변환 */
  font-size: 0.9375rem; /* 15px → 0.9375rem 변환 */
  border: 0;
  border-radius: 0.9375rem; /* 15px → 0.9375rem 변환 */
  outline: none;
  padding-left: 0.625rem; /* 10px → 0.625rem 변환 */
  background-color: rgb(233, 233, 233);
}

#select_box > div > div > form > table > tbody > tr:nth-child(4) > td > input[type=password] {
  height: 2rem; /* 32px → 2rem 변환 */
  font-size: 0.9375rem; /* 15px → 0.9375rem 변환 */
  border: 0;
  border-radius: 0.9375rem; /* 15px → 0.9375rem 변환 */
  outline: none;
  padding-left: 0.625rem; /* 10px → 0.625rem 변환 */
  background-color: rgb(233, 233, 233);
}
	
input[type=file]::file-selector-button {
  width: 5.625rem; /* 90px → 5.625rem 변환 */
  height: 1.875rem; /* 30px → 1.875rem 변환 */
  background: #0073ff;
  color: white;
  border: 0px solid rgb(77, 77, 77);
  border-radius: 1.25rem; /* 20px → 1.25rem 변환 */
  cursor: pointer;
}

input[type=file]::file-selector-button:hover {
   background-color: rgba(0, 80, 190, 0.97);
    box-shadow: 0 0.25rem 0.375rem -0.0625rem rgba(0, 0, 0, 0.1), 0 0.125rem 0.25rem -0.0625rem rgba(0, 0, 0, 0.08);
  }

#btnUpdate {
  width: 4.375rem; /* 70px → 4.375rem 변환 */
  height: 2.1875rem; /* 35px → 2.1875rem 변환 */
  background: #0073ff;
  color: white;
  border: 0px solid rgb(77, 77, 77);
  border-radius: 1.25rem; /* 20px → 1.25rem 변환 */
  cursor: pointer;
}
#btnUpdate:hover {
  background-color: rgba(0, 80, 229, 0.91);
  box-shadow: 0 0.25rem 0.375rem -0.0625rem rgba(0, 0, 0, 0.1), 0 0.125rem 0.25rem -0.0625rem rgba(0, 0, 0, 0.08);	
}

#btnCancel {
  width: 3.125rem; /* 50px → 3.125rem 변환 */
  height: 2.1875rem; /* 35px → 2.1875rem 변환 */
  background-color: #8e979c;
  border: 0px solid #555555;
  border-radius: 1.25rem; /* 20px → 1.25rem 변환 */
  color: white;
  margin: 0 0 0.04375rem 0.3125rem; /* 0 0 0.7% 0.3125rem → 0 0 0.04375rem 0.3125rem 변환 */
  font-size: 0.875rem;
}

#btnCancel:hover {
  background-color: rgba(0, 0, 0, 0.49);
  box-shadow: 0 0.25rem 0.375rem -0.0625rem rgba(0, 0, 0, 0.1),
}		
</style>



<script type="text/javascript">

	$(document).ready(function(){
		
		<%-- === #166. 스마트 에디터 구현 시작 === --%>
		  
			//전역변수
	       var obj = [];
	       
	       //스마트에디터 프레임생성
	       nhn.husky.EZCreator.createInIFrame({
	           oAppRef: obj,
	           elPlaceHolder: "content",
	           sSkinURI: "<%= ctxPath%>/resources/smarteditor/SmartEditor2Skin.html",
	           htParams : {
	               // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
	               bUseToolbar : true,            
	               // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
	               bUseVerticalResizer : true,    
	               // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
	               bUseModeChanger : true,
	           }
	       });
	       
	      <%-- === 스마트 에디터 구현 끝 === --%>
		  
	   // 글쓰기 버튼
		$("button#btnUpdate").click(function(){
			
			<%-- === 스마트 에디터 구현 시작 === --%>
	         // id가 content인 textarea에 에디터에서 대입
	           obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
	        <%-- === 스마트 에디터 구현 끝 === --%>
			
	        
	     	// 지역 유효성 검사
			const tb_city = $("input:text[name='tb_city']").val(); 			 
			if(tb_city == "") {
				alert("지역을 입력하세요!!");
				return; // 종료
			}
			
			
			// 글제목 유효성 검사 
			const tb_subject = $("input:text[name='tb_subject']").val().trim(); 
			
			if(tb_subject == "") {
				alert("글 제목을 입력하세요!!");
				return; // 종료
			}
	        
			// 글내용 유효성 검사 (스마트에디터 사용할 경우)
			<%-- === 글내용 유효성 검사(스마트 에디터 사용 할 경우) 시작 === --%>
            let contentval = $("textarea#content").val();
			
         	// 글내용 유효성 검사 하기 
            // alert(contentval); // content에  공백만 여러개를 입력하여 쓰기할 경우 알아보는것.
            // <p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</p> 이라고 나온다.
          
            contentval = contentval.replace(/&nbsp;/gi, ""); // 공백을 "" 으로 변환
            /*    
	                           대상문자열.replace(/찾을 문자열/gi, "변경할 문자열");
	             ==> 여기서 꼭 알아야 될 점은 나누기(/)표시안에 넣는 찾을 문자열의 따옴표는 없어야 한다는 점입니다. 
	                           그리고 뒤의 gi는 다음을 의미합니다.
	         
	              g : 전체 모든 문자열을 변경 global
	              i : 영문 대소문자를 무시, 모두 일치하는 패턴 검색 ignore
          	*/ 
         	// alert(contentval);
         	// <p>             </p>
          
            contentval = contentval.substring(contentval.indexOf("<p>")+3);
            contentval = contentval.substring(0, contentval.indexOf("</p>"));
                   
            if(contentval.trim().length == 0) {
                alert("글내용을 입력하세요!!");
               return;
            }
            
            <%-- === 글내용 유효성 검사(스마트 에디터 사용 할 경우) 끝 === --%>
            
            
			// 글 암호 유효성 검사
			const tb_pw = $("input:password[name='tb_pw']").val(); 			 
			if(tb_pw == "") {
				alert("글 암호을 입력하세요!!");
				return; // 종료
			}
			
			// 폼 (form)을 적용하자
			const frm = document.editFrm;
			frm.method = "post";
			frm.action = "<%= ctxPath%>/tbeditEnd.exp";
			frm.submit();
			
		});
	    
	    
	});// end of $(document).ready(function(){});

</script>

<div style="inline-size: 100%; margin: auto; max-inline-size: 85rem; padding: 50px 0;">

	<div id="select_box">

		<div style="display:flex;">

	<div style="margin: auto; padding-left:3%;">
		

			<h2 style="margin-bottom: 1.875rem;">여행후기 수정</h2>


	 <form name="editFrm">
	 		<input type="hidden" name="tb_seq" value="${requestScope.tripboardvo.tb_seq}" readonly />
	 		<input type="hidden" name="fk_userid" value="${sessionScope.loginuser.userid}" readonly /> <%-- readonly는 읽기 전용 => input 태그 안에 있는 내용 못바꾸게 설정 --%>         			   
            <input type="hidden" name="tb_name" value="${requestScope.tripboardvo.tb_name}" readonly />       			  		
			<table style="width: 1024px">
				
				<tr style="border-bottom: 0.0625rem solid #ddd;">
         			<th style="width: 15%; background-color: #f1f1f1;"><span style="color:red;">* </span>제목</th>
         			<td>
							<input type="text" name="tb_subject" size="100" maxlength="200" value="${requestScope.tripboardvo.tb_subject}" placeholder="제목을 입력해주세요" autocomplete="off"/> 
         			</td>
				</tr>
				
				<tr style="border-bottom: 0.0625rem solid #ddd;">
         			<th style="width: 15%; background-color: #f1f1f1;"><span style="color:red;">* </span>지역</th>
         			<td>
         			   <input type="text" name="tb_city" size="33" value="${requestScope.tripboardvo.tb_city}" placeholder="도시 이름을 입력하세요. ex) 서울, 부산" autocomplete="off" />  			
         			</td>
				</tr>
				
				
				<%-- !!!  textarea 태그에서 required="required" 속성을 사용하면 
                       	 스마트 에디터는 오류가 발생하므로 사용하지 않는다. !!! --%>
				<tr style="border-bottom: 0.0625rem solid #ddd;">
         			<th style="width: 15%; background-color: #f1f1f1;"><span style="color:red;">* </span>내용</th>
         			<td>
         				<textarea style="width:100%; height:300px;" name="tb_content" id="content">${requestScope.tripboardvo.tb_content}</textarea>
         			</td>
				</tr>
					
				
				<tr style="border-bottom: 0.0625rem solid #ddd;">
         			<th style="width: 15%; background-color: #f1f1f1;"><span style="color:red;">* </span>글암호</th>
         			<td>
         				<input type="password" name="tb_pw" maxlength="20" value="${requestScope.tripboardvo.tb_pw}" /> 
         			</td>
				</tr>				
			</table>
			
			
			<div style="margin: 20px; float: right;">
				<button type="button" id="btnUpdate">글쓰기</button>
				<button type="button" id="btnCancel" onclick="javascript:location.href='<%= ctxPath%>/tblist.exp'">취소</button>
			</div>		
		</form>
	</div>
</div>

		
	</div>
	
</div>