package com.spring.app.ch.review.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.spring.app.ch.review.service.ReviewService;
import com.spring.app.expedia.domain.ReviewVO;
import com.spring.app.expedia.domain.UserVO;

@Controller
public class ReviewController {
	
	@Autowired  // Type에 따라 알아서 Bean 을 주입해준다.
	private ReviewService service;
	
	
	// === 로그인 한 회원이 쓴 이용후기 목록 페이지 요청 === //
	// 먼저, com.spring.app.HomeController 클래스에 가서 @Controller 을 주석처리한다.
	@GetMapping("/myrvlist.exp") 
	public ModelAndView requiredLogin_myrvlist(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		//  String userid = request.getParameter("userid");
		//  필요없다
		// List<Map<String, Object>> myrvList = service.myrvList(userid);
		
		String rs_seq = request.getParameter("rs_seq");
		
		
		////////////////////////////////////////////////////////////////////
		HttpSession session = request.getSession();
		UserVO loginuser = (UserVO) session.getAttribute("loginuser");
		
		List<Map<String, Object>> myrvList = null; 
		
		
		if(loginuser != null) {
		  myrvList = service.myrvList(loginuser.getUserid());
		}
		
		/////////////////////////////////////////////////////////////////////
		
		// System.out.println("myrvList" + myrvList);
		
		
		mav.addObject("myrvList", myrvList);
		
		mav.setViewName("ch/review/myrvlist.tiles1");
		
		return mav;
	}

	
	
	// === 이용후기 게시판 글쓰기 페이지 요청 === //
	// 먼저, com.spring.app.HomeController 클래스에 가서 @Controller 을 주석처리한다.
	@GetMapping("/rvindex.exp") 
	public ModelAndView reviewindex(ModelAndView mav) {
		
		
		mav.setViewName("ch/review/rvindex.tiles1");
		
		return mav;
	}
	
	
	
	// === 숙소 상세페이지에서 이용후기 게시판 글보여주는 페이지 요청 === //
	// 먼저, com.spring.app.HomeController 클래스에 가서 @Controller 을 주석처리한다.
	@GetMapping("/rvshow.exp") 
	public ModelAndView reviewshow(ModelAndView mav, HttpServletRequest request) {
		
		
	
		mav.setViewName("ch/review/reviewmodal.tiles1");
		
		return mav;
	}
	
	// 숙소 상세페이지 눌렀을 때 이용후기 입력 모달 창 띄우기
		@ResponseBody
	    @GetMapping(value = "/reviewshowModal.exp", produces="text/plain;charset=UTF-8")
	    public String reviewshowModal(HttpServletRequest request, ModelAndView mav) {
		    
			int totalCount = service.totalCount();
			
			String searchWord = request.getParameter("searchWord");
		      
		    mav.addObject("totalCount", totalCount);
		    
			
			String lodge_id = request.getParameter("lodge_id");
			System.out.println("lodge_id => " + lodge_id);
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("lodge_id", lodge_id);
			paraMap.put("searchWord", searchWord); 
			
			// 그래프 정보 가져오기 
			List<Map<String, String>> getprogressinfoList = service.getprogressinfoList(paraMap);			
			System.out.println("getprogressinfoList " + getprogressinfoList);
			
			// 평점 평균, 이용후기 총 개수 가져오기
			List<Map<String, String>> getratingavgcntList = service.getratingavgcntList(paraMap);
			System.out.println("getratingavgcntList " + getratingavgcntList);
						
			
			
			JsonObject jsonObj = new JsonObject();
			jsonObj.addProperty("lodge_id", lodge_id);
			
			Gson gson = new Gson();
			
			return gson.toJson(jsonObj);
		}
	
	
	
	@ResponseBody
	@GetMapping(value="/reviewSearchAjax.exp", produces="text/plain;charset=UTF-8")
	public String reviewSearchAjax(HttpServletRequest request) {
		
		String userid = request.getParameter("userid");
		
		
		// 관련성, 최근 이용후기, 평점 높은 순, 낮은 순
		Map<String, Object> paraMap = new HashMap<>();
		
		// 정렬기준
		paraMap.put("sort", request.getParameter("sort"));
		// relative, recent_review, highrating, lowrating
		
		List<Map<String, String>> getreviewList = service.getReviewList(paraMap);
		System.out.println(getreviewList);
		
		JSONArray jsonArr = new JSONArray(); // []
		
		if (getreviewList != null) {
			for(Map<String, String> reviewMap : getreviewList) {
				JSONObject jsonObj = new JSONObject(); // {}
				jsonObj.put("sort", reviewMap.get("sort"));
				
				jsonArr.put(jsonObj);
				
			}// end of for 
			
		}
		
		return jsonArr.toString();
	};	
	
	
	// 이용후기 입력 모달 창 띄우기
	@ResponseBody
    @GetMapping(value = "/reviewWriteModal.exp", produces="text/plain;charset=UTF-8")
    public String reviewWriteModal(HttpServletRequest request) {
	    
				
		
		String rs_seq = request.getParameter("rs_seq");
		
		
		System.out.println("rs_seq => " + rs_seq);
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("rs_seq", rs_seq);
		
		JsonObject jsonObj = new JsonObject();
		jsonObj.addProperty("rs_seq", rs_seq);
		
		Gson gson = new Gson();
		
		return gson.toJson(jsonObj);
	}
	
	// 이용후기 글쓰기 완료 
	@PostMapping("/rvaddEnd.exp") 
	public ModelAndView rvaddEnd(Map<String, String> paraMap, ModelAndView mav, ReviewVO reviewvo) {
		
		int n = 0;
		
		n = service.add(reviewvo);
		
		if(n==1) {
			mav.setViewName("redirect:/trip.exp");
		}
		
		else {
			mav.setViewName("ch/review/error/add_error.tiles1");
		}
		
		return mav;
	}
	
	// 이용후기 입력 모달 창 띄우기
	@ResponseBody
    @GetMapping(value = "/reviewEditModal.exp", produces="text/plain;charset=UTF-8")
    public String reviewEditModal(HttpServletRequest request) {
	    
		// 이용 후기 수정해야할 글번호 가져오기					
		String rv_seq = request.getParameter("rv_seq");
		// System.out.println("rv_seq => " + rv_seq);
		
		String message = "";
		
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("rv_seq", rv_seq);
		
		
		ReviewVO reviewvo = service.selectReviewBySeq(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		// JSON 객체에 필요한 데이터 추가
	    jsonObj.put("rv_seq", reviewvo.getRv_seq());
	    jsonObj.put("rv_subject", reviewvo.getRv_subject());
	    jsonObj.put("rv_content", reviewvo.getRv_content());
	    jsonObj.put("fk_rv_rating", reviewvo.getFk_rv_rating());
		
		
		return jsonObj.toString();
	}
	
	// 이용후기 수정하기
	@PostMapping("/rveditEnd.exp")
	public String reviewEdit(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		UserVO loginuser = (UserVO) session.getAttribute("loginuser");
		
		String fk_rv_rating = request.getParameter("fk_rv_rating");
		String rv_seq = request.getParameter("rv_seq");
		String rv_subject = request.getParameter("rv_subject");
		String rv_content = request.getParameter("rv_content");
		
		
		int n = 0;
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("rv_subject", rv_subject);
		paraMap.put("rv_content", rv_content);
		paraMap.put("rv_rating", fk_rv_rating);
		paraMap.put("rv_seq", rv_seq);
		
		String message = "";
		if(loginuser != null) {
			n = service.reviewEdit(paraMap);
			
			if(n == 1) {
				
				message = "리뷰가 수정되었습니다!";
				String loc = request.getContextPath()+"/myrvlist.exp";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
			}
			
			else {
				message = "리뷰 수정에 실패했습니다!";
				String loc = request.getContextPath()+"/myrvlist.exp";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
			}
		}
		
		else {
			message = "리뷰 수정에 실패했습니다!";
		}
				
		return "msg";
	}
	
	// 이용후기 삭제 하기
	@ResponseBody
    @GetMapping(value = "/reviewDeleteModal.exp", produces="text/plain;charset=UTF-8")
	public String reviewDeleteModal(HttpServletRequest request) {
		
		String rv_seq = request.getParameter("rv_seq");
		System.out.println("rv_seq => " + rv_seq);
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("rv_seq", rv_seq);
		
		
		JsonObject jsonObj = new JsonObject();
		jsonObj.addProperty("rv_seq", rv_seq);
		
		Gson gson = new Gson();
		
		return gson.toJson(jsonObj);
	}
	
	// 이용후기 수정하기
	@PostMapping("/rvdeleteEnd.exp")
	public String reviewDelete(HttpServletRequest request) {
		
		String rv_seq = request.getParameter("rv_seq");
		System.out.println("rv_seq => " + rv_seq);
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("rv_seq", rv_seq);
		
		return "";
	}
	
}
