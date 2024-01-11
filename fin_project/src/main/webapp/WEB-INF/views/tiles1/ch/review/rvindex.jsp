<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<%
	String ctxPath = request.getContextPath();
    //      /board
%>  
<!-- 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Josefin+Sans:wght@500&display=swap" rel="stylesheet">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gothic+A1:wght@700&display=swap" rel="stylesheet">


<style type="text/css">	
	.reviewshow > div {
		color: rgba(0, 58, 255, 0.77);		
	}
	.reviewshow > div:hover {
	 	text-decoration: underline;
	 	cursor: pointer;
	}
	
	/* 모달 css 시작 */
	
	.reviewWriteModal{ 
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
	
	.reviewWriteModal_header{		
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
	

	#mycontent > form > div > div.reviewWriteModal_header > span {
	    position: absolute; 
	    top: 6px; /* 15px를 16px 기준으로 나눈 값 */
	    left: 0.9375rem; /* 15px를 16px 기준으로 나눈 값 */
	    color: #0073ff;
	    font-size: 30px;
	    cursor: pointer;	    	    
	}
	
	/* 별점 css 시작 */
	
	#mycontent > form > div > div.reviewWriteModal_header > div > div.rating {
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
	   width: 30%;
       height: 50.5px; 
   	   user-select: none;
	}
	
	#mycontent > form > div > div.reviewWriteModal_header > div > div.rating > fieldset > span > span {
		width: 100%;
		margin: 3% 0 0 5%;		
	}
	
	.rateCircle input[type=radio]:checked ~ label,
    .rateCircle label:hover {
        background-image: url(<%= ctxPath%>/resources/images/ch/circle-solid.png);
    }
	
	/* 별점 css 끝 */
	
	#mycontent > form > div > div > div > div.rv_subject > input[type=text] {
	  height: 2rem; /* 32px → 2rem 변환 */
	  font-size: 0.9375rem; /* 15px → 0.9375rem 변환 */
	  border: 0;
	  border-radius: 0.9375rem; /* 15px → 0.9375rem 변환 */
	  outline: none;
	  padding-left: 0.625rem; /* 10px → 0.625rem 변환 */
	  background-color: rgb(233, 233, 233);
	  margin: 2% 0 2% 0;
	}
	
	#content {
	  width: 61.7%;
	  height: 200px;	
	  font-size: 0.9375rem; /* 15px → 0.9375rem 변환 */
	  border: 0;
	  border-radius: 0.9375rem; /* 15px → 0.9375rem 변환 */
	  outline: none;
	  margin: 2% 0 2% 0;
	  padding: 0.625rem; /* 내부 여백을 주어 삐져나가는 현상을 방지합니다. */
	  box-sizing: border-box; /* 패딩, 보더 등을 포함한 크기 조절을 위해 box-sizing 설정 */
	  resize: none; /* 사용자가 텍스트 영역의 크기를 조절하지 못하게 합니다. */
	  background-color: rgb(233, 233, 233);	
	}
	
	#btnWrite {
		background-color: #0073ff;
	    height: 2.5rem; /* 40px를 16px 기준으로 나눈 값 */
	    color: white;
	    width: 61.3%;; /* 70px를 16px 기준으로 나눈 값 */
	    border: 0px solid #555555;
	    border-radius: 1.0625rem; /* 17px를 16px 기준으로 나눈 값 */
	    font-size: 0.875rem; /* 14px를 16px 기준으로 나눈 값 */
	}
	
	#btnWrite:hover {
		background-color:rgba(0, 80, 190, 0.97);
	    box-shadow: 0 0.25rem 0.375rem -0.0625rem rgba(0, 0, 0, 0.1), 0 0.125rem 0.25rem -0.0625rem rgba(0, 0, 0, 0.08);
	}
</style>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		$("button#btnWrite").click(function(){
			
			const rv_subject = $("input:text[name='rv_subject']").val();
			if(rv_subject == "") {
				alert("제목을 입력하세요!!");
				return; // 종료
			}
			
			
			// 폼 (form)을 적용하자
			const frm = document.reviewWriteForm;
			frm.method = "post";
			frm.action = "<%= ctxPath%>/rvaddEnd.exp";
			frm.submit();
			
		});
		
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
		    const ratingValue = parseInt($(this).attr('for').split('_')[1]);
		    const ratingDescSpan = $('#rating_desc');
		    ratingDescSpan.text(`\${ratingValue} - \${ratingText[ratingValue]}`);
		    console.log('Rating Value:', ratingValue);
		    console.log('ratingDescSpan', ratingDescSpan);
		    // 원하는 작업을 추가하세요. <span id='rating_desc'></span>
		    
		  });

		  $('input[type="radio"]').change(function() {
			    // 선택된 라디오 버튼 값 가져오기
			    let selectedValue = $('input[type="radio"]:checked').val();
			    console.log(selectedValue);
			    
			    // 선택된 값에 따라 다른 라디오 버튼 비활성화
			    $('input[type="radio"]').not(':checked').prop('disabled', true);
			    
			    // 선택된 값에 해당하는 라디오 버튼 활성화
			    $(`input[type="radio"][value="${selectedValue}"]`).prop('disabled', false);
		  });
		  
		
	}); 
	
	
	
	
	// Function Declaration
	// 리뷰작성 버튼 클릭시
		function reviewWrite() {			
			
			let rs_seq = "18";
			// alert(rs_seq);
		
			if ("리뷰 작성하기" == $(".rvadd").text()) {
				alert("dsafasfdsafdsa");
			    $.ajax({
			        url: "<%= ctxPath%>/reviewWriteModal.exp",  
			        data: {"rs_seq": rs_seq},
			        dataType: "json",
			        success: function (json) {
			        	   console.log(JSON.stringify(json));
			        	// alert("2222");
			            // 모달 내용을 변수에 저장
			            var v_html = 
			            	"<div class='reviewWriteModal'>" +
			                "<div class='reviewWriteModal_header'>" +
			                "<span class='close'>&times;</span>" +
			                "<div class='reviewWriteModal_content' style='padding-left: 10%; height: 570px; overflow-y: auto;'>" +
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
			                "<span id='rating_desc'></span>" +
			                "</span>" +
			                "</fieldset>" +
			                "</div>" +
			                "<input type='hidden' id='rs_seq_input' name='rs_seq' value=''>" +
			                "<input type='hidden' name='fk_lodge_id' size='33' readonly/>" +
			                "<br>" +
			                "<div class='rv_subject'>" +
			                "<h4>제목</h4>" +
			                "<input type='text' name='rv_subject' size='50' maxlength='200' placeholder='제목을 입력해주세요.' autocomplete='off'/>" +
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
			                
			               
						
			            // 모달 영역에 새로운 내용 삽입
			            $("form[name='reviewWriteForm']").html(v_html);
			            alert($("form[name='reviewWriteForm']"));
			            // 모달 표시
			            $(".reviewWriteModal").fadeIn();
			            $(".reviewWriteModal_header").show();
			            $("body").addClass("modal-open");
			            
			         // 모달의 닫기 버튼 클릭 시 모달 닫기
			    	    $("span.close").click(function() {
			    	        $(".reviewWriteModal").fadeOut();
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
			
			
			
	}
		
	
	
	
	
	
</script>


<div style="inline-size: 100%; margin: auto; max-inline-size: 85rem; padding: 50px 0;">

	<div id="select_box">
						
			<a style="font-weight: bold;" href="<%=ctxPath%>/account.exp">내 계정</a>
		
		<!-- 이용한 숙소가 없는 경우 -->	
		<div style="text-align:center;">			
				<div class="reviewWrite">
					<a class="rvadd" onclick="reviewWrite()">리뷰 작성하기</a>
					
				</div>
		</div>
		
	</div>
	
</div>

<!-- 이용후기 모달 -->
<form name="reviewWriteForm">
	
</form>


