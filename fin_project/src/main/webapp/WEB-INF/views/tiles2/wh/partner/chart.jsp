<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	String ctxPath = request.getContextPath();
%>    

<style type="text/css">
	.highcharts-figure,
	.highcharts-data-table table {
	    min-width: 360px;
	    max-width: 800px;
	    margin: 1em auto;
	}
	
	.highcharts-data-table table {
	    font-family: Verdana, sans-serif;
	    border-collapse: collapse;
	    border: 1px solid #ebebeb;
	    margin: 10px auto;
	    text-align: center;
	    width: 100%;
	    max-width: 500px;
	}
	
	.highcharts-data-table caption {
	    padding: 1em 0;
	    font-size: 1.2em;
	    color: #555;
	}
	
	.highcharts-data-table th {
	    font-weight: 600;
	    padding: 0.5em;
	}
	
	.highcharts-data-table td,
	.highcharts-data-table th,
	.highcharts-data-table caption {
	    padding: 0.5em;
	}
	
	.highcharts-data-table thead tr,
	.highcharts-data-table tr:nth-child(even) {
	    background: #f8f8f8;
	}
	
	.highcharts-data-table tr:hover {
	    background: #f1f7ff;
	}
</style>

<script src="<%=ctxPath%>/resources/Highcharts-10.3.3/code/highcharts.js"></script>
<script src="<%=ctxPath%>/resources/Highcharts-10.3.3/code/modules/exporting.js"></script>
<script src="<%=ctxPath%>/resources/Highcharts-10.3.3/code/modules/export-data.js"></script>
<script src="<%=ctxPath%>/resources/Highcharts-10.3.3/code/modules/accessibility.js"></script>




<div style="display: flex;">   
<div style="width: 80%; min-height: 1100px; margin:auto; ">

   <h2 style="margin: 50px 0;">숙소 이용 현황</h2>
   
   <form name="searchFrm" style="margin: 20px 0 50px 0; ">
      <select name="searchType" id="searchType" style="height: 30px;">
         <option value="">통계선택하세요</option>
         <option value="useLodgeCnt">${requestScope.year}년도 숙소 이용인원 통계</option>
         <option value="beforeOneYearuseLodgeCnt"><fmt:parseNumber value="${requestScope.year-1}"></fmt:parseNumber>년도 숙소 이용인원 통계</option>
      </select>
   	
   	  <input type="hidden" id=h_userid name="h_userid" value="${sessionScope.loginhost.h_userid}">
   </form>
   
   <div id="chart_container"></div>
   <div id="table_container" style="margin: 40px 0 0 0;"></div>

</div>
</div>




<script type="text/javascript">
	$(document).ready(function(){
		
		$("select#searchType").change(function(e){
			func_choice($(this).val());
			// $(this).val() 은 "" 또는 "deptname" 또는 "gender" 또는 "genderHireYear" 또는 "deptnameGender" 이다.
			
		});// end of $("select#searchType").change(function(){}----------------
		
		// 문서가 로드 되어지면 "숙소 총 이용인원 통계" 페이지가 보이도록 한다.
		$("select#searchType").val("useLodgeCnt").trigger("change");
		
	});// end of $(document).ready(function(){}-----------------------------------

			
	//Function Declaration
	function func_choice(searchTypeVal) {
		
		switch (searchTypeVal) {
			case "":	// 통계선택하세요 를 선택한 경우
				$("div#chart_container").empty();
				$("div#table_container").empty();
				$("div.highcharts-data-table").empty();
				break;
	
			case "useLodgeCnt":	// 올해 숙소 이용인원 통계 를 선택한 경우
				
				$.ajax({
					url:"<%=ctxPath%>/useLodgeCnt.exp",
					data: {"h_userid":$("input#h_userid").val()},
					dataType:"json",
					success:function(json){
						// console.log(JSON.stringify(json));
						/*
							[{"rm_type":"이그제큐티브 그랜드 디럭스","MON01":"1","MON02":"1","MON03":"0","MON04":"0","MON05":"0","MON06":"0","MON07":"0","MON08":"0","MON09":"0","MON10":"0","MON11":"0","MON12":"2"}
							,{"rm_type":"디럭스","MON01":"1","MON02":"1","MON03":"0","MON04":"0","MON05":"0","MON06":"0","MON07":"0","MON08":"0","MON09":"0","MON10":"0","MON11":"0","MON12":"2"}
							,{"rm_type":"슈페리얼","MON01":"1","MON02":"1","MON03":"0","MON04":"0","MON05":"0","MON06":"0","MON07":"0","MON08":"0","MON09":"0","MON10":"0","MON11":"0","MON12":"2"}
							,{"rm_type":"이그제큐티브 프리미어","MON01":"1","MON02":"1","MON03":"0","MON04":"0","MON05":"0","MON06":"0","MON07":"0","MON08":"0","MON09":"0","MON10":"0","MON11":"0","MON12":"2"}
							,{"rm_type":"프리미어","MON01":"1","MON02":"1","MON03":"0","MON04":"0","MON05":"0","MON06":"0","MON07":"0","MON08":"0","MON09":"0","MON10":"0","MON11":"0","MON12":"2"}]
						*/
						
						$("div#chart_container").empty();
						$("div#table_container").empty();
						$("div.highcharts-data-table").empty();
						
						let resultArr = [];
						
						for(let i=0; i<json.length; i++){
							let month_Arr = [];
						
							month_Arr.push(Number(json[i].MON01));
							month_Arr.push(Number(json[i].MON02));
							month_Arr.push(Number(json[i].MON03));
							month_Arr.push(Number(json[i].MON04));
							month_Arr.push(Number(json[i].MON05));
							month_Arr.push(Number(json[i].MON06));
							month_Arr.push(Number(json[i].MON07));
							month_Arr.push(Number(json[i].MON08));
							month_Arr.push(Number(json[i].MON09));
							month_Arr.push(Number(json[i].MON10));
							month_Arr.push(Number(json[i].MON11));
							month_Arr.push(Number(json[i].MON12));
							let obj = {name: json[i].rm_type,
									   data: month_Arr};
						
							resultArr.push(obj); // 배열 속에 객체를 넣기
							
						}// end of for------------------------------
						
						///////////////////////////////////////////////////////////
						Highcharts.chart('chart_container', {
						    chart: {
						        type: 'line'
						    },
						    title: {
						        text: '${requestScope.year-1}'+'년 숙소 예약 현황'
						    },
						    subtitle: {
						        text: 'Source: <a href="<%= ctxPath%>/schedule/scheduleManagement.exp" target="_blank">reservation.schedule</a>'
						    },
						    xAxis: {
						        categories: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
						    },
						    yAxis: {
						        title: {
						            text: '예약 수'
						        }
						    },
						    plotOptions: {
						        line: {
						            dataLabels: {
						                enabled: true
						            },
						            enableMouseTracking: false
						        }
						    },
						    series: resultArr
						});
						///////////////////////////////////////////////////////////	
						
						let v_html = "<table>";
						
							v_html += "<tr>" + 
											"<th>객실등급</th>" +
											"<th>1월</th>" +
											"<th>2월</th>" +
											"<th>3월</th>" +
											"<th>4월</th>" +
											"<th>5월</th>" +
											"<th>6월</th>" +
											"<th>7월</th>" +
											"<th>8월</th>" +
											"<th>9월</th>" +
											"<th>10월</th>" +
											"<th>11월</th>" +
											"<th>12월</th>" +
									  "</tr>";
						
									  
						$.each(json, function(index, item){
							v_html += "<tr>" +
										"<td>"+item.rm_type+"</td>" +
										"<td>"+item.MON01+"</td>" +
										"<td>"+item.MON02+"</td>" +
										"<td>"+item.MON03+"</td>" +
										"<td>"+item.MON04+"</td>" +
										"<td>"+item.MON05+"</td>" +
										"<td>"+item.MON06+"</td>" +
										"<td>"+item.MON07+"</td>" +
										"<td>"+item.MON08+"</td>" +
										"<td>"+item.MON09+"</td>" +
										"<td>"+item.MON10+"</td>" +
										"<td>"+item.MON11+"</td>" +
										"<td>"+item.MON12+"</td>" +
									  "</tr>";
				
							});	  
						
						v_html += "</table>";
						
						$("div#table_container").html(v_html);
					},
					error: function(request, status, error){
			            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			        }
				});
			
				
				break;
				
			case "beforeOneYearuseLodgeCnt":	// 작년 숙소 이용인원 통계 를 선택한 경우
				$("div#chart_container").empty();
				$("div#table_container").empty();
				$("div.highcharts-data-table").empty();
				
				$.ajax({
					url:"<%=ctxPath%>/beforeOneYearuseLodgeCnt.exp",
					data: {"h_userid":$("input#h_userid").val()},
					dataType:"json",
					success:function(json){
						// console.log(JSON.stringify(json));
						/*
							[{"rm_type":"이그제큐티브 그랜드 디럭스","MON01":"1","MON02":"1","MON03":"0","MON04":"0","MON05":"0","MON06":"0","MON07":"0","MON08":"0","MON09":"0","MON10":"0","MON11":"0","MON12":"2"}
							,{"rm_type":"디럭스","MON01":"1","MON02":"1","MON03":"0","MON04":"0","MON05":"0","MON06":"0","MON07":"0","MON08":"0","MON09":"0","MON10":"0","MON11":"0","MON12":"2"}
							,{"rm_type":"슈페리얼","MON01":"1","MON02":"1","MON03":"0","MON04":"0","MON05":"0","MON06":"0","MON07":"0","MON08":"0","MON09":"0","MON10":"0","MON11":"0","MON12":"2"}
							,{"rm_type":"이그제큐티브 프리미어","MON01":"1","MON02":"1","MON03":"0","MON04":"0","MON05":"0","MON06":"0","MON07":"0","MON08":"0","MON09":"0","MON10":"0","MON11":"0","MON12":"2"}
							,{"rm_type":"프리미어","MON01":"1","MON02":"1","MON03":"0","MON04":"0","MON05":"0","MON06":"0","MON07":"0","MON08":"0","MON09":"0","MON10":"0","MON11":"0","MON12":"2"}]
						*/
						
						$("div#chart_container").empty();
						$("div#table_container").empty();
						$("div.highcharts-data-table").empty();
						
						let resultArr = [];
						
						for(let i=0; i<json.length; i++){
							let month_Arr = [];
						
							month_Arr.push(Number(json[i].MON01));
							month_Arr.push(Number(json[i].MON02));
							month_Arr.push(Number(json[i].MON03));
							month_Arr.push(Number(json[i].MON04));
							month_Arr.push(Number(json[i].MON05));
							month_Arr.push(Number(json[i].MON06));
							month_Arr.push(Number(json[i].MON07));
							month_Arr.push(Number(json[i].MON08));
							month_Arr.push(Number(json[i].MON09));
							month_Arr.push(Number(json[i].MON10));
							month_Arr.push(Number(json[i].MON11));
							month_Arr.push(Number(json[i].MON12));
							let obj = {name: json[i].rm_type,
									   data: month_Arr};
						
							resultArr.push(obj); // 배열 속에 객체를 넣기
							
						}// end of for------------------------------
						
						///////////////////////////////////////////////////////////
						Highcharts.chart('chart_container', {
						    chart: {
						        type: 'line'
						    },
						    title: {
						        text: '${requestScope.year-1}'+'년 숙소 예약 현황'
						    },
						    subtitle: {
						        text: 'Source: <a href="<%= ctxPath%>/schedule/scheduleManagement.exp" target="_blank">reservation.schedule</a>'
						    },
						    xAxis: {
						        categories: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
						    },
						    yAxis: {
						        title: {
						            text: '예약 수'
						        }
						    },
						    plotOptions: {
						        line: {
						            dataLabels: {
						                enabled: true
						            },
						            enableMouseTracking: false
						        }
						    },
						    series: resultArr
						});
						///////////////////////////////////////////////////////////	
						
						let v_html = "<table>";
						
							v_html += "<tr>" + 
											"<th>객실등급</th>" +
											"<th>1월</th>" +
											"<th>2월</th>" +
											"<th>3월</th>" +
											"<th>4월</th>" +
											"<th>5월</th>" +
											"<th>6월</th>" +
											"<th>7월</th>" +
											"<th>8월</th>" +
											"<th>9월</th>" +
											"<th>10월</th>" +
											"<th>11월</th>" +
											"<th>12월</th>" +
									  "</tr>";
						
									  
						$.each(json, function(index, item){
							v_html += "<tr>" +
										"<td>"+item.rm_type+"</td>" +
										"<td>"+item.MON01+"</td>" +
										"<td>"+item.MON02+"</td>" +
										"<td>"+item.MON03+"</td>" +
										"<td>"+item.MON04+"</td>" +
										"<td>"+item.MON05+"</td>" +
										"<td>"+item.MON06+"</td>" +
										"<td>"+item.MON07+"</td>" +
										"<td>"+item.MON08+"</td>" +
										"<td>"+item.MON09+"</td>" +
										"<td>"+item.MON10+"</td>" +
										"<td>"+item.MON11+"</td>" +
										"<td>"+item.MON12+"</td>" +
									  "</tr>";
				
							});	  
						
						v_html += "</table>";
						
						$("div#table_container").html(v_html);
					},
					error: function(request, status, error){
			            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			        }
				});
			
				
				break;
				
						
				
		}// end of switch (searchTypeVal) ----------------------------------------
		
		
	}// end of function func_choice(searchTypeVal) -------------------------------
			
			
			
			
</script>




