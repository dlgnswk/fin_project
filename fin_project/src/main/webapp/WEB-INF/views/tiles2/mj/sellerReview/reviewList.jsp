<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%
	String ctxPath = request.getContextPath();
%>



<script type="text/javascript">
	$(document).ready(function() {
		
		
						
					/* 답글쓰기 시작  */
						$("button.btn_answer").click(function(e) {

							// alert($(e.target).attr("id"));  
							
							// alert("확인완료");	
							
							$("div#"+$(e.target).attr("id")).show();
						});

						$("button.cansel").click(function() {

							//  alert("확인완료임ㅋㅋ");

							$("div.showanswer").hide();
						});
					/* 	
						$("button.send").click(function(){
							 const textarea_val = $("textarea[name='reviewContent']").val();

							$("textarea[name='insert_reviewContent'").val(textarea_val);
							
						}); */
						
						
						
						$("button.send").click(function(e){
						     
								
							   const index = $("button.send").index($(e.target));
							   
							    console.log(index);
								
							    let reviewContent = $("textarea[name='reviewContent']").eq(index).val();

							   const cContentValue = $("textarea[name='c_content']");
							   cContentValue.val(reviewContent);
							   
							   
							   
								
							   
							   const groupno = $("input[id='groupno']").eq(index).val();
							   
							     let c_groupno = $("input[name='c_groupno']");

							 
							   c_groupno.val(groupno);
								
							   
							   
						
							    
							
							   
							   const regDate = $("input[id='regDate']").eq(index).val();
							   
							     let c_regDate = $("input[name='c_regDate']");

							 
							     c_regDate.val(regDate);
							    
							
							   
							   
							   const fk_seq = $("input[id='fk_seq']").eq(index).val();
							   
							     let c_org_seq = $("input[name='c_org_seq']");

							 
							     c_org_seq.val(fk_seq);
							    
							
							   
							   
								   
								   const depthno = $("input[id='depthno']").eq(index).val();
								   
								     let c_depthno = $("input[name='c_depthno']");

								 
								     c_depthno.val(depthno);
								    
								
							   
								   const seq = $("input[id='seq']").eq(index).val();
								   
								     let c_seq = $("input[name='c_seq']");

								 
								     c_seq.val(seq);
								    
								     
								
							   
								   const rs_seq = $("input[id='rs_seq']").eq(index).val();
								   
								     let fk_rs_seq = $("input[name='fk_rs_seq']");

								 
								     fk_rs_seq.val(rs_seq);
								    
								
							   
							   
							   
							   
								   const userid = $("input[id='userid']").eq(index).val();
								   
								     let fk_h_userid = $("input[name='fk_h_userid']");

								 
								     fk_h_userid.val(userid);
								     
								     
								     
								     
								     
								   const lodge = $("input[id='lodge']").eq(index).val();
								   
								     let fk_lodge_id = $("input[name='fk_lodge_id']");

								 
								     fk_lodge_id.val(lodge);
								    
								
							   
							   
							   
							   
							   
							   
								const frm = document.forms["insertFrm"];
							   	 frm.method = "post";
							   	 frm.action = "<%=ctxPath%>/reviewEnd.exp";
								 frm.submit();

							});
						/* 답글쓰기 끝  */
						
						

						/* 수정창 */						
						$("div.wantUpdate").hide();
						

						$("button.update").click(function(e) {

						//	 alert($(e.target).attr("id"));  
							
						//	alert("확인완료");	
							
							$("div#"+$(e.target).attr("id")).show();
						});

						
						
						$("button.closecansel").click(function() {

							 // alert("확인완료임ㅋㅋ");

							 $("div.wantUpdate").hide();
						});
						
			
						
						
		
						
						
	});					
						
						
						
						
						
/* 						$("span#totalCount").show();
						$("span#countHIT").show();
						
						// HIT상품 게시물을 더보기 위하여 "더보기..." 버튼 클릭액션에 대한 초기값 호출하기 
						// 즉, 맨처음에는 "더보기..." 버튼을 클릭하지 않더라도 클릭한 것 처럼 8개의 HIT상품을 게시해주어야 한다는 말이다. 
						displayHIT("1");
						
						// HIT 상품 게시물을 더보기 위하여 "더보기..." 버튼 클릭액션 이벤트 등록하기  
						$("button#btnMoreHIT").click(function(){
							
							if($(this).text() == "처음으로") {
								$("div#displayHIT").empty();
								$("span#end").empty();
								displayHIT("1");
								$(this).text("더보기...");
							}
							else {
						      displayHIT($(this).val());
						   // displayHIT("9");   첫번째로 더보기를 클릭한 경우
						   // displayHIT("17");  두번째로 더보기를 클릭한 경우
						   // displayHIT("25");  세번째로 더보기를 클릭한 경우
						   // displayHIT("33");  네번째로 더보기를 클릭한 경우
						   }
							
						});// end of $("button#btnMoreHIT").click(function(){})---				
						
						
						
	});					
		
	
	
	
	// Function Declaration

	let lenHIT = 8;
	// HIT 상품 "더보기..." 버튼을 클릭할때 보여줄 상품의 개수(단위)크기 

	// display 할 HIT상품 정보를 추가 요청하기(Ajax 로 처리함)
	function displayHIT(start) { // start가  1 이라면   1~ 8  까지 상품 8개를 보여준다.
								 // start가  9 이라면   9~16  까지 상품 8개를 보여준다.
								 // start가 17 이라면  17~24  까지 상품 8개를 보여준다.
								 // start가 25 이라면  25~32  까지 상품 8개를 보여준다.
								 // start가 33 이라면  33~36  까지 상품 4개를 보여준다.(마지막 상품)
								 
		$.ajax({
			url:"mallDisplayJSON.exp",
		    type:"get",
			data:{"searchWord": $("input[name='searchWord']").val(),
				 "start": start,
				 "len": lenHIT},  
			dataType:"json",
			success:function(json){
				
				console.log(json);
			
							
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}      
		});						   
		
	} */

	
	console.log();
	
     function goSearch() {
	  alert("확인했습니다");
	 
	 <%--  const frm = document.reviewSearchFrm;
   	 frm.method = "get";
   	 frm.action = "<%=ctxPath%>/mallDisplayJSON.exp";
	 frm.submit();--%> 
	
	    
	    $.ajax({
	    	url:"searchComment.exp",
	    	type:"get",
	    	data:{"searchWord": $("input[name='searchWord']").val()},
	    	dataType:"json",
	    	success:function(json){ 
	    		console.log(json);
	    	},
	    	error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}   
	    		  
	    });
	 
	}// end of function goSearch()---------------- 
	
	
	
<%-- 
	function wantUpdate() {
		
		
		 
		$.ajax({
	        url: '<%=ctxPath%>/reviewUpdate.exp',  
	        type: 'GET',
	        dataType: 'json',
	        success: function(response) {
	            // 서버에서 받은 데이터로 내용 수정
	            $('#lgName').text(response.LG_NAME);
	            $('#regDate').text(response.RV_REGDATE);
	            $('#rvContent').text(response.RV_CONTENT);
	        },
	        error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}   
	    });
		
		
	} --%>
	
	
</script>

<link rel="stylesheet" type="text/css"
	href="<%=ctxPath%>/resources/css/mj/review/list.css" />


<div id="container" style="height: 1850px;">
	<div id="search"
		style="border: 0px solid blue; width: 60%; margin: auto; background-color: #fff; border-radius: 0.8rem; height: 180px;">
		<div>
			<div>
				<div>이용후기 관리</div>
			</div>
			<!-- <div id="word" style="width: 12%; margin-left: 22%;">
				<div style="font-size: 13pt;">후기 검색</div>
			</div> -->
		</div>
		<div id="searchBar"
			style="display: flex; border: 0px solid red; margin-bottom: 25px;">

			<select name="searchType" style="height: 30px; display: none;">
				<option value="RV_CONTENT">글내용</option>
			</select> <input name="searchWord" placeholder="이름, 도시, 아이디를 입력하세요." size="60"
				style="border-radius: 60px; border: 2px solid #e0e0e0; height: 50px; margin-right: 1%;" />
			<div id="searchIcon" onclick="goSearch()"
				style="background-color: #1668e3;">
				<svg xmlns="http://www.w3.org/2000/svg" height="16" width="16"
					style="min-inline-size: 1.5rem;" ;
				viewBox="0 0 512 512">
			<path fill="#fff"
						d="M416 208c0 45.9-14.9 88.3-40 122.7L502.6 457.4c12.5 12.5 12.5 32.8 0 45.3s-32.8 12.5-45.3 0L330.7 376c-34.4 25.2-76.8 40-122.7 40C93.1 416 0 322.9 0 208S93.1 0 208 0S416 93.1 416 208zM208 352a144 144 0 1 0 0-288 144 144 0 1 0 0 288z" /></svg>
			</div>
		</div>
	</div>

	<div style="margin-top: 1.5%;">

		<div id="review"
			style="border: 0px solid blue; height: 1500px; border-radius: 0.8rem;">
			<div>
				<div style="display: flex;">
					<%-- left side --%>
					<div style="border: solid 0px red; width: 35%; height: 1500px">
						<br>
						<h4 class="rating_avg" style="margin-left: 8%;">
							9.0/10.0 - <span style="font-size: 1rem;">매우 훌륭해요</span>
						</h4>
						<span style="margin-left: 50%;">개 실제 이용 고객 후기</span>
						<div class="rating"
							style="margin-top: 2%; padding-left: 7%; padding-right: 5.5%;">
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

					</div>


					<%-- right side --%>
					<c:if test="${not empty requestScope.commentList}">
						<div style="border: solid 0px blue; width: 65%;">

							<c:forEach var="comment" items="${requestScope.commentList}"
								varStatus="status">

							<input  id="lodge" value="${comment.FK_LODGE_ID}" /> 
							<input  id="regDate" value="${comment.RV_REGDATE}" />
							<input  id="fk_seq" value="${comment.RV_ORG_SEQ}" />
							<input  id="groupno" value="${comment.RV_GROUPNO}" />
							<input  id="rs_seq" value="${comment.FK_RS_SEQ}" />
							<input  id="userid" value="${comment.H_USERID}" /> 
							<input  id="depthno" value="${comment.RV_DEPTHNO}" />
							<input  id="seq" value="${comment.RV_SEQ}" />


								<div>
									<div>
										<c:if test="${comment.RV_DEPTHNO == 0}">

											<div>
												<div>${comment.FK_RV_RATING}/10-
													${comment.RV_RATING_DESC}</div>
												<br> <br>
												<div>${comment.FK_USERID}</div>
												<div>${comment.RV_REGDATE}</div>
												<br>
												<div>${comment.RV_CONTENT}</div>
												<div>${comment.RV_REGDATE}${comment.livedate}숙박함</div>


											</div>

											<br>

											<br>

										</c:if>



										<div>
											<c:if test="${comment.RV_DEPTHNO > 0}">
												<div style="border-bottom: 1px solid #dfe0e4;">
													<br>
													<div>
														<div>
															<c:set var="firstFourChars"
																value="${fn:substring(comment.RV_CONTENT, 0, 4)}" />${firstFourChars}:
															${comment.LG_NAME}, ${comment.RV_REGDATE}
														</div>
													</div>

													<div>
														<div>${comment.RV_CONTENT}</div>
													</div>
													<br>
													<div style="display: flex;"></div>
													<button
														style="width: 10%; margin-right: 1.25rem; height: 30px; border: #fff; background-color: #1668e3; color: #fff; border-radius: 2500rem;"
														type="button" id="updateHere${status.count}" class="update"
														>수정</button>
													<button
														style="width: 10%; height: 30px; border: #fff; background-color: #1668e3; color: #fff; border-radius: 2500rem;"
														type="button" id="delete${status.count}">삭제</button>
													<br>
													<br>

												</div>

											</c:if>

											<c:if test="${comment.RV_DEPTHNO == 0 }">
												<div style="border-bottom: 1px solid #dfe0e4;">

													<button
														style="width: 15%; height: 30px; border: #fff; background-color: #1668e3; color: #fff; border-radius: 2500rem;"
														type="button" id="clickHere${status.count}"
														class="btn_answer">답글 쓰기</button>

													<br> <br>
												</div>
											</c:if>


										</div>

									</div>




									<div id="clickHere${status.count}" class="showanswer"
										style="border-bottom: 1px solid #dfe0e4;">

										<br>
										<div>
											<div>답변</div>

											<textarea style="width: 70%; height: 150px; margin-top: 1%;"
												name="reviewContent"></textarea>

											<br> <br>

											<div>사업자명</div>

											<textarea
												style="width: 70%; height: 40px; margin-top: 1%; font-size: 1.25rem;" readonly>${comment.LG_NAME}</textarea>



											<div style="display: flex; margin-top: 3%;">
												<button type="button"
													style="width: 10%; height: 30px; border: #fff; margin-right: 3%; background-color: #1668e3; color: #fff; border-radius: 2500rem;"
													class="send">전송</button>
												<button class="cansel" type="reset"
													style="width: 10%; height: 30px; border: #fff; background-color: #1668e3; color: #fff; border-radius: 2500rem;">
													취소</button>
											</div>



											




											<br>
										</div>


									</div>

									<div id="updateHere${status.count}" class="wantUpdate"
										style="border-bottom: 1px solid #dfe0e4;">

										<br>
										<div>
											<div>수정</div>

											<textarea style="width: 70%; height: 150px; margin-top: 1%;"
												name="reviewContent"></textarea>

											<br> <br>

											<div>사업자명</div>

											<textarea
												style="width: 70%; height: 40px; margin-top: 1%; font-size: 1.25rem;" readonly>${comment.LG_NAME}</textarea>



											<div style="display: flex; margin-top: 3%;">
												<button type="button"
													style="width: 10%; height: 30px; border: #fff; margin-right: 3%; background-color: #1668e3; color: #fff; border-radius: 2500rem;"
												 	>수정</button>
												<button type="button"
													style="width: 10%; height: 30px; border: #fff; background-color: #1668e3; color: #fff; border-radius: 2500rem;"
													class="closecansel">취소</button>
											</div>



											




											<br>
										</div>


									</div>

								</div>

							</c:forEach>


							<form name="insertFrm">

								<textarea style="display:none; width: 70%; height: 30px; margin-top: 1%;"
									name="c_content"></textarea>


								<input type="hidden" name="c_groupno" /> 
								<input type="hidden" name="fk_lodge_id"/> 
								<input type="hidden" name="c_org_seq" />
								<input type="hidden" name="c_depthno"/>
								<input type="hidden" name="c_seq"/>
								<input type="hidden" name="fk_h_userid"/>
								<input type="hidden" name="c_regDate"/>
								<input type="hidden" name="fk_rs_seq"/>
								<input type="hidden" name="fk_h_userid"/>

							</form>










						</div>
					</c:if>
					<c:if test="${empty requestScope.commentList}">
						<div>등록된 리뷰가 없습니다.</div>
					</c:if>



				</div>




			</div>
		</div>


		<div>

			<div class="row" id="displayHIT" style="text-align: left;"></div>

			<div>
				<p>
					<button type="button"
						style="width: 30%; height: 30px; border: 1px solid black; margin-top: 1%; margin-left: 35%; background-color: #fff; color: #1668e3; border-radius: 2500rem;"
						id="btnMoreHIT">이용 후기 더보기</button>

					<span id="totalCount">${requestScope.totalCount}</span> <span
						id="countHIT">0</span>
				</p>
			</div>
		</div>

	</div>
</div>

<script type="text/javascript">
		/* 댓글 답변 숨기기 다시 생기기  */
		$("div.showanswer").hide();
</script>


