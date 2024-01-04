<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>

<%
	String ctxPath = request.getContextPath();
	//     /board
%>

<style type="text/css">

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		
		
		
		// 글쓰기 버튼
		$("button#btnWrite").click(function(){
			
			const chat = $("textarea:text[name='chat']").val();
			if(chat == "") {
				alert("문의내용을 작성하세요!!");
				return;
			}
			
			// 폼(form)을 전송(submit)
			const frm = document.addFrm;
			frm.method = "post";
			frm.action = "<%= ctxPath%>/addEnd.exp";
			frm.submit();
			
		});
		
	}); // end of $(document).ready(function(){});
	
	// Function Declaration
	
	
	
</script>

<div style="display: flex;">
	<div style="margin: auto; padding-left: 3%;">
		
  		<%-- 문의 글 작성하는 form --%>
		<form name="addFrm">	
			<div style="margin: 20px;">
				<input style="width:100%; height: 612px;" name="chat" id="chat">
				<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnWrite">전송</button>
			</div>
		</form>
		
	</div>
</div>



