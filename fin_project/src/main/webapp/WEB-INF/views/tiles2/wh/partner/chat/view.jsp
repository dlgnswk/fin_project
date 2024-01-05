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
		
		goReadComment(); // 페이징 처리안한 댓글 읽어오기

		
		$("span.move").hover(function(){ 
				$(this).addClass("moveColor");
			}, function(){
				$(this).removeClass("moveColor");
			});
		
		<%--
		$("input:text[name='content']").bind("keydown",function(e){
			if(e.keyCode == 13) {
				goAddWrite();
			}
		});
		--%>
		
	});// end of $(document).ready(function(){}-----------------------------------

// Function Declaration		
// == 댓글쓰기 ==
function goAddWrite() {
	
	const comment_content = $("input:text[name='content']").val().trim();
	if(comment_content == "") {
		alert("댓글 내용을 입력하세요!!");
		return;
	}
	
	if($("input:file[name='attach']").val() == "") {
		// 첨부파일이 없는 댓글쓰기인 경우
		goAddWrite_noAttach();
	}
	else {
		// 첨부파일이 없는 댓글쓰기인 경우
		goAddWrite_withAttach();
	}
	
	
	
	
	
	
}// end of function goAddWrite(){}--------------------------------------------


// 첨부파일이 없는 댓글쓰기인 경우
function goAddWrite_noAttach() {
	
	<%--
        // 보내야할 데이터를 선정하는 또 다른 방법
        // jQuery에서 사용하는 것으로써,
        // form태그의 선택자.serialize(); 을 해주면 form 태그내의 모든 값들을 name값을 키값으로 만들어서 보내준다. 
           const queryString = $("form[name='addWriteFrm']").serialize();
    --%>
    const queryString = $("form[name='addWriteFrm']").serialize();
    
	$.ajax({
		url:"<%= ctxPath%>/addComment.action",
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
		
			if(json.n == 0) {
				alert(json.name + "님의 포인트는 300점을 초과할 수 없으므로 댓글쓰기가 불가합니다.");
			}
			else {
			//	goReadComment(); // 페이징 처리 안한 댓글 읽어오기
				goViewComment(1); // 페이징 처리한 댓글 읽어오기
			}
			$("input:text[name='content']").val("");
		
		},
		error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        }
	});
	
}// end of function goAddWrite_noAttach() ---------------------------------
	

// 페이징 처리 안한 댓글 읽어오기
function goReadComment() {
	
	$.ajax({
		url:"<%= ctxPath%>/readComment.exp",
		data:{"chat_no":"${requestScope.chatvo.chat_no}"},
		dataType:"json",
		success:function(json){
			// console.log(JSON.stringify(json));
			
			let v_html = ``;
			if(json.length > 0) {
			
				$.each(json, function(index, item){
					v_html += `<tr>
							     <td class='text-center'>\${index+1}</td>
							     <td>\${item.content}</td>
							     <td class='text-center'>\${item.name}</td>
							     <td class='text-center'>\${item.regDate}</td>
						      </tr>`;
				});
			}
			else {
				v_html = `<tr>
						     <td colspan='4'>댓글이 없습니다.</td>
					      </tr>`;
			}
			
			$("tbody#commentDisplay").html(v_html);
			
			
		},
		error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        }
		
		
	});
	
	
}// end of function goReadComment() ---------------------------------------------------








	

function goView(chat_no) {
	
	const goBackURL = "${requestScope.goBackURL}";
	
    const frm = document.goViewFrm;
    frm.chat_no.value = chat_no;
    frm.goBackURL.value = goBackURL;
    
    
    frm.method = "post";
    frm.action = "<%=ctxPath%>/view_2.action";
    frm.submit();
    
    
}// end of function goView(seq) --------------------------------
	
	
	
</script>    
    
    
<div style="display: flex;">
	<div style="margin: auto; padding-left: 3%;">
	
	   <h2 style="margin-bottom: 30px;">1:1 문의 </h2>    
	    
	   <c:if test="${not empty requestScope.chatvo}">
		   <table class="table table-bordered table-dark" style="width: 1024px;">
			   <tr>
		           <th style="width: 15%">채팅번호</th>
		           <td>${requestScope.chatvo.chat_no}</td>
		       </tr>       		
			   
			   <tr>
		           <th>숙소명</th>
		           <td>${requestScope.chatvo.name}</td>
		       </tr>       		
			  
			   <tr>
		           <th>채팅</th>
		           <td><p style="word-break: break-all;">${requestScope.chatvo.chat}</p></td>
		       </tr>       	
			 
			   <tr>
		           <th>읽음여부</th>
		           <td>${requestScope.chatvo.readCount}</td>
		       </tr>       		
			  
	   	   </table>
	   </c:if> 
	   
	   <c:if test="${empty requestScope.chatvo}">
	  	 <div style="padding: 20px 0; font-size: 16pt; color: red;" >존재하지 않습니다</div>
	   </c:if> 
	   
	   <div class="mt-5">
		   <%-- 글 조회수 1증가를 위해서  view.action 대신에 view_2.action 으로 바꾼다. --%>
		   <%-- 
		   <div style="margin-bottom:1%;">이전글제목&nbsp;&nbsp;<span class="move" onclick="javascript:location.href='view_2.action?seq=${requestScope.boardvo.previousseq}'">${requestScope.boardvo.previoussubject}</span></div>
		   <div style="margin-bottom:1%;">다음글제목&nbsp;&nbsp;<span class="move" onclick="javascript:location.href='view_2.action?seq=${requestScope.boardvo.nextseq}'">${requestScope.boardvo.nextsubject}</span></div>
	   	   --%>


	   	  
	   	   <button type="button" class="btn btn-secondary btn-sm mr-3" onclick="javascript:location.href='<%=ctxPath%>/list.action'">전체목록보기</button> 
	   	   	   	   
	  	   
	  	   <%-- === #141. 어떤 글에 대한 답변글쓰기는 로그인 되어진 회원의 gradelevel 컬럼의 값이 10인 직원들만 답변글쓰기가 가능하다. === 
   	   		 
	   	   		<span>groupno : ${requestScope.boardvo.groupno}</span>
	   	   		<span>depthno : ${requestScope.boardvo.depthno}</span>
   	   		
	   	   		<button type="button" class="btn btn-secondary btn-sm mr-3" onclick="javascript:location.href='<%=ctxPath%>/add.action?subject=${requestScope.boardvo.subject}&groupno=${requestScope.boardvo.groupno}&fk_seq=${requestScope.boardvo.seq}&depthno=${requestScope.boardvo.depthno}'">답변글쓰기</button> 
	  	   </c:if>
	  	   --%>
	  	   
	  	   <%-- === #83. 댓글쓰기 폼 추가(판매자만 남길 수 있게) === 
	  	   <c:if test="${not empty sessionScope.loginuser}">
	  	   	  <h3 style="margin-top: 50px;">댓글쓰기</h3>
	  	   
	  	   	  <form name="addWriteFrm" id="addWriteFrm" style="margin-top: 20px;">
	              <table class="table" style="width: 1024px">
	              	 <tr style="height: 30px;">
	                    <th width="10%">성명</th>
	  	   			    	<td>
		  	   			    	<input type="hidden" name="fk_userid" value="${sessionScope.loginuser.userid}" readonly>
		  	   			    	<input type="text" name="name" value="${sessionScope.loginuser.name}" readonly>
	  	   			  		</td>
	  	   			 </tr>
	              	 
	              	 <tr style="height: 30px;">
	                 	<th>댓글내용</th>
	  	   			 		<td>
	  	   			    		<input type="text" name="content" size="100" maxlength="1000" />
	  	   			     
	  	   			     		<%-- 댓글에 달리는 원게시물 글번호(즉, 댓글의 부모글 글번호) 
	  	   			     		<input type="hidden" name="parentSeq" value="${requestScope.boardvo.seq}" readonly>
	  	   			 		</td>
	  	   			 	</tr>
	  	   			 	
	  	   			 	
	  	   			 	<tr>
		                	<th colspan="2">
		                		<button type="button" class="btn btn-success btn-sm mr-3" onclick="goAddWrite()">댓글쓰기 확인</button>
		                		<button type="reset" class="btn btn-success btn-sm">댓글쓰기 취소</button>
		                	</th>
		                </tr>
           			</table>         
          		</form>
  	   		</c:if>
	   		--%>
	   		
	   		<%-- === #94. 댓글 내용 보여주기 === --%>
	   		<h3 style="margin-top: 50px;">댓글내용</h3>
	   		<table class="table" style="width: 1024px; margin-top: 2%; margin-bottom: 3%;">
	   			<thead>
	   				<tr>
	   					<th style="width: 6%;  text-align: center;">번호</th>
            			<th style="text-align: center;">내용</th>
	   				
	   				
	   					<th style="width: 8%; text-align: center;">작성자</th>
            			<th style="width: 12%; text-align: center;">작성일자</th>
	   				</tr>
	   			</thead>
	   			<tbody id="commentDisplay"></tbody>
	   		</table>
	 
	   </div> 
	
	</div>
</div>    
    
<form name="goViewFrm">
	<input type="hidden" name="chat_no" />
	<input type="hidden" name="goBackURL" />
</form>   
    
    
    
    
    
    