/**
 * 
 */
package com.spring.app.mj.comment.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.common.MyUtil;
import com.spring.app.expedia.domain.CommentVO;
import com.spring.app.expedia.domain.LodgeVO;
import com.spring.app.mj.comment.service.CommentService;

/**
 *   @FileName  : ReviewController.java 
 * 
 * @Project   : final_project 
 * @Date      : 2023. 12. 19 
 * @작성자      : 손명진 
 * @변경이력 : 
 * @프로그램설명 : 판매자 답글달기
 */

@Controller
public class CommentController {

	@Autowired // Type에 따라 알아서 Bean 을 주입해준다.
	private CommentService service;

	@GetMapping("reviewlist.exp")
	public ModelAndView reviewlist(ModelAndView mav, HttpServletRequest request) {


		String searchWord = request.getParameter("searchWord");
		String userId = request.getParameter("userid");
		
		
		// lodge_id를 가져는 메소드
		// List<LodgeVO> get__lodge_Id = service.get__lodge_Id(userId);
		
		
		
		if(userId == null) {
			
			
			
			mav.setViewName("redirect:reviewlist.exp?userid="+ userId);
			
		
			return mav;
		}
		
		
		
		 if(searchWord == null) {
				searchWord = "";
			 }
				
		 if(searchWord != null) {
			searchWord = searchWord.trim();
			// "     입니다      " ==>  "입니다"
			// "             " ==>  ""
		 }
		
		String reviewContent = request.getParameter("reviewContent");
		// System.out.println(reviewContent);
	
		

		
//		아이디와 사업자아이디 비교하기
		List<String> lodgeIdList = service.getLodgeIdList(userId);
		
		//System.out.println(lodgeIdList);
		
		HttpSession session = request.getSession();
		session.setAttribute("lodgeIdList", lodgeIdList);
		session.setAttribute("userId", userId);
		
		
		Map<String, Object> paraMap = new HashMap<>();
		paraMap.put("searchWord", searchWord); 
		paraMap.put("lodgeIdList", lodgeIdList);
		
		
		
		
		
		
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");

			

		 
		 
	//	 boardList = service.boardListSearch(paraMap); // 글목록 가져오기(페이징 처리 안했으며, 검색어가 없는 것 또는 검색어가 있는것 모두 포함한 것)  
		 
		 // 먼저, 총 게시물 건수(totalCount)를 구해와야 한다.
		 // 총 게시물 건수(totalCount)는 검색조건이 있을 때와 없을때로 나뉘어진다. 
		 int totalCount = 0;    // 총 게시물 건수 
		 int sizePerPage = 5;  // 한 페이지당 보여줄 게시물 건수 
		 int currentShowPageNo = 0; // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함. 
		 int totalPage = 0;         // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
		 
		 // 총 게시물 건수(totalCount)
		 totalCount = service.getTotalCount(paraMap);
	//	 System.out.println("~~~~ 확인용 totalCount : " + totalCount); 
		 // ~~~~ 확인용 totalCount : 214
		 // ~~~~ 확인용 totalCount : 4
		 // ~~~~ 확인용 totalCount : 2
		 // ~~~~ 확인용 totalCount : 6
		 // ~~~~ 확인용 totalCount : 3
		 
		 // 만약에 총 게시물 건수(totalCount)가 124 개 이라면 총 페이지수(totalPage)는 13 페이지가 되어야 한다.
		 // 만약에 총 게시물 건수(totalCount)가 120 개 이라면 총 페이지수(totalPage)는 12 페이지가 되어야 한다.
		 totalPage = (int) Math.ceil((double)totalCount/sizePerPage); 
		 // (double)124/10 ==> 12.4 ==> Math.ceil(12.4) ==> 13.0 ==> 13
		 // (double)120/10 ==> 12.0 ==> Math.ceil(12.0) ==> 12.0 ==> 12
		 
		 if(str_currentShowPageNo == null) {
			 // 게시판에 보여지는 초기화면
			 
			 currentShowPageNo = 1;
		 }
		 
		 else {
			  
			 try {
				 currentShowPageNo = Integer.parseInt(str_currentShowPageNo); 
				 
				 if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
					// get 방식이므로 사용자가 str_currentShowPageNo 에 입력한 값이 0 또는 음수를 입력하여 장난친 경우 
					// get 방식이므로 사용자가 str_currentShowPageNo 에 입력한 값이 실제 데이터베이스에 존재하는 페이지수 보다 더 큰값을 입력하여 장난친 경우   
					 currentShowPageNo = 1;
				 }
				 
			 } catch(NumberFormatException e) {
				 // get 방식이므로 사용자가 str_currentShowPageNo 에 입력한 값이 숫자가 아닌 문자를 입력하여 장난친 경우
				 currentShowPageNo = 1;
			 }
		 }
		 
		 
		// **** 가져올 게시글의 범위를 구한다.(공식임!!!) **** 
		/*
		     currentShowPageNo      startRno     endRno
		    --------------------------------------------
		         1 page        ===>    1           10
		         2 page        ===>    11          20
		         3 page        ===>    21          30
		         4 page        ===>    31          40
		         ......                ...         ...
		 */
		 int startRno = ((currentShowPageNo - 1) * sizePerPage) + 1; // 시작 행번호 
		 int endRno = startRno + sizePerPage - 1; // 끝 행번호 
			
		 paraMap.put("startRno", String.valueOf(startRno));
		 paraMap.put("endRno", String.valueOf(endRno));
		 
		 List<Map<String, Object>> commentList = service.getSearchList(paraMap);
		 // 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것) 

		 
		 
		 
		 if (commentList != null) {
		     for (Map<String, Object> comment : commentList) {
		            String lodge_id = (String) comment.get("FK_LODGE_ID");
		            paraMap.put("lodge_id", lodge_id);
		        //System.out.println("lodge_id");
		    }
		 }
			/*
			 * else { // 검색되어진 결과물이 존재하지 않을 경우 paraMap.put("lodge_id", "ICDU5968"); }
			 */
		
			
		// 평점 별 후기 갯수 가져오기

				 
		 if(commentList != null) {	
			 Map<String, String> rv_cnt_byRate = service.getRvcntByRate2(paraMap);
			 
			 //System.out.println(rv_cnt_byRate);
			 //System.out.println(rv_cnt_byRate.get("six"));
	    
	      // 평점 총 후기 갯수구하기
	         int gettotalByRate = service.gettotalByRate(paraMap);

	    // 차트를 위한 판매자 총 갯수구하기  
	         int gettotalComment = service.gettotalComment(paraMap);
		 
		 	      
	      //System.out.println(rv_cnt_byRate);
	      //System.out.println(gettotalByRate);
	      //System.out.println(gettotalComment);
	
			 mav.addObject("gettotalComment",gettotalComment);
			
			 mav.addObject("rv_cnt_byRate",rv_cnt_byRate);
			 
			 mav.addObject("gettotalByRate",gettotalByRate);
		 }	
			
	  
		 mav.addObject("commentList", commentList);
	
		// === #121. 페이지바 만들기 === //
		int blockSize = 10;
		// blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 개수이다.
		/*
			              1  2  3  4  5  6  7  8  9 10 [다음][마지막]  -- 1개블럭
			[맨처음][이전]  11 12 13 14 15 16 17 18 19 20 [다음][마지막]  -- 1개블럭
			[맨처음][이전]  21 22 23
		*/
		
		int loop = 1;
		/*
	   	loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
	   */
		
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
		// *** !! 공식이다. !! *** //
		
	/*
	   1  2  3  4  5  6  7  8  9  10  -- 첫번째 블럭의 페이지번호 시작값(pageNo)은 1 이다.
	   11 12 13 14 15 16 17 18 19 20  -- 두번째 블럭의 페이지번호 시작값(pageNo)은 11 이다.
	   21 22 23 24 25 26 27 28 29 30  -- 세번째 블럭의 페이지번호 시작값(pageNo)은 21 이다.
	   
	   currentShowPageNo         pageNo
	  ----------------------------------
	        1                      1 = ((1 - 1)/10) * 10 + 1
	        2                      1 = ((2 - 1)/10) * 10 + 1
	        3                      1 = ((3 - 1)/10) * 10 + 1
	        4                      1
	        5                      1
	        6                      1
	        7                      1 
	        8                      1
	        9                      1
	        10                     1 = ((10 - 1)/10) * 10 + 1
	       
	        11                    11 = ((11 - 1)/10) * 10 + 1
	        12                    11 = ((12 - 1)/10) * 10 + 1
	        13                    11 = ((13 - 1)/10) * 10 + 1
	        14                    11
	        15                    11
	        16                    11
	        17                    11
	        18                    11 
	        19                    11 
	        20                    11 = ((20 - 1)/10) * 10 + 1
	        
	        21                    21 = ((21 - 1)/10) * 10 + 1
	        22                    21 = ((22 - 1)/10) * 10 + 1
	        23                    21 = ((23 - 1)/10) * 10 + 1
	        ..                    ..
	        29                    21
	        30                    21 = ((30 - 1)/10) * 10 + 1
	*/
		
		String pageBar = "<ul style='list-style:none;'>";
		String url = "reviewlist.exp";
		
		// === [맨처음][이전] 만들기 === // 
		
		if(searchWord != null) {
		
		if(pageNo != 1) {
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?userid="+userId+"&searchWord="+searchWord+"&currentShowPageNo=1'>[맨처음]</a></li>";
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?userid="+userId+"&searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
		}
		
		while( !(loop > blockSize || pageNo > totalPage) ) {
			
			if(pageNo == currentShowPageNo) {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:blue; padding:2px 4px;'>"+pageNo+"</li>";
			}
			else {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?userid="+userId+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>"; 
			}
			
			loop++;
			pageNo++;
		}// end of while-------------------------
		
		
		// === [다음][마지막] 만들기 === //
		if(pageNo <= totalPage) {
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?userid="+userId+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?userid="+userId+"&searchWord="+searchWord+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
		}
		
		pageBar += "</ul>";
		}	
		else {
			
			
			
			if(pageNo != 1) {
				pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?userid="+userId+"&currentShowPageNo=1'>[맨처음]</a></li>";
				pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?userid="+userId+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
			}
			
			while( !(loop > blockSize || pageNo > totalPage) ) {
				
				if(pageNo == currentShowPageNo) {
					pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";
				}
				else {
					pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?userid="+userId+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>"; 
				}
				
				loop++;
				pageNo++;
			}// end of while-------------------------
			
			
			// === [다음][마지막] 만들기 === //
			if(pageNo <= totalPage) {
				pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?userid="+userId+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
				pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?userid="+userId+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
			}
			
			pageBar += "</ul>";
			
		}
		
		
		
		mav.addObject("pageBar", pageBar);
		
		
		// === #123. 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
		//           사용자가 "검색된결과목록보기" 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해
		//           현재 페이지 주소를 뷰단으로 넘겨준다.
		String goBackURL = MyUtil.getCurrentURL(request);
	//	System.out.println("~~~ 확인용(list.action) goBackURL : " + goBackURL);
		/*
		    ~~~ 확인용 goBackURL : /list.action
		    ~~~ 확인용 goBackURL : /list.action?searchType=&searchWord=&currentShowPageNo=5
		    ~~~ 확인용 goBackURL : /list.action?searchType=subject&searchWord=java
		    ~~~ 확인용 goBackURL : /list.action?searchType=name&searchWord=서영학 
		    ~~~ 확인용 goBackURL : /list.action?searchType=name&searchWord=서영학&currentShowPageNo=9
		*/
		
		mav.addObject("goBackURL", goBackURL);
	
			
			mav.addObject("commentList", commentList);
			mav.addObject("userid", userId);
			mav.addObject("searchWord", searchWord);
			
			
			
	//		// 가져올 값이 있는 경우
	//		for (Map<String, Object> comment : commentList) {
	//		   
	//		    //paraMap.put("h_lodgename", comment.get("h_lodgename"));
	//			System.out.println(comment.get("H_LODGENAME"));
	//		}
	//		
			
			
			
			
			mav.setViewName("mj/sellerReview/reviewList.tiles2");
	
			return mav;
	}

	
// 답글 완료
	@PostMapping("reviewEnd.exp")
	public ModelAndView reviewEnd(ModelAndView mav, HttpServletRequest request) {


		
		// 글목록
		List<Map<String, Object>> commentList = service.getSelect();
		
		
		mav.addObject("commentList", commentList);
	
		
		String c_groupno = request.getParameter("c_groupno");
		String c_content = request.getParameter("c_content");
		String c_regDate = request.getParameter("c_regDate");
		String c_org_seq = request.getParameter("c_org_seq");
		String c_depthno = request.getParameter("c_depthno");
		String fk_rs_seq = request.getParameter("fk_rs_seq");
		String fk_h_userid = request.getParameter("fk_h_userid");
		String c_seq = request.getParameter("c_seq");
		String fk_lodge_id = request.getParameter("fk_lodge_id");
		
		c_content = c_content.replaceAll("<", "&lt;");
		c_content = c_content.replaceAll(">", "&gt;");
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("c_groupno", c_groupno);
		paraMap.put("c_content", c_content);
		paraMap.put("c_regDate", c_regDate);
		paraMap.put("c_org_seq", c_org_seq);
		paraMap.put("c_depthno", c_depthno);
		paraMap.put("c_seq", c_seq);
		paraMap.put("fk_rs_seq", fk_rs_seq);
		paraMap.put("fk_h_userid", fk_h_userid);
		paraMap.put("fk_lodge_id", fk_lodge_id);
		
		
//		System.out.println(fk_lodge_id);
//		System.out.println(c_content);
//		System.out.println(c_groupno);
//		System.out.println(c_regDate);
//		System.out.println(c_org_seq);
//		System.out.println(c_depthno);
//		System.out.println(c_seq);
//		System.out.println(fk_rs_seq);
//		System.out.println(fk_userid);
		
//		CommentVO commentvo1 = new CommentVO();
//		commentvo1.setC_content(request.getParameter("c_content").replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
		
		
		
		
	
		
		
	//	Map<String, Object> paraMap = new HashMap<>();
		
		
		//System.out.println(commentList);
		
//		// 가져올 값이 있는 경우
//		for (Map<String, Object> comment : commentList) {
		   
//		    paraMap.put("h_lodgename", comment.get("h_lodgename"));
			// System.out.println(comment.get("h_lodgename"));
//		}

		
		//System.out.println("h_lodgename");
		
		
	
		
		// insert하기
	    int n = service.add_Comment(paraMap);
		
		
		
		
		
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userId");
		
		
		
	    mav.setViewName("redirect:/reviewlist.exp?userid="+ userId);

	return mav;
}

	
	
	// 댓글 수정
	@PostMapping("updateEnd.exp")
	public ModelAndView reviewUpdate(HttpServletRequest request,ModelAndView mav){
		
		
		// 글목록
		List<Map<String, Object>> commentList = service.getSelect();
		
		
		mav.addObject("commentList", commentList);

		
		String c_content = request.getParameter("c_content");
		String c_regDate = request.getParameter("c_regDate");
		String c_seq = request.getParameter("c_seq");
		
		System.out.println(c_seq);
		
		
		
		c_content = c_content.replaceAll("<", "&lt;");
		c_content = c_content.replaceAll(">", "&gt;");
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("c_content", c_content);
		paraMap.put("c_regDate", c_regDate);
		paraMap.put("c_seq", c_seq);
		
		
		int n = service.edit(paraMap);
		
		
		
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userId");
		
		
		
		
		mav.setViewName("redirect:/reviewlist.exp?userid="+ userId);
		
		
		
		
		return mav;
	}
	
	// 댓글 삭제
	@PostMapping("deleteEnd.exp")
	public ModelAndView deleteReview(HttpServletRequest request,ModelAndView mav){
		
		
		// 글목록
		List<Map<String, Object>> commentList = service.getSelect();
		
		
		mav.addObject("commentList", commentList);
		
		
	
		String c_seq = request.getParameter("c_seq");
		
		int n = service.goDelete(c_seq);
		
		//System.out.println(c_seq);
		// System.out.println(n);
		
		
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userId");
		
		
		
		mav.setViewName("redirect:/reviewlist.exp?userid="+ userId);
		
		
		return mav;
	}
	
	
	
//	
//	// 검색
//	   @ResponseBody
//	    @GetMapping(value="/mallDisplayJSON.exp")
//	    public String searchComment(HttpServletRequest request){
//	    	
//	    	
//		    String searchWord = request.getParameter("searchWord");
////	    	int start = Integer.parseInt(request.getParameter("start"));
////	    	int len = Integer.parseInt(request.getParameter("len"));
//		    
//		    
//		    String start = request.getParameter("start");
//		    String len = request.getParameter("len");
//		    
//		    
//	    	HttpSession session = request.getSession();
//			List<String> lodgeIdList = (ArrayList<String>) session.getAttribute("lodgeIdList");
//	    	
//	    	 
//	    //	System.out.println(start);
//	    //	System.out.println(len);
////	    	System.out.println(searchWord);
////	    	System.out.println(lodgeIdList);
//	    
//
//			if(searchWord == null) {
//				searchWord = "";
//			}
//	
//			if(searchWord != null) {
//				searchWord = searchWord.trim();
//			}
//			
//			Map<String,Object> paraMap = new HashMap<>();
//			paraMap.put("start",start);
//			paraMap.put("end",start+len);
//			paraMap.put("searchWord",searchWord);
//			paraMap.put("lodgeIdList",lodgeIdList);
//
//	    	
//	    	List<Map<String, Object>> commentList = service.getSearchList(paraMap);
//	    	
//			JSONArray jsonArr = new JSONArray(); // [] 
//			
//			if(commentList != null) {
//				for(Map<String, Object> word : commentList) {
//					JSONObject jsonObj = new JSONObject(); // {} 
//					jsonObj.put("word", word);
//					//System.out.println(word);
//					// System.out.println(word.get("LG_NAME"));
//					jsonArr.put(jsonObj); // [{},{},{}]
//				}// end of for------------
//			}
//			
//	    	
//	    	
//	   
//	    	
//	    	
//	    	return jsonArr.toString();
//	    }
}
