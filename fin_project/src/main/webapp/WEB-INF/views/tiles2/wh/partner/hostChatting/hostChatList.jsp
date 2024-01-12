<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String ctxPath = request.getContextPath();
	//     /expedia
%>

<style type="text/css">

	
	a {text-decoration: none !important;} /* 페이지바의 a 태그에 밑줄 없애기 */
	
	div.list {
	
			border:solid 0px red; 
			border-radius:15px;
			padding:10px; 
			display: flex;
			margin-botton:2%;
	}
	div.list:hover {
	  background-color: #F0F8FF;
	}

	span.name {
		font-weight : 700;
		display: block;
	}
	
	span.lg_en_name {
		
	}

	
	
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		
				
				
	});// end of $(document).ready(function(){}----------------------------------------

//Function Declaration		
function goViewHostChat(fk_userid) {
		 // alert(`숙소 ID \${fk_lodge_id}번을 봅니다.`);
	<%--
		location.href=`<%= ctxPath%>/view.action?seq=\${seq}`;
	--%>
	
	const name = $("span.name").val();
	
	
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
    
	
    const frm = document.goViewHostChatFrm;
    frm.fk_userid.value = fk_userid;
    frm.goBackURL.value = goBackURL;
    frm.name.value = name;
    
    
    frm.action = "<%=ctxPath%>/hostChat.exp";
    frm.submit();
    
    
}// end of function goViewChat(fk_lodge_id) --------------------------------
	

			
			

</script>


<body style="background-color:white;">
<div style="inline-size: 100%; margin: auto; max-inline-size: 75rem; padding: 50px 0;">
	<div style="width:40%; margin:auto; border:solid 0px gray;">

    <h2 style="margin-bottom: 30px; padding-bottom:30px; border-bottom: solid 1px #dfe0e4;">1:1 문의내역</h2>
   
	  
	  <c:if test="${not empty requestScope.chatHostRoomList}">
	  <div style="height:400px; overflow: auto;">
		  <c:forEach var="chatvo" items="${requestScope.chatHostRoomList}">
			
			   <div class="list" onclick="goViewHostChat('${chatvo.fk_userid}')">
				   <div style="margin-left:0;">
					   
					   <span class="name">${chatvo.name}</span>
					   <span class="fk_userid">${chatvo.fk_userid}</span>
				   </div>
				   <svg class="uitk-icon navigate_next uitk-icon-directional uitk-icon-medium" style="margin-left:auto; margin-top:3%;" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" focusable="false"><path d="M10 6 8.59 7.41 13.17 12l-4.58 4.59L10 18l6-6-6-6z"></path></svg>
			   </div>
			
		  </c:forEach>
	  </div>
	  </c:if>
	  
	  
	  
	  
	  
	  
	  <c:if test="${empty requestScope.chatHostRoomList}">
	     <div>
	     	문의내역이 없습니다.
	     </div>
	  </c:if>
   
   <%-- === #122. 페이지바 만들기 === --%>
   <div align="center" style="border: solid 0px gray; width:80%; margin: 30px auto;">
    	${requestScope.pageBar}
   </div>
   
   
	</div>
</div>

<%-- 
	=== #124. 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
	                      돌아갈 페이지를 알려주기 위해 현재 페이지 주소를 뷰단으로 넘겨준다.  
--%>
	<form name="goViewHostChatFrm">
		<input type="hidden" name="fk_userid"/>
		<input type="hidden" name="goBackURL" />
		<input type="hidden" name="name" />
	</form>
</body>
