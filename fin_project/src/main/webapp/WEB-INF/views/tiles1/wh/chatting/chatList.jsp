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
		
		
				
				
	});// end of $(document).ready(function(){}----------------------------------------

//Function Declaration		
function goView(chat_no) {
		 alert(`글번호 \${chat_no}번을 봅니다.`);
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
    frm.chat_no.value = chat_no;
    frm.goBackURL.value = goBackURL;
    
    frm.method = "post";
    
    frm.action = "<%=ctxPath%>/view.exp";
    <%--
    frm.action = "<%=ctxPath%>/view_2.action";
    --%>
    frm.submit();
    
    
}// end of function goView(seq) --------------------------------
	

			
			

</script>


<div style="display: flex;">
<div style="margin: auto; padding-left: 3%;">

   <h2 style="margin-bottom: 30px;">문의목록</h2>
   
   <table style="width: 1024px" class="table table-bordered">
      <thead>
       <tr>
          <th style="width: 70px;  text-align: center;">문의번호</th>
          <th style="width: 70px;  text-align: center;">숙소ID</th>
          <th style="width: 150px; text-align: center;">문의날짜</th>
       </tr>
      </thead>

	  <tbody>
	  <c:if test="${not empty requestScope.chatRoomList}">
	  <c:forEach var="chatvo" items="${requestScope.chatRoomList}">
		<tr>
		   <td align="center">${chatvo.chat_no}</td>
		   <td align="center">${chatvo.fk_lodge_id}</td>
		   <td align="center">${chatvo.chat_date}</td>
		</tr>
	  </c:forEach>
	  </c:if>
	  
	  <c:if test="${empty requestScope.chatRoomList}">
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
   
   
</div>
</div>

<%-- 
	=== #124. 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
	                      돌아갈 페이지를 알려주기 위해 현재 페이지 주소를 뷰단으로 넘겨준다.  
--%>
<form name="goViewFrm">
	<input type="hidden" name="fk_lodge_id" value=""/>
	<input type="hidden" name="goBackURL" />
</form>

