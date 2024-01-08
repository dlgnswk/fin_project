<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	String ctxPath = request.getContextPath();
%>

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/css/jh/trip/trip.css" >

<script type="text/javascript">

	$(document).ready(function(){
		
		// 재훈 : 예약리스트 3개씩만 뿌려주기
		ajax_before_reservation();
		ajax_after_reservation();
		
		// 재훈 : 위시리스트 보여주기
		ajax_wishList()
		
		// 재훈 : 전체 예약보기 버튼 생성
		$("div#show_all").text("내 여행 전체보기");
		
		// 재훈 : 예약보기 버튼클릭 이벤트
		$("div#show_all").click(function(){
			
			// 전체보기를 클릭한 경우
			if($("div#show_all").text() == "내 여행 전체보기"){
				
				// 기존에 있는 예약 지우고
				$("div#beforeTravel").empty();
				$("div#afterTravel").empty();

				// 전체예약 리스트 넣어주기
				ajax_before_reservation_all();
				ajax_after_reservation_all();
				
				// 간단히 보기로 버튼 내용 변경
				$("div#show_all").text("내 여행 간단히 보기")
			}
			// 간단히 보기를 클릭한 경우
			else{
				
				// 기존에 있는 예약 지우고
				$("div#beforeTravel").empty();
				$("div#afterTravel").empty();
				
				// 예약 3개씩 뿌려주기
				ajax_before_reservation();
				ajax_after_reservation();
				
				// 전체보기로 버튼 내용 변경
				$("div#show_all").text("내 여행 전체보기")
				
			}
			
		});
		
		
		// 재훈 : 정보 더보기 버튼 클릭시 정보 더보기 보여주기
		$(document).on("click", "div.more_info", function(){
			$("div.more_info_content").hide();
			$(this).parent().find("div.more_info_content").show();
		});
		
		
		$(document).on("click", "a.delete_wishlist", function(){
			var lodge_id = $(this).parent().find("input").val();
			delete_wishlist(lodge_id);
		});
		
		
	});
	
	// Function Declaration
	$(document).mouseup(function (e) {
		var movewrap = $("div.more_info_content");
		if (movewrap.has(e.target).length === 0) {
			movewrap.hide();
		}
	});
	
	function cancel_reservation(rs_no){
		
		if(confirm("정말로 예약을 취소하시겠습니까?")){
		
			$.ajax({
				url:"<%= ctxPath%>/cancelReservationAjax.action",
				data:{"rs_no":rs_no},
				dataType:"json",
				success : function(json){
					
					if(json.n == 1){
						alert("예약이 성공적으로 취소 되었습니다.");
						window.location.reload();
					}
					else{
						alert("체크인 날짜 기준 72시간 이전이기 때문에\n판매자와 연락바랍니다.");
						window.location.reload();
					}
					
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			
			});
		}
	};
	
	
	function delete_wishlist(lodge_id){
		
		if(confirm("위시리스트에서 삭제하시겠습니까?")){
			
			$.ajax({
				url:"<%= ctxPath%>/deleteWishlistAjax.action",
				data:{"lodge_id":lodge_id},
				dataType:"json",
				success : function(json){
					
					if(json.n == 1){
						alert("위시리스트에서 삭제 되었습니다.");
						window.location.reload();
					}
					else{
						alert("위시리스트 삭제에 실패하였습니다.");
						window.location.reload();
					}
					
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			
			});
		}
		
	};
	
	
	// 체크인 이전의 숙소들을 ajax로 가져오기(3개씩)
	function ajax_before_reservation(){
		
		$.ajax({
			url:"<%= ctxPath%>/beforeReservationAjax.action",
			data:{"userid":"${sessionScope.loginuser.userid}"},
			dataType:"json",
			success : function(json){
				
				let v_html = "";
				
				// 예약내용이 있는 경우
				if(json.length > 0){
					
					$.each(json, function(index, item){
						
						<%-- 1개의 예약 숙소 정보 --%>
						v_html += "<div class='my_travel_info'>";
						
						<%-- 숙소 메인이미지 --%>
						v_html += 	"<div class='my_travel_img'>";
						v_html +=		"<img src='<%= ctxPath%>/resources/images/" + item.lodge_id + "/lodge_img/" + item.lg_img_save_name + "' class='image_thumnail'>";
						v_html += 	"</div>";
							
						<%-- 숙소 정보 --%>
						v_html += 	"<div  class='my_travel_text'>";
							
						<%-- 첫번째 줄 정보 --%>
						v_html += 		"<div class='first_content'>";
									<%-- 숙소 정보 --%>
						v_html += 			"<div class='status_badge'>";
						v_html += 				"<span class='uitk-badge uitk-badge-base-small uitk-badge-base-has-text uitk-badge-positive uitk-spacing uitk-spacing-margin-blockend-half uitk-spacing-margin-inlineend-one uitk-layout-flex-item'>";
						v_html += 					"<span class='uitk-badge-base-text' aria-hidden='false'>예약 완료</span>";
						v_html += 				"</span>";
						v_html += 			"</div>";
									
						<%-- 버튼 --%>
						v_html += 			"<div class='more_info'>";
						v_html += 				"<input class='more_info_id' type='hidden' value='" + item.rs_no + "'>";
						v_html += 				"<svg class='uitk-icon uitk-icon-leading uitk-icon-default-theme' aria-describedby='more_vert-description' role='img' viewBox='0 0 24 24' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink'>";
						v_html += 					"<path fill-rule='evenodd' d='M12 8a2 2 0 0 0 2-2 2 2 0 0 0-2-2 2 2 0 0 0-2 2c0 1.1.9 2 2 2Zm0 2a2 2 0 0 0-2 2c0 1.1.9 2 2 2a2 2 0 0 0 2-2 2 2 0 0 0-2-2Zm-2 8c0-1.1.9-2 2-2a2 2 0 0 1 2 2 2 2 0 0 1-2 2 2 2 0 0 1-2-2Z' clip-rule='evenodd'></path>";
						v_html += 				"</svg>";
						v_html += 			"</div>";
						v_html += 			"<div class='more_info_content'>";
						v_html += 				"<div><a class='go_lodge' href='<%= ctxPath%>/lodgeDetail_info.exp?lodge_id=" + item.lodge_id + "'>숙소 보기</a></div>";
						v_html += 				"<div><a class='go_lodge' href='<%= ctxPath%>/chat.exp?lodge_id=" + item.lodge_id + "'>판매자와 채팅하기</a></div>";
						v_html += 				"<div><a class='go_lodge' onclick='cancel_reservation(" + item.rs_no + ")'>예약취소 하기</a></div>";
						v_html += 			"</div>";
						v_html += 		"</div>";
							
						<%-- 두번째 줄 정보 --%>
						v_html += 		"<div class='second_content'>";
						v_html += 			"<div class='lodge_name'>" + item.lg_name + "</div>";
						v_html += 		"</div>";
							
						<%-- 세번째 줄 정보 --%>
						v_html += 		"<div class='third_content'>";
						v_html += 			"<div class='lodge_checkin'>";
						v_html += 				"체크인 : <span>" + item.rs_month + "월 " + item.rs_day + "일" + "</span>";
						v_html += 			"</div>";
						v_html += 		"</div>";
							
						<%-- 네번째 줄 정보 --%>
						v_html += 		"<div class='fourth_content'>";
						v_html += 			"<div class='reservation_no'>";
						v_html += 				"일정번호 : <span>" + item.rs_no + "</span>";
						v_html += 			"</div>";
						v_html += 		"</div>";
						v_html += 	"</div>";
						v_html += "</div>";
						
						$("div#beforeTravel").html(v_html);
						
					});
					
				}
				else{
					
					v_html += 		"<div class='no_reservation'>";
					v_html += 			"<div>예정된 여행이 없습니다.</div>";
					v_html += 		"</div>";
					
					$("div#beforeTravel").html(v_html);
				}

				// 재훈 : 페이지 로드시  정보 더보기 가리기
				$("div.more_info_content").hide();
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
	}
	
	
	// 체크인 이전의 숙소들을 ajax로 가져오기(전부)
	function ajax_before_reservation_all(){
		
		$.ajax({
			url:"<%= ctxPath%>/beforeReservationAllAjax.action",
			data:{"userid":"${sessionScope.loginuser.userid}"},
			dataType:"json",
			success : function(json){
				
				let v_html = "";
				
				// 예약내용이 있는 경우
				if(json.length > 0){
					
					$.each(json, function(index, item){
						
						<%-- 1개의 예약 숙소 정보 --%>
						v_html += "<div class='my_travel_info'>";
						
						<%-- 숙소 메인이미지 --%>
						v_html += 	"<div class='my_travel_img'>";
						v_html +=		"<img src='<%= ctxPath%>/resources/images/" + item.lodge_id + "/lodge_img/" + item.lg_img_save_name + "' class='image_thumnail'>";
						v_html += 	"</div>";
							
						<%-- 숙소 정보 --%>
						v_html += 	"<div  class='my_travel_text'>";
							
						<%-- 첫번째 줄 정보 --%>
						v_html += 		"<div class='first_content'>";
									<%-- 숙소 정보 --%>
						v_html += 			"<div class='status_badge'>";
						v_html += 				"<span class='uitk-badge uitk-badge-base-small uitk-badge-base-has-text uitk-badge-positive uitk-spacing uitk-spacing-margin-blockend-half uitk-spacing-margin-inlineend-one uitk-layout-flex-item'>";
						v_html += 					"<span class='uitk-badge-base-text' aria-hidden='false'>예약 완료</span>";
						v_html += 				"</span>";
						v_html += 			"</div>";
									
						<%-- 버튼 --%>
						v_html += 			"<div class='more_info'>";
						v_html += 				"<input class='more_info_id' type='hidden' value='" + item.rs_no + "'>";
						v_html += 				"<svg class='uitk-icon uitk-icon-leading uitk-icon-default-theme' aria-describedby='more_vert-description' role='img' viewBox='0 0 24 24' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink'>";
						v_html += 					"<path fill-rule='evenodd' d='M12 8a2 2 0 0 0 2-2 2 2 0 0 0-2-2 2 2 0 0 0-2 2c0 1.1.9 2 2 2Zm0 2a2 2 0 0 0-2 2c0 1.1.9 2 2 2a2 2 0 0 0 2-2 2 2 0 0 0-2-2Zm-2 8c0-1.1.9-2 2-2a2 2 0 0 1 2 2 2 2 0 0 1-2 2 2 2 0 0 1-2-2Z' clip-rule='evenodd'></path>";
						v_html += 				"</svg>";
						v_html += 			"</div>";
						v_html += 			"<div class='more_info_content'>";
						v_html += 				"<div><a class='go_lodge' href='<%= ctxPath%>/lodgeDetail_info.exp?lodge_id=" + item.lodge_id + "'>숙소 보기</a></div>";
						v_html += 				"<div><a class='go_lodge' href='<%= ctxPath%>/chat.exp?lodge_id=" + item.lodge_id + "'>판매자와 채팅하기</a></div>";
						v_html += 				"<div><a class='go_lodge' onclick='cancel_reservation(" + item.rs_no + ")'>예약취소 하기</a></div>";
						v_html += 			"</div>";
						v_html += 		"</div>";
							
						<%-- 두번째 줄 정보 --%>
						v_html += 		"<div class='second_content'>";
						v_html += 			"<div class='lodge_name'>" + item.lg_name + "</div>";
						v_html += 		"</div>";
							
						<%-- 세번째 줄 정보 --%>
						v_html += 		"<div class='third_content'>";
						v_html += 			"<div class='lodge_checkin'>";
						v_html += 				"체크인 : <span>" + item.rs_month + "월 " + item.rs_day + "일" + "</span>";
						v_html += 			"</div>";
						v_html += 		"</div>";
							
						<%-- 네번째 줄 정보 --%>
						v_html += 		"<div class='fourth_content'>";
						v_html += 			"<div class='reservation_no'>";
						v_html += 				"일정번호 : <span>" + item.rs_no + "</span>";
						v_html += 			"</div>";
						v_html += 		"</div>";
						v_html += 	"</div>";
						v_html += "</div>";
						
						$("div#beforeTravel").html(v_html);
						
					});
					
				}
				else{
					
					v_html += 		"<div class='no_reservation'>";
					v_html += 			"<div>예정된 여행이 없습니다.</div>";
					v_html += 		"</div>";
					
					$("div#beforeTravel").html(v_html);
				}

				// 재훈 : 페이지 로드시  정보 더보기 가리기
				$("div.more_info_content").hide();
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
	}
	
	
	// 체크인 이후의 숙소들을 ajax로 가져오기(3개씩)
	function ajax_after_reservation(){
		
		$.ajax({
			url:"<%= ctxPath%>/afterReservationAjax.action",
			data:{"userid":"${sessionScope.loginuser.userid}"},
			dataType:"json",
			success : function(json){
				
				let v_html = "";
				
				// 예약내용이 있는 경우
				if(json.length > 0){
					
					$.each(json, function(index, item){
						
						<%-- 1개의 예약 숙소 정보 --%>
						v_html += "<div class='my_travel_info'>";
						
						<%-- 숙소 메인이미지 --%>
						v_html += 	"<div class='my_travel_img'>";
						v_html +=		"<img src='<%= ctxPath%>/resources/images/" + item.lodge_id + "/lodge_img/" + item.lg_img_save_name + "' class='image_thumnail'>";
						v_html += 	"</div>";
							
						<%-- 숙소 정보 --%>
						v_html += 	"<div  class='my_travel_text'>";
							
						<%-- 첫번째 줄 정보 --%>
						v_html += 		"<div class='first_content'>";
									<%-- 숙소 정보 --%>
						v_html += 			"<div class='status_badge'>";
						if(item.rs_cancel == 0){
							v_html += 			"<span class='uitk-badge uitk-badge-base-small uitk-badge-base-has-text uitk-badge-standard uitk-spacing uitk-spacing-margin-blockend-half uitk-spacing-margin-inlineend-one uitk-layout-flex-item'>";
							v_html += 				"<span class='uitk-badge-base-text' aria-hidden='false'>완료된 여행</span>";
							v_html += 			"</span>";
						}
						else{
							v_html += 			"<span class='uitk-badge uitk-badge-base-small uitk-badge-base-has-text uitk-badge-warning uitk-spacing uitk-spacing-margin-blockend-half uitk-spacing-margin-inlineend-one uitk-layout-flex-item'>";
							v_html += 				"<span class='uitk-badge-base-text' aria-hidden='false'>취소된 여행</span>";
							v_html += 			"</span>";
						}
						v_html += 			"</div>";
									
						<%-- 버튼 --%>
						v_html += 			"<div class='more_info'>";
						v_html += 				"<input class='more_info_id' type='hidden' value='" + item.rs_no + "'>";
						v_html += 				"<svg class='uitk-icon uitk-icon-leading uitk-icon-default-theme' aria-describedby='more_vert-description' role='img' viewBox='0 0 24 24' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink'>";
						v_html += 					"<path fill-rule='evenodd' d='M12 8a2 2 0 0 0 2-2 2 2 0 0 0-2-2 2 2 0 0 0-2 2c0 1.1.9 2 2 2Zm0 2a2 2 0 0 0-2 2c0 1.1.9 2 2 2a2 2 0 0 0 2-2 2 2 0 0 0-2-2Zm-2 8c0-1.1.9-2 2-2a2 2 0 0 1 2 2 2 2 0 0 1-2 2 2 2 0 0 1-2-2Z' clip-rule='evenodd'></path>";
						v_html += 				"</svg>";
						v_html += 			"</div>";
						v_html += 			"<div class='more_info_content'>";
						v_html += 				"<div><a class='go_lodge' href='<%= ctxPath%>/lodgeDetail_info.exp?lodge_id=" + item.lodge_id + "'>다시 예약하기</a></div>";
						if(item.rs_cancel == 0){
							if(item.rv_yn == '-1'){
								v_html += 		"<div><a class='go_lodge reviewWrite' onclick='reviewWrite(" + item.rs_no + ")'>리뷰 작성하기</a></div>";
							}
							else{
								v_html += 		"<div><a class='go_lodge reviewWrite' href='<%= ctxPath%>/myrvlist.exp'>작성한 리뷰보기</a></div>";
							}
						}
						v_html += 			"</div>";
						v_html += 		"</div>";
							
						<%-- 두번째 줄 정보 --%>
						v_html += 		"<div class='second_content'>";
						v_html += 			"<div class='lodge_name'>" + item.lg_name + "</div>";
						v_html += 		"</div>";
							
						<%-- 세번째 줄 정보 --%>
						v_html += 		"<div class='third_content'>";
						v_html += 			"<div class='lodge_checkin'>";
						v_html += 				"체크인 : <span>" + item.rs_month + "월 " + item.rs_day + "일" + "</span>";
						v_html += 			"</div>";
						v_html += 		"</div>";
							
						<%-- 네번째 줄 정보 --%>
						v_html += 		"<div class='fourth_content'>";
						v_html += 			"<div class='reservation_no'>";
						v_html += 				"일정번호 : <span>" + item.rs_no + "</span>";
						v_html += 			"</div>";
						v_html += 		"</div>";
						v_html += 	"</div>";
						v_html += "</div>";
						
						$("div#afterTravel").html(v_html);
						
					});
					
				}
				else{
					
					v_html += 		"<div class='no_reservation'>";
					v_html += 			"<div>완료된 여행이 없습니다.</div>";
					v_html += 		"</div>";
					
					$("div#afterTravel").html(v_html);
				}

				// 재훈 : 페이지 로드시  정보 더보기 가리기
				$("div.more_info_content").hide();
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
	}
	
	
	// 체크인 이후의 숙소들을 ajax로 가져오기(전부)
	function ajax_after_reservation_all(){
		
		$.ajax({
			url:"<%= ctxPath%>/afterReservationAllAjax.action",
			data:{"userid":"${sessionScope.loginuser.userid}"},
			dataType:"json",
			success : function(json){
				
				let v_html = "";
				
				// 예약내용이 있는 경우
				if(json.length > 0){
					
					$.each(json, function(index, item){
						
						<%-- 1개의 예약 숙소 정보 --%>
						v_html += "<div class='my_travel_info'>";
						
						<%-- 숙소 메인이미지 --%>
						v_html += 	"<div class='my_travel_img'>";
						v_html +=		"<img src='<%= ctxPath%>/resources/images/" + item.lodge_id + "/lodge_img/" + item.lg_img_save_name + "' class='image_thumnail'>";
						v_html += 	"</div>";
							
						<%-- 숙소 정보 --%>
						v_html += 	"<div  class='my_travel_text'>";
							
						<%-- 첫번째 줄 정보 --%>
						v_html += 		"<div class='first_content'>";
									<%-- 숙소 정보 --%>
						v_html += 			"<div class='status_badge'>";
						if(item.rs_cancel == 0){
							v_html += 			"<span class='uitk-badge uitk-badge-base-small uitk-badge-base-has-text uitk-badge-standard uitk-spacing uitk-spacing-margin-blockend-half uitk-spacing-margin-inlineend-one uitk-layout-flex-item'>";
							v_html += 				"<span class='uitk-badge-base-text' aria-hidden='false'>완료된 여행</span>";
							v_html += 			"</span>";
						}
						else{
							v_html += 			"<span class='uitk-badge uitk-badge-base-small uitk-badge-base-has-text uitk-badge-warning uitk-spacing uitk-spacing-margin-blockend-half uitk-spacing-margin-inlineend-one uitk-layout-flex-item'>";
							v_html += 				"<span class='uitk-badge-base-text' aria-hidden='false'>취소된 여행</span>";
							v_html += 			"</span>";
						}
						v_html += 			"</div>";
									
						<%-- 버튼 --%>
						v_html += 			"<div class='more_info'>";
						v_html += 				"<input class='more_info_id' type='hidden' value='" + item.rs_no + "'>";
						v_html += 				"<svg class='uitk-icon uitk-icon-leading uitk-icon-default-theme' aria-describedby='more_vert-description' role='img' viewBox='0 0 24 24' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink'>";
						v_html += 					"<path fill-rule='evenodd' d='M12 8a2 2 0 0 0 2-2 2 2 0 0 0-2-2 2 2 0 0 0-2 2c0 1.1.9 2 2 2Zm0 2a2 2 0 0 0-2 2c0 1.1.9 2 2 2a2 2 0 0 0 2-2 2 2 0 0 0-2-2Zm-2 8c0-1.1.9-2 2-2a2 2 0 0 1 2 2 2 2 0 0 1-2 2 2 2 0 0 1-2-2Z' clip-rule='evenodd'></path>";
						v_html += 				"</svg>";
						v_html += 			"</div>";
						v_html += 			"<div class='more_info_content'>";
						v_html += 				"<div><a class='go_lodge' href='<%= ctxPath%>/lodgeDetail_info.exp?lodge_id=" + item.lodge_id + "'>다시 예약하기</a></div>";
						if(item.rs_cancel == 0){
							if(item.rv_yn == '-1'){
								v_html += 		"<div><a class='go_lodge reviewWrite' onclick='reviewWrite(" + item.rs_no + ")'>리뷰 작성하기</a></div>";
							}
							else{
								v_html += 		"<div><a class='go_lodge reviewWrite' href='<%= ctxPath%>/myrvlist.exp'>작성한 리뷰보기</a></div>";
							}
						}
						v_html += 			"</div>";
						v_html += 		"</div>";
							
						<%-- 두번째 줄 정보 --%>
						v_html += 		"<div class='second_content'>";
						v_html += 			"<div class='lodge_name'>" + item.lg_name + "</div>";
						v_html += 		"</div>";
							
						<%-- 세번째 줄 정보 --%>
						v_html += 		"<div class='third_content'>";
						v_html += 			"<div class='lodge_checkin'>";
						v_html += 				"체크인 : <span>" + item.rs_month + "월 " + item.rs_day + "일" + "</span>";
						v_html += 			"</div>";
						v_html += 		"</div>";
							
						<%-- 네번째 줄 정보 --%>
						v_html += 		"<div class='fourth_content'>";
						v_html += 			"<div class='reservation_no'>";
						v_html += 				"일정번호 : <span>" + item.rs_no + "</span>";
						v_html += 			"</div>";
						v_html += 		"</div>";
						v_html += 	"</div>";
						v_html += "</div>";
						
						$("div#afterTravel").html(v_html);
						
					});
					
				}
				else{
					
					v_html += 		"<div class='no_reservation'>";
					v_html += 			"<div>완료된 여행이 없습니다.</div>";
					v_html += 		"</div>";
					
					$("div#afterTravel").html(v_html);
				}

				// 재훈 : 페이지 로드시  정보 더보기 가리기
				$("div.more_info_content").hide();
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
	}
	
	
	// 좋아요 누른 숙소들을 ajax로 가져오기
	function ajax_wishList(){
		
		$.ajax({
			url:"<%= ctxPath%>/getWishListAjax.action",
			data:{"userid":"${sessionScope.loginuser.userid}"},
			dataType:"json",
			success : function(json){
				
				let v_html = "";
				
				// 예약내용이 있는 경우
				if(json.length > 0){
					
					$.each(json, function(index, item){
						
						<%-- 1개의 예약 숙소 정보 --%>
						v_html += "<div>";
						v_html += 	"<div class='my_wish_travel_info'>";
						
						<%-- 숙소 메인이미지 --%>
						v_html += 		"<div class='my_wish_travel_img'>";
						v_html +=			"<img src='<%= ctxPath%>/resources/images/" + item.lodge_id + "/lodge_img/" + item.lg_img_save_name + "' class='image_thumnail'>";
						v_html += 		"</div>";
							
						<%-- 숙소 정보 --%>
						v_html += 		"<div  class='my_travel_text'>";
							
						<%-- 첫번째 줄 정보 --%>
						v_html += 			"<div class='first_content'>";
									<%-- 숙소 정보 --%>
						v_html += 				"<div class='status_badge'>";
						v_html += 					"<svg class='uitk-icon uitk-spacing uitk-spacing-padding-inlineend-one uitk-icon-xsmall uitk-icon-negative-theme' aria-hidden='true' viewBox='0 0 24 24' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink'>";
						v_html += 						"<path fill-rule='evenodd' d='m12 22-8.44-8.69a5.55 5.55 0 0 1 0-7.72C4.53 4.59 5.9 4 7.28 4c1.4 0 2.75.59 3.72 1.59l1 1.02 1-1.02c.97-1 2.32-1.59 3.72-1.59 1.4 0 2.75.59 3.72 1.59a5.55 5.55 0 0 1 0 7.72L12 22Z' clip-rule='evenodd'></path>";
						v_html += 					"</svg>";
						v_html += 					"<span>저장됨</span>"
						v_html += 				"</div>";
									
						<%-- 버튼 --%>
						v_html += 				"<div class='more_info'>";
						v_html += 					"<input class='more_info_id' type='hidden' value='" + item.rs_no + "'>";
						v_html += 					"<svg class='uitk-icon uitk-icon-leading uitk-icon-default-theme' aria-describedby='more_vert-description' role='img' viewBox='0 0 24 24' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink'>";
						v_html += 						"<path fill-rule='evenodd' d='M12 8a2 2 0 0 0 2-2 2 2 0 0 0-2-2 2 2 0 0 0-2 2c0 1.1.9 2 2 2Zm0 2a2 2 0 0 0-2 2c0 1.1.9 2 2 2a2 2 0 0 0 2-2 2 2 0 0 0-2-2Zm-2 8c0-1.1.9-2 2-2a2 2 0 0 1 2 2 2 2 0 0 1-2 2 2 2 0 0 1-2-2Z' clip-rule='evenodd'></path>";
						v_html += 					"</svg>";
						v_html += 				"</div>";
						v_html += 				"<div class='more_info_content'>";
						v_html += 					"<div><a class='go_lodge' href='<%= ctxPath%>/lodgeDetail_info.exp?lodge_id=" + item.lodge_id + "'>예약하기</a></div>";
						v_html += 					"<div><a class='go_lodge delete_wishlist' >위시리스트에서 삭제</a><input id='" + item.lodge_id + "' type='hidden' value='" + item.lodge_id + "' /></div>";
						v_html += 				"</div>";
						v_html += 			"</div>";
							
						<%-- 두번째 줄 정보 --%>
						v_html += 			"<div class='second_content'>";
						v_html += 				"<div class='lodge_name'>" + item.lg_name + "</div>";
						v_html += 			"</div>";
							
						<%-- 세번째 줄 정보 --%>
						v_html += 			"<div class='third_content'>";
						v_html += 				"<div class='lodge_price'>";console.log(item.min_price);
						v_html += 					"&#8361; <span>" + Number(item.min_price).toLocaleString('en') +"</span>";
						v_html += 				"</div>";
						v_html += 			"</div>";
							
						<%-- 네번째 줄 정보 --%>
						v_html += 			"<div class='fourth_content wishlist_content'>";
						v_html += 				"<div class='lodge_rating'>";
						if(item.rating == "평점없음"){
							v_html += 				"<span>" + item.rating + "</span> (";
						}
						else{
							v_html += 				"<span>" + item.rating + "</span>/10 (";
						}
						if(item.review_cnt == "리뷰없음"){
							v_html += 				"<span>이용후기없음</span>)";
						}
						else{
							v_html += 				"<span>" + item.review_cnt + "</span>개 이용 후기)";
						}
						v_html += 				"</div>";
						v_html += 				"<div class='lodge_price_date'>1박당</div>";
						v_html += 			"</div>";
						
						v_html += 		"</div>";
						
						v_html += 	"</div>";
						v_html += "</div>";
						
						$("div.my_wish_travel_list").html(v_html);
						
					});

					// 재훈 : 페이지 로드시  정보 더보기 가리기
					$("div.more_info_content").hide();
					
				}
				else{
					
					v_html += 		"<div class='no_wishlist'>";
					v_html += 			"<div>위시리스트에 추가한 숙소가 없습니다.</div>";
					v_html += 		"</div>";
					
					$("div.my_wish_travel_list").html(v_html);
				}
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
	}
	
	
</script>

<body  style="background-color: f3f3f5;">
	<div style="inline-size: 100%; margin: auto; max-inline-size: 75rem; padding: 50px 0;">
			
		<div class="my_travel_title">
			<div>내 여행</div>
			<div id="show_all"></div>
		</div>
		
		
		<div class="my_travel_list">
			<div class="my_travel_info_title">
				예정된 여행
			</div>
			
			<div class="my_travel_info_title">
				완료된 여행
			</div>
		</div>
		
		<div class="my_travel_list my_travel_content">
			
			<%-- N개의 예약 숙소 정보 리스트 --%>
			<div id="beforeTravel">
				<%-- 체크인 이전의 숙소들이 json으로 들어오는 곳 --%>
			</div>
			
			<%-- N개의 예약 숙소 정보 리스트 --%>
			<div id="afterTravel">
				<%-- 체크인 이후의 숙소들이 json으로 들어오는 곳 --%>
			</div>
		
		</div>	
		
		<div class="my_travel_title">
			위시리스트
		</div>
		
		<div class="my_wish_travel_list my_travel_content">
			<%-- 위시리스트에 추가한 숙소들이 json으로 들어오는 곳 --%>
			<a></a>
		</div>	
		
	</div>
</body>



