<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
	String ctxPath = request.getContextPath();
	//     /expedia
%>    
    
<style type="text/css">


	a {text-decoration: none !important;}

	div#hostChatDisplay {
					 
                     max-height: 350px;
                     overflow: auto;
					
	}


</style>    
    
<script type="text/javascript">

	$(document).ready(function(){
		
		
		goViewHostChatList(); // 페이징 처리한 댓글 읽어오기
		
		
		$("#hostChat_comment").bind("keyup",function(e){
			
			if(e.keyCode == 13) {
				goAddHostChat();
				
			};
		});
		
		
	});// end of $(document).ready(function(){}-----------------------------------

// Function Declaration		
// == 채팅쓰기 ==
function goAddHostChat() {
	
	const hostChat_comment = $("input:text[name='hostChat_comment']").val().trim();
	if(hostChat_comment == "") {
		alert("채팅 내용을 입력하세요!!");
		return;
	}
	
	else {
		$.ajax({
			url:"<%= ctxPath%>/addHostChat.exp",
			data:{"hostChat_comment":$("input:text[name='hostChat_comment']").val()
				 ,"chat_no":$("input:hidden[name='chat_no']").val()},
			type:"post",
			dataType:"json",
			success:function(json){
				// console.log(JSON.stringify(json));
				// {"n":1, "name":"이순신"} {"n":0, "name":"최우현"}
			
				if(json.n == 1) {
					goViewHostChatList(); // 페이징 처리한 댓글 읽어오기			
					
				}
				
				$("input:text[name='hostChat_comment']").val("");
				
				 $("div#hostChatDisplay").scrollTop(9999999999999);
				
				
				
			},
			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		});
	}
	
}// end of function goAddWrite(){}--------------------------------------------



	


//=== #127. Ajax 로 불러온 댓글 내용들을 페이징 처리 하기 === //
function goViewHostChatList() {
	
	$.ajax({
		url:"<%= ctxPath%>/viewHostChatList.exp",
		data:{"chat_no":"${requestScope.chatvo.chat_no}"},	  
		dataType:"json",
		success:function(json){
			
			let v_html = "";
			if(json.length > 0) {
				
				$.each(json, function(index, item){
					
					if(item.r_status == 1) {
						v_html += '<div style="margin-bottom:3px; text-align:right;">';
					   	v_html += item.reply_comment;
					   	v_html += ' <span style="font-size:11px;color:#777;">' + item.reply_date + '</span>';
					   	v_html += '</div>';
					}
					
					else {
						v_html += '<div style="margin-bottom:3px; text-align:left;">';
					   	v_html += '[${requestScope.name}] ';
					   	v_html += item.reply_comment;
					   	v_html += ' <span style="font-size:11px;color:#777;">' + item.reply_date + '</span>';
					   	v_html += '</div>';
					}
				   
				});
					
				
				
			}
			
			
			$("div#hostChatDisplay").html(v_html+"<br>");
			
			
			
			
		},
		
		error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        }
	});
	
}// end of function goViewChatList(currentShowPageNo) ---------------------------------------------------



	
</script>    
    
    
<div style="display: flex;">
	<div style="margin: auto; padding-left: 3%;">
	
	   <h2 style="margin-bottom: 30px;">1:1 문의(판매자) </h2>    
	    
	   <c:if test="${not empty requestScope.chatvo}">
		   <form name="chatWriteFrm" id="chatWriteFrm" style="margin-top: 20px;">
			   <table class="table table-bordered">
					<tr>
						<td>${requestScope.chatvo.fk_userid}</td>					
					</tr>
					
					<tr>
						<td colspan="2"><div id="hostChatDisplay"></div></td>
					</tr>
					
					<tr>
						<td colspan="2"><input type="text" name="hostChat_comment" id="hostChat_comment" placeholder="대화 내용을 입력하세요." class="form-control" size="100" maxlength="1000" autocomplete="off">
						<input type="text" style="display: none" > 
						<button type="button" id="addHostChat" class="btn btn-success btn-sm mr-3" onclick="goAddHostChat()">전송</button></td>
					</tr>
				
				
				
			   </table>
		   
		   	   <input type="hidden" name="chat_no" value="${requestScope.chatvo.chat_no}">
		  	   <input type="hidden" name="chat_date" value="${requestScope.chatvo.chat_date}">
		  	   <input type="hidden" name="fk_userid" value="${requestScope.chatvo.fk_userid}">
		  	   <input type="hidden" name="fk_lodge_id" value="${requestScope.chatvo.fk_lodge_id}">
		   </form>
		   
		  
	   </c:if> 
	   
	   <c:if test="${empty requestScope.chatvo}">
	  	 <div style="padding: 20px 0; font-size: 16pt; color: red;" >채팅이 존재하지 않습니다</div>
	   </c:if> 
	   
	
	   
	   	  
	   	   	   	   
	
			
	
	
	 	<button type="button" class="btn btn-secondary btn-sm mr-3" onclick="javascript:location.href='<%=ctxPath%>/hostChatList.exp'">전체목록보기</button> 
	 
	 
	 
	 
	 
	 
	 
	
	</div>
</div>    
    
<form name="goViewFrm">
	<input type="hidden" name="chat_no" />
	<input type="hidden" name="goBackURL" />
</form>   
    
    
    
    
    
    