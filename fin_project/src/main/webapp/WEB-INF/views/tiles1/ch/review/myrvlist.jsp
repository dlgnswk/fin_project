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
	height: 280px;
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
	    top:0; 
	    left:0; 
	    display:none;
	}
	
	body.modal-open {
	    overflow: hidden; /* 페이지 스크롤 막기 */
	    background: rgba(0, 0, 0, 0.4);	   
	    z-index: 1;
	}
	
	.reviewEditModal_header{		
	    width: 720px; /* 500px를 16px 기준으로 나눈 값 */
	    height: 640px;        /* 300px를 16px 기준으로 나눈 값 */
	    background:#fff; 
	    border-radius:0.625rem; /* 10px를 16px 기준으로 나눈 값 */
	    text-align:left;
	    box-sizing:border-box; 
	    padding: 50px 0; /* 74px를 16px 기준으로 나눈 값 */
	    line-height:1.4375rem; /* 23px를 16px 기준으로 나눈 값 */
	    cursor:pointer;
	    position: fixed; 
	    top: 50%; 
	    left: 50%; 
	    transform: translate(-50%, -50%);
	}
	
	#myrvlist > form > div > div > span {
	    position: absolute; 
	    top: 6px; /* 15px를 16px 기준으로 나눈 값 */
	    left: 0.9375rem; /* 15px를 16px 기준으로 나눈 값 */
	    color: #0073ff;
	    font-size: 30px;
	    cursor: pointer;	    	    
	}
	
	/* 별점 css 시작 */
	
	#mycontent > form > div > div.reviewWriteEdit_header > div > div.rating {
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
	   width: 8.9%;
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
	
	#myrvlist > form > div > div > div > div.rv_subject > input[type=text] {
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
	  width: 72%;
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
	
	#btnEdit {
		background-color: #0073ff;
	    height: 2.5rem; /* 40px를 16px 기준으로 나눈 값 */
	    color: white;
	    width: 72%; /* 70px를 16px 기준으로 나눈 값 */
	    border: 0px solid #555555;
	    border-radius: 1.0625rem; /* 17px를 16px 기준으로 나눈 값 */
	    font-size: 0.875rem; /* 14px를 16px 기준으로 나눈 값 */
	}
	
	#btnEdit:hover {
		background-color:rgba(0, 80, 190, 0.97);
	    box-shadow: 0 0.25rem 0.375rem -0.0625rem rgba(0, 0, 0, 0.1), 0 0.125rem 0.25rem -0.0625rem rgba(0, 0, 0, 0.08);
	}
	
	/* 삭제 모달 css 시작 */
	.reviewDeleteModal{ 
	    position:absolute; 
	    width:100%; 
	    height:100%; 
	    background: rgba(0,0,0,0.4); 
	    top:0; 
	    left:0; 
	    display:none;
	    z-index: 100;
	}
	
	body.modal-open {
	    overflow: hidden; /* 페이지 스크롤 막기 */
	}
	
	.reviewDeleteModal_header{
	    width:31.25rem; /* 500px를 16px 기준으로 나눈 값 */
	    height:18.75rem; /* 300px를 16px 기준으로 나눈 값 */
	    background:#fff; 
	    border-radius:0.625rem; /* 10px를 16px 기준으로 나눈 값 */
	    text-align:center;
	    box-sizing:border-box; 
	    padding:4.625rem 0; /* 74px를 16px 기준으로 나눈 값 */
	    line-height:1.4375rem; /* 23px를 16px 기준으로 나눈 값 */
	    cursor:pointer;
	    position: fixed; 
	    top: 50%; 
	    left: 50%; 
	    transform: translate(-50%, -50%);
	}
	
	#mycontent > form:nth-child(9) > div > div.reviewDeleteModal_header > span {
	    position: absolute; 
	    top: 0.9375rem; /* 15px를 16px 기준으로 나눈 값 */
	    right: 0.9375rem; /* 15px를 16px 기준으로 나눈 값 */
	}
	
	#btn_rvdel {
	    background-color: #0073ff;
	    height: 2.5rem; /* 40px를 16px 기준으로 나눈 값 */
	    color: white;
	    width: 4.375rem; /* 70px를 16px 기준으로 나눈 값 */
	    border: 0px solid #555555;
	    border-radius: 1.0625rem; /* 17px를 16px 기준으로 나눈 값 */
	    font-size: 0.875rem; /* 14px를 16px 기준으로 나눈 값 */
	    margin: 0 5% 0 0;
	}
	
	#btn_rvdel:hover {
		 background-color:rgba(0, 80, 190, 0.97);
	    box-shadow: 0 0.25rem 0.375rem -0.0625rem rgba(0, 0, 0, 0.1), 0 0.125rem 0.25rem -0.0625rem rgba(0, 0, 0, 0.08);
	}
	
	#btn_cancel {
		background-color: #8e979c;
	    height: 2.5rem; /* 40px를 16px 기준으로 나눈 값 */
	    margin-left: 0.3125rem; /* 5px를 16px 기준으로 나눈 값 */
	    color: white;
	    width: 4.375rem; /* 70px를 16px 기준으로 나눈 값 */
	    border: 0px solid #555555;
	    border-radius: 1.0625rem; /* 17px를 16px 기준으로 나눈 값 */
	    font-size: 0.875rem; /* 14px를 16px 기준으로 나눈 값 */
	}
	#btn_cancel:hover {
	    background-color:rgba(94, 110, 128, 1);
	    box-shadow: 0 0.25rem 0.375rem -0.0625rem rgba(0, 0, 0, 0.1), 0 0.125rem 0.25rem -0.0625rem rgba(0, 0, 0, 0.08);
	}
	/* 삭제 모달 css 끝 */
	
</style>

<script type="text/javascript"> 
	
$(document).ready(function() {
	
	$("button#btnEdit").click(function(){
		
		// 이용후기 내용 유효성 검사
		const rv_subject = $("input:text[name='rv_subject']").val(); 			 
		if(rv_content == "") {
			alert("제목을  입력하세요!!");
			return; // 종료
		}
		
		
		// 이용후기 내용 유효성 검사
		const rv_content = $("textarea[name='rv_content']").val(); 			 
		if(rv_content == "") {
			alert("이용 후기를  입력하세요!!");
			return; // 종료
		}
		
		// 폼 (form)을 적용하자
		const frm = document.reviewEditForm;
		frm.method = "post";
		frm.action = "<%= ctxPath%>/rveditEnd.exp";
		frm.submit();
	});
	
	
	
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
	
	$(document).on("click", "button.dropdown_bar", function(){
	 // 해당 버튼에 대응하는 드롭다운 컨텐츠 찾기
	    var dropdownContent = $(this).closest('.review').find('.dropdown_content');

	    // 다른 드롭다운 컨텐츠는 모두 숨기기
	    $("div.dropdown_content").not(dropdownContent).hide();

	    // 클릭된 드롭다운 컨텐츠 토글
	    dropdownContent.toggle(); 
	});
    
    
	// Function Declaration
	$(document).mouseup(function (e) {
		let dropdown_content = $("div.dropdown_content");
		// console.log(dropdown_content);
		if (dropdown_content.has(e.target).length === 0) {
			dropdown_content.hide();
		}
	});
    
	// 리뷰 수정하기
	$(document).on("click", "button#btnEdit", function(){
		console.log("수정 하깅")
		// 폼 (form)을 적용하자
		const frm = document.reviewEditForm;
		frm.method = "post";
		frm.action = "<%= ctxPath%>/rveditEnd.exp";
		frm.submit();
		
	});
	
	// 리뷰 수정하기
	$(document).on("click", "button#btn_rvdel", function(){
		console.log("삭제 하깅")
		// 폼 (form)을 적용하자
		const frm = document.reviewDeleteForm;
		frm.method = "post";
		frm.action = "<%= ctxPath%>/rvdeleteEnd.exp";
		frm.submit();
		
	});
	
   // 삭제 모달 내 header에서 '취소' 버튼 클릭 시 동작
   $(document).on("click", "button#btn_cancel", function(){
        $(".reviewDeleteModal").fadeOut();
        $("body").removeClass("modal-open"); // body에서 modal-open 클래스 제거
    });
	
	
	
});   
    
 	// Function Declaration
	// 리뷰수정 버튼 클릭시
	function reviewEdit(rv_seq) {								
			
	    $.ajax({
	        url: "<%= ctxPath%>/reviewEditModal.exp",  
	        data: {"rv_seq": rv_seq },
	        dataType: "json",
	        success: function (json) {
	        	// console.log(JSON.stringify(json));
	        	// console.log(json.rv_seq);
	        	// console.log(json.rv_subject);
	        	// console.log(json.rv_content);
	        	// console.log(json.fk_rv_rating);
	            var v_html = 
	            	"<div class='reviewEditModal' id='reviewEditModal'>" +
	                "<div class='reviewEditModal_header'>" +
	                "<span class='close'>&times;</span>" +
	                "<div class='reviewEditModal_content' style='padding-left: 22%; height: 570px; overflow-y: auto;'>" +
	                "<h4>귀하의 경험에 대해 평가해주세요.</h4>" +
	                "<input type='hidden' id='rv_seq_input' name='rv_seq' value='" + rv_seq +"'>" +
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
	                "<br>" +
	                "<div class='rv_subject'>" +
	                "<h4>제목</h4>" +
	                "<input type='text' name='rv_subject' size='50' maxlength='200' value='" + json.rv_subject +"' placeholder='제목을 입력해주세요.' autocomplete='off'/>" +
	                "</div>" +
	                "<div class='rv_content'>" +
	                "<h4>리뷰 쓰기</h4>" +
	                "<textarea name='rv_content' id='content' autocomplete='off'>" + json.rv_content + "</textarea>" +
	                "</div>" +
	                "<div>" +
	                "<button type='button' id='btnEdit'>수정 하기</button>" +
	                "</div>" +
	                "</div>" +
	                "</div>" +
	                "</div>";
	                
	               
                // 모달 창이 뜨면 드롭다운 내용은 꺼지도록 설정
                $("div.dropdown_content").hide();
                
	            // 모달 영역에 새로운 내용 삽입
	            $("form[name='reviewEditForm']").html(v_html);
	            // alert($("form[name='reviewEditForm']"));
	            // 모달 표시
	            $(".reviewEditModal").fadeIn();
	            $(".reviewEditModal_header").show();
	            $("body").addClass("modal-open");
	            
	            // 모달창 뜰 때 배경색 변경
	            $('#headerOfheader > div > section').css('background-color', 'rgba(0, 0, 0, 0.4)');
	            $('#myrvlist > div').css('background-color', 'rgba(0, 0, 0, 0.0)');
	            $('#myfooter > footer > div > div > ul.uitk-layout-flex.uitk-layout-flex-align-items-center.uitk-layout-flex-flex-direction-row.uitk-layout-flex-justify-content-flex-start.uitk-layout-flex-flex-wrap-wrap.no-bullet > li > a > img').css('filter', 'brightness(60%)');
	           
	            setInitialRating(json.fk_rv_rating);
	            
	            // 모달의 닫기 버튼 클릭 시 모달 닫기
	    	    $("span.close").click(function() {
	    	        $(".reviewEditModal").fadeOut();
	    	        $("body").removeClass("modal-open"); // body에서 modal-open 클래스 제거
	    	        $('#headerOfheader > div > section').css('background-color', '');
	    	        $('#myrvlist > div').css('background-color', '');
	    	        
	    	        $('#myfooter > footer > div > div > ul.uitk-layout-flex.uitk-layout-flex-align-items-center.uitk-layout-flex-flex-direction-row.uitk-layout-flex-justify-content-flex-start.uitk-layout-flex-flex-wrap-wrap.no-bullet > li > a > img').css('filter', '');
	    	        document.body.style.overflow = 'auto';
	    	    });
	         	
	            const reviewEditModal = document.getElementById('reviewEditModal');
	    	    window.addEventListener('click', function (e) { // 모달 외의 body 클릭 시 모달창 display:none
	    	        if (e.target === reviewEditModal) {
	    	        	$(".reviewEditModal").fadeOut();
		    	        $("body").removeClass("modal-open"); // body에서 modal-open 클래스 제거
		    	        $('#headerOfheader > div > section').css('background-color', '');
		    	        $('#myrvlist > div').css('background-color', '');
		    	        
		    	        $('#myfooter > footer > div > div > ul.uitk-layout-flex.uitk-layout-flex-align-items-center.uitk-layout-flex-flex-direction-row.uitk-layout-flex-justify-content-flex-start.uitk-layout-flex-flex-wrap-wrap.no-bullet > li > a > img').css('filter', '');
		    	        document.body.style.overflow = 'auto';
	    	        }
	    	        
	    	     });  
	            
	            
	    	   	
	        }, // end of success
	        error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
	    });// end of ajax	
			
	}// end of function reviewEdit(rv_seq)
	
	function setInitialRating() {
	    // 'rateCircle label' 클래스를 가진 모든 label 요소를 가져옵니다.
	    const labels = document.querySelectorAll('.rateCircle label');

	    // 각 label의 배경 이미지를 'circle-regular.png'로 초기화합니다.
	    labels.forEach((label) => {
	        label.style.backgroundImage = `url('<%= ctxPath%>/resources/images/ch/circle-regular.png')`;
	    });

	    // 각 label에 마우스 이벤트를 추가
	    labels.forEach((label, index) => {
	    	
	        // label에 마우스를 올렸을 때의 동작
	        label.addEventListener('mouseover', () => {
	            // 현재 label을 기준으로 그 이하의 label들은 'circle-solid.png' 이미지로 변경하고,
	            // 그 이상의 label들은 'circle-regular.png' 이미지로 변경
	            for (let i = 0; i <= index; i++) {
	                labels[i].style.backgroundImage = `url('<%= ctxPath%>/resources/images/ch/circle-solid.png')`;
	            }
	            for (let i = index + 1; i < labels.length; i++) {
	                labels[i].style.backgroundImage = `url('<%= ctxPath%>/resources/images/ch/circle-regular.png')`;
	            }
	        });

	        
	        // label에서 마우스가 빠져나갔을 때의 동작을 정의합니다.
	        label.addEventListener('mouseout', () => {
	            // 선택된 별이 없다면 모든 label을 'circle-regular.png' 이미지로 변경
	            const checked = document.querySelector('.rateCircle input[type=radio]:checked');
	            if (!checked) {
	                labels.forEach((label) => {
	                    label.style.backgroundImage = `url('<%= ctxPath%>/resources/images/ch/circle-regular.png')`;
	                });
	            } else {
	                // 선택된 별 이후의 별은 'circle-regular.png' 이미지로, 그 이하는 'circle-solid.png' 이미지로 변경
	                const checkedIndex = Array.from(labels).indexOf(checked.nextElementSibling);
	                for (let i = 0; i <= checkedIndex; i++) {
	                    labels[i].style.backgroundImage = `url('<%= ctxPath%>/resources/images/ch/circle-solid.png')`;
	                }
	                for (let i = checkedIndex + 1; i < labels.length; i++) {
	                    labels[i].style.backgroundImage = `url('<%= ctxPath%>/resources/images/ch/circle-regular.png')`;
	                }
	            }
	        });
	        
	        
	    });
	}// end of function setInitialRating()
	
	function reviewDelete(rv_seq) {
	    $.ajax({
	        url: "<%= ctxPath%>/reviewDeleteModal.exp",
	        data: {"rv_seq":rv_seq},
	        dataType: "json",
	        success: function (json) {
	            let v_html = "";
	            v_html += "<div class='reviewDeleteModal' id='reviewDeleteModal'>";             
	            v_html += "<div class='reviewDeleteModal_header'>";
	            v_html += "<span class='close'>&times;</span>";           
	            v_html += "<h3>여행후기를 삭제하시겠습니까?</h3>";
	            v_html += "<input type='hidden' id='rv_seq_input' name='rv_seq' value='" + rv_seq +"'>";
	            v_html += "<p style='margin-top:10%;'>";
	            v_html += "<button id='btn_rvdel' type='button'>삭제</button>";
	            v_html += "<button id='btn_cancel'>취소</button>";
	            v_html += "</p>";
	            v_html += "</div>";
	            v_html += "</div>";
	            
	            // 모달 창이 뜨면 드롭다운 내용은 꺼지도록 설정
	            $("div.dropdown_content").hide();
	            
	         	// 모달 영역에 새로운 내용 삽입
	            $("form[name='reviewDeleteForm']").html(v_html);
	            
	            $("body").addClass("modal-open");
	            
	            // 모달 표시
	            $(".reviewDeleteModal").fadeIn();
	            $(".reviewDeleteModal_header").show();
	            $("body").addClass("modal-open");
	            
	            // 모달창 뜰 때 배경색 변경
	            $('#headerOfheader > div > section').css('background-color', 'rgba(0, 0, 0, 0.4)');
	            $('#myrvlist > div').css('background-color', 'rgba(0, 0, 0, 0.0)');
	            
	            
	            $("span.close").click(function() {
	                $(".reviewDeleteModal").fadeOut();
	                $("body").removeClass("modal-open"); // body에서 modal-open 클래스 제거
	    	        $("body").removeClass("modal-open"); // body에서 modal-open 클래스 제거
	    	        $('#headerOfheader > div > section').css('background-color', '');
	    	        $('#myrvlist > div').css('background-color', '');
	    	        document.body.style.overflow = 'auto';
	            });
	            
	            const reviewDeleteModal = document.getElementById('reviewDeleteModal');
	    	    window.addEventListener('click', function (e) { // 모달 외의 body 클릭 시 모달창 display:none
	    	        if (e.target === reviewDeleteModal) {
	    	        	$(".reviewDeleteModal").fadeOut();
		    	        $("body").removeClass("modal-open"); // body에서 modal-open 클래스 제거
		    	        $('#headerOfheader > div > section').css('background-color', '');
		    	        $('#myrvlist > div').css('background-color', '');
		    	        document.body.style.overflow = 'auto';
	    	        }
	    	        
	    	     });
	        },
	        error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
	    });
	}
	
</script>
<div style="inline-size: 100%; margin: auto; max-inline-size: 85rem; padding: 50px 0;">

	<div id="myrvlist">					
			
			<a style="font-weight: bold; margin-left: 6%;" href="<%=ctxPath%>/account.exp">내 계정</a>		
			 <c:if test="${not empty requestScope.myrvList}">	
				<c:forEach var="myrvList" items="${requestScope.myrvList}">
				<div class="review">
					<div class="reviewcontent">	
						<br>
						<h4>${myrvList.LG_NAME}
						<button class="dropdown_bar" type="button" id="dropdownMenuButton" >
							<svg style="float:right;" viewBox="0 0 24 24" width="32px" height="20px" class="d Vb UmNoP"><path d="M5 14a2 2 0 100-4 2 2 0 000 4zM19 14a2 2 0 100-4 2 2 0 000 4zM12 14a2 2 0 100-4 2 2 0 000 4z"></path></svg>
						</button>                                                                                                                                                                                                                                                                                                                                                                          
						</h4>
						<div class="dropdown_content">
						    <%-- <div class="rvedit" id="rvedit" onclick="javascript:location.href='<%= ctxPath%>/rvedit.exp?rv_seq=${requestScope.reviewvo.tb_seq}'">리뷰 수정</div> --%>
						    <a class="rvedit" id="rvedit" onclick="reviewEdit(${myrvList.RV_SEQ})">리뷰 수정</a>
        					<a class="rvdelete" id="rvdelete" onclick="reviewDelete(${myrvList.RV_SEQ})">리뷰 삭제</a>
			  			</div>	
						<br>
						<input type="hidden" name="rv_seq" value="${myrvList.RV_SEQ}" readonly />
                        <div>${myrvList.FK_RV_RATING}/10 - ${myrvList.RV_RATING_DESC}</div>
                        <br>
                        <div>${myrvList.RV_SUBJECT}</div>
                        <br>
                        <div>${myrvList.RV_CONTENT}</div>
                        <div>${myrvList.RV_REGDATE}</div>
                        <br>
                        <span> ${myrvList.STAYDATE}에  ${myrvList.livedate} 숙박함 </span>
                    </div>    
				</div>
				<br>
				</c:forEach>
				</c:if>
				<c:if test="${empty requestScope.myrvList}">
				<div style="text-align: center;">
					<div class="no_review">
						<h4>첫 이용 후기를 작성해주세요!</h4>
					</div>
					<br>
					<br> <a href="/expedia/index.exp">다음 여행 예약</a>
				</div>
			</c:if>
			
			<!-- 이용후기 모달 -->
		<form name="reviewEditForm">
			
		</form>
		
		<form name="reviewDeleteForm"> 

		</form>
	</div>
	
</div>
