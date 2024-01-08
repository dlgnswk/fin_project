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

	span.move {cursor: pointer; color: navy;}
	.moveColor {color: #660029; font-weight: bold; background-color: #ffffe6;}

	a {text-decoration: none !important;}

</style>    
    
<script type="text/javascript">

	$(document).ready(function(){
		
		goViewChat(1); // 페이징 처리한 댓글 읽어오기
		
		
		$("input:text[name='msg']").bind("keydown",function(e){
			if(e.keyCode == 13) {
				goChatWrite();
			}
		});
		
		
	});// end of $(document).ready(function(){}-----------------------------------

// Function Declaration		
// == 채팅쓰기 ==
function goChatWrite() {
	
	const comment_msg = $("input:text[name='msg']").val().trim();
	if(comment_msg == "") {
		alert("채팅 내용을 입력하세요!!");
		return;
	}
	

	goChatWrite_noAttach();

	
	
	
	
	
	
	
}// end of function goAddWrite(){}--------------------------------------------


// 첨부파일이 없는 채팅쓰기인 경우
function goChatWrite_noAttach() {
	
	<%--
        // 보내야할 데이터를 선정하는 또 다른 방법
        // jQuery에서 사용하는 것으로써,
        // form태그의 선택자.serialize(); 을 해주면 form 태그내의 모든 값들을 name값을 키값으로 만들어서 보내준다. 
           const queryString = $("form[name='addWriteFrm']").serialize();
    --%>
    const queryString = $("form[name='chatWriteFrm']").serialize();
    
	$.ajax({
		url:"<%= ctxPath%>/addChat.exp",
	
	/*
		data:{"fk_userid":$("input:hidden[name='fk_userid']").val()
			 ,"name":$("input:text[name='name']").val()
		     ,"content":$("input:text[name='content']").val()
		     ,"parentSeq":$("input:hidden[name='parentSeq']").val() },
	*/
		// 또는     
		data:queryString,
		type:"post",
		dataType:"json",
		success:function(json){
			// console.log(JSON.stringify(json));
			// {"n":1, "name":"이순신"} {"n":0, "name":"최우현"}
		
			if(json.n == 1) {
				goViewChat(1); // 페이징 처리한 댓글 읽어오기			
			
			}
			
			$("input:text[name='msg']").val("");
		
		},
		error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        }
	});
	
}// end of function goChatWrite_noAttach() ---------------------------------
	




//=== #127. Ajax 로 불러온 댓글 내용들을 페이징 처리 하기 === //
function goViewChat(currentShowPageNo) {
	
	$.ajax({
		url:"<%= ctxPath%>/msgList.exp",
		data:{"chat_no":"${requestScope.chatvo.chat_no}",
			  "currentShowPageNo":currentShowPageNo},
		dataType:"json",
	
		success:function(json){
			// == 첨부파일을 넣어준 것이 없을 시 == 
			// console.log(JSON.stringify(json));
			
			/* [{"name":"최우현","regdate":"2023-11-21- 16:41:31","content":"댓글입니다 200"},
				{"name":"최우현","regdate":"2023-11-21- 16:41:31","content":"댓글입니다 199"},
				{"name":"최우현","regdate":"2023-11-21- 16:41:31","content":"댓글입니다 198"},
				{"name":"최우현","regdate":"2023-11-21- 16:41:31","content":"댓글입니다 197"},
				{"name":"최우현","regdate":"2023-11-21- 16:41:31","content":"댓글입니다 196"}]
			
			*/
			
			// 또는
			
			// []
			
			
			
			
			
			let v_html = "";
			if(json.length > 0) {
			
				$.each(json, function(index, item){
			
				   	v_html += '<div style="margin-bottom:3px;">';
				   	v_html += '[' + item.fk_userid + '] ';
				   	v_html += item.reply_comment;
				   	v_html += ' <span style="font-size:11px;color:#777;">' + new Date().toLocaleTimeString() + '</span>';
				   	v_html += '</div>';
				   	
				   	
				   	
				   	
				});
			}
			
			<%--
			else {
				v_html =  "<tr>";
				v_html += 	"<td colspan='4'>댓글이 없습니다.</td>";
				v_html += "</tr>";
			}
			--%>
			$("div#msgDisplay").html(v_html);
			
			// 페이지바 함수 호출
			makeMsgPageBar(currentShowPageNo);
			
		},
		
		error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        }
	});
	
}// end of function goReadComment() ---------------------------------------------------

// === 댓글내용 페이지바 Ajax 로 만들기 === //
function makeMsgPageBar(currentShowPageNo) {
	
	<%-- === 원글에 대한 댓글의 totalPage 수를 알아와야 한다. === --%>
	$.ajax({
		url:"<%=ctxPath%>/getMsgTotalPage.exp",
		data:{"chat_no":"${requestScope.chatvo.chat_no}",
			  "sizePerPage":"10"},
		type:"get",
		dataType:"json",
		success:function(json){
			// console.log(JSON.stringify(json));
			// {"totalPage":22}
			// {"totalPage":0}
			
			if(json.totalPage > 0) {
					// 댓글이 있는 경우
					
					const totalPage = json.totalPage;
					const blockSize = 10;
					
				 // blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 개수 이다.
	           	 /*
	                              1 2 3 4 5 6 7 8 9 10  [다음][마지막]           -- 1개블럭
	                [맨처음][이전]  11 12 13 14 15 16 17 18 19 20  [다음][마지막]   -- 1개블럭
	                [맨처음][이전]  21 22 
	             */
					
		            let loop = 1;
	             /*
	                loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
	             */
		            
					if(typeof currentShowPageNo == "string") {
						currentShowPageNo = Number(currentShowPageNo);
					}
					
			     // *** !! 다음은 currentShowPageNo 를 얻어와서 pageNo 를 구하는 공식이다. !! *** //
	             let pageNo = Math.floor( (currentShowPageNo - 1)/blockSize ) * blockSize + 1;
	             /*
	                currentShowPageNo 가 3페이지 이라면 pageNo 는 1 이 되어야 한다.
	                ((3 - 1)/10) * 10 + 1;
	                ( 2/10 ) * 10 + 1;
	                ( 0.2 ) * 10 + 1;
	                Math.floor( 0.2 ) * 10 + 1;  // 소수부가 있을시 Math.floor(0.2) 은 0.2 보다 작은 최대의 정수인 0을 나타낸다.
	                0 * 10 + 1 
	                1
	                
	                currentShowPageNo 가 11페이지 이라면 pageNo 는 11 이 되어야 한다.
	                ((11 - 1)/10) * 10 + 1;
	                ( 10/10 ) * 10 + 1;
	                ( 1 ) * 10 + 1;
	                Math.floor( 1 ) * 10 + 1;  // 소수부가 없을시 Math.floor(1) 은 그대로 1 이다.
	                1 * 10 + 1
	                11
	                
	                currentShowPageNo 가 20페이지 이라면 pageNo 는 11 이 되어야 한다.
	                ((20 - 1)/10) * 10 + 1;
	                ( 19/10 ) * 10 + 1;
	                ( 1.9 ) * 10 + 1;
	                Math.floor( 1.9 ) * 10 + 1;  // 소수부가 있을시 Math.floor(1.9) 은 1.9 보다 작은 최대의 정수인 1을 나타낸다.
	                1 * 10 + 1
	                11
	             
	                
	                1  2  3  4  5  6  7  8  9  10  -- 첫번째 블럭의 페이지번호 시작값(pageNo)은 1 이다.
	                11 12 13 14 15 16 17 18 19 20  -- 두번째 블럭의 페이지번호 시작값(pageNo)은 11 이다.
	                21 22 23 24 25 26 27 28 29 30  -- 세번째 블럭의 페이지번호 시작값(pageNo)은 21 이다.
	                
	                currentShowPageNo         pageNo
	               ----------------------------------
	                     1                      1 = Math.floor((1 - 1)/10) * 10 + 1
	                     2                      1 = Math.floor((2 - 1)/10) * 10 + 1
	                     3                      1 = Math.floor((3 - 1)/10) * 10 + 1
	                     4                      1
	                     5                      1
	                     6                      1
	                     7                      1 
	                     8                      1
	                     9                      1
	                     10                     1 = Math.floor((10 - 1)/10) * 10 + 1
	                    
	                     11                    11 = Math.floor((11 - 1)/10) * 10 + 1
	                     12                    11 = Math.floor((12 - 1)/10) * 10 + 1
	                     13                    11 = Math.floor((13 - 1)/10) * 10 + 1
	                     14                    11
	                     15                    11
	                     16                    11
	                     17                    11
	                     18                    11 
	                     19                    11 
	                     20                    11 = Math.floor((20 - 1)/10) * 10 + 1
	                     
	                     21                    21 = Math.floor((21 - 1)/10) * 10 + 1
	                     22                    21 = Math.floor((22 - 1)/10) * 10 + 1
	                     23                    21 = Math.floor((23 - 1)/10) * 10 + 1
	                     ..                    ..
	                     29                    21
	                     30                    21 = Math.floor((30 - 1)/10) * 10 + 1
	                     
	            */
	            
	            let pageBarHTML = "<ul style='list-style:none;'>";
					
	        	// === [맨처음][이전] 만들기 === //
	            if(pageNo != 1) {
	            	pageBarHTML += "<li style='display:inline-block; width: 70px; font-size:12pt;'><a href='javascript:goViewComment(\"1\")'>[맨처음]</a></li>";	            	
	            	pageBarHTML += "<li style='display:inline-block; width: 50px; font-size:12pt;'><a href='javascript:goViewComment(\""+(pageNo-1)+"\")'>[이전]</a></li>";	            	
	            }
	            
	            while(!(loop > blockSize || pageNo > totalPage)){
	            	
	            	if(pageNo == currentShowPageNo) {
	            		pageBarHTML += "<li style='display:inline-block; width: 30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px'>"+pageNo+"</li>";
	            	}
	            	else {
	            		pageBarHTML += "<li style='display:inline-block; width: 30px; font-size:12pt;'><a href='javascript:goViewComment(\""+pageNo+"\")'>"+pageNo+"</a></li>";
	            	}
	            	
	            	loop++;
	            	pageNo++;
	            }// end of while()-------------------------------------------
	             
	            // === [다음][마지막] 만들기 === //
	            if(pageNo <= totalPage) {
	            	pageBarHTML += "<li style='display:inline-block; width: 50px; font-size:12pt;'><a href='javascript:goViewComment(\""+pageNo+"\")'>[다음]</a></li>";	            	
	            	pageBarHTML += "<li style='display:inline-block; width: 70px; font-size:12pt;'><a href='javascript:goViewComment(\""+totalPage+"\")'>[마지막]</a></li>";	            	
	            }
	            
	            
	            pageBarHTML += "</ul>";
	            
	            $("div#pageBar").html(pageBarHTML);
	            
			}// end of if(json.totalPage > 0)---------------------------------------------------------
		},
		error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        }
	});
	
	
}// end of function makeCommentPageBar(currentShowPageNo) -------------------------------------------





	
<%--
function goView(chat_no) {
	
	const goBackURL = "${requestScope.goBackURL}";
	
    const frm = document.goViewFrm;
    frm.chat_no.value = chat_no;
    frm.goBackURL.value = goBackURL;
    
    
    frm.method = "post";
    frm.action = "<%=ctxPath%>/view_2.action";
    frm.submit();
    
    
}// end of function goView(seq) --------------------------------
--%>	
	
	
</script>    
    
    
<div style="display: flex;">
	<div style="margin: auto; padding-left: 3%;">
	
	   <h2 style="margin-bottom: 30px;">1:1 문의 </h2>    
	    
	   <c:if test="${not empty requestScope.chatvo}">
		   <form name="chatWriteFrm" id="chatWriteFrm" style="margin-top: 20px;">
			   <table class="table table-bordered">
					<tr>
						<td>${requestScope.chatvo.fk_lodge_id}</td>					
					</tr>
					<tr>
						<td colspan="2"><div id="msgDisplay"></div></td>
					</tr>
					<tr>
						<td colspan="2"><input type="text" name="msg" id="msg" placeholder="대화 내용을 입력하세요." class="form-control" size="100" maxlength="1000">
						<button type="button" class="btn btn-success btn-sm mr-3" onclick="goChatWrite()">전송</button></td>
					</tr>
				
				
				
			   </table>
		   
		   	   <input type="hidden" name="chat_no" value="${requestScope.chatvo.chat_no}">
		  	   <input type="hidden" name="chat_date" value="${requestScope.chatvo.chat_date}">
		  	   <input type="hidden" name="fk_userid" value="${requestScope.chatvo.fk_userid}">
		   </form>
		   
		  
	   </c:if> 
	   
	   <c:if test="${empty requestScope.chatvo}">
	  	 <div style="padding: 20px 0; font-size: 16pt; color: red;" >채팅이 존재하지 않습니다</div>
	   </c:if> 
	   
	
	   	<%-- #136. 댓글 페이지바 === --%>
	 		<div style="display: flex; margin-bottom: 50px;">
	 		<div id="pageBar" style="margin:auto; text-align: center;"></div>
		    </div>  
	   	  
	   	   	   	   
	  	 
	  	   
	  	   <%-- === #83. 댓글쓰기 폼 추가(판매자만 남길 수 있게) === 
	  	   <c:if test="${not empty sessionScope.loginuser}">
	  	   
	  	   --%>
	  	   	 
	 
			
			
	
			
	
	
	 	<button type="button" class="btn btn-secondary btn-sm mr-3" onclick="javascript:location.href='<%=ctxPath%>/list.action'">전체목록보기</button> 
	 
	 
	 
	 
	 
	 
	 
	
	</div>
</div>    
    
<form name="goViewFrm">
	<input type="hidden" name="chat_no" />
	<input type="hidden" name="goBackURL" />
</form>   
    
    
    
    
    
    