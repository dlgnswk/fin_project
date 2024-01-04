/**
 * 
 */
package com.spring.app.mj.comment.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.expedia.domain.CommentVO;
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

		int totalCount = service.totalAllCount("1");

		String searchWord = request.getParameter("searchWord");
		
		
		String reviewContent = request.getParameter("reviewContent");
		// System.out.println(reviewContent);
	

		
		
		
		mav.addObject("totalCount", totalCount);
		
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchWord", searchWord); 
		
		List<Map<String, Object>> commentList = service.getSearchList(paraMap);
		
	
		
		int commentListSize = commentList.size();
		//System.out.println("commentList의 크기: " + commentListSize);
		
		// System.out.println(commentList);
		
		//mav.addObject("searchList", searchList);
		
		

//		 if(searchWord == null) {
//				searchWord = "";
//			 }
//				
//			 if(searchWord != null) {
//				searchWord = searchWord.trim();
//				// "     입니다      " ==>  "입니다"
//				// "             " ==>  ""
//			 }
//			 
//			 Map<String, String> paraMap = new HashMap<>();
//			 paraMap.put("searchWord", searchWord);
//		
//		
//		List<ReviewVO> ReviewList = null;

//		ReviewList = service.ReviewList();

		
		mav.addObject("commentList", commentList);
		
		
		
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
		
		
		
		
		
		
		
		mav.setViewName("mj/sellerReview/reviewList.tiles2");

	return mav;
}

	
	
	// 댓글 수정
	@ResponseBody
	@GetMapping(value="/reviewUpdate.exp")
	public String reviewUpdate(HttpServletRequest request){
		
		
		
	
		
		
		
		
		
		JSONObject jsonObj = new JSONObject();
		
		
		
		
		
		
		
		return jsonObj.toString();
	}

	   @ResponseBody
	    @GetMapping(value="/searchComment.exp")
	    public String searchComment(HttpServletRequest request){
	    	
	    	
	    	
	    	String searchWord = request.getParameter("searchWord");
	    	System.out.println(searchWord);
	    	
	    
	    	
	    	
	    	
	    	
	    	JSONObject jsonObj = new JSONObject();
	    	
	    	
	    	
	    	
	   
	    	
	    	
	    	return jsonObj.toString();
	    }
}
