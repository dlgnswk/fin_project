<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>   
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.spring.app.expedia.domain.UserVO"%>
<%
	String ctxPath = request.getContextPath();
%>
<%
	Date date = new Date();
	SimpleDateFormat sdft = new SimpleDateFormat("yyyy");
	String thisYear = sdft.format(date);
	String nextYear = String.valueOf(Integer.parseInt(thisYear)+1);
%>
 
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/css/jy/user_rewards_2.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/css/jy/user_rewards_1.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/css/jy/com_expedia.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/css/jy/common.css" />
<style>
	
	td {
		font-weight: 500;
		font-size: 0.875rem;
		line-height: 4rem;
	}
</style>	
<script>
	$(document).ready(function(){
		makePageBar(1);
		$("a.tooltip1").bind("click",function(){
			$("div.tooltip1").show();
		});
		
		var body = document.querySelector("body");
		body.addEventListener('click', clickBodyEvent);
		
		// 메시지 div 외의 공간 클릭 시 div 숨김처리
		function clickBodyEvent(e) { // 이벤트 버블링 기술 이용
		    // console.log(e.target);
		    // console.log(e.currentTarget);
		    
		    if(e.target == e.currentTarget.querySelector(".tooltip1")){
		    	return;
		    }
		    else {
		    	$("div.tooltip1").hide();
		    }
		}
		
		$("select[name='searchType']").bind("change",function(e){
			goViewPointList(1);
		});
	})
	
	// 해당 페이지의 포인트 내역을 가져오는 함수 
	function goViewPointList(currentShowPageNo) {
		const searchType = $("select[name='searchType']").val();
		$.ajax({
			url:"goViewPointList_json.exp",
			data:{"currentShowPageNo": currentShowPageNo,
				  "searchType":searchType,
				  "userid":"${sessionScope.loginuser.userid}"},
			dataType:"json",
			success:function(json){
				console.log(json);
				if(json.pointList != null){
					let html = "";
					$.each(json.pointList, function(index, item){						
						html += '<tr>'
							  + '<td>' +item.pt_change_date+'</td>'
							  + '<td style="line-height: 1.5rem; height: 100%; padding-top:0.5rem;">'
							  +		'<div class="c_flex" style="flex-direction: column;">'
							  +			'<div>'+item.lg_name+'</div>'
							  +			'<div><a class="c_text_link_m">일정 #'+item.rs_seq+'</a></div>'
							  +		'</div>'
							  +	'</td>'
							  +	'<td>'+item.pt_amount+'</td>';

						if(item.pt_amount < 0){
							html += '<td>사용</td>';
						}
						if(item.pt_amount >= 0){
							html += '<td>적립</td>';
						}
						html += '</tr>';
					})
					$("tbody").html(html);
					makePageBar(currentShowPageNo);
					//console.log($("tbody").html());
				}
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		 	}
			
		});
		
	}
	
	// === 댓글내용 페이지바 Ajax 로 만들기 === //
    function makePageBar(currentShowPageNo){
      
		const totalPage = ${requestScope.paraMap.totalPage};
 	  	if(totalPage > 0){
 	  		
	        const blockSize = 10;
	        // blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 개수 이다.
          
   	  		let loop = 1;
         	if(typeof currentShowPageNo == "string"){
       	  		currentShowPageNo = Number(currentShowPageNo);
          	}
		  	// *** !! 다음은 currentShowPageNo 를 얻어와서 pageNo 를 구하는 공식이다. !! *** //
          	let pageNo = Math.floor( (currentShowPageNo - 1)/blockSize ) * blockSize + 1;
		  	console.log("pageNo",pageNo);
          
        	let pageBarHTML = "<ul style='list-style: none;'>";
        
     		// === [맨처음] [이전] 만들기 === //
        	if(pageNo <= totalPage){
       			pageBarHTML += "<li style='display: inline-block; width: 70px; font-size:12pt;'><a href='javascript:goViewPointList(\"1\")'>[맨처음]</a></li>";
       			pageBarHTML += "<li style='display: inline-block; width: 50px; font-size:12pt;'><a href='javascript:goViewPointList(\""+(pageNo-1)+"\")'>[이전]</a></li>";
        	}
        
        	while(!(loop>blockSize || pageNo > totalPage)) {
        	
        		if(pageNo == currentShowPageNo){
        			pageBarHTML += "<li style='display: inline-block; width: 70px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";
        		}
        		else {
        			pageBarHTML += "<li style='display: inline-block; width: 50px; font-size:12pt;'><a href='javascript:goViewPointList(\""+pageNo+"\")'>"+pageNo+"</a></li>";
        		}
        		loop++;
        		pageNo++;	            	
        	}// end of while--------------------------------------
        
        
    		// === [다음] [마지막] 만들기 === //
        	if(pageNo <= totalPage){
       			pageBarHTML += "<li style='display: inline-block; width: 50px; font-size:12pt;'><a href='javascript:goViewPointList(\""+pageNo+"\")'>[다음]</a></li>";
       			pageBarHTML += "<li style='display: inline-block; width: 70px; font-size:12pt;'><a href='javascript:goViewPointList(\""+totalPage+"\")'>[마지막]</a></li>";
        	}
        	pageBarHTML += "</ul>";
    	
        	$("div#pageBar").html(pageBarHTML);
      	 }// end of if------------
          
       
       
    } // end of function makeCommentPageBar(currentShowPageNo)-------------
	
	
</script>
<body>
	<div id="activity_page_wrap" class="site-content-wrap">
		<div class="site-content cols-row" role="main">
			<nav class="bread-crumb cf" itemscope=""
				itemtype="http://schema.org/WebPage">
				<ol xmlns:v="http://rdf.data-vocabulary.org/#" itemprop="breadcrumb"
					aria-label="breadcrumb" role="navigation" itemscope=""
					itemtype="http://schema.org/BreadcrumbList">
					<li typeof="v:Breadcrumb"><a href="/user/expediarewards" rel="v:url" property="v:title" itemprop="url">
						<span itemprop="name">익스피디아 리워드 마켓플레이스</span></a>
						<span aria-hidden="true">&nbsp;•&nbsp;</span>
					</li>
					<li typeof="v:Breadcrumb">
						<strong aria-hidden="true" itemprop="name">익스피디아 리워드 적립 현황</strong>
						<strong class="visuallyhidden">익스피디아 리워드 적립 현황,&nbsp;현재 페이지</strong></li>
				</ol>
			</nav>
			<div class="page-content col" role="region">
				<!-- ACTIVITY HISTORY LIST -->
				<section id="activity_feed" class="activity-feed">
					<header class="cols-row-header cf search-header no-group  your-brand-activity">
						<h1 class="section-header-main">고객님의 익스피디아 리워드 적립 현황</h1>
						<div class="section-header-content">
							<p class="rewards-member-id supporting same-line">
								<strong>회원 ID:</strong>${sessionScope.loginuser.userid}
							</p>
						</div>
					</header>
					<h2 class="current-year-progress"><%= nextYear%>년 진행 상황</h2>
					<a class ="tooltip1" href="#tooltip1" data-control="tooltip" role="button"
						data-arrow="true" data-fade="out" data-manual="none"
						data-show-tooltip="true" data-tooltip-classes="secondary">자세히 알아보기</a>
					<div class="tooltip1 uitk-tooltip active-tooltip theme-click theme-standard show-arrow secondary top center on fade" role="tooltip" style="width: 16.9412em; text-align: left; visibility: visible; left: 0px; top: -0.5rem; display:none;">
						<div class="tooltip-inner" style="color:#616161">
							<strong><%= thisYear%>년</strong> 예약 활동에 따라 고객님의 <strong><%= nextYear%>년</strong> 회원 등급(블루, 실버 또는 골드)이 결정됩니다.
						</div>
						<span class="tooltip-arrow" style="margin-left: -44.1125px; margin-right: 0px;"></span>
					</div>
					<%
						int gold = 25;
						int silver = 10;
						int now = (int) request.getAttribute("user_rs_cnt");
						UserVO loginuser = (UserVO) session.getAttribute("loginuser");
						String user_lvl = loginuser.getUser_lvl();
						String next_user_lvl = "";
						
						if(now < 10) { next_user_lvl = "실버"; }
						else if(now < 25) { next_user_lvl = "골드"; }
						int left_cnt_next = 0;
						if(next_user_lvl == "골드"){
							left_cnt_next = gold - now;
						}
						if(next_user_lvl == "실버"){
							left_cnt_next = silver - now;
						}
					
					%>
					
					<div class="box  tier-progress" id="tier_progress">
						<header class="cols-row-header cf section-header no-group">
							<c:if test="${requestScope.loginuser.user_lvl ne '골드'}">
								<h3 class="section-header-main  tier-progress-suggestion"> <%= nextYear%>년에  <a style="color: #1668e3; font-weight:bold;"><%=next_user_lvl%> 등급</a>이 되고 싶으세요? 
								<%= thisYear%>년 12월 31일까지 여행 아이템을 <%= left_cnt_next%>개 더 적립해 주세요.</h3>
							</c:if>
							<c:if test="${requestScope.loginuser.user_lvl eq '골드'}">
								<h3 class="section-header-main  tier-progress-suggestion"> <%= nextYear%>년 회원님의 등급은 골드입니다. <%= nextYear%>년 12월 31일까지 골드 등급의 혜택을 누리세요.</h3>
							</c:if>
						</header>
						<header>여행 아이템</header>
						<div id="tripElements_progress"
							class="tier-progress-bar cf cols-row"
							data-tier="lty.tier.rewards.blue">
							<div class="bar-graph">
								<span class="tier-completion-marker"
									data-tier="lty.tier.rewards.silver" style="left: 50%"> <span class="caption">실버 (여행 아이템 10개)</span>
								</span>
								<span class="tier-completion-marker" data-tier="lty.tier.rewards.gold" style="left: 100%">
									<span class="caption">골드 (여행 아이템 25개)</span>
								</span> 
								<span class="bar-graph-bar" style="width: ${requestScope.user_rs_cnt*100/25}%" data-tier="lty.tier.rewards.blue">
									<c:if test="${requestScope.user_rs_cnt*100/25 > 90}">
										<span class="bar-graph-label" style="top: -100%" aria-hidden="true" data-position-to-bar="outside">여행 아이템 <fmt:formatNumber pattern="###,###">${requestScope.user_rs_cnt}</fmt:formatNumber>개 </span>
									</c:if>
									<c:if test="${requestScope.user_rs_cnt*100/25 <= 90}">
										<span class="bar-graph-label" aria-hidden="true" data-position-to-bar="outside">여행 아이템 <fmt:formatNumber pattern="###,###">${requestScope.user_rs_cnt}</fmt:formatNumber>개 </span>
									</c:if>
								</span>
							</div>
							<div class="progress-caption">
								<header class="so-far">적립된 여행 아이템: <fmt:formatNumber pattern="###,###">${requestScope.user_rs_cnt}</fmt:formatNumber>개</header>
								<c:if test="${sessionScope.loginuser.user_lvl eq '블루'}">
									<span class="to-next-tier">여행 아이템 ${10-requestScope.user_rs_cnt}개 더 있으면 실버 등급 
										<span class="visuallyhidden">여행 아이템 ${25-requestScope.user_rs_cnt}개 있으면 골드 등급</span>
									</span>	
								</c:if>
								<c:if test="${sessionScope.loginuser.user_lvl eq '실버'}">
									<span class="to-next-tier">여행 아이템 ${25-requestScope.user_rs_cnt}개 더 있으면 골드 등급 
									</span>											
								</c:if>								
							</div>
						</div>
					</div>
					<header class="cols-row-header cf section-header no-group  recent-activity">
						<h3 class="section-header-main">최근 적립 활동</h3>
					</header>

					<!-- Start Activity History-->
					<%-- user 의 tbl_point 데이터가 없을 때  시작 --%>
					<c:if test="${empty requestScope.user_point_list}">
					<p> 이 등급 유효 기간에 적립 활동이 없습니다. 예약하여 포인트를 적립하고, 쿠폰을 활용하고, 특별 혜택도 확인해 보세요.
						<span class="shopping-options-message">지금 바로
						<a href="<%= ctxPath%>/index.exp">호텔편</a>을 찾아보세요.
						</span>
					</p>
					</c:if>
					<%-- user 의 tbl_point 데이터가 없을 때  끝 --%>
					
					<%-- user 의 tbl_point 데이터가 있을 때 시작  --%>
					<c:if test="${not empty requestScope.pointList}">
					<div class="box">
						<div class="c_flex" style="justify-content: end; padding: 0 2rem 1rem 0;">
							<select name="searchType" style="padding: 0.3rem 1rem;">
								<option value="all">전체</option>
								<option value="get">적립</option>
								<option value="use">사용</option>
							</select>
						</div>						
						<table style="width: 100%; line-height: 3rem;">
							<thead>
								<tr>
									<th>날짜</th>
									<th>적립 및 사용 현황</th>
									<th>포인트</th>
									<th>상태</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="p_list" items="${requestScope.pointList}">
									<tr>
										<td>${p_list.pt_change_date}</td>
										<td style="line-height: 1.5rem; height: 100%; padding-top:0.5rem;">
											<div class="c_flex" style="flex-direction: column;">
												<div>${p_list.lg_name}</div>
												<div><a class="c_text_link_m">일정 #${p_list.rs_seq}</a></div>	
											</div>																					
										</td>
										<td><fmt:formatNumber pattern="###,###">${p_list.pt_amount}</fmt:formatNumber></td>
										<c:if test="${p_list.pt_amount < 0}">
											<td>사용</td>
										</c:if>
										<c:if test="${p_list.pt_amount > 0}">
											<td>적립</td>
										</c:if>
									</tr>
								</c:forEach> 								
							</tbody>
						</table>
					   <div id="pageBar" align="center" style="border: solid 0px gray; width:80%; margin: 30px auto;">
					    	<%-- ${requestScope.pageBar} --%>
					   </div>
					</div>
					</c:if>
					<%-- user 의 tbl_point 데이터가 있을 때 끝  --%>
					
					<span class="shopping-options-dropdown-wrap">
						<button class="btn btn-utility btn-secondary dropdown-toggle"
							data-control="menu" aria-expanded="false">
							<span class="btn-label">포인트 적립 방법 표시<span class="icon icon-toggle180" aria-hidden="true"></span></span>
						</button>
						<div class="menu">
							<a href="<%= ctxPath%>/index.exp">호텔 예약</a> <a href="<%= ctxPath%>/index.exp">항공 예약</a>
						</div>
					</span>
					<!-- End Activity History-->
				</section>
				<hr>
				<!-- REDEEM BAR -->
				<div class="box  redeem-bar cols-row" id="redeem_bar">

					<header class="box-title">
						<h3 class="title-main">익스피디아 리워드 포인트를 사용하는 다양한 방법</h3>
					</header>
					<div class="cols-nested">
						<section id="redeem-modules" class="redeem-modules count-1">
							<div class="redeem-module redeem_for_hotel"
								id="redeem_for_hotel_link">
								<a href="<%= ctxPath%>/index.exp"> 호텔에 사용 </a>
								<p>할인가로 숙박</p>
							</div>
						</section>
					</div>
				</div>
				
			</div>
		</div>
	</div>
</body>
</html>