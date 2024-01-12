package com.spring.app.ch.review.service;

import java.util.List;
import java.util.Map;

import com.spring.app.expedia.domain.ReviewVO;



public interface ReviewService {

	
	// 로그인한 회원의 이용후기를 가져오기
	List<Map<String, Object>> myrvList(String userid);
	
	// 글 번호를 이용한 글 가져오기
	ReviewVO selectReviewBySeq(Map<String, String> paraMap);
	
	// 글 수정하기
	int reviewEdit(Map<String, String> paraMap);
	
	// 글 삭제하기
	int reviewDelete(Map<String, String> paraMap);
	


}
