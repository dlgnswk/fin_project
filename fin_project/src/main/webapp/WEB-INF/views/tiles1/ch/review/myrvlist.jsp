<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<%
	String ctxPath = request.getContextPath();
    //      /expedia
%>  
<title>회원님이 작성한 이용후기 목록</title>


<style>
	
	div.review{
	height: 250px;
	width: 45%;
	margin: 0 auto;
	background-color: white;
	border-radius: 1rem;
	text-align: left;
	}
	
	div.reviewcontent {
	padding-left: 20px;
	}
	
	.dropdown_bar {
	height:30px; 
	float:right;
	margin: 0 2% 3% 0;
	}
	
	.dropdown_content {
    position: absolute;
    display: none;
    margin-right: 31%;
    width: 8.125rem; /* 130px를  16px 기준으로 나눈 값 */
    background-color: white;
    border-radius: 0.25rem; /* 4px를 16px 기준으로 나눈 값 */
    box-shadow: 0.25rem 0.25rem 0.625rem #c5b0b0; /* 4px, 4px, 10px를 16px 기준으로 나눈 값 */
    animation: fade-in 1s ease;
    right: 0; /* 오른쪽에 위치하도록 설정 */
    z-index: 1; /* 다른 요소 위에 나타나도록 z-index 설정 */
	}

	#rvedit, #rvdelete {
	    text-align: center;
	    color: black;
	    padding: 0.5rem;
	    text-decoration: none;
	    display: block;
	    font-size: 16px;
	}
	
	#rvedit:hover {
		border: 0px solid black;
		border-radius: 6px;
		cursor: pointer;
		background-color: rgba(0, 0, 0, 0.06);
	}
	
	#rvdelete:hover {
		border: 0px solid black;
		border-radius: 6px;
		cursor: pointer;
		background-color: rgba(0, 0, 0, 0.06);
	}
	
	#dropdownMenuButton{
	border: 0px solid black;
	border-radius: 70%;
	background-color: rgba(0, 0, 0, 0);
	}
	
	#dropdownMenuButton:hover {
	cursor: pointer;
	background-color: rgba(0, 0, 0, 0.06);
	}
	
	/* 수정 모달 창 css */
	
	/* 모달 css 시작 */
	
	.reviewEditModal{ 
	    position:absolute;
	    width:100%; 
	    height:100%; 
	    background: rgba(0, 0, 0, 0.21); 
	    top:0; 
	    left:0; 
	    display:none;
	    z-index: 100;
	}
	
	body.modal-open {
	    overflow: hidden; /* 페이지 스크롤 막기 */
	}
	
	.reviewEditModal_header{		
	    width: 720px; /* 500px를 16px 기준으로 나눈 값 */
	    height: 640px;        /* 300px를 16px 기준으로 나눈 값 */
	    background:#fff; 
	    border-radius:0.625rem; /* 10px를 16px 기준으로 나눈 값 */
	    position:relative; 
	    top:50%; 
	    left:50%;
	    margin-top:-320px; /* height의 절반 */
	    margin-left:-360px; /* width의 절반 */
	    text-align:left;
	    box-sizing:border-box; 
	    padding: 50px 0; /* 74px를 16px 기준으로 나눈 값 */
	    line-height:1.4375rem; /* 23px를 16px 기준으로 나눈 값 */
	    cursor:pointer;
	}
	

	#mycontent > form > div > div.reviewEditModal_header > span {
	    position: absolute; 
	    top: 6px; /* 15px를 16px 기준으로 나눈 값 */
	    left: 0.9375rem; /* 15px를 16px 기준으로 나눈 값 */
	    color: #0073ff;
	    font-size: 30px;
	    cursor: pointer;	    	    
	}
	
	/* 별점 css 시작 */
	
	#mycontent > form > div > div.reviewEditModal_header > div > div.rating {
		width: 68%;
	}
	
	.rateCircle fieldset{
    display: inline-block; /* 하위 별점 이미지들이 있는 영역만 자리를 차지함.*/
    border: 0; /* 필드셋 테두리 제거 */
    width: 100%;
    height: 100px;
	}
	
	.rateCircle input[type=radio]{
	    display: none;
	}
	
	.rateCircle label{
	   background-image: url(<%= ctxPath%>/resources/images/ch/circle-regular.png);
	   width: 26%;
       height: 50.5px; 
   	   user-select: none;
	}
	
	#mycontent > form > div > div.reviewEditModal_header > div > div.rating > fieldset > span > span {
		width: 100%;
		margin: 3% 0 0 5%;		
	}
	
	.rateCircle input[type=radio]:checked ~ label,
    .rateCircle label:hover {
        background-image: url(<%= ctxPath%>/resources/images/ch/circle-solid.png);
    }
	
	/* 별점 css 끝 */
	
</style>

<script type="text/javascript"> 
	
$(document).ready(function() {
	
	// 글 드롭 다운 메뉴
	var dropdown = document.querySelector(".dropdown_bar");
    var dropdownContent = document.querySelector(".dropdown_content");
    var modal = document.querySelector(".tbdeleteModal");
    
    dropdown.addEventListener("click", function(event) {
        if (dropdownContent.style.display === "block") {
            dropdownContent.style.display = "none";
        } else {
            dropdownContent.style.display = "block";
        }
        event.stopPropagation(); // 이벤트 버블링 방지
    });

    // 문서의 다른 영역을 클릭했을 때 드롭다운을 닫음
    document.addEventListener("click", function(event) {
        if (!dropdown.contains(event.target) && event.target !== dropdownContent) {
            dropdownContent.style.display = "none";
        }
    });
    
    
 // Function Declaration
	// 리뷰작성 버튼 클릭시
		function rvedit() {			
			
			if ("리뷰 수정" == $(".rvedit").text()) {
				alert("dsafasfdsafdsa");
			    $.ajax({
			        url: "<%= ctxPath%>/reviewEditModal.exp",
			        data: { "rs_seq": "1"  },
			        dataType: "json",
			        success: function (json) {
			        	// console.log(JSON.stringify(json));
			        	// alert("2222");
			            // 모달 내용을 변수에 저장
			            var v_html = 
			            	"<div class='reviewEditModal'>" +
			                "<div class='reviewEditModal_header'>" +
			                "<span class='close'>&times;</span>" +
			                "<div class='reviewEditModal_content' style='padding-left: 5%; height: 570px; overflow-y: auto;'>" +
			                "<h4>귀하의 경험에 대해 평가해주세요.</h4>" +
			                "<div class='rating'>" +
			                "<fieldset class='rateCircle'>" +
			                "<span style='display:flex'>" +
			                "<input type='radio' id='ratingpoint_2' name='rv_rating' value='2'/>" +
			                "<label for='ratingpoint_2'></label>" +
			                "<input type='radio' id='ratingpoint_4' name='rv_rating' value='4'/>" +
			                "<label for='ratingpoint_4'></label>" +
			                "<input type='radio' id='ratingpoint_6' name='rv_rating' value='6'/>" +
			                "<label for='ratingpoint_6'></label>" +
			                "<input type='radio' id='ratingpoint_8' name='rv_rating' value='8'/>" +
			                "<label for='ratingpoint_8'></label>" +
			                "<input type='radio' id='ratingpoint_10' name='rv_rating' value='10'/>" +
			                "<label for='ratingpoint_10'></label>" +
			                "<span>2 - 너무 별로에요</span>" +
			                "</span>" +
			                "</fieldset>" +
			                "</div>" +
			                "<div class='rv_subject'>" +
			                "<h4>제목</h4>" +
			                "<input type='text' name='rv_subject' size='70' maxlength='200' placeholder='제목을 입력해주세요.' autocomplete='off'/>" +
			                "</div>" +
			                "<div class='rv_content'>" +
			                "<h4>리뷰 쓰기</h4>" +
			                "<textarea style='width:70%; height:300px;' name='rv_content' id='content' autocomplete='off'></textarea>" +
			                "</div>" +
			                "<div></div>" +
			                "</div>" +
			                "</div>" +
			                "</div>";
			                
			               
						
			            // 모달 영역에 새로운 내용 삽입
			            $("form[name='reviewEditForm']").html(v_html);
			            alert($("form[name='reviewEditForm']"));
			            // 모달 표시
			            $(".reviewEditModal").fadeIn();
			            $(".reviewEditModal_header").show();
			            $("body").addClass("modal-open");
			            
			         // 모달의 닫기 버튼 클릭 시 모달 닫기
			    	    $("span.close").click(function() {
			    	        $(".reviewEditModal").fadeOut();
			    	        $("body").removeClass("modal-open"); // body에서 modal-open 클래스 제거
			    	    });
			         	
			    	    const labels = document.querySelectorAll('.rateCircle label');

			    	    function updateStars(index) {
			    	        for (let i = 0; i < labels.length; i++) {
			    	            if (i <= index) {
			    	                labels[i].style.backgroundImage = `url('<%= ctxPath%>/resources/images/ch/circle-solid.png')`;
			    	            } else {
			    	                labels[i].style.backgroundImage = `url('<%= ctxPath%>/resources/images/ch/circle-regular.png')`;
			    	            }
			    	        }
			    	    }

			    	    labels.forEach((label, index) => {
			    	        label.addEventListener('click', () => {
			    	            updateStars(index);
			    	        });

			    	        label.addEventListener('mouseover', () => {
			    	            updateStars(index);
			    	        });

			    	        label.addEventListener('mouseout', () => {
			    	            const checked = document.querySelector('.rateCircle input[type=radio]:checked');
			    	            if (!checked) {
			    	                labels.forEach((label) => {
			    	                    label.style.backgroundImage = `url('<%= ctxPath%>/resources/images/ch/circle-regular.png')`;
			    	                });
			    	            } else {
			    	                updateStars(Array.from(labels).indexOf(checked.nextElementSibling));
			    	            }
			    	        });
			    	    });
			    	    
			    	    
			         	
			        }
			    });//
			}
			
			else{

				$.ajax({
					url:"리뷰 없는 페이지",
					data:{"rs_seq":"1"},
					dataType:"json",
					success: function(json){
						
						v_html = "";
						
						v_html += "<div class='reviewEditModal'>"
						
						
						
						$("form[name='reviewEditForm']").html(v_html);
						
					}
					
				});
				
		        $(".reviewEditModal").fadeIn();
		        $(".reviewEditModal_header").show(); // 삭제 버튼 클릭 시 헤더 영역 보이기
		        $("body").addClass("modal-open"); // body에 modal-open 클래스 추가
		        
		        // 불러온 값(json타입의 list, map 아무거나) input에 넣어주기
		        
		        
		        
			}
			
	}
});
</script>
<div style="inline-size: 100%; margin: auto; max-inline-size: 85rem; padding: 50px 0;">

	<div id="myrvlist">					
			<a style="font-weight: bold;" href="<%=ctxPath%>/account.exp">내 계정</a>		
				
				<div class="review">
					<div class="reviewcontent">	
						<br>
						<h4>신라호텔
						<button class="dropdown_bar" type="button" id="dropdownMenuButton" >
							<svg style="float:right;" viewBox="0 0 24 24" width="32px" height="20px" class="d Vb UmNoP"><path d="M5 14a2 2 0 100-4 2 2 0 000 4zM19 14a2 2 0 100-4 2 2 0 000 4zM12 14a2 2 0 100-4 2 2 0 000 4z"></path></svg>
						</button>                                                                                                                                                                                                                                                                                                                                                                          
						</h4>
						<div class="dropdown_content">
						    <%-- <div class="rvedit" id="rvedit" onclick="javascript:location.href='<%= ctxPath%>/rvedit.exp?rv_seq=${requestScope.reviewvo.tb_seq}'">리뷰 수정</div> --%>
						    <div class="rvedit" id="rvedit" onclick="rvedit()">리뷰 수정</div>
        					<div class="rvdel" id="rvdelete">리뷰 삭제</div>
			  			</div>	
						<br>
                        <div>8/10 - 훌륭해요</div>
                        <div>임채혁</div>
                        <br>
                        <div>2024.01.29</div>
                        <br>
                        <span> 2024.01.23 에 3박 숙박함 </span>
                    </div>    
				</div>
		
		
		<!-- 이용한 숙소가 없는 경우 -->	
		<div style="text-align:center;">			
				<div class="no_review"><h4>첫 이용 후기를 작성해주세요!</h4></div>
				<br><br>
				<a href="<%=ctxPath%>/index.exp">다음 여행 예약</</a>
		</div>
		
		<!-- 이용후기 모달 -->
		<form name="reviewEditForm">
			
		</form>
		
		
	</div>
	
</div>
