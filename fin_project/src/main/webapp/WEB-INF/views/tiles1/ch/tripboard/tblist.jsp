<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<%
	String ctxPath = request.getContextPath();
    //      /expedia
%>  
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">


<style>
	
	div#tripboard {
    margin: 0 auto;
    width: 80%;
    padding-left: 1rem; /* 10px → 1rem 변환 */
    font-family: 'Noto Sans', sans-serif;
}

table {
    border-spacing: 0;
    border-collapse: collapse;
    box-sizing: border-box;
    border-top: 0.125rem solid black; /* 1px → 0.0625rem 변환 */
    margin: 0 auto;
    width: 100%;
}

table.tbl_tripboard th {
    height: 3.75rem; /* 60px → 3.75rem 변환 */
    padding: 0 1.25rem; /* 20px → 1.25rem 변환 */
    border-bottom: 0.0625rem solid #ddd; /* 1px → 0.0625rem 변환 */
    background: rgba(0, 0, 0, 0.04);
    color: #222;
    text-align: center;
    font-weight: bold;
}


table.tbl_tripboard tr:hover {
    cursor: pointer;
    background-color: rgba(0, 0, 0, 0.06);
}

table.tbl_tripboard td {
    height: 3.75rem; /* 60px → 3.75rem 변환 */
    padding: 0 1.25rem; /* 20px → 1.25rem 변환 */
    line-height: 1.5625rem; /* 25px → 1.5625rem 변환 */
    border-bottom: 0.0625rem solid #ddd; /* 1px → 0.0625rem 변환 */
    letter-spacing: -0.02em;
    text-align: center;
    vertical-align: middle;
    font-weight: normal;
}

#tripboard > form > button:nth-child(4) {
	background-color: #0073ff;	
	border: 0px solid #555555;
    border-radius: 15px;
    color: white;
    height: 30px; /* 35px → 2.1875rem 변환 */
    margin: 0 0 0.7% 0.3125rem; /* 0 0 0.7% 0.5px → 0 0 0.7% 0.3125rem 변환 */
    font-size: 12px; /* 14px → 0.875rem 변환 */
}

#tripboard > button {
	background-color: #8e979c;
	border: 0px solid #555555;
    border-radius: 15px;
    color: white;	
    height: 30px; /* 35px → 2.1875rem 변환 */
    margin: 0 0 0.7% 0.3125rem; /* 0 0 0.7% 0.5px → 0 0 0.7% 0.3125rem 변환 */
    font-size: 12px; /* 14px → 0.875rem 변환 */
}

#tripboard > form > button:nth-child(4):hover {
	width: 4.6%;
	background-color: rgba(0, 80, 229, 0.91)	;
    box-shadow: 0 0.25rem 0.375rem -0.0625rem rgba(0, 0, 0, 0.1), 0 0.125rem 0.25rem -0.0625rem rgba(0, 0, 0, 0.08);
}


#tripboard > button:hover {
	background-color: rgba(0, 0, 0, 0.49);
    box-shadow: 0 0.25rem 0.375rem -0.0625rem rgba(0, 0, 0, 0.1), 0 0.125rem 0.25rem -0.0625rem rgba(0, 0, 0, 0.08);
}

input {
  height: 2rem; /* 32px → 2rem 변환 */
  font-size: 0.9375rem; /* 15px → 0.9375rem 변환 */
  border: 0;
  border-radius: 0.9375rem; /* 15px → 0.9375rem 변환 */
  outline: none;
  padding-left: 0.625rem; /* 10px → 0.625rem 변환 */
  background-color: rgb(233, 233, 233);
}





	
</style>
<script type="text/javascript">

$(document).ready(function(){
		
	$("input:text[name='searchWord']").bind("keyup", function(e){
		  if(e.keyCode == 13){ // 엔터를 했을 경우 
			  goSearch();
		  }  
	  });
		
	// 검색시 검색조건 및 검색어값 유지시키기
	if(${not empty requestScope.paraMap}) {
		  $("select[name='searchType']").val("${requestScope.paraMap.searchType}");
		  $("input[name='searchWord']").val("${requestScope.paraMap.searchWord}");
	} 
		
	
});// end of $(document).ready(function(){})-----------


// Function Declaration
function goView(tb_seq) {
	// alert(`글번호 \${tb_seq}번을 봅니다.`);
	
	const goBackURL = "${requestScope.goBackURL}";
	//    goBackURL = "/list.action?searchType=name&searchWord=서영학&currentShowPageNo=9"; 

	 const frm = document.goViewFrm;
	 frm.tb_seq.value = tb_seq;
	 frm.goBackURL.value = goBackURL;
	 
	 
	 frm.method = "post";
  // frm.action = "<%= ctxPath%>/tbview.exp";  
   	 frm.action = "<%= ctxPath%>/tbview_2.action";
	 frm.submit();
	 
}// end of function goView(seq)---------------
	
	
	function goSearch() {
		 // alert("확인");
		 const frm = document.searchFrm;
	  	 frm.method = "get";
	  	 frm.action = "<%=ctxPath%>/tblist.exp";
	  	 frm.submit();
	 }// end of function goSearch()----------------
 

</script>



<div style="inline-size: 100%; margin: 0 auto; max-inline-size: 85rem; padding: 50px 0;">

	
   <div id="tripboard">
		
      <h3><span style="cursor:pointer;"onclick="javascript:location.href='<%= ctxPath%>/tblist.exp'">여행 후기</span></h3>
	  <button type="button" style="float: right;" onclick="javascript:location.href='<%= ctxPath%>/tbadd.exp'">
         	<span aria-hidden="true" style="vertical-align: super;"><svg xmlns="http://www.w3.org/2000/svg" height="16" width="30" viewBox="0 0 512 512" style="transform: translateY(0px);"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="white" d="M441 58.9L453.1 71c9.4 9.4 9.4 24.6 0 33.9L424 134.1 377.9 88 407 58.9c9.4-9.4 24.6-9.4 33.9 0zM209.8 256.2L344 121.9 390.1 168 255.8 302.2c-2.9 2.9-6.5 5-10.4 6.1l-58.5 16.7 16.7-58.5c1.1-3.9 3.2-7.5 6.1-10.4zM373.1 25L175.8 222.2c-8.7 8.7-15 19.4-18.3 31.1l-28.6 100c-2.4 8.4-.1 17.4 6.1 23.6s15.2 8.5 23.6 6.1l100-28.6c11.8-3.4 22.5-9.7 31.1-18.3L487 138.9c28.1-28.1 28.1-73.7 0-101.8L474.9 25C446.8-3.1 401.2-3.1 373.1 25zM88 64C39.4 64 0 103.4 0 152V424c0 48.6 39.4 88 88 88H360c48.6 0 88-39.4 88-88V312c0-13.3-10.7-24-24-24s-24 10.7-24 24V424c0 22.1-17.9 40-40 40H88c-22.1 0-40-17.9-40-40V152c0-22.1 17.9-40 40-40H200c13.3 0 24-10.7 24-24s-10.7-24-24-24H88z"/></svg>
         	</span>
       </button>	
      <table class="tbl_tripboard">

         <thead>

            <tr style="text-align: center;">
               <th style="width: 13%;">글 번호</th>
               <th style="width: 10%;">지역</th>
               <th style="width: 37%;">글 제목</th>
               <th style="width: 15%;">작성자</th>
               <th style="width: 15%;">글 등록일</th>
               <th style="width: 10%;">조회 수</th>
            </tr>
         </thead>
         <c:if test="${not empty requestScope.tripboardList}">
            <c:forEach var="tripboardvo" items="${requestScope.tripboardList}">
               <tbody>
                  <tr onclick="goView('${tripboardvo.tb_seq}')">
                     <td>${tripboardvo.tb_seq}</td>
                     <td>${tripboardvo.tb_city}</td>
                     <td>
                     <c:if test ="${empty tripboardvo.tb_fileName}">
                     	<span>${tripboardvo.tb_subject}</span>
                     </c:if>
                     <c:if test ="${not empty tripboardvo.tb_fileName}">
                    	<span class="container" style="vertical-align: super;">${tripboardvo.tb_subject} <svg xmlns="http://www.w3.org/2000/svg" height="16" width="14" viewBox="0 0 448 512" style="transform: translateY(-2px);"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path d="M64 32C28.7 32 0 60.7 0 96V416c0 35.3 28.7 64 64 64H384c35.3 0 64-28.7 64-64V173.3c0-17-6.7-33.3-18.7-45.3L352 50.7C340 38.7 323.7 32 306.7 32H64zm0 96c0-17.7 14.3-32 32-32H288c17.7 0 32 14.3 32 32v64c0 17.7-14.3 32-32 32H96c-17.7 0-32-14.3-32-32V128zM224 288a64 64 0 1 1 0 128 64 64 0 1 1 0-128z"/></svg></span>
                     </c:if>
                     </td> 
                     <td>${tripboardvo.tb_name} 님</td>
                     <td class="date">${tripboardvo.tb_regDate}</td>
                     <td class="readcount">${tripboardvo.tb_readCount}</td>
                  </tr>
            </c:forEach>
         </c:if>
         </tbody>
      </table>

      <%-- === 페이지바 보여주기 === --%>
      <div align="center"
         style="border: solid 0px gray; width: 80%; margin: 30px auto;">
         ${requestScope.pageBar}
      </div>

      <%-- === 검색 폼 추가  === --%>
      <form name="searchFrm" style="margin-top: 20px; border:none;">
         <select name="searchType" style="height: 2rem; background-color: rgb(233, 233, 233); border: 0px; border-radius: 15px; text-align:center;" >
            <option value="tb_city">지역</option>
            <option value="tb_subject"> 글제목</option>
            <option value="tb_content"> 글내용</option>
            <option value="tb_subject_content"> 글제목+글내용</option>
            <option value="tb_name"> 글쓴이</option>
         </select> <input type="text" name="searchWord" size="38"
            autocomplete="off" /> <input type="text" style="display: none;" />
         <%-- form 태그내에 input 태그가 오로지 1개 뿐일경우에는 엔터를 했을 경우 검색이 되어지므로 이것을 방지하고자 만든것이다. --%>
         <button type="button" onclick="goSearch()" style="width: 2.8%;">
            <span aria-hidden="true" style="vertical-align: super;"> <svg xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="white" d="M416 208c0 45.9-14.9 88.3-40 122.7L502.6 457.4c12.5 12.5 12.5 32.8 0 45.3s-32.8 12.5-45.3 0L330.7 376c-34.4 25.2-76.8 40-122.7 40C93.1 416 0 322.9 0 208S93.1 0 208 0S416 93.1 416 208zM208 352a144 144 0 1 0 0-288 144 144 0 1 0 0 288z"/></svg>        
            </span>
         </button>                  
      </form>
	</div>
   </div>


</div>

	<form name="goViewFrm">
	   <input type="hidden" name="tb_seq" />
	   <input type="hidden" name="goBackURL" />
	   <input type="hidden" name="searchType" />
	   <input type="hidden" name="searchWord" />
	</form>
