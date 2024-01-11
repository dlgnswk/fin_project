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
					 
                     max-height: 400px;
                     overflow: auto;
					
	}

	input#hostChat_comment {
					border: 1px solid #818494;
					border-radius: 0.5rem;
    				color: #191e3b;
    				outline: none;
    				width:82%;
    				margin-left:3%;
    				
    				
    				
	}
	
	input#hostChat_comment:focus { 
					outline:2px solid #1668e3;
					
	}

	svg#goChat {
					fill: gray; 
					margin-left:3%; 
					margin-top:1%;
					margin-bottom:3%;
	}

	div#chatRoom_bottom {
	
						background-color:#f3f3f5;
						height: 50px;
						line-height: 50px;
						text-align:center;
						color: #1668e3;
						
						  
	}

	div#chatRoom_bottom:hover {
						background-color: #F0F8FF;
	}


</style>    
    
<script type="text/javascript">

	$(document).ready(function(){
		
		/* setInterval(function(){
			
			goViewHostChatList();
			
			
		}, 1000);
		 */
		goViewHostChatList();
		// let hostChat_comment = document.querySelector('div#hostChat_comment');
		
		
		
		 // 페이징 처리한 댓글 읽어오기
		
		
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


function a() {
	let chatUl = document.querySelector('.chat_ul');
	  chatUl.scrollTop = chatUl.scrollHeight;
}

	


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
						v_html += '<div style="margin-bottom:4%; text-align:right; width:70%; margin-left:auto;"  >';
						v_html += '<span style="font-size:10px;color:#777;  margin-right:1%;">' + item.reply_date.substr(11) + '</span>';
						v_html += '<span style="border-radius:0.4rem; background-color:#191e3b; word-break: break-word; font-size:14px; padding: 2%; color:white; ">'+item.reply_comment+'</span>';
					   	v_html += '</div>';
					}
					
					else {
						v_html += '<div style="margin-bottom:3%; text-align:left; width:70%;" >';
					   	v_html += '<span style="display:block; font-size:13px; margin-bottom:1%; padding-left:1%;">${requestScope.name}</span> ';
					   	v_html += '<span style="border-radius:0.4rem; background-color:#f3f3f5; word-break: break-word; font-size:14px; padding: 2%; color:#191e3b; width:70%;">'+item.reply_comment+'</span>';
					   	v_html += '<span style="font-size:10px; color:#777; margin-left:1%;">' + item.reply_date.substr(11) + '</span>';
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
    
<body style="background-color:white;">
<div style="inline-size: 100%; margin: auto; max-inline-size: 75rem; padding: 50px 0; display: flex;">
	<div style="width:40%; margin:auto; border:solid 0px gray; ">    

	
	   <c:if test="${not empty requestScope.chatvo}">
		   <form name="chatWriteFrm" id="chatWriteFrm">
		   
			   <div style="border-radius:0.5rem; border:1px solid #dee2e6;">
					<div style="border-bottom: 1px solid #dfe0e4; height:50px; padding:2%; text-align:center; font-weight:600;">${requestScope.chatvo.fk_userid}</div>					
				
					<div id="hostChatDisplay" style="padding:3%; "></div>
				
					<div style="display:flex; margin-top:2%;">
						<input type="text" name="hostChat_comment" id="hostChat_comment" placeholder="메시지 입력" class="form-control" size="100" maxlength="1000" autocomplete="off">
						<input type="text" style="display: none" > 
						<svg id="goChat" onclick="goAddHostChat();" xmlns="http://www.w3.org/2000/svg" height="5%" width="5%" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path d="M498.1 5.6c10.1 7 15.4 19.1 13.5 31.2l-64 416c-1.5 9.7-7.4 18.2-16 23s-18.9 5.4-28 1.6L284 427.7l-68.5 74.1c-8.9 9.7-22.9 12.9-35.2 8.1S160 493.2 160 480V396.4c0-4 1.5-7.8 4.2-10.7L331.8 202.8c5.8-6.3 5.6-16-.4-22s-15.7-6.4-22-.7L106 360.8 17.7 316.6C7.1 311.3 .3 300.7 0 288.9s5.9-22.8 16.1-28.7l448-256c10.7-6.1 23.9-5.5 34 1.4z"/></svg>
					</div>
					
					<div id="chatRoom_bottom" onclick="javascript:location.href='<%=ctxPath%>/hostChatList.exp'">
						대화 목록
					</div>
				
			   </div>
		   
		   	   <input type="hidden" name="chat_no" value="${requestScope.chatvo.chat_no}">
		  	   <input type="hidden" name="chat_date" value="${requestScope.chatvo.chat_date}">
		  	   <input type="hidden" name="fk_userid" value="${requestScope.chatvo.fk_userid}">
		  	   <input type="hidden" name="fk_lodge_id" value="${requestScope.chatvo.fk_lodge_id}">
		   </form>
	   </c:if> 
	   
	   <c:if test="${empty requestScope.chatvo}">
	  	 <div style="padding: 20px 0; font-size: 16pt; color: red;" >채팅이 존재하지 않습니다</div>
	   </c:if> 
	   
	
	   
	   	  
	   	   	   	   
	
			
	
	
	 
	 
	 
	 
	 
	 
	
	</div>
</div>    
    
<form name="goViewFrm">
	<input type="hidden" name="chat_no" />
	<input type="hidden" name="goBackURL" />
</form>   
    
</body>    
    
    
    
    