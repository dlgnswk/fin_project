package com.spring.app.ch.review.service;

import java.util.List;
import java.util.Map;

import com.spring.app.expedia.domain.ReviewVO;



public interface ReviewService {

	List<Map<String, Object>> reviewList(Map<String, String> paraMap);

	int totalCount();
	
	// 로그인한 회원의 위시리스트를 가져오기
	List<Map<String, Object>> myrvList(String userid);
	
	// 글쓰기 
	int add(ReviewVO reviewvo);
	
	// 검색하기 위한 글 리스트로 뽑기
	List<Map<String, String>> getReviewList(Map<String, Object> paraMap);
	
	// 그래프 정보 가져오기 
	List<Map<String, String>> getprogressinfoList(Map<String, String> paraMap);
	
	// 평점 평균, 이용후기 총 개수 가져오기
	List<Map<String, String>> getratingavgcntList(Map<String, String> paraMap);
	
	// 
	int likeAdd(Map<String, String> paraMap);

	int likeDelete(Map<String, String> paraMap);

	Map<String, Integer> getCnt(String rv_seq);
	
	// 글 번호를 이용한 글 가져오기
	ReviewVO selectReviewBySeq(Map<String, String> paraMap);
	
	// 글 수정하기
	int reviewEdit(Map<String, String> paraMap);
	


}
