package com.spring.app.ch.review.model;

import java.util.List;
import java.util.Map;

import com.spring.app.expedia.domain.ReviewVO;



public interface ReviewDAO {


	List<Map<String, Object>> reviewList(Map<String, String> paraMap);
	
	// 이용후기 작성
	int add(ReviewVO reviewvo);
	
	// 로그인 한 회원의 이용후기 목록 가져오기
	List<Map<String, Object>> myrvList(String userid);
	
	// 검색하기 위한 글 리스트로 뽑기
	List<Map<String, String>> getReviewList(Map<String, Object> paraMap);
	
	// 그래프 정보 가져오기
	List<Map<String, String>> getprogressinfoList(Map<String, String> paraMap);
	
	// 평점 평균, 이용후기 총 개수 가져오기
	List<Map<String, String>> getratingavgcntList(Map<String, String> paraMap);

	int getLike(Map<String, String> paraMap);

	int deleteLike(Map<String, String> paraMap);

	Map<String, Integer> getCnt(String rv_seq);
	
	// 글 번호를 이용한 글 가져오기
	ReviewVO selectReviewBySeq(Map<String, String> paraMap);
	
	// 이용후기 수정하기
	int reviewEdit(Map<String, String> paraMap);
	
	// 이용후기 삭제하기
	int reviewDelete(Map<String, String> paraMap);
	
	
	
	
}
