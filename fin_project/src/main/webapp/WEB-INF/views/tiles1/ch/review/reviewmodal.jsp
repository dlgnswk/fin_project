<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<%
	String ctxPath = request.getContextPath();
    //      /board
%>  
<!-- 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Josefin+Sans:wght@500&display=swap" rel="stylesheet">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gothic+A1:wght@700&display=swap" rel="stylesheet">


<style type="text/css">
	.reviewshow > div {
		color: rgba(0, 58, 255, 0.77);		
	}
	.reviewshow > div:hover {
	 	text-decoration: underline;
	 	cursor: pointer;
	}
	
	/* 모달 css 시작 */
	
	.reviewModal{ 
	    position:absolute;
	    width:100%; 
	    height:100%; 
	    background: rgba(0, 0, 0, 0.21); 
	    top:0; 
	    left:0; 
	    display:none;
	    z-index: 100;
	}
	
	body.modal-open {
	    overflow: hidden; /* 페이지 스크롤 막기 */
	}
	
	.reviewModal_header{		
	    width: 720px; /* 500px를 16px 기준으로 나눈 값 */
	    height: 640px;        /* 300px를 16px 기준으로 나눈 값 */
	    background:#fff; 
	    border-radius:0.625rem; /* 10px를 16px 기준으로 나눈 값 */
	    position:relative; 
	    top:50%; 
	    left:50%;
	    margin-top:-320px; /* height의 절반 */
	    margin-left:-360px; /* width의 절반 */
	    text-align:left;
	    box-sizing:border-box; 
	    padding: 50px 0; /* 74px를 16px 기준으로 나눈 값 */
	    line-height:1.4375rem; /* 23px를 16px 기준으로 나눈 값 */
	    cursor:pointer;
	}
	

	#mycontent > div.reviewModal > div > span.close {
	    position: absolute; 
	    top: 6px; /* 15px를 16px 기준으로 나눈 값 */
	    left: 0.9375rem; /* 15px를 16px 기준으로 나눈 값 */
	    color: #0073ff;
	    font-size: 30px;
	    cursor: pointer;	    	    
	}
	
	#mycontent > div.reviewModal > div > span:nth-child(1) {
		position: absolute; 
	   	top: 13px;
    	left: 2.8125rem; 
	}
	
	.rating_avg {
		font-family: 'Josefin Sans', sans-serif;
	}
	
	#mycontent > div.reviewModal > div > div > h4 > span {
		font-family: 'Gothic A1', sans-serif;
		font-size: 20px;
	}
	
	/* 그래프 바 css 시작 */
	
	progress {
	  -webkit-appearance: none;
	}
	
	::-webkit-progress-bar {
	   width: 627px;  /* --> bar 전체 길이 */
	   height: 8px;   /* --> bar 두께 */
 		   border: 0px solid gray;
 		   border-radius: 12px;    
	   background-color: rgba(0, 0, 0, 0.13); /* --> 진행률  배경 색상 */
	}
	
	::-webkit-progress-value {
	  background-color: rgba(0, 0, 88, 0.96); /* --> 진행률  값 색상 */
	  border: 0px solid gray;
 		  border-radius: 12px;
	}
	
	/* 그래프 바 css 끝 */
	
	/* 검색창 css 시작 */
	
	
	.input-wrapper {
    position: relative;
    margin-bottom: 20px;
    display: flex;
    align-items: center;
	}
	
	#search-input-box {
	    height: 57px;
	    border: 1px solid rgba(0, 0, 0, 0.21);
	    border-radius: 10px;
	    outline: none;
	    padding-left: 0.625rem;
	    background-color: #fff;
	    transition: border-color 0.3s ease;
	    margin-right: 10px; /* 버튼과의 간격을 조절하기 위한 마진 추가 */
	}
	
	#search-input-box:focus {
	    border: 2px solid #0073ff;
	}
	
	#search-input-label {
	    position: absolute;
	    top: 18px; /* 레이블의 상단 여백 조정 */
	    left: 10px; /* 레이블의 좌측 여백 조정 */
	    color: #aaa;
	    pointer-events: none;
	    transition: all 0.3s ease;
	}
	
	#search-input-box:focus + #search-input-label,
	#search-input-box:not(:placeholder-shown) + #search-input-label {
	    top: 0;
	    font-size: 13px;
	    color: black;
	}
	
	#mycontent > div.reviewModal > div > div > div.search_filter > form > div > button {
		padding-right: 5.8%;
	    background-color: #0073ff;
	    border: 0px solid #555555;
	    border-radius: 100%;
	    color: white;
	    height: 58px;
	}
	
	#mycontent > div.reviewModal > div > div > div.search_filter > form > div > button:hover {
	    background-color: rgba(0, 80, 229, 0.91);
	    box-shadow: 0 0.25rem 0.375rem -0.0625rem rgba(0, 0, 0, 0.1), 0 0.125rem 0.25rem -0.0625rem rgba(0, 0, 0, 0.08);	
	}	
	
	/* 검색창 css 끝 */
	
	/* 셀렉트 창 css 시작 */	
	#mycontent > div.reviewModal > div > div.reviewModal_content > div.search_filter > form > select:focus {
	    border: 2px solid #0073ff;
	    outline: none;
	}
	
	#mycontent > div.reviewModal > div > div.reviewModal_content > div.search_filter > form > select {
	    height: 50px; /* 32px → 2rem 변환 */
	    font-size: 0.9375rem; /* 15px → 0.9375rem 변환 */
	    border: 1px solid rgba(0, 0, 0, 0.21);
	    border-radius: 0.9375rem; /* 15px → 0.9375rem 변환 */
	    outline: none;
	    padding-left: 0.625rem; /* 10px → 0.625rem 변환 */
	    background-color: #fff;	
	}
	/* 셀렉트 창 css 끝 */
	
		
	/* 댓글목록 시작  */
	
	
	
	.review {
	   background-color: #fff;
	   width: 95.6%;
	}
	
	
	
	
	/* 훌륭해요 글짜크기  */
	
	#review > div > div > div:nth-child(2) > div:nth-child(1) > div:nth-child(2) > div {
	   font-size:1.25rem;
	}
	
	/* 아이디 글짜크기 */
	#review > div > div > div:nth-child(2) > div:nth-child(1) > div:nth-child(4) > div,
	#review > div > div > div:nth-child(2) > div:nth-child(1) > div:nth-child(5) > div,
	#review > div > div > div:nth-child(2) > div:nth-child(1) > div:nth-child(8) > div{
	   font-size:.875rem;
	}
	
	
	/* 모달 css 끝 */
	
	
	
	
	
</style>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		$(".reviewmodalshow").click(function() {
	        $(".reviewModal").fadeIn();
	        $(".reviewModal_header").show(); // 삭제 버튼 클릭 시 헤더 영역 보이기
	        $("body").addClass("modal-open"); // body에 modal-open 클래스 추가
			
		});
		
		// 모달의 닫기 버튼 클릭 시 모달 닫기
	    $("span.close").click(function() {
	        $(".reviewModal").fadeOut();
	        $("body").removeClass("modal-open"); // body에서 modal-open 클래스 제거
	    });
		
	    const inputBox = document.getElementById('search-input-box');
	    const inputLabel = document.getElementById('search-input-label');

		
	});
	
</script>


<div style="inline-size: 100%; margin: auto; max-inline-size: 85rem; padding: 50px 0;">

	<div id="select_box">
						
			<a style="font-weight: bold;" href="<%=ctxPath%>/account.exp">내 계정</a>
		
		<!-- 이용한 숙소가 없는 경우 -->	
		<div class="reviewshow" style="text-align:center;">			
				<div class="reviewmodalshow">이용후기 모두보기<span style="font-weight:bold;"> ></span> </div>
		</div>
		
	</div>
	
</div>

<!-- 이용후기 모달 -->
<div class="reviewModal">
	<div class="reviewModal_header">
		<span>고객 이용 후기</span> <span class="close">&times;</span>
		<div class="reviewModal_content"
			style="padding-left: 5%; height: 570px; overflow-y: auto;">
			<br>
			<h4 class="rating_avg">9.0/10.0 - <span>매우 훌륭해요</span></h4>
			<span>개 실제 이용 고객 후기</span>
			<div class="rating"
				style="margin-top: 2%; padding-left: 1%; padding-right: 5.5%;">
				<div class="progressbar_1">					    
			      <h5 style="font-size: 14px;">
					10 - 훌륭해요 <span style="float: right;">216</span>
				  </h5>
				 	<progress id="progress" value="50" min="0" max="100"></progress>			
				</div>
				<div class="progressbar_2">
					<h5 style="font-size: 14px;">
						8 - 좋아요 <span style="float: right;">216</span>
					</h5>
					<progress id="progress" value="50" min="0" max="100"></progress>
				</div>
				<div class="progressbar_3">
					<h5 style="font-size: 14px;">
						6 - 괜찮아요 <span style="float: right;">216</span>
					</h5>
					<progress id="progress" value="50" min="0" max="100"></progress>
				</div>
				<div class="progressbar_4">
					<h5 style="font-size: 14px;">
						4 - 별로에요 <span style="float: right;">216</span>
					</h5>
					<progress id="progress" value="50" min="0" max="100"></progress>
				</div>
				<div class="progressbar_5">
					<h5 style="font-size: 14px;">
						2 - 너무 별로에요<span style="float: right;">216</span>
					</h5>
					<progress id="progress" value="50" min="0" max="100"></progress>
				</div>
			</div>



			<div class="search_filter" style="margin-top: 3%; display: flex;">
				<!-- <input type="text" style="height: 50px; border: 1px solid black; border-radius: 10px;" id="search-input-box" name="reviewSearch" placeholder="  이용 후기 검색" /> -->
				<form name="searchFrm">
					<div class="input-wrapper">
						<input type="text" id="search-input-box" name="reviewSearch" size="72" maxlength="200" autocomplete="off" /> 
						<label for="search-input-box" id="search-input-label">이용 후기 검색</label>
						<button type="button" onclick="goSearch()">
						<span aria-hidden="true" style="vertical-align: super;"> <svg xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512" style="transform: translate(15px);">
                		<!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.-->
               			 <path fill="white" d="M416 208c0 45.9-14.9 88.3-40 122.7L502.6 457.4c12.5 12.5 12.5 32.8 0 45.3s-32.8 12.5-45.3 0L330.7 376c-34.4 25.2-76.8 40-122.7 40C93.1 416 0 322.9 0 208S93.1 0 208 0S416 93.1 416 208zM208 352a144 144 0 1 0 0-288 144 144 0 1 0 0 288z" />
            			</svg></span>
						</button>
					</div>
					<select name="searchType" style="width: 40%;">
						<option value="relation">관련성</option>
						<option value="recent_review">최근 이용 후기</option>
						<option value="best_review">최고 고객 평점</option>
						<option value="bad_review">최저 고객 평점</option>
					</select>
				</form>
			</div>
							
			<div class="review">
				   <c:forEach var="reviewList" items="${requestScope.reviewList}">		
					<div style="border-bottom: 1px solid black">
					<c:if test="${reviewList.RV_DEPTHNO == 0}">                        
                        <br>
                        <div>
                           <div>${reviewList.FK_RV_RATING}/10 - ${reviewList.RV_RATING_DESC}</div>
                        </div>
                        <br>
                        <div>
                           <div>${reviewList.RS_NAME}</div>
                        </div>
                        <div>
                           <div>${reviewList.RV_REGDATE}</div>
                        </div>
                        <br>
                        <div>
                           <div>${reviewList.RV_CONTENT}</div>
                        </div>
                         <span> ${reviewList.RS_DATE}에 ${reviewList.livedate} 숙박함 </span>
                        <br>

                        <div class="reviewfindBtn">
                           <%-- <button type="button" class="btn_like" id="btnLike">좋아요</button>&nbsp;&nbsp; --%>
                           <svg xmlns="http://www.w3.org/2000/svg"
                              style="margin-right: 5px;" height="16" width="16"
                              fill="rgba(35, 121, 255, 0.89)" viewBox="0 0 512 512"
                              onclick="golikeAdd('${requestScope.tripboardvo.tb_seq}')">
                              <path
                                 d="M313.4 32.9c26 5.2 42.9 30.5 37.7 56.5l-2.3 11.4c-5.3 26.7-15.1 52.1-28.8 75.2H464c26.5 0 48 21.5 48 48c0 18.5-10.5 34.6-25.9 42.6C497 275.4 504 288.9 504 304c0 23.4-16.8 42.9-38.9 47.1c4.4 7.3 6.9 15.8 6.9 24.9c0 21.3-13.9 39.4-33.1 45.6c.7 3.3 1.1 6.8 1.1 10.4c0 26.5-21.5 48-48 48H294.5c-19 0-37.5-5.6-53.3-16.1l-38.5-25.7C176 420.4 160 390.4 160 358.3V320 272 247.1c0-29.2 13.3-56.7 36-75l7.4-5.9c26.5-21.2 44.6-51 51.2-84.2l2.3-11.4c5.2-26 30.5-42.9 56.5-37.7zM32 192H96c17.7 0 32 14.3 32 32V448c0 17.7-14.3 32-32 32H32c-17.7 0-32-14.3-32-32V224c0-17.7 14.3-32 32-32z" /></svg>
                           <span id="likeCnt">0</span>
                        </div>
                        <br>
                        </c:if>
                        <c:if test="${reviewList.RV_DEPTHNO > 0}">
                        	<input type="hidden" name="rv_seq" size="38"
								value="${reviewList.RV_SEQ}" autocomplete="off" readonly />
							<div>답변 제공: ${reviewList.H_LODGENAME}님 , ${reviewList.RV_REGDATE}</div>
							<div>${reviewList.FK_USERID}</div>
							<div>${reviewList.RV_CONTENT}</div>
							<br>
                        </c:if>
                    </div>    
					</c:forEach>                   
                   <br>
                   <div style="display: flex; justify-content: center;">
					    <button type="button" style="width: 30%; height: 30px; border: 1px solid black; margin-bottom: 5%; background-color: #fff; color: #1668e3; border-radius: 2500rem;">이용 후기 더보기</button>
					</div>
					<br>
			</div>
		</div>
	</div>


</div>



