<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>

<link type="text/css" rel="stylesheet" href="<%= ctxPath%>/resources/css/db/rm_image.css" />

<title>객실 사진 등록</title>

<script type="text/javascript">

	let roomImage_arr = []; 	// 객실 이미지 배열
	
	$(document).ready(function(){
		
		// == roomImage 메인이미지 Drag & Drop 만들기 == //
		$("div#roomImage").on("dragenter", function(e){ /* "dragenter" 이벤트는 드롭대상인 박스 안에 Drag 한 파일이 최초로 들어왔을 때 */ 
       		e.preventDefault();
	        e.stopPropagation();
	    }).on("dragover", function(e){ /* "dragover" 이벤트는 드롭대상인 박스 안에 Drag 한 파일이 머물러 있는 중일 때. 필수이벤트이다. dragover 이벤트를 적용하지 않으면 drop 이벤트가 작동하지 않음 */ 
			e.preventDefault();
	        e.stopPropagation();
	        $(this).css("background-color", "#f2f2f2");
	    }).on("dragleave", function(e){ /* "dragleave" 이벤트는 Drag 한 파일이 드롭대상인 박스 밖으로 벗어났을 때  */
			e.preventDefault();
	        e.stopPropagation();
	        $(this).css("background-color", "#fff");
	    }).on("drop", function(e){      /* "drop" 이벤트는 드롭대상인 박스 안에서 Drag 한것을 Drop(Drag 한 파일(객체)을 놓는것) 했을 때. 필수이벤트이다. */
			e.preventDefault();
	    	const elmt = $(this);
	    	elmt.find("div.infoDiv").hide(); // 안쪽 회색 상자 숨기기	    
	    	
	        var files = e.originalEvent.dataTransfer.files;
	        
	        let check = fileCheck(files);
	        
	       	if( check == false ) {
	       	// 이미지 파일이 아닌경우
	       		alert("해당 파일은 이미지가 아닙니다. 이미지(*.png, *.jpeg) 파일을 등록해 주세요.");
	       		return;
	       	}
	       	else {
	       	// 이미지 파일이 올라온 경우
            	arrDropPush(roomImage_arr, files, elmt);
	       	
	       	}// end of if( check == false ) else 이미지 파일이 아닌경우 -------------
	        
	    }); // end of drop 이벤트 처리 ----------------------------
		
		// "사진 추가" 버튼 클릭시 input 파일을 클릭한 것으로 한다.		
		$("button.btnAdd").click(function(){
			$(this).next().click();
		});// end of $("button.btnAdd").click(function()
		
				
		// let roomImage_arr = []; 	/ 객실 사진
		// roomImage 객실 "사진 첨부" 클릭
		$("input[name='roomImage']").change(function(){
			$(this).parent().parent().parent().find("div.infoDiv").hide(); // 상자정보 숨기기
		//	console.log($("input[name='mainImage']").get(0).files[0]);
			
			const files = $(this).get(0).files;
			
			let check = fileCheck(files);
			const elmt = $(this);
			
	       	if( check == false ) {
	       	// 이미지 파일이 아닌경우
	       		alert("해당 파일은 이미지가 아닙니다. 이미지(*.png, *.jpeg) 파일을 등록해 주세요.");
	       		return;
	       	}
	       	else {
	       	// 이미지 파일이 올라온 경우
            	
        		if(files != null && files != undefined){
					//	console.log("files.length 는 => " + files.length);
					arrPush(roomImage_arr, files, elmt);
	        	
	        	}// end of if(files != null && files != undefined)--------------------------
	        
	       	}// end of if( check == false ) else 이미지 파일이 아닌경우 -------------
			
		});// end of $("input[name='mainImage']").change(function()
		
		
	// 들어온 파일의 타입을 체크한다.
	function fileCheck(file) {
	
		const fileType = file[0].type; // 파일의 타입이 무엇인지 확인한다.
	//	console.log(typeof fileType); // image.png, image.jpeg
		
		let check = false; // 기본
			
		if( fileType.includes('jpeg') || fileType.includes('png') ) {
		// 파일 타입에 png, jpeg가 포함되어 있으면 이면 체크 true	
			check = true;
		}
		// png, jpeg포함되어 있지 않으면 false이다.
	//	console.log("check => "+ check);
		return check;
	} // end of function fileCheck(file)
	
	
	// "drop" 하는 이벤트 
	function arrDropPush(arr, files, elmt) {
		
		if(files != null && files != undefined){
			//	console.log("files.length 는 => " + files.length);
			
    		let html = "";
        	const f = files[0]; // 어차피 files.length 의 값이 1 이므로 위의 for문을 사용하지 않고 files[0] 을 사용하여 1개만 가져오면 된다. 
        	let fileSize = f.size/1024/1024;  /* 파일의 크기는 MB로 나타내기 위하여 /1024/1024 하였음 */
    	
    		if(fileSize >= 10) {
    			alert("10MB 이상인 파일은 업로드할 수 없습니다.!!");
    			elmt.css("background-color", "#fff");
    			return;
    		}
    		else {
    		// 하나의 파일은 10MB를 넘지 못한다.
    		
   				arr.push(f); //  드롭대상인 박스 안에 첨부파일을 드롭하면 파일들을 담아둘 배열인 file_arr 에 파일들을 저장시키도록 한다.
        		const fileName = f.name; // 파일명	
       			
               	const fileReader = new FileReader();
               	fileReader.readAsDataURL(files[0]); //  fileReader.result안에 이미지를 저장한다.
               	
               	let viewFileName = fileName;
	        //  console.log(fileName);
	            // 이그제큐티브 스위트 투베드룸1.png
			//	console.log(fileName.substr(0,fileName.lastIndexOf('.')));
	            // 이그제큐티브 스위트 투베드룸1
	        //	console.log(fileName.substr(fileName.lastIndexOf('.')));
				// .png
               	
               	const fileFrontName = viewFileName.substr(0,viewFileName.lastIndexOf('.'));
				const fileTypeName = viewFileName.substr(viewFileName.lastIndexOf('.'));
              	// .png
              	
	          	if( fileFrontName.length > 7) {
	          		console.log(fileFrontName);
	          		console.log(fileTypeName);
	          		console.log(fileFrontName.substr(0,6) + "···" + fileTypeName);
	          		viewFileName = fileFrontName.substr(0,6) + "···" + fileTypeName;
	          	}
               	
   				fileReader.onload = function(){
					/*
		              	data:image/jpeg;base64,/9j/4AAQSkZJRgABAQEAeAB4AAD/2wBDAAIBAQIBAQICAgICAgICAwUDAwMDAwYEBAMFBwYHBwcGBwcICQsJCAgKCAcHCg0KCgsMDAwMBwkODw0MDgsMDAz/2wBDAQICAg 
		              	이러한 형태로 출력되며, img.src 의 값으로 넣어서 사용한다.
		          	*/
		          	
		          	html += 
		          		"<div class='imageItem exitData'>" +
   		                   	"<img class='__image' src='"+fileReader.result+"' />" + // &times;는 X로 보여주는 것이다.
   		                   	"<div class='imageName'><span class='delete'>&times;</span><span class='fileName'>"+viewFileName+"</span></div>"
	               		"</div>";
                    
               		elmt.append(html);
                   	// document.getElementById("previewImg").src = fileReader.result;
               		elmt.scrollLeft(99999999); // 스크롤 끝으로
   				}; // end of fileReader.onload = function() -----------
    				
    		
			} // end of if(fileSize >= 10) else ---------- 파일은 10MB
    	
    	}// end of if(files != null && files != undefined)--------------------------
    
    	elmt.css("background-color", "#fff");		
	}// end of function arrDropPush(arr, files, elmt) ----------------------
	
	
	// "사진 추가" 하는 이벤트
	function arrPush(arr, files, elmt) {
		
		let html = "";
    	const f = files[0]; // 어차피 files.length 의 값이 1 이므로 위의 for문을 사용하지 않고 files[0] 을 사용하여 1개만 가져오면 된다.
    	console.log(f);
    	let fileSize = f.size/1024/1024;  /* 파일의 크기는 MB로 나타내기 위하여 /1024/1024 하였음 */
	
		if(fileSize >= 10) {
			alert("10MB 이상인 파일은 업로드할 수 없습니다.!!");
			$(this).css("background-color", "#fff");
			return;
		}
		else {
		// 하나의 파일은 10MB를 넘지 못한다.
				
			arr.push(f); //  드롭대상인 박스 안에 첨부파일을 드롭하면 파일들을 담아둘 배열인 file_arr 에 파일들을 저장시키도록 한다.
       		const fileName = f.name; // 파일명	
   			
           	const fileReader = new FileReader();
           	fileReader.readAsDataURL(files[0]); //  fileReader.result안에 이미지를 저장한다.
           	
           	let viewFileName = fileName;
        //  console.log(fileName);
            // 이그제큐티브 스위트 투베드룸1.png
		//	console.log(fileName.substr(0,fileName.lastIndexOf('.')));
            // 이그제큐티브 스위트 투베드룸1
        //	console.log(fileName.substr(fileName.lastIndexOf('.')));
			// .png
           	
           	const fileFrontName = viewFileName.substr(0,viewFileName.lastIndexOf('.'));
			const fileTypeName = viewFileName.substr(viewFileName.lastIndexOf('.'));
             	// .png
             	
          	if( fileFrontName.length > 7) {
          		console.log(fileFrontName);
          		console.log(fileTypeName);
          		console.log(fileFrontName.substr(0,6) + "···" + fileTypeName);
          		viewFileName = fileFrontName.substr(0,6) + "···" + fileTypeName;
          	}
           	
			fileReader.onload = function(){
				/*
	              	data:image/jpeg;base64,/9j/4AAQSkZJRgABAQEAeAB4AAD/2wBDAAIBAQIBAQICAgICAgICAwUDAwMDAwYEBAMFBwYHBwcGBwcICQsJCAgKCAcHCg0KCgsMDAwMBwkODw0MDgsMDAz/2wBDAQICAg 
	              	이러한 형태로 출력되며, img.src 의 값으로 넣어서 사용한다.
	          	*/
	          	
	          	html += 
	          		"<div class='imageItem exitData'>" +
	                   	"<img class='__image' src='"+fileReader.result+"' />" + // &times;는 X로 보여주는 것이다.
	                   	"<div class='imageName'><span class='delete'>&times;</span><span class='fileName'>"+viewFileName+"</span></div>"
               		"</div>";
                   
               	elmt.parent().parent().parent().find(".image_drop").append(html);
               	// document.getElementById("previewImg").src = fileReader.result;
               	elmt.parent().parent().parent().find(".image_drop").scrollLeft(99999999); // 스크롤 끝으로
			}; // end of fileReader.onload = function() -----------
				
		} // end of if(fileSize >= 10) else ---------- 파일은 10MB
		
	} // end of function arrLimitPush(arr, files, elmt) ------------------------------------- 이미지 5개 제한 
	
	
	
	// === 사진 등록 하기  === //
	$(document).on("click", "button#image_register", function(){
		const fk_rm_seq = $("select[name='fk_rm_seq']").val();
		
		if (fk_rm_seq != "") {
		// 사진등록 객실을 선택한 경우		
			var formData = new FormData($("form[name='addFrm']").get(0));
			
			console.log(roomImage_arr);
			// 메인 이미지 
			if(roomImage_arr.length > 0) {
				
				roomImage_arr.forEach(function(item){
					// 첨부파일 추가하기 "file_arr" 이 키값이고  item 이 밸류값인데 file_arr 배열속에 저장되어진 배열요소인 파일첨부되어진 파일이 되어진다.
					// 같은 key를 가진 값을 여러 개 넣을 수 있다.(덮어씌워지지 않고 추가가 된다.)
		        	formData.append("roomImage_arr", item);  
		        });
				
			}// end of if(mainImage_arr.length > 0)
				
			
			formData.append("fk_rm_seq", fk_rm_seq);
		
			$.ajax({
	            url : "<%= ctxPath%>/rm_image.exp",
	            type : "post",
	            data : formData,
	            async: false,
	            processData:false,  // 파일 전송시 설정 -> query string(쿼리 스트링) 하지마라
	            contentType:false,  // 파일 전송시 설정 
	            dataType:"json",
	            success:function(json){
	          	  	
	            	alert("이미지가 성공적으로 등록되었습니다.");
	            },
	            error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		      	}
	        });
		}
		else{
			alert("사진을 등록하시려는 객실을 선택해 주세요.");
		}
		
		location.href="javascript:location.reload(true)";
		
	}); // end of $("button#image_register").click(function()
	
	
	// 객실 이름이 바뀌면 DB에 기존에 등록되어 있는 이미지 파일명을 가져오는 이벤트
	$(document).on("change","select[name='fk_rm_seq']",function(){
		
		roomImage_arr = []; // 새로운 객실을 위해서 -> 이미지 파일 배열 초기화 
		let elmt = $("input[name='roomImage']"); 
		// 새로운 객실을 보여주기 위해 -> 현재 보여주는 객실이미지들 제거
		elmt.parent().parent().parent().find(".imageItem").remove();
		elmt.parent().parent().parent().find(".infoDiv").show();
		
		$.ajax({
            url : "<%= ctxPath%>/getRmImgData.exp",
            type : "post",
            data : { fk_rm_seq:$("select[name='fk_rm_seq']").val()},
            async: false,
            dataType:"json",
            success:function(json){
            	
            	$.each(json, function(index, item){
				//	console.log(item.rm_img_name +"\n" + item.rm_img_save_name);
            		
					// 'C:/git/final_exp/final_project/src/main/webapp/resources/images/'+'${requestScope.fk_lodge_id}'+"/room_img/"+item.rm_img_save_name
					let html = "<div class='imageItem'>" +
		          			      "<img class='__image' src='<%=ctxPath%>/resources/images/"+"${requestScope.fk_lodge_id}"+"/room_img/"+item.rm_img_save_name+"' />" + 
		                   	      "<div class='imageName'>" +
		          			        "<span class='delete'>&times;</span>" +
		          			        "<span class='fileName'>"+item.rm_img_name+"</span>" +
		          			        "<input type='hidden' class='rm_img_name' value='"+item.rm_img_name+"' />"+
		          			      	"<input type='hidden' class='rm_img_save_name' value='"+item.rm_img_save_name+"' />"+
		          			      	"<input type='hidden' class='rm_img_main' value='"+item.rm_img_main+"' />" +
		          			      "</div>"+
	               			   "</div>";					// &times;는 X로 보여주는 것이다.
	               		
	               	elmt.parent().parent().parent().find(".image_drop").append(html);
	               	// document.getElementById("previewImg").src = fileReader.result;
	               	elmt.parent().parent().parent().find(".infoDiv").hide();
	               	
            	}); // end of $.each(json, function(index, item)
            			
            },
            error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	      	}	
        });
		
	}); // end of $(document).on("change","select[name='fk_rm_seq']",function(){
	
	// 페이지가 로드 되면 첫번째 객실의 사진을 가져오는 이벤트 발생
	$("select[name='fk_rm_seq']").trigger("change");	
	
	// "x"를 눌렀을때 저장 경로와 DB에서 삭제한다.
	$(document).on("click","span.delete",function(){
		
		if( confirm("선택한 이미지를 정말로 삭제하시겠습니까?") ) {
		
			if($(this).parent().parent().hasClass("exitData")) {
			// 이미지 파일 배열에 값이 추가된 이미지를 제거했다.			
				const deleteIdx = $(this).parent().parent().index(".exitData");
				roomImage_arr.splice(deleteIdx,1); // 삭제가 발생한 index와 같은 index를 가지는 파일을 배열에서 삭제한다.
			}
			else{
			// DB에서 가져온 이미지라 roomImage_arr에 값이 없는 경우이다.
				const rm_img_name = $(this).parent().find("input.rm_img_name").val();
				const rm_img_save_name = $(this).parent().find("input.rm_img_save_name").val();
				const rm_img_main = $(this).parent().find("input.rm_img_main").val();
				
				console.log(rm_img_name, rm_img_save_name);
				// 해당하는 이미지와 같은 경로의 값을 DB에서 삭제한다.
				$.ajax({
		            url : "<%= ctxPath%>/delIdxImg.exp",
		            type : "post",
		            data : { "fk_lodge_id":"${requestScope.fk_lodge_id}",
		            		 "fk_rm_seq":$("select[name='fk_rm_seq']").val(),
		            		 "rm_img_save_name":rm_img_save_name,
		            		 "rm_img_name":rm_img_name,
		            		 "rm_img_main":rm_img_main
		            		},
		            async: false,
		            dataType:"json",
		            success:function(json){
		            	
		            	if(json.reault == 1){
		            		// 현재 페이지로 이동(==새로고침) 서버에 가서 다시 읽어옴.
			            	location.href="javascript:location.reload(true)";
		            	}
		            	
		            },
		            error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			      	}	
		        }); // end of $.ajax
				
			}
		//	console.log(roomImage_arr);
			$(this).parent().parent().remove(); // 사진 지우기
		}
		
		// "사진 업로드"설명 보여줄지 결정한다.
		imageItem();
		
	}); // end of $(document).on("click","span.delete",function(){
	
	// 이미지 전체 삭제 버튼
	$("button.btnDelete").click(function(){
		
		if( confirm("등록된 사진을 정말로 삭제하시겠습니까?") ) {
		// 등록된 사진을 전부 삭제한다.
			let cnt = $("div.imageItem").length;
			
			if( cnt > 0 ) {
			// 이미지가 들어와 있는 경우이다.
				// 이미지 파일 배열 초기화
				roomImage_arr = [];
				
				// == 해당 객실이름의 이미지 정보를 DB와 저장경로에서 삭제하기 == //
				const removeImgs = $(this).parent().parent().parent().find("div.image_drop");
				
				// fk_rm_seq값을 가진 행 삭제
				$.ajax({
		            url : "<%= ctxPath%>/delRoomImgFk_rm_seq.exp",
		            type : "post",
		            data : { "fk_rm_seq":$("select[name='fk_rm_seq']").val() },
		            async: false,
		            dataType:"json",
		            success:function(json){
		            	
		            	location.href="javascript:location.reload(true)";
		            	
		            },
		            error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			      	}	
		        }); // end of $.ajax
			
				// 페이지에서 보이는 이미지들 제거 
				removeImgs.find(".imageItem").remove();
				imageItem(); // "사진 업로드"설명 보여줄지 결정한다
			
			}
			
		} // end of if( confirm("등록된 사진을 정말로 삭제하시겠습니까?") ) ---------
		
	});// end of $("button.btnDelete").click(function()
			
			
			
	
	// "사진 업로드"설명 보여줄지 결정한다
	function imageItem() {

		if( $("div.imageItem").length == 0) {
		// 보여지는 이미지가 없으면 infoDiv를 보여준다.
			$("div.infoDiv").show();
		}
		else {
		// 보여지는 이미지 있으면 infoDiv를 숨겨준다.
			$("div.infoDiv").hide();
		}
	
	} // end of function imageItem() {
});// end of $(document).ready(function(){	
		
		
</script>


<div id="root_container" style="inline-size: 100%; margin: auto; max-inline-size: 75rem; padding: 50px 0;">
	<div class="container">
		<div class="title">
			<h2>객실 사진 등록</h2>
		</div>

		
		<div class="images_div">
			<span class="div_span">
				<select name="fk_rm_seq">
					<option value="">--선택--</option>
					<c:forEach var="updateRmInfo" items="${updateRmInfoMapList}" >
						<option value="${updateRmInfo.rm_seq}">${updateRmInfo.rm_type}</option>
					</c:forEach>
				</select>
			</span>
			<div class="image_drop __flex" id="roomImage">
				<div class="infoDiv __flex">
					<div class="verticalMiddle __flex">
						<div class="svgDiv">
							<svg class="__Icon" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a6a6a6" d="M149.1 64.8L138.7 96H64C28.7 96 0 124.7 0 160V416c0 35.3 28.7 64 64 64H448c35.3 0 64-28.7 64-64V160c0-35.3-28.7-64-64-64H373.3L362.9 64.8C356.4 45.2 338.1 32 317.4 32H194.6c-20.7 0-39 13.2-45.5 32.8zM256 192a96 96 0 1 1 0 192 96 96 0 1 1 0-192z"/></svg>
							사진 업로드
						</div>
						<div class="dragText">
							사진 추가 또는 이미지 끌어다 놓기
						</div>
					</div>
				</div>
			</div>
			<div class="btnContDiv__ __flex">
				<div class="flexChild">
					<span class="addText">*가장 먼저 등록한 사진이 객실의 메인사진으로 사용됩니다.</span>
					<button type="button" class="btnDelete"><svg class="svgCam" xmlns="http://www.w3.org/2000/svg" height="16" width="14" viewBox="0 0 448 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#2667b9" d="M432 256c0 17.7-14.3 32-32 32L48 288c-17.7 0-32-14.3-32-32s14.3-32 32-32l352 0c17.7 0 32 14.3 32 32z"/></svg>사진 전체 제거</button>
					<button type="button" class="btnAdd" ><svg class="svgCam" xmlns="http://www.w3.org/2000/svg" height="16" width="14" viewBox="0 0 448 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#2667b9" d="M256 80c0-17.7-14.3-32-32-32s-32 14.3-32 32V224H48c-17.7 0-32 14.3-32 32s14.3 32 32 32H192V432c0 17.7 14.3 32 32 32s32-14.3 32-32V288H400c17.7 0 32-14.3 32-32s-14.3-32-32-32H256V80z"/></svg>사진 추가</button>
					<input type="file" name="roomImage" accept=".jpg, .png" style="display:none;"/>
				</div>
			</div>
		</div>
			
		<form name="addFrm" enctype="multipart/form-data"></form>
		
		<div class="hadan">
			<button id="image_register" type="button">사진 등록</button>
		</div>
	</div>
</div>
