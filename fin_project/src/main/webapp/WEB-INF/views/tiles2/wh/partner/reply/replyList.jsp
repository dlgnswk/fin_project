<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String ctxPath = request.getContextPath();
	//     /expedia
%>

<style type="text/css">

	th {background-color: #ddd}
	
	.subjectStyle {font-weight: bold;
				   color: navy;
				   cursor: pointer; }
	a {text-decoration: none !important;} /* 페이지바의 a 태그에 밑줄 없애기 */
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		
		
		$("input:text[name='searchWord']").bind("keydown",function(e){
			if(e.keyCode == 13) {
				goSearch();
			}
		});
		
		
		// 검색 시 검색조건 및 검색어값 유지시키기
	     if(${not empty requestScope.paraMap}) {
	        $("select[name='searchType']").val("${requestScope.paraMap.searchType}");
	        $("input[name='searchWord']").val("${requestScope.paraMap.searchWord}");
	     };
		
		<%-- === #107. 검색어 입력 시 자동글 완성하기 2 === --%>
		$("div#displayList").hide();
		
		$("input[name='searchWord']").keyup(function(){
			
			const wordLength = $(this).val().trim().length;
			// 검색어에서 공백을 제거한 길이를 알아온다.
			
			if(wordLength == 0) {
				$("div#displayList").hide();
				// 검색어가 공백이거나 검색어 입력 후 백스페이스 키를 눌러서 검색어를 모두 지우면 검색된 내용이 안나오도록 해야 한다.
			}
			else {
				
				
				if($("select[name='searchType']").val() == "name" ) {
					
					$.ajax({
						url:"<%= ctxPath%>/wordSearchShow.exp",
						type:"get",
						data:{"searchType":$("select[name='searchType']").val(),
							  "searchWord":$("input[name='searchWord']").val()},
						dataType:"json",
						success:function(json){
							// console.log(JSON.stringify(json));
							/*
								[{"word":"안녕하세요 java를 처음배웁니다."}
								,{"word":"JAVA가 쉽나요 궁금해요?"}
								,{"word":"웹페이지에 필요한 jaVaScript는 쉽나요?"}
								,{"word":"CSS 와 javascript는 배워야 하나요?"}
								,{"word":"Korea VS Japan 라이벌 경기 "}]
							
								또는
								[]
							*/
							
							<%-- === #112. 검색어 입력 시 자동글 완성하기 7 === --%>
							if(json.length > 0) {
								// 검색된 데이터가 있는 경우임.
								
								let v_html = ``;
								
								$.each(json, function(index,item){
									const word = item.word;
									// word ==> 안녕하세요 java를 처음 배웁니다.
									// word ==> JAVA가 쉽나요 궁금해요?
									// word ==> 웹페이지에 필요한 jaVaScript는 쉽나요?
											
								//	word.toLowerCase() 은 word 를 모두 소문자로 변경하는 것이다.
									// word ==> 안녕하세요 java를 처음 배웁니다.
									// word ==> java가 쉽나요 궁금해요?
									// word ==> 웹페이지에 필요한 javascript는 쉽나요?
									
									const idx = word.toLowerCase().indexOf($("input[name='searchWord']").val().toLowerCase());
									// 만약에 검색어가 JavA 이라면
									/*
										안녕하세요 java를 처음 배웁니다. 은 idx가 6 이다.
										java가 쉽나요 궁금해요? 은 idx가 0 이다.		
										웹페이지에 필요한 javascript는 쉽나요? 은 idx가 10 이다.	
									*/
									
									const len = $("input[name='searchWord']").val().length;
									// 검색어(JavA)의 길이 len 은 4 가된다.
									
								/*
									console.log("~~~~~~ 시작 ~~~~~~");
									console.log(word.substring(0,idx)); // 검색어(JavA) 앞까지의 글자 => "안녕하세요 "
									console.log(word.substring(idx, idx+len)); // 검색어(JavA) 글자 => "java"
									console.log(word.substring(idx+len)); // 검색어(JavA) 뒤부터 끝까지의 글자 => "를 처음 배웁니다.""
									console.log("~~~~~~ 끝 ~~~~~~");
								*/
								
									const result = word.substring(0,idx) + "<span style='color:purple;'>"+ word.substring(idx, idx+len) +"</span>"+ word.substring(idx+len);
									
									v_html += `<span style='cursor:pointer;' class='result'  >\${result}</span><br>`;
										
								});// end of $.each(json, function(index,item){}-------------------------------------
								
								const input_width = $("input[name='searchWord']").css("width"); // 검색어 input 태그 width 값 알아오기		
										
								// 검색결과 div#displayList 의 width 크기를 검색어 입력  input 태그의 width 와 일치시키기
								$("div#displayList").css({"width":input_width});
								
								$("div#displayList").html(v_html);		
								$("div#displayList").show();
							
							}
						},
						error: function(request, status, error){
			                  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			            }
					});
					
				}
			}
		});// end of $("input[name='searchWord']").keyup(function(){}----------------------------------------
		
				
		<%-- === #113. 검색어 입력 시 자동글 완성하기 8 === --%>		
		$(document).on("click", "span.result", function(){
			const word = $(this).text();
			// e.target 과 $(this) 의 차이점 확인
			$("input[name='searchWord']").val(word)// 텍스트박스에 검색된 결과의 문자열을 입력해준다.
			
			$("div#displayList").hide();
			goSearch();
			
		});
		
		
		
		
		
				
				
	});// end of $(document).ready(function(){}----------------------------------------

//Function Declaration		
function goView(chat_no) {
		// alert(`글번호 \${seq}번을 봅니다.`);
	<%--
		location.href=`<%= ctxPath%>/view.action?seq=\${seq}`;
	--%>
	
	const goBackURL = "${requestScope.goBackURL}";
	// 	  goBackURL = "/list.action?searchType=name&searchWord=최우현&currentShowPageNo=9"
	<%--	
		아래처럼 get 방식으로 보내면 안된다. 왜냐하면 get방식에서 &가 전송될 데이터의 구분자로 사용되기 때문이다. 
		location.href=`<%= ctxPath%>/view.action?seq=\${seq}`;
		location.href=`<%= ctxPath%>/view.action?seq=\${seq}&goBackURL=\${goBackURL}`;
		location.href=`<%= ctxPath%>/view.action?seq=\${seq}&goBackURL=/list.action?searchType=name&searchWord=최우현&currentShowPageNo=9`;
    --%>
	
    <%-- &를 글자 그대로 인식하는 post 방식으로 보내야 한다. 
    	  그러므로 아래의 #124. 에 표기된 form 태그를 먼저 만든다. --%>
    
	
    const frm = document.goViewFrm;
    frm.seq.value = seq;
    frm.goBackURL.value = goBackURL;
    
    if( ${not empty requestScope.paraMap}) { // 검색조건이 있을 경우
    	frm.searchType.value = "${requestScope.paraMap.searchType}";
    	frm.searchWord.value = "${requestScope.paraMap.searchWord}";
	}
    
    frm.method = "post";
    
    frm.action = "<%=ctxPath%>/view.exp";
    <%--
    frm.action = "<%=ctxPath%>/view_2.action";
    --%>
    frm.submit();
    
    
}// end of function goView(seq) --------------------------------
	
function goSearch() {
	const frm = document.searchFrm;
	frm.method = "get";
	frm.action = "<%= ctxPath%>/list.exp";
	frm.submit();
}// end of function goSearch() {}-------------------------------
			
			

</script>


<div style="display: flex;">
<div style="margin: auto; padding-left: 3%;">

   <h2 style="margin-bottom: 30px;">문의목록</h2>
   
   <table style="width: 1024px" class="table table-bordered">
      <thead>
       <tr>
          <th style="width: 70px;  text-align: center;">문의번호</th>
          <th style="width: 70px;  text-align: center;">예약자명</th>
          <th style="width: 150px; text-align: center;">날짜</th>
       </tr>
      </thead>

	  <tbody>
	  <c:if test="${not empty requestScope.chatvo}">
	  <c:forEach var="chatvo" items="${requestScope.chatvo}">
		<tr>
		   <td align="center">${item.chat_no}</td>
		   <td align="center">${item.fk_userid}</td>
		   <td align="center">${chatvo.chat_date}</td>
		</tr>
	  </c:forEach>
	  </c:if>
	  
	  <c:if test="${empty requestScope.chatvo}">
	     <tr>
	  	   <td colspan="5">문의가 없습니다.</td>
	     </tr>
	  </c:if>
	  </tbody>
   </table>
   
   <%-- === #122. 페이지바 만들기 === --%>
   <div align="center" style="border: solid 0px gray; width:80%; margin: 30px auto;">
    	${requestScope.pageBar}
   </div>
   
   
   <%-- === #101. 글검색 폼 추가하기 : 글제목, 글쓴이로 검색을 하도록 한다. === --%>
    <form name="searchFrm" style="margin-top: 20px;">
      <select name="searchType" style="height: 26px;">
         <option value="name">예약자명</option>
      </select>
      <input type="text" name="searchWord" size="40" autocomplete="off" /> 
      <input type="text" style="display: none;"/> <%-- form 태그내에 input 태그가 오로지 1개 뿐일경우에는 엔터를 했을 경우 검색이 되어지므로 이것을 방지하고자 만든것이다. --%> 
      <button type="button" class="btn btn-secondary btn-sm" onclick="goSearch()">검색</button>
   </form>
   
   <%-- === #106. 검색어 입력 시 자동글 완성하기 1 === --%>
   <div id="displayList" style="border:solid 1px gray; border-top:0px; height:100px; margin-left:11.5%; margin-top:-1px; margin-bottom:30px; overflow:auto;">
   </div>
</div>
</div>

<%-- 
	=== #124. 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
	                    사용자가 "검색된결과목록보기" 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해
	                    현재 페이지 주소를 뷰단으로 넘겨준다.  
--%>
<form name="goViewFrm">
	<input type="hidden" name="chat_no" />
	<input type="hidden" name="goBackURL" />
	<input type="hidden" name="searchType" />
	<input type="hidden" name="searchWord" />
</form>

