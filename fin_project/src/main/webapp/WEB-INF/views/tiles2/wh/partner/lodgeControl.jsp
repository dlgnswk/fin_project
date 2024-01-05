<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<title>시설 관리</title>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<%
	String ctxPath = request.getContextPath();
    //      /board
%>  

<script type="text/javascript">

	$(document).ready(function(){
		
		
		
		
	});// end of $(document).ready(function(){}--------------------------------------
 
	// 숙소 등록 페이지로 이동 시켜주는 함수		
	function controlLodge() {
		
		location.href="<%= ctxPath%>/register_lodge.exp";
		
	}
		
	// 숙소 사진등록 페이지로 이동 시켜주는 함수
	function controlLodgeImg() {
		 
		location.href="<%= ctxPath%>/image_lodge.exp";
		
	}
	
	// 객실 등록 페이지로 이동 시켜주는 함수
	function controlRoom() {
		
		location.href="<%= ctxPath%>/rm_register.exp";
		
		
	}
	
	// 객실 사진등록 페이지로 이동 시켜주는 함수
	function controlRoomImg() {
		
		location.href="<%= ctxPath%>/rm_image.exp";
		
	}

</script>



<div id="container" style="inline-size: 100%; margin: auto; max-inline-size: 75rem; padding: 50px 0; background-img : url('https://headless.expediagroup.com/content/dam/marketing/headless/images/home-page/Content-page-image-hero-LG2.jpg')">
	<div id="select_box" style="width:40%; margin: 0 auto;">
		
		<form name="useridSendFrm" >
			<input type="hidden" name="userid" value="${sessionScope.loginhost.h_userid}"/>
		</form>
		
		<div>
			<img src="https://apps.expediapartnercentral.com/list/static/images/logo-expedia-2023.svg" style="width:180px; height:40px;"/>
		
			<div style="margin-top: 5%;">Expedia Group에서 숙박 시설의 진정한 가치를 알아보는 고객과 만나보세요. 등록은 무료이며, 쉽고 간편하게 숙소를 등록하고 관리 할 수 있습니다.</div>
		</div>
		
		
		<div style="border: solid 0px gray; box-shadow:1px 3px 5px 1px gray; margin: 0; line-height: 18px; width: 100%; padding: 40px; border-radius: 1rem; margin-top: 2%;">
			
			<div style="font-family: Century Gothic,CenturyGothic,AppleGothic,sans-serif; font-weight: 700; font-size: 22px; line-height: 32px; color: #009; margin-bottom: 2%; margin-left:5%; ">
				시설관리
			</div>
			
			<div style="display:flex">
				<div onclick="controlLodge()" style="margin:5% auto; border: 2px solid #5252ff;  height: 200px; border-radius: 1rem; width:40%; margin-bottom: 25px; cursor:pointer; ">
					<div style="width:50%; margin:10% auto;">
						<img src="https://apps.expediapartnercentral.com/list/static/images/Lodging.svg" style="width:80px; height:80px;"/>
					</div>
					
					<div style="font-family: Century Gothic,CenturyGothic,AppleGothic,sans-serif; font-weight: 600; font-size: 18px; line-height: 26px; text-align: center; color: #121617;">
							숙소 등록
					</div>
				</div>
				
			
				<div onclick="controlLodgeImg())" style="margin:5% auto; border: 2px solid #5252ff;  height: 200px; border-radius: 1rem; width:40%; margin-bottom: 25px; cursor:pointer;">
					<div style="width:50%; margin:10% auto;">
						<img src="https://headless.expediagroup.com/content/dam/marketing/headless/site-assets/icons/icon-ideal-guests.png" style="width:80px; height:80px;"/>
					</div>
					
					<div style="font-family: Century Gothic,CenturyGothic,AppleGothic,sans-serif; font-weight: 600; font-size: 18px; line-height: 26px; text-align: center; color: #121617;">
							숙소 사진등록
					</div>
				</div>
			</div>
			
			
			<div style="display:flex">
				<div onclick="controlRoom()" style="margin:5% auto; border: 2px solid #5252ff;  height: 200px; border-radius: 1rem; width:40%; margin-bottom: 25px; cursor:pointer; ">
					<div style="width:50%; margin:10% auto;">
						<img src="https://apps.expediapartnercentral.com/list/static/images/Lodging.svg" style="width:80px; height:80px;"/>
					</div>
					
					<div style="font-family: Century Gothic,CenturyGothic,AppleGothic,sans-serif; font-weight: 600; font-size: 18px; line-height: 26px; text-align: center; color: #121617;">
							객실 등록
					</div>
				</div>
				
			
				<div onclick="controlRoomImg()" style="margin:5% auto; border: 2px solid #5252ff;  height: 200px; border-radius: 1rem; width:40%; margin-bottom: 25px; cursor:pointer;">
					<div style="width:50%; margin:10% auto;">
						<img src="https://headless.expediagroup.com/content/dam/marketing/headless/site-assets/icons/icon-ideal-guests.png" style="width:80px; height:80px;"/>
					</div>
					
					<div style="font-family: Century Gothic,CenturyGothic,AppleGothic,sans-serif; font-weight: 600; font-size: 18px; line-height: 26px; text-align: center; color: #121617;">
							객실 사진등록
					</div>
				</div>
			</div>
			
		</div>
	</div>
	
</div>