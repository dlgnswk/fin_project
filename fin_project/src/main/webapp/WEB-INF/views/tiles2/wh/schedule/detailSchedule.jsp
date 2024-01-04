<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>


<%
 	String ctxPath = request.getContextPath();
	//     /board
%>

<style type="text/css">

	table#schedule{
		margin-top: 70px;
	}
	
	table#schedule th, td{
	 	padding: 10px 5px;
	 	vertical-align: middle;
	}
	
	a{
	    color: #395673;
	    text-decoration: none;
	    cursor: pointer;
	}
	
	a:hover {
	    color: #395673;
	    cursor: pointer;
	    text-decoration: none;
		font-weight: bold;
	}
	
	button.btn_normal{
		background-color: #0071bd;
		border: none;
		color: white;
		width: 70px;
		height: 30px;
		font-size: 12pt;
		padding: 3px 0px;
		margin-right: 10px;
		border-radius: 10%;
	}

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		// ==== 종일체크박스에 체크를 할 것인지 안할 것인지를 결정하는 것 시작 ==== //
		// 시작 시 분
		var str_startdate = $("span#startdate").text();
	 // console.log(str_startdate); 
		// 2021-12-01 09:00
		var target = str_startdate.indexOf(":");
		var start_min = str_startdate.substring(target+1);
	 // console.log(start_min);
		// 00
		var start_hour = str_startdate.substring(target-2,target);
	 //	console.log(start_hour);
		// 09
		
		// 종료 시 분
		var str_enddate = $("span#enddate").text();
	//	console.log(str_enddate);
		// 2021-12-01 18:00
		target = str_enddate.indexOf(":");
		var end_min = str_enddate.substring(target+1);
	 // console.log(end_min);
	    // 00 
		var end_hour = str_enddate.substring(target-2,target);
	 //	console.log(end_hour);
		// 18
		
		if(start_hour=='00' && start_min=='00' && end_hour=='23' && end_min=='59' ){
			$("input#allDay").prop("checked",true);
		}
		else{
			$("input#allDay").prop("checked",false);
		}
		// ==== 종일체크박스에 체크를 할 것인지 안할 것인지를 결정하는 것 끝 ==== //
		
	}); // end of $(document).ready(function(){})==============================


	// ~~~~~~~ Function Declartion ~~~~~~~
	
	// 일정 삭제하기
	function delSchedule(rs_seq){
	
		var bool = confirm("일정을 삭제하시겠습니까?");
		
		if(bool){
			$.ajax({
				url: "<%= ctxPath%>/schedule/deleteSchedule.exp",
				type: "post",
				data: {"rs_seq":rs_seq},
				dataType: "json",
				success:function(json){
					if(json.n==1){
						alert("일정을 삭제하였습니다.");
					}
					else {
						alert("일정을 삭제하지 못했습니다.");
					}
					
					location.href="<%= ctxPath%>/schedule/scheduleManagement.exp";
				},
				error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		        }
			});
		}
		
	}// end of function delSchedule(rs_seq){}-------------------------

	
</script>

<div style="margin-left: 80px; width: 88%;">
<h3 style="display: inline-block;">일정 상세보기</h3>&nbsp;&nbsp;<a href="<%= ctxPath%>/schedule/scheduleManagement.exp"><span>◀캘린더로 돌아가기</span></a> 

		<table id="schedule" class="table table-bordered">
			<tr>
				<th style="width: 160px; vertical-align: middle;">일자</th>
				<td>
					<span id="startdate">${requestScope.map.STARTDATE}</span>&nbsp;~&nbsp;<span id="enddate">${requestScope.map.ENDDATE}</span>&nbsp;&nbsp;  
					<input type="checkbox" id="allDay" disabled/>&nbsp;종일
				</td>
			</tr>
			<tr>
				<th style="vertical-align: middle;">예약자 아이디</th>
				<td>${requestScope.map.FK_USERID}</td>
			</tr>
			
			<tr>
				<th style="vertical-align: middle;">예약자명</th>
				<td>${requestScope.map.RS_NAME}</td>
			</tr>
			
			<tr>
				<th style="vertical-align: middle;">예약자 연락처</th>
				<td>${requestScope.map.RS_MOBILE}</td>
			</tr>
			
			<tr>
				<th style="vertical-align: middle;">예약일자</th>
				<td>${requestScope.map.RS_DATE}</td>
			</tr>
			
			<tr>
				<th style="vertical-align: middle;">투숙인원</th>
				<td>${requestScope.map.RS_GUEST_CNT}</td>
			</tr>
			
			<tr>
				<th style="vertical-align: middle;">결제금액</th>
				<td>
				<fmt:formatNumber pattern="#,###">${requestScope.map.RS_PRICE}</fmt:formatNumber>&nbsp;원
				</td>
			</tr>
			
		</table>
	
	<input type="hidden" value="${sessionScope.loginhost.h_userid}" />
	<input type="hidden" value="${requestScope.map.RS_SEQ}" />
	
	
	<div style="float: right;">
		
		<button type="button" class="btn_normal" onclick="delSchedule('${requestScope.map.RS_SEQ}')">삭제</button>
		<button type="button" id="cancel" class="btn_normal" style="margin-right: 0px;" onclick="javascript:location.href='<%= ctxPath%>${requestScope.listgobackURL_schedule}'">취소</button> 
		

	
	</div>
</div>

<form name="goEditFrm">
	<input type="hidden" name="rs_seq"/>
	<input type="hidden" name="gobackURL_detailSchedule" value="${requestScope.gobackURL_detailSchedule}"/>
</form>
