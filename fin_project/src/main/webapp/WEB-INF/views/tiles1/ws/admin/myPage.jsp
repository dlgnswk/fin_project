<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<%
	String ctxPath = request.getContextPath();
    //      /board
%> 
<title>마이 페이지</title>

<script type="text/javascript">
	$(document).ready(function(){
		$("button.btn_logOut").bind("mouseover",function(e){
			$(e.target).css('background-color','#ECF4FD')
		});
		
		$("button.btn_logOut").bind("mouseout",function(e){
			$(e.target).css('background-color','')
		});
		
	});
	
	
</script>



<style>
	.padd_24 {
		margin:0 0 24px 0;
	}
	.padd_12 {
		margin-bottom:12px;
	}
	.btn_style {
	    --egds-legacy-background-color: hsla(0,0%,100%,0);
	    --egds-legacy-color: #1668e3;
	    --egds-legacy-fill-color: #1668e3;
	    background-color: var(--egds-undefined,var(--egds-legacy-background-color));
	    border-radius: 2500rem;
	    color: var(--egds-secondary,var(--egds-legacy-color));
	}
	
	.side_menu_container > a {
		color:black;
	}
	
	.side_menu_container > a:hover {
		text-decoration: none;
	}

</style>
<%--================ 왼쪽 색션 시작 ================--%>	
<div style="background-color:#f3f3f5;"><%-- 나중에 header에 color 넣으면 지울거임 --%>

	<div style="inline-size: 100%; margin: auto; max-inline-size: 85rem; padding: 50px 0; border: 0px solid yellow;">
	
		<div style="width:88%; margin:0 auto 10% auto;">
			<div id="select_box" style="display:flex; border: 0px solid red;">
			
				<div class="left_section" style="border: 0px solid blue; margin:auto 1% 10% 1%; width:35%;">
					<div class="login_member padd_24" style="width: 100%; border: 1px solid lightgray; height: 160px; padding: 10px; border-radius: 1rem; background-color: #ffffff;">
						
							<div>
								<div>
									<span>최&nbsp;원석&nbsp;님&nbsp;로그인중..</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="fill: #fff; background-color: #193082; padding: 0.15rem 0.3rem; color: #fff; border-radius: 0.25rem;"><span style="font-size:10pt">블루</span></span>
									<br>
									<span>arcnet743@gmail.com</span>
								</div>
							</div>
							<br>
							<div>
								<div>point : 0 ₩</div>
							</div>
						


						<div>
							<a href="#" style="font-color:black;">
								<div style="display: flex; background-color: #ffffff;">
									<div style="display: inline-block; padding: 0; margin: 3.8% 25% 3% 0; width: 80%;">리워드 적립 현황 보기</div>

									<div style="display: inline-block; margin: 3%; width: 10%;">
										<svg style="width: 30px; height: 30px;" class="uitk-icon uitk-icon-directional" aria-describedby="chevron_right-description" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
											<desc id="chevron_right-description">chevron</desc>
											<path d="M10 6 8.59 7.41 13.17 12l-4.58 4.59L10 18l6-6-6-6z"></path>
										</svg>
									</div>
								</div>
							</a>
						</div>


					</div>

					<div class="padd_24">모든 브랜드의 프로필, 리워드와 기본 설정을 한 곳에서 관리해 보세요.</div>
					
					<div class="padd_24" style="display:flex;">
						<div style="margin:auto;">
							<img class="left_sec_logo" alt="익스피디아 로고" src="https://a.travel-assets.com/egds/marks/onekey__expedia.svg" id="expedia.com" style="width:88px;">&nbsp;&nbsp;
							<img class="left_sec_logo" alt="호텔스닷컴 로고" src="https://a.travel-assets.com/egds/marks/onekey__hotels__english.svg" id="hotels.com" style="width:88px;">&nbsp;&nbsp;
							<img class="left_sec_logo" alt="Vrbo 로고" src="https://a.travel-assets.com/egds/marks/onekey__vrbo.svg" id="vrbo.com" style="width:88px;">
						</div>
					</div>
					
					<%-- 사이드 메뉴  시작--%>
					<div class="side_menu_container">
						<a href="#">
							<div class="padd_12" style="display:flex; border: 1px solid lightgray; border-radius: 1rem; background-color:#ffffff;"">
							
								<div style="vertical-align: middle; margin:3%; width:10%;">
									<svg style="width:30px;height:30px;" xmlns="http://www.w3.org/2000/svg">
										<path d="M16 8a4 4 0 1 1-8 0 4 4 0 0 1 8 0zM4 18c0-2.66 5.33-4 8-4s8 1.34 8 4v2H4v-2z"></path>
									</svg>
								</div>
								
								<div style="display:inline-block; width:80%; padding:0;margin:3.8% 25% 3% 0;">프로필</div>
								
								<div style="display:inline-block; width:10%; margin:3%;">
									<svg style=" width:30px;height:30px;" class="uitk-icon uitk-icon-directional" aria-describedby="chevron_right-description" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
										<desc id="chevron_right-description">chevron</desc>
										<path d="M10 6 8.59 7.41 13.17 12l-4.58 4.59L10 18l6-6-6-6z"></path>
									</svg>
								</div>
							
							</div>
						</a>
					
					
						<a href="#">
							<div class="padd_12" style="display:flex; border: 1px solid lightgray; border-radius: 1rem; background-color:#ffffff;"">
							
								<div style="vertical-align: middle; margin:3%; width:10%;">
									<svg style="width:30px;height:30px;" xmlns="http://www.w3.org/2000/svg">
										<path d="M2 12a10 10 0 1 1 20 0 10 10 0 0 1-20 0zm11.41 8v-1.91c1.74-.33 3.11-1.33 3.12-3.16 0-2.52-2.16-3.39-4.18-3.91-2.02-.52-2.67-1.07-2.67-1.91 0-.96.9-1.64 2.4-1.64 1.58 0 2.17.76 2.22 1.87h1.96a3.54 3.54 0 0 0-2.85-3.39V4h-2.67v1.93c-1.72.37-3.11 1.49-3.11 3.21 0 2.05 1.7 3.07 4.18 3.67 2.23.53 2.67 1.31 2.67 2.14 0 .61-.44 1.59-2.4 1.59-1.83 0-2.55-.82-2.65-1.87H7.47c.11 1.94 1.56 3.04 3.27 3.4V20h2.67z"></path>
									</svg>
								</div>
								
								<div style="display:inline-block; width:80%; padding:0;margin:3.8% 25% 3% 0;">포인트 내역</div>
								
								<div style="display:inline-block; width:10%; margin:3%;">
									<svg style=" width:30px;height:30px;" class="uitk-icon uitk-icon-directional" aria-describedby="chevron_right-description" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
										<desc id="chevron_right-description">chevron</desc>
										<path d="M10 6 8.59 7.41 13.17 12l-4.58 4.59L10 18l6-6-6-6z"></path>
									</svg>
								</div>
							
							</div>
						</a>	
						
						<a href="#">
							<div class="padd_12" style="display:flex; border: 1px solid lightgray; border-radius: 1rem; background-color:#ffffff;"">
							
								<div style="vertical-align: middle; margin:3%; width:10%;">
									<svg style="width:30px;height:30px;" xmlns="http://www.w3.org/2000/svg">
										<path d="M20 2H4a2 2 0 0 0-2 2v18l4-4h14a2 2 0 0 0 2-2V4a2 2 0 0 0-2-2z"></path>
									</svg>
								</div>
								
								<div style="display:inline-block; width:80%; padding:0;margin:3.8% 25% 3% 0;">이용 후기</div>
								
								<div style="display:inline-block; width:10%; margin:3%;">
									<svg style=" width:30px;height:30px;" class="uitk-icon uitk-icon-directional" aria-describedby="chevron_right-description" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
										<desc id="chevron_right-description">chevron</desc>
										<path d="M10 6 8.59 7.41 13.17 12l-4.58 4.59L10 18l6-6-6-6z"></path>
									</svg>
								</div>
							
							</div>
						</a>
						
						<a href="#">
							<div class="padd_12" style="display:flex; border: 1px solid lightgray; border-radius: 1rem; background-color:#ffffff;"">
							
								<div style="vertical-align: middle; margin:3%; width:10%;">
									<svg style="width:30px;height:30px;" xmlns="http://www.w3.org/2000/svg">
										<path d="M19.5 12c0 .34-.03.66-.07.98l2.11 1.65a.5.5 0 0 1 .12.64l-2 3.46c-.12.22-.38.31-.61.22l-2.49-1c-.52.39-1.08.73-1.69.98l-.38 2.65A.49.49 0 0 1 14 22h-4a.49.49 0 0 1-.49-.42l-.38-2.65a7.3 7.3 0 0 1-1.69-.98l-2.49 1a.5.5 0 0 1-.61-.22l-2-3.46a.5.5 0 0 1 .12-.64l2.11-1.65a7.93 7.93 0 0 1 0-1.96L2.46 9.37a.5.5 0 0 1-.12-.64l2-3.46c.12-.22.38-.31.61-.22l2.49 1a7.68 7.68 0 0 1 1.69-.98l.38-2.65A.49.49 0 0 1 10 2h4c.25 0 .46.18.49.42l.38 2.65a7.3 7.3 0 0 1 1.69.98l2.49-1a.5.5 0 0 1 .61.22l2 3.46a.5.5 0 0 1-.12.64l-2.11 1.65c.04.32.07.64.07.98zm-11 0a3.5 3.5 0 1 0 7 0 3.5 3.5 0 0 0-7 0z"></path>
									</svg>
								</div>
								
								<div style="display:inline-block; width:80%; padding:0;margin:3.8% 25% 3% 0;">설정</div>
								
								<div style="display:inline-block; width:10%; margin:3%;">
									<svg style=" width:30px;height:30px;" class="uitk-icon uitk-icon-directional" aria-describedby="chevron_right-description" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
										<desc id="chevron_right-description">chevron</desc>
										<path d="M10 6 8.59 7.41 13.17 12l-4.58 4.59L10 18l6-6-6-6z"></path>
									</svg>
								</div>
							</div>
						</a>
					<%-- 사이드 메뉴  끝 --%>	
						
						<div style="display:flex;">	
							<div style="margin:auto auto 10% auto; padding-block:0.8rem; width:83%; height:100px;">
								<button class="btn_style btn_logOut" style="width:100%; height:35px; border:0px" type="button">로그아웃</button>
							</div>
						</div>	
							
					</div>
					
				</div>
			<%--================ 왼쪽 색션 끝 ================--%>	
			<%--================ 오른쪽 색션 시작 ================--%>
			
				<div class="right_section" style="border: 1px solid lightgray; height: 800px; padding: 40px; margin:0 0 auto 1%; border-radius: 1rem; width:100%; background-color:#ffffff;">
					<div>
						<h2>> 내 정보 </h2>
						
						<div id="mypage_right">
							
							
							
						</div>
					</div>
				</div>
				
			</div>
		</div>	
	</div>
	
</div>