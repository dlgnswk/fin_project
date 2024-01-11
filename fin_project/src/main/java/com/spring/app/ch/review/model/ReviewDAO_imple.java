package com.spring.app.ch.review.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.app.expedia.domain.ReviewVO;

@Repository
public class ReviewDAO_imple implements ReviewDAO {
	
	@Resource
	private SqlSessionTemplate sqlsession;
	

	
	// 회원이 작성한 이용후기 목록 가져오기
	@Override
	public List<Map<String, Object>> myrvList(String userid) {
		
		List<Map<String, Object>> myrvList = sqlsession.selectList("ch_review.myrvList", userid);
		
		return myrvList;
	}
	
	
	// 글 번호를 이용한 글 가져오기
	@Override
	public ReviewVO selectReviewBySeq(Map<String, String> paraMap) {
		
		ReviewVO reviewvo = sqlsession.selectOne("ch_review.selectReviewBySeq", paraMap);
		
		return reviewvo;
	}

	@Override
	public int reviewEdit(Map<String, String> paraMap) {
		
		int n = sqlsession.update("ch_review.edit", paraMap);
		return n;
	}

	@Override
	public int reviewDelete(Map<String, String> paraMap) {
		int n = sqlsession.update("ch_review.delete", paraMap);
		return n;
	}
	

}
