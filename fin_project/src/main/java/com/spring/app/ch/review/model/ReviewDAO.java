package com.spring.app.ch.review.model;

import java.util.List;
import java.util.Map;

import com.spring.app.expedia.domain.ReviewVO;



public interface ReviewDAO {

	
	// 로그인 한 회원의 이용후기 목록 가져오기
	List<Map<String, Object>> myrvList(String userid);
		
	// 글 번호를 이용한 글 가져오기
	ReviewVO selectReviewBySeq(Map<String, String> paraMap);
	
	// 이용후기 수정하기
	int reviewEdit(Map<String, String> paraMap);
	
	// 이용후기 삭제하기
	int reviewDelete(Map<String, String> paraMap);
	
	
	
	
}
