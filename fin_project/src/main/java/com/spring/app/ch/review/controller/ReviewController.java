package com.spring.app.ch.review.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.spring.app.ch.review.service.ReviewService;

@Controller
public class ReviewController {
	
	@Autowired  // Type에 따라 알아서 Bean 을 주입해준다.
	private ReviewService service;
	
	// === 이용후기 게시판 글쓰기 페이지 요청 === //
	// 먼저, com.spring.app.HomeController 클래스에 가서 @Controller 을 주석처리한다.
	@GetMapping("/rvindex.exp") 
	public ModelAndView reviewindex(ModelAndView mav) {
		
		
		mav.setViewName("ch/review/rvindex.tiles1");
		
		return mav;
	}
	
	// === 이용후기 게시판 글보여주는 페이지 요청 === //
	// 먼저, com.spring.app.HomeController 클래스에 가서 @Controller 을 주석처리한다.
	@GetMapping("/rvshow.exp") 
	public ModelAndView reviewshow(ModelAndView mav, HttpServletRequest request) {
		
		int totalCount = service.totalCount();
		
		String searchWord = request.getParameter("searchWord");
	      
	      
	      mav.addObject("totalCount", totalCount);
	      
	      
	      Map<String, String> paraMap = new HashMap<>();
	      paraMap.put("searchWord", searchWord); 
	      
	      List<Map<String, Object>> reviewList = service.reviewList(paraMap);
	      
	      
	 //    int reviewListSize = reviewList.size();
	      
	      mav.addObject("reviewList", reviewList);
		
		mav.setViewName("ch/review/reviewmodal.tiles1");
		
		return mav;
	}
	
	// 모달 입력 창 띄우기
	@ResponseBody
    @GetMapping(value = "/reviewWriteModal.exp", produces="text/plain;charset=UTF-8")
    public String reviewWriteModal(@RequestParam String rs_seq) {
	 // System.out.println("rs_seq => " + rs_seq);
		
		
		
		
		JsonObject jsonObj = new JsonObject();
		jsonObj.addProperty("rs_seq", rs_seq);
		
		Gson gson = new Gson();
		
		return gson.toJson(jsonObj);
	}
	

	
	
	
	
	
	
}
