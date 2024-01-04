<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<%
	String ctxPath = request.getContextPath();
    //      /board
%>  

<script src="https://kit.fontawesome.com/cba4097ef6.js" crossorigin="anonymous"></script>

<style>	
	.content_block {
    position: relative;
    width: 80%;
    min-height: 37.5rem; /* 600px를 렘 단위로 변환한 값 */
    margin: 0 auto;
}
	
	.page_navigation {
    width: 80%;
    height: 1.5625rem; /* 25px를 렘 단위로 변환한 값 */
    margin: auto;
    text-align: right;
	}
	
	a:link,
	a:visited,
	a:active,
	a {
	  color: black;
	}
	
	a:hover{
	text-decoration-line : underline;
	color: black;
	}
	
	ul {
    list-style: none;
	}
	
	ul.page_nav li {
    display: inline-block;
    height: 3.125rem; /* 50px를 렘 단위로 변환한 값 */
    line-height: 3.125rem; /* 50px를 렘 단위로 변환한 값 */
    padding-left: 1.25rem; /* 20px를 렘 단위로 변환한 값 */
    font-size: 0.875rem; /* 14px를 렘 단위로 변환한 값 */
    color: #777;
	}
	
	div {
    display: block;
	}
		
	.tit_con_title {
    margin-bottom: 1.25rem; /* 20px를 렘 단위로 변환한 값 */
    line-height: 1;
    color: #222;
	}
	
	
	.tb_article .brd_title {
    border-top: 0.125rem solid #222; /* 2px를 렘 단위로 변환한 값 */
	}

	.brd_title .tag {
    position: static;
    display: inline-block;
    margin: -0.3125rem 0.3125rem 0 0; /* -5px 5px 0 0을 렘 단위로 변환한 값 */
    vertical-align: middle;
	}

	.brd_title {
    position: relative;
    height: 5rem; /* 80px를 렘 단위로 변환한 값 */
    padding: 0 1.25rem; /* 20px를 렘 단위로 변환한 값 */
    font-size: 1.125rem; /* 18px를 렘 단위로 변환한 값 */
	}

	#content > div > h4 > span > h5 {
    margin-top: 0.9375rem; /* 15px를 렘 단위로 변환한 값 */
	}

	brd_editor {
    border-top: 0.0625rem solid #222; /* 1px를 렘 단위로 변환한 값 */
    border-bottom: 0.0625rem solid #222; /* 1px를 렘 단위로 변환한 값 */
	}

	.report_box {
    display: flex;
    padding: 0 1.25rem; /* 20px를 렘 단위로 변환한 값 */
    justify-content: space-between;
    align-items: center;
    border-top: 0.0625rem solid #ddd; /* 1px를 렘 단위로 변환한 값 */
	}

	.tb_article .like_wrap {
    position: relative;
    display: flex;
    margin-bottom: 2.5rem; /* 40px를 렘 단위로 변환한 값 */
    justify-content: center;
    align-items: center;
	}

	.tb_article .editor_travel .report_box {
    padding-top: 1.375rem; /* 22px를 렘 단위로 변환한 값 */
	}

	.tb_article .brd_right {
    position: absolute;
    display: flex;
    right: 1.25rem; /* 20px를 렘 단위로 변환한 값 */
    top: 1.875rem; /* 30px를 렘 단위로 변환한 값 */
    font-size: 0.9375rem; /* 15px를 렘 단위로 변환한 값 */
	}

	.tb_article .brd_right span {
    position: relative;
    padding: 0 0.9375rem; /* 15px를 렘 단위로 변환한 값 */
	}

	#content > div.tb_article > h4 > div > span:nth-child(3) {
    padding: 0 0 0 0.9375rem; /* 15px를 렘 단위로 변환한 값 */
	}
	
	.tb_article .brd_right {
    display: flex;
    justify-content: space-between;
	}
	
	.tb_article .brd_right span:last-child {
	    margin-left: auto;
	}
	
	.editor_area {
    min-height: 18.75rem; /* 300px를 렘 단위로 변환한 값 */
    padding: 2.5rem 1.25rem; /* 40px를 렘 단위로 변환한 값 */
    margin-bottom: 2.5rem; /* 40px를 렘 단위로 변환한 값 */
    line-height: 1.5625rem; /* 25px를 렘 단위로 변환한 값 */
    border-bottom: 0.125rem solid #222; /* 2px를 렘 단위로 변환한 값 */
	}

	.tb_article .like_wrap div {
    position: relative;
    display: flex;
    padding: 0.625rem 2.5rem; /* 10px 40px를 렘 단위로 변환한 값 */
    justify-content: center;
    align-items: center;
    border: 0.0625rem solid #ddd; /* 1px를 렘 단위로 변환한 값 */
    border-radius: 1.875rem; /* 30px를 렘 단위로 변환한 값 */
	}

	.tb_article .like_wrap p {
    padding-right: 1.25rem; /* 20px를 렘 단위로 변환한 값 */
    padding-top: 0.9375rem; /* 15px를 렘 단위로 변환한 값 */
    color: #222;
	}

	table {
    border-spacing: 0;
    border-collapse: collapse;
    box-sizing: border-box;
	}

	.tbl_cell {
    width: 48.75rem; /* 780px를 렘 단위로 변환한 값 */
    height: 5rem; /* 80px를 렘 단위로 변환한 값 */
    display: table-cell;
    line-height: 1.4;
    vertical-align: middle;
	}

	table.tbl_pren {
    width: 100%;
    margin: 3.125rem 0 1.25rem 0; /* 50px 0 20px 0을 렘 단위로 변환한 값 */
    border-top: 0.0625rem solid #ddd; /* 1px solid #ddd를 렘 단위로 변환한 값 */
	}

	tr {
    display: table-row;
    vertical-align: inherit;
    border-color: inherit;
	}

	table.tbl_pren th {
    height: 3.75rem; /* 60px를 렘 단위로 변환한 값 */
    padding: 1.25rem; /* 20px를 렘 단위로 변환한 값 */
    border-bottom: 0.0625rem solid #ddd; /* 1px를 렘 단위로 변환한 값 */
    color: #222;
    text-align: left;
	}

	table.tbl_pren td {
    position: relative;
    height: 3.75rem; /* 60px를 렘 단위로 변환한 값 */
    padding: 1.25rem; /* 20px를 렘 단위로 변환한 값 */
    border-bottom: 0.0625rem solid #ddd; /* 1px를 렘 단위로 변환한 값 */
    vertical-align: middle;
    text-align: left;
	}
	
	/* 드롭다운 메뉴 예시 스타일 */

	.dropdown_content {
    position: absolute;
    display: none;
    width: 9.8125rem; /* 157px를 16px 기준으로 나눈 값 */
    background-color: white;
    border-radius: 0.25rem; /* 4px를 16px 기준으로 나눈 값 */
    box-shadow: 0.25rem 0.25rem 0.625rem #c5b0b0; /* 4px, 4px, 10px를 16px 기준으로 나눈 값 */
    animation: fade-in 1s ease;
    right: 0; /* 오른쪽에 위치하도록 설정 */
    z-index: 1; /* 다른 요소 위에 나타나도록 z-index 설정 */
	}

	#tbedit, #tbdelete {
	    text-align: left;
	    color: black;
	    padding: 0.5rem;
	    text-decoration: none;
	    display: block;
	    font-size: 16px;
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
	
	/* 드롭다운 메뉴 스타일 */
	
	#tbedit:hover {
		border: 0px solid black;
		border-radius: 6px;
		cursor: pointer;
		background-color: rgba(0, 0, 0, 0.06);
	}
	
	#tbdelete:hover {
		border: 0px solid black;
		border-radius: 6px;
		cursor: pointer;
		background-color: rgba(0, 0, 0, 0.06);
	}
	
	
	/* 목록버튼 css */
	#btnList {
    background-color: #0073ff;
    height: 1.9187rem; /* 30.7px를 16px 기준으로 나눈 값 */
    color: white;
    width: 3.4375rem; /* 55px를 16px 기준으로 나눈 값 */
    margin: 0 0 0.4375%; /* 7px를 16px 기준으로 나눈 값 */
    border: 0px solid #555555;
    border-radius: 16px; /* 5px를 16px 기준으로 나눈 값 */
    font-size: 0.875rem; /* 14px를 16px 기준으로 나눈 값 */
	}
	#btnList:hover {
    background-color: rgba(0, 80, 190, 0.97);
    box-shadow: 0 0.25rem 0.375rem -0.0625rem rgba(0, 0, 0, 0.1), 0 0.125rem 0.25rem -0.0625rem rgba(0, 0, 0, 0.08);
	}
  	
  	/* 모달 css 시작 */
	.tbdeleteModal{ 
	    position:absolute; 
	    width:100%; 
	    height:100%; 
	    background: rgba(0,0,0,0.8); 
	    top:0; 
	    left:0; 
	    display:none;
	    z-index: 100;
	}
	
	body.modal-open {
	    overflow: hidden; /* 페이지 스크롤 막기 */
	}
	
	.tbdeleteModal_header{
	    width:31.25rem; /* 500px를 16px 기준으로 나눈 값 */
	    height:18.75rem; /* 300px를 16px 기준으로 나눈 값 */
	    background:#fff; 
	    border-radius:0.625rem; /* 10px를 16px 기준으로 나눈 값 */
	    position:relative; 
	    top:50%; 
	    left:50%;
	    margin-top:-9.375rem; /* height의 절반 */
	    margin-left:-15.625rem; /* width의 절반 */
	    text-align:center;
	    box-sizing:border-box; 
	    padding:4.625rem 0; /* 74px를 16px 기준으로 나눈 값 */
	    line-height:1.4375rem; /* 23px를 16px 기준으로 나눈 값 */
	    cursor:pointer;
	}
	
	.tbdeleteModal_body{
	    width:31.25rem; /* 500px를 16px 기준으로 나눈 값 */
	    height:18.75rem; /* 300px를 16px 기준으로 나눈 값 */
	    background:#fff; 
	    border-radius:0.625rem; /* 10px를 16px 기준으로 나눈 값 */
	    position:relative; 
	    top:50%; 
	    left:50%;
	    margin-top:-9.375rem; /* height의 절반 */
	    margin-left:-15.625rem; /* width의 절반 */
	    text-align:center;
	    box-sizing:border-box; 
	    padding:4.625rem 0; /* 74px를 16px 기준으로 나눈 값 */
	    line-height:1.4375rem; /* 23px를 16px 기준으로 나눈 값 */
	    cursor:pointer;
	}
	
	
	#mycontent > form:nth-child(9) > div > div.tbdeleteModal_header > span,
	#mycontent > form:nth-child(9) > div > div.tbdeleteModal_body > span {
	    position: absolute; 
	    top: 0.9375rem; /* 15px를 16px 기준으로 나눈 값 */
	    right: 0.9375rem; /* 15px를 16px 기준으로 나눈 값 */
	}
	
	#btn_tbdel {
	    background-color: #0073ff;
	    height: 2.5rem; /* 40px를 16px 기준으로 나눈 값 */
	    color: white;
	    width: 4.375rem; /* 70px를 16px 기준으로 나눈 값 */
	    border: 0px solid #555555;
	    border-radius: 1.0625rem; /* 17px를 16px 기준으로 나눈 값 */
	    font-size: 0.875rem; /* 14px를 16px 기준으로 나눈 값 */
	}
	 
	#btn_tbdelconfirm {
	    background-color: #0073ff;
	    height: 2.5rem; /* 40px를 16px 기준으로 나눈 값 */
	    color: white;
	    width: 5rem; /* 80px를 16px 기준으로 나눈 값 */
	    border: 0px solid #555555;
	    border-radius: 1.0625rem; /* 17px를 16px 기준으로 나눈 값 */
	    font-size: 0.875rem; /* 14px를 16px 기준으로 나눈 값 */
	}
	
	#btn_tbdel:hover, #btn_tbdelconfirm:hover, #btn_confirm:hover {
	    background-color:rgba(0, 80, 190, 0.97);
	    box-shadow: 0 0.25rem 0.375rem -0.0625rem rgba(0, 0, 0, 0.1), 0 0.125rem 0.25rem -0.0625rem rgba(0, 0, 0, 0.08);
	}
	
	#btn_cancel, #btn_cancelconfirm {
	    background-color: #8e979c;
	    height: 2.5rem; /* 40px를 16px 기준으로 나눈 값 */
	    margin-left: 0.3125rem; /* 5px를 16px 기준으로 나눈 값 */
	    color: white;
	    width: 4.375rem; /* 70px를 16px 기준으로 나눈 값 */
	    border: 0px solid #555555;
	    border-radius: 1.0625rem; /* 17px를 16px 기준으로 나눈 값 */
	    font-size: 0.875rem; /* 14px를 16px 기준으로 나눈 값 */
	}
	
	#btn_cancel:hover, #btn_cancelconfirm:hover {
	    background-color:rgba(94, 110, 128, 1);
	    box-shadow: 0 0.25rem 0.375rem -0.0625rem rgba(0, 0, 0, 0.1), 0 0.125rem 0.25rem -0.0625rem rgba(0, 0, 0, 0.08);
	}
	
	#mycontent > div.tbdeleteModal > div.tbdeleteModal_body > p > input[type=password] {
	    width: 40%;
	    height: 1.875rem; /* 30px를 16px 기준으로 나눈 값 */
	}
  	
	/* 모달 css 끝*/
	
	/* 이전 글 다음글 css */
	#content > div.tb_article > table > tbody > tr:hover {
		cursor: pointer;
    	background-color: rgba(0, 0, 0, 0.06);
	}
	
	
    
	/* 이용하신 숙소 css 끝  */
</style>

<script type="text/javascript">
	  
$(document).ready(function() {
    
	goLikeCount();
	
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
    
    // 삭제 버튼 클릭 시 모달 열기
    $("div#tbdelete").click(function() {
        $(".tbdeleteModal").fadeIn();
        $(".tbdeleteModal_header").show(); // 삭제 버튼 클릭 시 헤더 영역 보이기
        $(".tbdeleteModal_body").hide(); // 삭제 버튼 클릭 시 바디 영역 숨기기
        
        
        $("body").addClass("modal-open"); // body에 modal-open 클래스 추가
    });
    
    // 삭제 모달 내 '삭제' 버튼 클릭 시 동작
    $("#btn_tbdel").click(function() {
        $(".tbdeleteModal_header").hide(); // 헤더 영역 숨기기
        $(".tbdeleteModal_body").show();   // 바디 영역 보이기
    });
    
    
    // 삭제 모달 내 header에서 '취소' 버튼 클릭 시 동작
    $("#btn_cancel").click(function() {
        $(".tbdeleteModal").fadeOut();
        $("body").removeClass("modal-open"); // body에서 modal-open 클래스 제거
    });
    
    // 삭제 모달 내 body에서 '취소' 버튼 클릭 시 동작
    $("#btn_cancelconfirm").click(function() {
        $(".tbdeleteModal").fadeOut();
        $("body").removeClass("modal-open"); // body에서 modal-open 클래스 제거
    });
    
    // 모달의 닫기 버튼 클릭 시 모달 닫기
    $("span.close").click(function() {
        $(".tbdeleteModal").fadeOut();
        $("body").removeClass("modal-open"); // body에서 modal-open 클래스 제거
    });
    
    
    // 삭제 모달 내 '삭제' 버튼 클릭 시 동작 (필요한 경우)
    $("#btn_tbdelconfirm").click(function() {
        // 삭제 기능 구현
    	// 글 암호 유효성 검사
		 
		const tb_pw = $("input:password[name='tb_pw']").val(); 			 
		if(tb_pw == "") {
			alert("글 암호을 입력하세요!!");
			return; 
		}
		else {
			if(tb_pw != "${requestScope.tripboardvo.tb_pw}") {
				alert("입력하신 글 암호가 올바르지 않습니다!");
				return; 
			}
		}
		
		
		
		const frm = document.delFrm;
		frm.method = "post";
		frm.action = "<%= ctxPath%>/delEnd.exp";
		frm.submit();	
        
        
    });
    
    
});

//Function Declaration
function goView(tb_seq) {
	// alert(`글번호 \${tb_seq}번을 봅니다.`);
	
	const goBackURL = "${requestScope.goBackURL}";
	//    goBackURL = "/list.action?searchType=name&searchWord=서영학&currentShowPageNo=9"; 

	 const frm = document.goViewFrm;
	 frm.tb_seq.value = tb_seq;
	 frm.goBackURL.value = goBackURL;
	 
	 
	 frm.method = "post";
<%--   // frm.action = "<%= ctxPath%>/tbview.exp";   --%>
   	 frm.action = "<%= ctxPath%>/tbview_2.action";
	 frm.submit();
	 
}// end of function goView(seq)---------------
	
//**** 특정제품에 대한 좋아요 등록하기 **** // 
function golikeAdd(tb_seq) {

  if(${empty sessionScope.loginuser}){
     alert("좋아요를 하시려면 먼저 로그인 하셔야 합니다.");
     
     window.location.href = "<%= ctxPath%>/login.exp"; // 로그인 페이지 URL로 변경해주세요
     
  }

      $.ajax({
           url:"<%= ctxPath%>/likeAdd.exp",
           type:"post",
           data:{"tb_seq":tb_seq,
                "userid":"${sessionScope.loginuser.userid}"},
           dataType:"json", 
           success:function(json) {
              console.log(JSON.stringify(json));
               // {"msg":"해당제품에\n 좋아요를 클릭하셨습니다."}
                 // 또는
                 // {"msg":"이미 좋아요를 클릭하셨기에\n 두번 이상 좋아요는 불가합니다."}
                 
            // alert(json.msg);
              goLikeCount();
            //swal(json.msg);
            // goLikeCount();
           },
           error: function(request, status, error){
              alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
           }
        });
  


}// end of golikeAdd(pnum)---------------------------



// **** 게시판 좋아요 갯수를 보여주기 **** //
function goLikeCount() {

	
   $.ajax({
         url:"<%= ctxPath%>/likeCount.exp",
         data:{"tb_seq":"${requestScope.tripboardvo.tb_seq}"},
         dataType:"JSON", 
         success:function(json) {
            console.log(JSON.stringify(json));
             // {"likecnt":1, "dislikecnt":0}
             //alert("하하하");
            $("span#likeCnt").html(json.likecnt);
         },
         error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
         }
      });    
   
}// end of function goLikeCount()-------------------


</script>

<div style="inline-size: 100%; margin: auto; max-inline-size: 85rem; padding: 30px 0;">

	<div id="select_box">
		<div id="container">
			 
			<div class="page_navigation">
				<ul class="page_nav">
					<li><a href="<%= ctxPath%>/index.exp">홈</a></li>
					<li>></li>
					<li><a href="<%= ctxPath%>/tblist.exp">여행 후기</a></li>
				</ul>
			</div>
					 
			<div class="content_block" id="content">
				
				<div class="dropdown_main">
					<div >																				
						<h3 class="tit_con_title" style="margin-bottom: 1.875rem;">
						여행 후기
						<c:if test="${not empty sessionScope.loginuser && sessionScope.loginuser.userid == requestScope.tripboardvo.fk_userid}">
						<button class="dropdown_bar" style="height:30px; float:right; margin-top:15px;" type="button" id="dropdownMenuButton" >
							<svg style="float:right;" viewBox="0 0 24 24" width="20px" height="20px" class="d Vb UmNoP"><path d="M5 14a2 2 0 100-4 2 2 0 000 4zM19 14a2 2 0 100-4 2 2 0 000 4zM12 14a2 2 0 100-4 2 2 0 000 4z"></path></svg>
						</button>
						</c:if>
						</h3>							  																
					</div>
					<div class="dropdown_content">
						    <div id="tbedit" onclick="javascript:location.href='<%= ctxPath%>/tbedit.exp?tb_seq=${requestScope.tripboardvo.tb_seq}'">후기수정</div>
        					<div id="tbdelete">후기삭제</div>
			  		</div>	
				</div>	
				
				
				<div id="tooltip" style="display: none; position: absolute; background-color: #f1f1f1; padding: 10px; border-radius: 6px;"></div>				
			         <div class="tb_article">
			         	<c:if test="${not empty requestScope.tripboardvo}">
			                 <h4 class="brd_title" style="font-weight: normal;">
				              <span class="tbl_cell">
				              	<input type="hidden" name="tb_seq" value="${requestScope.tripboardvo.tb_seq}" readonly /> 	                         	
	                         <span class="tag"></span>
	                         	${requestScope.tripboardvo.tb_subject}
	                    	 </span>
								<div class="brd_right">
				                    <span>${requestScope.tripboardvo.tb_name} 님</span>
				                    <input type="hidden" name="tb_city" size="50" value="${requestScope.tripboardvo.tb_city}" maxlength="30"/>
				                    <span>${requestScope.tripboardvo.tb_regDate}</span>
									<span>조회 <em>${requestScope.tripboardvo.tb_readCount}</em></span>
			                    	<span>
			                    	 <c:if test="${sessionScope.loginuser != null}">
					                  <a href="<%= ctxPath%>/download.exp?tb_seq=${requestScope.tripboardvo.tb_seq}">${requestScope.tripboardvo.tb_orgFilename}</a>  
					                </c:if>
					                <c:if test="${sessionScope.loginuser == null}">
					                  ${requestScope.tripboardvo.tb_orgFilename}
					                </c:if>
			                    	</span>
			                    </div>			                    
			                 </h4>
			                 <div class="brd_editor editor_travel">
									<!-- 고객 작성 후기인 경우 -->
									<div class="report_box">
										<div class="txt_guide">
											&nbsp;&nbsp;&nbsp;&nbsp;<svg xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512" style="transform: translateY(-2px);"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#0f203e" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zM216 336h24V272H216c-13.3 0-24-10.7-24-24s10.7-24 24-24h48c13.3 0 24 10.7 24 24v88h8c13.3 0 24 10.7 24 24s-10.7 24-24 24H216c-13.3 0-24-10.7-24-24s10.7-24 24-24zm40-208a32 32 0 1 1 0 64 32 32 0 1 1 0-64z"/></svg>
											<span>아래 내용은 고객님께서 직접 다녀오신 여행 후기입니다.</span>
										</div>
				                    </div>
							        <!-- // 고객 작성 후기인 경우 -->
			                     <div class="editor_area">
			                         ${requestScope.tripboardvo.tb_content}
			                     </div>
			                 </div>
			            </c:if>
			      
				           <!-- 후기 좋아요 -->
				            <div class="like_wrap">
								<div>
									<p>후기가 도움 되었나요?</p>
									<div class="likebtn">
										<%-- <button type="button" class="btn_like" id="btnLike">좋아요</button>&nbsp;&nbsp; --%>
										<svg xmlns="http://www.w3.org/2000/svg" style="margin-right:5px;" height="24" width="24" fill="rgba(35, 121, 255, 0.89)" viewBox="0 0 512 512" onclick="golikeAdd('${requestScope.tripboardvo.tb_seq}')"><path d="M313.4 32.9c26 5.2 42.9 30.5 37.7 56.5l-2.3 11.4c-5.3 26.7-15.1 52.1-28.8 75.2H464c26.5 0 48 21.5 48 48c0 18.5-10.5 34.6-25.9 42.6C497 275.4 504 288.9 504 304c0 23.4-16.8 42.9-38.9 47.1c4.4 7.3 6.9 15.8 6.9 24.9c0 21.3-13.9 39.4-33.1 45.6c.7 3.3 1.1 6.8 1.1 10.4c0 26.5-21.5 48-48 48H294.5c-19 0-37.5-5.6-53.3-16.1l-38.5-25.7C176 420.4 160 390.4 160 358.3V320 272 247.1c0-29.2 13.3-56.7 36-75l7.4-5.9c26.5-21.2 44.6-51 51.2-84.2l2.3-11.4c5.2-26 30.5-42.9 56.5-37.7zM32 192H96c17.7 0 32 14.3 32 32V448c0 17.7-14.3 32-32 32H32c-17.7 0-32-14.3-32-32V224c0-17.7 14.3-32 32-32z"/></svg>
										<span id="likeCnt"></span>																			
									</div>
									
									
								</div>
							</div>
				            <!-- // 후기 좋아요 -->
								
				            <table class="tbl_pren">
					            <colgroup>
						            <col style="width:100px">
						            <col>
					            </colgroup>
				           		<tbody>
									 <c:if test="${empty requestScope.tripboardvo.tb_previousseq}">
									 	<tr>
						                <th scope="row">이전 글</th>		                						                
						                <td></td>
						            	</tr>
									 </c:if>
									 <c:if test="${not empty requestScope.tripboardvo.tb_previousseq}">
									 <tr onclick="goView('${requestScope.tripboardvo.tb_previousseq}')">
						                <th scope="row">이전 글</th>		                
						                
						                <td>${requestScope.tripboardvo.tb_previoussubject}</td>
						            </tr>
									</c:if>
									<c:if test="${empty requestScope.tripboardvo.tb_nextseq}">
										<tr>
						                <th scope="row">다음 글</th>		                						                
						                <td></td>
						            	</tr>
									</c:if>
									<c:if test="${not empty requestScope.tripboardvo.tb_nextseq}">
									<tr onclick="goView('${requestScope.tripboardvo.tb_nextseq}')">
						                <th scope="row">다음 글</th>
						                <td>${requestScope.tripboardvo.tb_nextsubject}</td>
						                		                
						            </tr>
						            </c:if>
					            </tbody>
				            </table>
				            <div class="btn_area">                
								<button type="button" class="btn_cof" id="btnList" onclick="javascript:location.href='<%= ctxPath%>/tblist.exp'">
								<span aria-hidden="true">
                                	<svg xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512" style="transform: translateY(-2px);"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="white" d="M40 48C26.7 48 16 58.7 16 72v48c0 13.3 10.7 24 24 24H88c13.3 0 24-10.7 24-24V72c0-13.3-10.7-24-24-24H40zM192 64c-17.7 0-32 14.3-32 32s14.3 32 32 32H480c17.7 0 32-14.3 32-32s-14.3-32-32-32H192zm0 160c-17.7 0-32 14.3-32 32s14.3 32 32 32H480c17.7 0 32-14.3 32-32s-14.3-32-32-32H192zm0 160c-17.7 0-32 14.3-32 32s14.3 32 32 32H480c17.7 0 32-14.3 32-32s-14.3-32-32-32H192zM16 232v48c0 13.3 10.7 24 24 24H88c13.3 0 24-10.7 24-24V232c0-13.3-10.7-24-24-24H40c-13.3 0-24 10.7-24 24zM40 368c-13.3 0-24 10.7-24 24v48c0 13.3 10.7 24 24 24H88c13.3 0 24-10.7 24-24V392c0-13.3-10.7-24-24-24H40z"/></svg>
                                </span>
                                </button>
				            </div>				            				            
				 	 </div>
				 	 
			    </div> 
		</div>		
	</div>
						
</div>

						<!-- 삭제 모달 창 구현 -->
				 	 <form name="delFrm">
					 	 <div class="tbdeleteModal">				 	 		  				 	 		  		                            
	                              <div class="tbdeleteModal_header">
	                               <span class="close">&times;</span>                                                       	                              	                             	
	                              	<h3>여행후기를 삭제하시겠습니까?</h3>                              
		                             <p style="margin-top:10%;">
		                             	<button id="btn_tbdel" type="button">삭제</button>
		                              	<button id="btn_cancel">취소</button>
		                             </p> 		                              	
	                              </div>
	                              <div class="tbdeleteModal_body">
	                               <span class="close">&times;</span>                                                       	                              	                             	
	                              	<h3>비밀번호를 입력하세요</h3>
	                              	<input type="hidden" name="tb_seq" value="${requestScope.tripboardvo.tb_seq}" readonly />                              
		                             <p style="margin-top:5%;">
		                             	<input type="password" name="tb_pw" maxlength="20" />	                           	
		                             </p>
		                             <div class="confirmbtn"style="margin-top:5%;">
			                             <button id="btn_tbdelconfirm">삭제완료</button>
			                         	 <button id="btn_cancelconfirm">취소</button> 		                              	
	                              	 </div>
	                              </div>	                                                                                     
		                     </div>
	                     </form>
                     
                     <form name="goViewFrm">
					   <input type="hidden" name="tb_seq" />
					   <input type="hidden" name="goBackURL" />
					   <input type="hidden" name="searchType" />
					   <input type="hidden" name="searchWord" />
					</form>
                     
                  