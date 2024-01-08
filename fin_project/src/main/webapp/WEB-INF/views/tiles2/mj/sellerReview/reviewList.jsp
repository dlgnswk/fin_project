<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%
	String ctxPath = request.getContextPath();
%>



<script type="text/javascript">
	$(document).ready(function() {
				
		
						
		
						
					// 여기부터 ajax 시작
					//$("button.btn_answer").click(function(e) {
						$(document).on('click',"button.ajx_btn_answer",function(e){	

							// alert($(e.target).attr("id"));  
							
							//alert("확인완료");	
							
							$(e.target).next().show();
							
							
						}); 
						
						$(document).on('click',"button.cansel",function(e){	

							//alert("해결완료임ㅋㅋ");

							$(e.target).parent().parent().parent().hide();
						});
					
					
					
					
					// 여기부터 ajax 끝
		
		
		
					/* 답글쓰기 시작  */
						//$("button.btn_answer").click(function(e) {
						$(document).on('click',"button.btn_answer",function(e){	

							// alert($(e.target).attr("id"));  
							
							// alert("확인완료");	
							
							$("div#"+$(e.target).attr("id")).show();
							
							
						}); 
						
						
						$("button.cansel").click(function() {

							//  alert("확인완료임ㅋㅋ");

							$("div.showanswer").hide();
						});
				
						
						
						
						$("button.send").click(function(e){
							 const index = $("button.send").index($(e.target));
							 console.log(index);
								
							/* 답글쓰기 유효성검사  */
							const reviewContent2 = $("textarea[name='reviewContent']").eq(index).val().trim();
							
							if(reviewContent2 == "") {
								alert("답변을 입력하세요!!");
								return; // 종료
							}
							
								
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
						
							
						$("button.updateBtn").click(function(e){
							
						    const index = $("button.updateBtn").index($(e.target));
						    console.log("index: ", index);

							
						    const updateTextarea = $("textarea[name='updateTextarea']").eq(index).val().trim();

						    if (updateTextarea === "") {
						        alert("수정하려면 답변을 입력하세요!!");
						        return; // 종료
						    }
						
						    
						    
						    
						    const cContentValue = $("textarea[name='c_content']");
							   cContentValue.val(updateTextarea);
							   
							   
						
							    
							
							   
							   const regDate = $("input[id='regDate']").eq(index).val();
							   
							     let c_regDate = $("input[name='c_regDate']");

							 
							     c_regDate.val(regDate);
							    
							
							   
							   
								   const seq = $("input[id='seq']").eq(index).val();
								   
								     let c_seq = $("input[name='c_seq']");

								 
								     c_seq.val(seq);
								    
								     
								
							const frm = document.forms["updateFrm"];
						   	 frm.method = "post";
						   	 frm.action = "<%=ctxPath%>/updateEnd.exp";
							 frm.submit();
							
						
						});
						
						
						/* 삭제 구현하기 */
						$("button.delete").click(function(e){
							
						    const index = $("button.delete").index($(e.target));
						   //  console.log("index: ", index);	
						   
						   
							
							 
								
							   
								   const seq = $("input[id='seq']").eq(index).val();
								   
								     let c_seq = $("input[name='c_seq']");

								 
								     c_seq.val(seq);
								    
								     
								
								
								    
									
									const frm = document.forms["deleteFrm"];
								   	 frm.method = "post";
								   	 frm.action = "<%=ctxPath%>/deleteEnd.exp";
									frm.submit();

								});

						$("input:text[name='searchWord']").bind("keyup",
								function(e) {
									if (e.keyCode == 13) { // 엔터를 했을 경우 
										goSearch();
									}
								});

						// displayHIT("1");
						
						// HIT 상품 게시물을 더보기 위하여 "더보기..." 버튼 클릭액션 이벤트 등록하기  
						$("button#btnMoreHIT").click(function() {


								displayHIT($(this).val());
								// displayHIT("9");   첫번째로 더보기를 클릭한 경우
								// displayHIT("17");  두번째로 더보기를 클릭한 경우
								// displayHIT("25");  세번째로 더보기를 클릭한 경우
								// displayHIT("33");  네번째로 더보기를 클릭한 경우
							

						});// end of $("button#btnMoreHIT").click(function(){})---


					});

	
	let lenHIT = 2;
	// HIT 상품 "더보기..." 버튼을 클릭할때 보여줄 상품의 개수(단위)크기 

	// display 할 HIT상품 정보를 추가 요청하기(Ajax 로 처리함)
	function displayHIT(start) { // start가  1 이라면   1~ 8  까지 상품 8개를 보여준다.
		// start가  9 이라면   9~16  까지 상품 8개를 보여준다.
		// start가 17 이라면  17~24  까지 상품 8개를 보여준다.
		// start가 25 이라면  25~32  까지 상품 8개를 보여준다.
		// start가 33 이라면  33~36  까지 상품 4개를 보여준다.(마지막 상품)

		v_html = "";
		
		$.ajax({
			url : "mallDisplayJSON.exp",
			//	type:"get",
			data : {
				"searchWord" : $("input[name='searchWord']").val(),
				"start" : start, // "1"  "9"  "17"  "25"  "33"
				"len" : lenHIT
			}, //  8    8    8     8     8
			dataType : "json",
			success : function(json) {
				
				console.log(json)

				if (json.length > 0) {

					$.each(json, function(index, item) {

						 
						
						 if (item.word.RV_DEPTHNO == 0) {
						
							 
							 v_html += "<br><div>"+"<div>" + item.word.FK_RV_RATING + "/10 " + item.word.RV_RATING_DESC + "</div><br><br>" +
									          "<div>" + item.word.FK_USERID + "</div>" +
									          "<div>" + item.word.RV_REGDATE + "</div><br>" +
									          "<div>" + item.word.RV_CONTENT + "</div>" +
									          "<div>" + item.word.RV_REGDATE + item.word.livedate + "숙박함" + "</div>"+"</div> <br><br>"+
															  
									          "<button class='ajx_btn_answer' style='width: 28%; height: 30px; border: #fff; background-color: #1668e3; color: #fff; border-radius: 2500rem;' " +
									          "type='button'>답글 쓰기</button>" + 
											  "<div class='ajx_showanswer' style='border-bottom: 1px solid #dfe0e4;'>" + 
												  "<br>" + 
												  "<div>"+
													  "<div>답변</div>" +
													  "<textarea style='width: 130%; height: 150px; margin-top: 1%;' name='reviewContent'></textarea>" + 
													  "<br>" +
													  "<br>" + 
												      "<div>사업자명</div>" + 
													  "<textarea style='width: 130%; height: 40px; margin-top: 1%; font-size: 1.25rem;' readonly>" + item.word.LG_NAME + "</textarea>" + 
													  "<div style='display: flex; margin-top: 3%;'>" + 
														  "<button type='button' style='width: 17%; height: 30px; border: #fff; margin-right: 6%; background-color: #1668e3; color: #fff; border-radius: 2500rem;' class='send'>전송</button>" + 
														  "<button class='cansel' type='reset' style='width: 17%; height: 30px; border: #fff; background-color: #1668e3; color: #fff; border-radius: 2500rem;'>취소</button>" + 
													  "</div>" + 
													  "<br>" + 
												  "</div>" + 
											  "</div>";
									          
						 }
						 
						 if (item.word.RV_DEPTHNO > 0) {
							 v_html += "<div style='border-bottom: 1px solid #dfe0e4; width: 200%;'>" +
				              "<div>" +
				              "<div>" + "답변제공" + ":" + item.word.LG_NAME + "," + item.word.RV_REGDATE + "</div>" +
				              "</div>" +
				              "<div>" + "<div>" + item.word.RV_CONTENT + "</div>" + "</div>" +
				              "</div><br>";
							}
						

					});// end of $.each(json, function(index, item)-----

					// HIT 상품 결과를 출력하기
					$("div#displayHIT").append(v_html);

					// !!!!! 중요 !!!!!
					// 더보기... 버튼의 value 속성에 값을 지정하기 
					$("button#btnMoreHIT").val(Number(start) + lenHIT);
					// 더보기... 버튼의 value 값이  "9" 로 변경된다.
					// 더보기... 버튼의 value 값이 "17" 로 변경된다.
					// 더보기... 버튼의 value 값이 "25" 로 변경된다.
					// 더보기... 버튼의 value 값이 "33" 로 변경된다.
					// 더보기... 버튼의 value 값이 "41" 로 변경된다.(존재하지 않는 것이다) 

					// span#countHIT 에 지금까지 출력된 상품의 개수를 누적해서 기록한다.
					console.log(Number($("span#countHIT").text()))
					console.log(json.length)

					
					$("span#countHIT").text(
							Number($("span#countHIT").text()) + json.length);

					// 더보기... 버튼을 계속해서 클릭하여 countHIT 값과 totalHITCount 값이 일치하는 경우 
					if ($("span#countHIT").text() == $("span#totalHITCount")
							.text()) {
						$("span#end").html("더이상 조회할 제품이 없습니다.");
						$("button#btnMoreHIT").disabled();
						//$("span#countHIT").text("0");
					}

				}
			},
			error : function(request, status, error) {
				alert("code: " + request.status + "\n" + "message: "
						+ request.responseText + "\n" + "error: " + error);
			}
		});

	}
</script>

<link rel="stylesheet" type="text/css"
	href="<%=ctxPath%>/resources/css/mj/review/list.css" />


<div id="container" >
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
		<form>
			<div id="searchBar"
				style="display: flex; border: 0px solid red; margin-bottom: 25px;">
				<input type="hidden" name="userid" value="${requestScope.userid}" />

				<input type="text" name="searchWord" placeholder="내용을 입력하세요."
					size="60"
					style="border-radius: 60px; border: 2px solid #e0e0e0; height: 50px; margin-right: 1%;" value="${searchWord} "/>
				<button id="searchIcon" style="background-color: #1668e3;">
					<svg xmlns="http://www.w3.org/2000/svg" height="16" width="16"
						style="min-inline-size: 1.5rem;" ;
					viewBox="0 0 512 512">
				<path fill="#fff"
							d="M416 208c0 45.9-14.9 88.3-40 122.7L502.6 457.4c12.5 12.5 12.5 32.8 0 45.3s-32.8 12.5-45.3 0L330.7 376c-34.4 25.2-76.8 40-122.7 40C93.1 416 0 322.9 0 208S93.1 0 208 0S416 93.1 416 208zM208 352a144 144 0 1 0 0-288 144 144 0 1 0 0 288z" /></svg>
				</button>
			</div>
		</form>
	</div>

	<div style="margin-top: 1.5%;">

		<div id="review"
			style="border: 0px solid blue; border-radius: 0.8rem;">
			<div>
				<div style="display: flex;">
					<%-- left side --%>
					<div style="border: solid 0px red; width: 35%;">
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

							<div id="showResult"></div>

							<c:forEach var="comment" items="${requestScope.commentList}"
								varStatus="status">

								<c:set var="firstFourChars"
									value="${fn:substring(comment.RV_CONTENT, 0, 4)}" />

								<input id="lodge" value="${comment.FK_LODGE_ID}" />
								<input id="regDate" value="${comment.RV_REGDATE}" />
								<input id="fk_seq" value="${comment.RV_ORG_SEQ}" />
								<input id="groupno" value="${comment.RV_GROUPNO}" />
								<input id="rs_seq" value="${comment.FK_RS_SEQ}" />
								<input id="userid" value="${comment.H_USERID}" />
								<input id="depthno" value="${comment.RV_DEPTHNO}" />
								<input id="seq" value="${comment.RV_SEQ}" />
								<input id="testcontent" value="${comment.RV_CONTENT}" />
								<input id="firstFourChars1" value="${firstFourChars}" />


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

											<div style="border-bottom: 1px solid #dfe0e4;">

												<button
													style="width: 15%; height: 30px; border: #fff; background-color: #1668e3; color: #fff; border-radius: 2500rem;"
													type="button" id="clickHere${status.count}"
													class="btn_answer">답글 쓰기</button>

												<br> <br>
											</div>

										</c:if>



										<div>
											<c:if test="${comment.RV_DEPTHNO > 0}">
												<div style="border-bottom: 1px solid #dfe0e4;">
													<br>
													<div>
														<div>${firstFourChars}: ${comment.LG_NAME},
															${comment.RV_REGDATE}</div>
													</div>

													<div>
														<div>${comment.RV_CONTENT}</div>
													</div>
													<br>
													<div style="display: flex;"></div>
													<button
														style="width: 10%; margin-right: 1.25rem; height: 30px; border: #fff; background-color: #1668e3; color: #fff; border-radius: 2500rem;"
														type="button" id="updateHere${status.count}"
														class="update">수정</button>
													<button
														style="width: 10%; height: 30px; border: #fff; background-color: #1668e3; color: #fff; border-radius: 2500rem;"
														type="button" class="delete">삭제</button>
													<br> <br>

												</div>

											</c:if>



											<c:if test='${firstFourChars == "답변제공" }'>
												<script type="text/javascript">
													$(document)
															.ready(
																	function() {
																		console
																				.log("clickHere${status.count-1}")
																		$(
																				"#clickHere${status.count-1}")
																				.remove()
																	})
												</script>
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
												style="width: 70%; height: 40px; margin-top: 1%; font-size: 1.25rem;"
												readonly>${comment.LG_NAME}</textarea>



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
												name="updateTextarea"></textarea>

											<br> <br>

											<div>사업자명</div>

											<textarea
												style="width: 70%; height: 40px; margin-top: 1%; font-size: 1.25rem;"
												readonly>${comment.LG_NAME}</textarea>



											<div style="display: flex; margin-top: 3%;">
												<button type="button"
													style="width: 10%; height: 30px; border: #fff; margin-right: 3%; background-color: #1668e3; color: #fff; border-radius: 2500rem;"
													class="updateBtn">수정</button>
												<button type="button"
													style="width: 10%; height: 30px; border: #fff; background-color: #1668e3; color: #fff; border-radius: 2500rem;"
													class="closecansel">취소</button>
											</div>








											<br>
										</div>


									</div>

								</div>

							</c:forEach>


							<form name="insertFrm" id="insertFrm">

								<textarea
									style="display: none; width: 70%; height: 30px; margin-top: 1%;"
									name="c_content"></textarea>


								<input type="hidden" name="c_groupno" /> <input type="hidden"
									name="fk_lodge_id" /> <input type="hidden" name="c_org_seq" />
								<input type="hidden" name="c_depthno" /> <input type="hidden"
									name="c_seq" /> <input type="hidden" name="fk_h_userid" /> <input
									type="hidden" name="c_regDate" /> <input type="hidden"
									name="fk_rs_seq" /> <input type="hidden" name="fk_h_userid" />

							</form>


							<form name="updateFrm" id="updateFrm">

								<textarea
									style="display: none; width: 70%; height: 30px; margin-top: 1%;"
									name="c_content"></textarea>


								<input type="hidden" name="c_seq" /> <input type="hidden"
									name="c_regDate" />

							</form>


							<form name="deleteFrm" id="deleteFrm">


								<input type="hidden" name="c_seq" />


							</form>








						<div class="row" id="displayHIT" style="display:inline-block;"></div>
				
						</div>
					</c:if>
					<c:if test="${empty requestScope.commentList}">
						<div>등록된 리뷰가 없습니다.</div>
					</c:if>



				</div>




			</div>
		</div>


		<div>

			




			<div>
				<p class="text-center">
					<span id="end"
						style="display: block; margin: 20px; font-size: 14pt; font-weight: bold; color: red;"></span>
					<button type="button" 
						id="btnMoreHIT" value="3" style="width:20%;">더보기...</button>
					<span id="totalHITCount">${requestScope.totalCount}</span> <span
						id="countHIT">2</span>
				</p>
			</div>


			<%-- <div>
				<p>
					 <span id="end"></span> 
					<button type="button"
						style="width: 30%; height: 30px; border: 1px solid black; margin-top: 1%; margin-left: 35%; background-color: #fff; color: #1668e3; border-radius: 2500rem;"
						id="btnMoreHIT" value=""></button>

					<span id="totalCount">${requestScope.totalCount}</span> <span
						id="countHIT">0</span>
				</p>
			</div> --%>
		</div>

	</div>
</div>

<script type="text/javascript">
	/* 댓글 답변 숨기기 다시 생기기  */	
	$("div.showanswer").hide();

</script>


