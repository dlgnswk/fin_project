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
import org.springframework.transaction.annotation.Transactional;
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
	
	// 이용후기 삭제하는 모달 창 띄우기
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
	
	// 이용삭제 수정하기
	@Transactional
	@PostMapping("/rvdeleteEnd.exp")
	public String reviewDelete(HttpServletRequest request) {
		
		String rv_seq = request.getParameter("rv_seq");
		System.out.println("rv_seq => " + rv_seq);
		
		HttpSession session = request.getSession();
		UserVO loginuser = (UserVO) session.getAttribute("loginuser");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("rv_seq", rv_seq);
		
		String message = "";
		
		if(loginuser != null) {
			
			int n = service.reviewDelete(paraMap);
				
			if(n == 1) {
				
				message = "리뷰가 삭제되었습니다!";
				String loc = request.getContextPath()+"/myrvlist.exp";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				return "msg";
			}
			
			else {
				message = "리뷰 삭제에 실패했습니다!";
				String loc = request.getContextPath()+"/myrvlist.exp";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
			
				return "msg";
			}
		
		}
		JSONObject jsonObj = new JSONObject();
				
		
		return jsonObj.toString();
	}
	
}
