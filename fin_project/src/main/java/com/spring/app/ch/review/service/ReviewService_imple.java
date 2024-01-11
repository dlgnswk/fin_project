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

	@Override
	public List<Map<String, Object>> reviewList(Map<String, String> paraMap) {
		
		List<Map<String, Object>> reviewList = dao.reviewList(paraMap);
	    return reviewList;
	}

	@Override
	public int totalCount() {
		// TODO Auto-generated method stub
		return 0;
	}
	
	// 로그인한 회원의 이용후기 리스트 가져오기
	@Override
	public List<Map<String, Object>> myrvList(String userid) {
		
		List<Map<String, Object>> myrvList = dao.myrvList(userid);
		
		return myrvList;
	}

	@Override
	public int add(ReviewVO reviewvo) {
		
		int n = dao.add(reviewvo);
		
		return n;
	}

	@Override
	public List<Map<String, String>> getReviewList(Map<String, Object> paraMap) {
		
		List<Map<String, String>> getReviewList = dao.getReviewList(paraMap);
		
		return getReviewList;
	}
	
	// 그래프 정보 가져오기
	@Override
	public List<Map<String, String>> getprogressinfoList(Map<String, String> paraMap) {
		
		List<Map<String, String>> getprogressinfoList = dao.getprogressinfoList(paraMap);
		
		return getprogressinfoList;
	}
	
	// 평점 평균, 이용후기 총 개수 가져오기
	@Override
	public List<Map<String, String>> getratingavgcntList(Map<String, String> paraMap) {
		
		List<Map<String, String>> getratingavgcntList = dao.getratingavgcntList(paraMap);
		
		return getratingavgcntList;
	}

	@Override
	public int likeAdd(Map<String, String> paraMap) {
		
		int n = dao.getLike(paraMap);
		return n;
	}

	@Override
	public int likeDelete(Map<String, String> paraMap) {
		
		int n = dao.deleteLike(paraMap);
		
		return n;
		
	}

	@Override
	public Map<String, Integer> getCnt(String rv_seq) {
		Map<String, Integer> map = dao.getCnt(rv_seq);
		return map;
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

	@Override
	public int reviewDelete(Map<String, String> paraMap) {
		
		int n = dao.reviewDelete(paraMap);
		
		return n;
	}
	

	
	
	
	
}	
