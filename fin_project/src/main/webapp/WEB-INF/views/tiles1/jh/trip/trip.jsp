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
		
		
		// 채혁, 재훈 : 리뷰 작성하기
		$(document).on("click", "button#btnWrite", function(){
			console.log("안됨");
			
			<%-- 
			// 이용후기 제목 유효성 검사
			const rv_subject = $("input:text[name= 'rv_subject']").val().trim();
			if(rv_subject == "") {
				alert("제목을 입력하세요!");
				return;
			}
			--%>
			// 이용후기 내용 유효성 검사
			const rv_content = $("textarea[name='rv_content']").val().trim(); 
			if(rv_content == "") {
				alert("내용을 입력하세요!");
				return;
			}
			
			// 이용후기 평점 입력 유효성 검사
			const rv_rating = document.querySelectorAll('.rateCircle label');
            
            const checked = document.querySelector('.rateCircle input[type=radio]:checked');
            if (!checked) {
                alert("평점을 입력해주세요!");
                return;
            }
            
			// 폼 (form)을 적용하자
			const frm = document.reviewWriteForm;
			frm.method = "post";
			frm.action = "<%= ctxPath%>/reviewInsert.exp";
			frm.submit();
			
		});
		
		
		// 채혁 ==============================================================
		$("input[type=radio]").change(function(){
			console.log($(this).val());
			console.log($(this).attr("id"));
		})
		
		const ratingText = {
		    2: '너무 별로예요',
		    4: '별로예요',
		    6: '괜찮아요',
		    8: '좋아요',
		    10: '훌륭해요'
		  };
			
		  $(document).on('click', '.rateCircle label', function() {
			// 클릭한 별점의 값을 가져와서 정수형으로 변환하여 ratingValue에 저장
			const ratingValue = parseInt($(this).attr('for').split('_')[1]);
			
			// 별점 설명이 표시될 span 요소를 찾아 ratingDescSpan에 저장
			const ratingDescSpan = $('#rating_desc');
		    
			// ratingDescSpan에 선택한 별점과 해당하는 설명을 표시
			ratingDescSpan.text(`\${ratingValue} - \${ratingText[ratingValue]}`);
		   // console.log('Rating Value:', ratingValue);
		   //  console.log('ratingDescSpan', ratingDescSpan);
		    // 원하는 작업을 추가하세요. <span id='rating_desc'></span>
		    
		  });
		// 채혁 ==============================================================
		
		
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
						v_html += 				"<div class='lodge_price'>";
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
	
	
	// 리뷰작성 버튼 클릭시
	function reviewWrite(rs_seq) {
	
		$.ajax({
			url: "<%= ctxPath%>/reviewWrite.exp",  
			data: {"rs_seq": rs_seq},
			dataType: "json",
			success: function (json) {
				console.log(JSON.stringify(json));
				var v_html = 
					"<div class='reviewWriteModal' id='reviewWriteModal'>" +
						"<div class='reviewWriteModal_header'>" +
							"<span class='close'>&times;</span>" +
							
							"<div class='reviewWriteModal_content' style='padding-left: 22%; height: 570px; overflow-y: auto;'>" +
								
								"<h4>귀하의 경험에 대해 평가해주세요.</h4>" +
								"<br>" +
								
				    			"<div class='rating'>" +
					    			"<fieldset class='rateCircle'>" +
					    				"<span style='display:flex'>" +
							    			"<input type='radio' id='ratingpoint_2' name='fk_rv_rating' value='2'/>" +
							    			"<label for='ratingpoint_2'></label>" +
							    			"<input type='radio' id='ratingpoint_4' name='fk_rv_rating' value='4'/>" +
							    			"<label for='ratingpoint_4'></label>" +
							    			"<input type='radio' id='ratingpoint_6' name='fk_rv_rating' value='6'/>" +
							    			"<label for='ratingpoint_6'></label>" +
							    			"<input type='radio' id='ratingpoint_8' name='fk_rv_rating' value='8'/>" +
							    			"<label for='ratingpoint_8'></label>" +
							    			"<input type='radio' id='ratingpoint_10' name='fk_rv_rating' value='10'/>" +
							    			"<label for='ratingpoint_10'></label>" +
							    			"<span id='rating_desc' style='margin: 2% 0 0 5%;'></span>" +
						    			"</span>" +
					    			"</fieldset>" +
					    		"</div>" +
					    		
				    			"<input type='hidden' id='rs_seq_input' name='rs_seq' value='" + rs_seq +"'>" +
				    			
				    			"<input type='hidden' name='fk_lodge_id' size='33' readonly/>" +
				    			
				    			"<br>" +
				    			
				    			"<div class='rv_subject'>" +
					    			"<h4>제목</h4>" +
					    			"<input type='text' name='rv_subject' size='50' maxlength='200' autocomplete='off'/>" +
				    			"</div>" +
				    			
				    			"<div class='rv_content'>" +
					    			"<h4>리뷰 쓰기</h4>" +
					    			"<textarea name='rv_content' id='content' autocomplete='off'></textarea>" +
				    			"</div>" +
				    			
				    			"<div>" +
				    				"<button type='button' id='btnWrite'>글쓰기</button>" +
				    			"</div>" +
				    			
			    			"</div>" +
		    			"</div>" +
	    			"</div>";
				
	    			$("div.more_info_content").hide();
	    			
				// 모달 영역에 새로운 내용 삽입
				$("form[name='reviewWriteForm']").html(v_html);
				
				const labels = document.querySelectorAll('.rateCircle label');
	            
	            const checked = document.querySelector('.rateCircle input[type=radio]:checked');
	            if (!checked) {
	                labels.forEach((label) => {
	                    label.style.backgroundImage = `url('<%= ctxPath%>/resources/images/ch/circle-regular.png')`;	              
	                });
	            } 
	            
	            else {
	                // 선택된 별 이후의 별은 'circle-regular.png' 이미지로, 그 이하는 'circle-solid.png' 이미지로 변경
	                const checkedIndex = Array.from(labels).indexOf(checked.nextElementSibling);
	                // console.log(checkedIndex); // 선택된 레이블의 index
	                for (let i = 0; i <= checkedIndex; i++) {
	                    labels[i].style.backgroundImage = `url('<%= ctxPath%>/resources/images/ch/circle-solid.png')`;
	                }
	                for (let i = checkedIndex + 1; i < labels.length; i++) {
	                	
	                    labels[i].style.backgroundImage = `url('<%= ctxPath%>/resources/images/ch/circle-regular.png')`;
	                }
	                
	            }
				
				
				
				// 모달 표시
				$(".reviewWriteModal").fadeIn();
				$(".reviewWriteModal_header").show();
				$("body").addClass("modal-open");
				
				
				// 모달창 뜰 때 배경색 변경
				$('#headerOfheader > div > section').css('background-color', 'background: rgba(0, 0, 0, 0.4);');
				$('#mycontent > div').css('background-color', 'rgba(0, 0, 0, 0.0)');				
				$('#beforeTravel > div').css('background-color', 'rgba(0, 0, 0, 0.0)');
				$('#afterTravel > div').css('background-color', 'rgba(0, 0, 0, 0.0)');
				$('#afterTravel > div').css('background-color', 'rgba(0, 0, 0, 0.0)');
				$('#myfooter > footer > div > div > ul.uitk-layout-flex.uitk-layout-flex-align-items-center.uitk-layout-flex-flex-direction-row.uitk-layout-flex-justify-content-flex-start.uitk-layout-flex-flex-wrap-wrap.no-bullet > li > a > img').css('filter', 'brightness(70%)x	');
				
				$('div.my_wish_travel_list.my_travel_content > div > div').css('background-color', 'rgba(0, 0, 0, 0.0)');
				$('#mycontent > div > div.my_wish_travel_list.my_travel_content > div').css('background-color', 'rgba(0, 0, 0, 0.0)');
				
				// 모달창 뜰 때 이미지 밝기 변경
				$('#beforeTravel > div > div.my_travel_img > img').css('filter', 'brightness(70%)');
				$('#afterTravel > div > div.my_travel_img').css('filter', 'brightness(70%)');
				$('#mycontent > div > div.my_wish_travel_list.my_travel_content > div > div > div.my_wish_travel_img > img').css('filter', 'brightness(70%)');
				$('#myfooter > footer > div > div > ul.uitk-layout-flex.uitk-layout-flex-align-items-center.uitk-layout-flex-flex-direction-row.uitk-layout-flex-justify-content-flex-start.uitk-layout-flex-flex-wrap-wrap.no-bullet > li > a > img').css('filter', 'brightness(70%)');
				
				// border 없애기
				$('#myfooter > footer > div > div > div > hr').css('border-top', 'solid 1px rgba(0, 0, 0, 0.1)');
				
				
				
				// 모달의 닫기 버튼 클릭 시 모달 닫기
	    		$("span.close").click(function() {
	    			$(".reviewWriteModal").fadeOut();
	    			$("body").removeClass("modal-open"); // body에서 modal-open 클래스 제거
	    			
	    			// 배경색 없애기
	    			$('#headerOfheader > div > section').css('background-color', '');
	    			$('#mycontent > div').css('background-color', '');
					$('#beforeTravel > div').css('background-color', '');
					$('#beforeTravel > div > div.my_travel_img').css('background-color', '');
					$('#beforeTravel > div > div.my_travel_text').css('background-color', '');
					$('#afterTravel > div').css('background-color', '');
					$('div.my_wish_travel_list.my_travel_content > div > div').css('background-color', '');
					$('#mycontent > div > div.my_wish_travel_list.my_travel_content > div').css('background-color', '');
					
					// 밝기 제거
					$('#beforeTravel > div > div.my_travel_img > img').css('filter', '');
					$('#afterTravel > div > div.my_travel_img').css('filter', '');
					$('#myfooter > footer > div > div > ul.uitk-layout-flex.uitk-layout-flex-align-items-center.uitk-layout-flex-flex-direction-row.uitk-layout-flex-justify-content-flex-start.uitk-layout-flex-flex-wrap-wrap.no-bullet > li > a > img').css('filter', '');
					$('#mycontent > div > div.my_wish_travel_list.my_travel_content > div > div > div.my_wish_travel_img > img').css('filter', '');
					$('#myfooter > footer > div > div > ul.uitk-layout-flex.uitk-layout-flex-align-items-center.uitk-layout-flex-flex-direction-row.uitk-layout-flex-justify-content-flex-start.uitk-layout-flex-flex-wrap-wrap.no-bullet > li > a > img').css('filter', '');
					
					// 보더 색상 변경
					$('#myfooter > footer > div > div > div > hr').css('border-top', 'solid 1px #dfe0e4');
					
					document.body.style.overflow = 'auto';
	    		});
	         	
	    		const reviewWriteModal = document.getElementById('reviewWriteModal');
	    	    window.addEventListener('click', function (e) { // 모달 외의 body 클릭 시 모달창 display:none
	    	        if (e.target === reviewWriteModal) {
	    	        	$(".reviewWriteModal").fadeOut();
		    	        $("body").removeClass("modal-open"); // body에서 modal-open 클래스 제거
		    	        
		    	     // 배경색 없애기
		    			$('#headerOfheader > div > section').css('background-color', '');
		    			$('#mycontent > div').css('background-color', '');
		    			$('#myrvlist > div').css('background-color', '');
						$('#beforeTravel > div').css('background-color', '');
						$('#beforeTravel > div > div.my_travel_img').css('background-color', '');
						$('#beforeTravel > div > div.my_travel_text').css('background-color', '');
						$('#afterTravel > div').css('background-color', '');
						$('div.my_wish_travel_list.my_travel_content > div > div').css('background-color', '');
						$('#mycontent > div > div.my_wish_travel_list.my_travel_content > div').css('background-color', '');
						// 밝기 제거
						$('#beforeTravel > div > div.my_travel_img > img').css('filter', '');
						$('#afterTravel > div > div.my_travel_img').css('filter', '');
						$('#myfooter > footer > div > div > ul.uitk-layout-flex.uitk-layout-flex-align-items-center.uitk-layout-flex-flex-direction-row.uitk-layout-flex-justify-content-flex-start.uitk-layout-flex-flex-wrap-wrap.no-bullet > li > a > img').css('filter', '');
						$('#mycontent > div > div.my_wish_travel_list.my_travel_content > div > div > div.my_wish_travel_img > img').css('filter', '');
		    	        
		    	        
		    	        $('#myfooter > footer > div > div > ul.uitk-layout-flex.uitk-layout-flex-align-items-center.uitk-layout-flex-flex-direction-row.uitk-layout-flex-justify-content-flex-start.uitk-layout-flex-flex-wrap-wrap.no-bullet > li > a > img').css('filter', '');
		    	        
		    	        document.body.style.overflow = 'auto';
		    	        
	    	        }
	    	        
	    	     });  
				
	    		// 모달이 열릴 때 초기 상태 설정 함수 호출
	            setInitialRating();
	    		
	    		
	    		
	    	    
	        },// end of success
	        error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
	        
	    }); // end of ajax
		
	} // end of function reviewWrite()
	
	// 모달이 열릴 때 초기 상태를 설정하는 함수
	// 이 함수는 별점 이미지를 초기 상태로 설정하고, 마우스 이벤트에 따라 이미지를 변경

function setInitialRating() {
	    // 'rateCircle label' 클래스를 가진 모든 label 요소를 가져옵니다.
	    const labels = document.querySelectorAll('.rateCircle label');
		
	    
	    // 각 label에 마우스 이벤트를 추가
	    labels.forEach((label, index) => {
	    	
	        // label을 클릭했을 때의 동작
	        label.addEventListener('click', () => {
	            // 현재 label을 기준으로 그 이하의 label들은 'circle-solid.png' 이미지로 변경하고,
	            // 그 이상의 label들은 'circle-regular.png' 이미지로 변경
	            for (let i = 0; i <= index; i++) {
	                labels[i].style.backgroundImage = `url('<%= ctxPath%>/resources/images/ch/circle-solid.png')`;
	            }
	            for (let i = index + 1; i < labels.length; i++) {
	                labels[i].style.backgroundImage = `url('<%= ctxPath%>/resources/images/ch/circle-regular.png')`;
	            }
	        });
	        
	        
	    });
	}// end of function setInitialRating()
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
		
		<div id="wishList" class="my_travel_title">
			위시리스트
		</div>
		
		<div class="my_wish_travel_list my_travel_content">
			<%-- 위시리스트에 추가한 숙소들이 json으로 들어오는 곳 --%>
			<a></a>
		</div>	
		
	</div>
</body>

<!-- 이용후기 모달 -->
<form name="reviewWriteForm">
	
</form>

