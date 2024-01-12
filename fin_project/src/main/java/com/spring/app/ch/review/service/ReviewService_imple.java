package com.spring.app.ch.review.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.ch.review.model.ReviewDAO;
import com.spring.app.expedia.domain.ReviewVO;


@Service
public class ReviewService_imple implements ReviewService {
	
	@Autowired  // Type에 따라 알아서 Bean 을 주입해준다.
	private ReviewDAO dao;



	
	// 로그인한 회원의 이용후기 리스트 가져오기
	@Override
	public List<Map<String, Object>> myrvList(String userid) {
		
		List<Map<String, Object>> myrvList = dao.myrvList(userid);
		
		return myrvList;
	}
	

	
	// 글 번호를 이용한 글 가져오기
	@Override
	public ReviewVO selectReviewBySeq(Map<String, String> paraMap) {
		
		ReviewVO reviewvo = dao.selectReviewBySeq(paraMap);
		
		return reviewvo;
	}
	
	// 이용 후기 수정하기
	@Override
	public int reviewEdit(Map<String, String> paraMap) {
		
		int n = dao.reviewEdit(paraMap);
		
		return n;
	}
	
	// 이용 후기 삭제하기
	@Override
	public int reviewDelete(Map<String, String> paraMap) {
		
		int n = dao.reviewDelete(paraMap);
		
		return n;
	}
	

	
	
	
	
}	
