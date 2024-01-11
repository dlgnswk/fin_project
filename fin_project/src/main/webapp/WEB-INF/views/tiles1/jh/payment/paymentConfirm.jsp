<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	String ctxPath = request.getContextPath();
    //      /expedia
%>  

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/css/jh/payment/paymentConfirm.css" />

<title>익스피디아 : 확인</title>

<body  style="background-color: f3f3f5;">
	<div style="inline-size: 100%; margin: auto; max-inline-size: 75rem; padding: 50px 0;">
	
		<div>
		
			<div class="">
				<h1 class="main_text">즐거운 여행 되세요!</h1>
			</div>

			<div class="desc_text_div">
				<div>모든 처리가 완료되었습니다. 숙소가 예약되었으며, 이제 신나게 떠나실 일만 남았어요!</div>
				
				<div>
					<span>${requestScope.email}</span>
					 주소로 예약 내용을 보내드렸습니다.
				</div>
			
				<div class="btn_div">
					<button class="goToMyTravel">
						<a href="<%= ctxPath%>/trip.exp">내 여행 보러가기</a>
					</button>
				</div>
				
			</div>

			<div class="desc_app_div">
				<div>
					<div class="desc_app_title">
						<img class="expedia_app_image" src="https://a.travel-assets.com/egds/marks/brands/expedia/app.svg" alt="">
						<span class="app_title">익스피디아 앱으로 여행 관리하기</span>
					</div>
					
					<div class="desc_app_content">
						<div class="desc_app_content-subject">
							<span>익스피디아 앱의 좋은 점</span>
						</div>
						
						<div class="desc_app_content-text">
							<ol>
								<li>예약한 여행에 대해 알림을 받으실 수 있어요.</li>
								<li>이동 중에도 쉽게 호텔에 연락하실 수 있어요.</li>
								<li>인터넷 연결 없이도 일정을 확인하실 수 있어요.</li>
							</ol>
						</div>
					</div>
				</div>
				
				<div class="app_QR">
					<div id="qrcode-image">
						<img src="https://a.travel-assets.com/mad-service/qr-code/footer_qr_cp/16_QR_FOOTER_CP.png" alt="scan code">
					</div>
					<h3 id="qrcode-cta">QR 코드 스캔</h3>
				</div>
			</div>
				
		</div>
		
	</div>
</body>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	