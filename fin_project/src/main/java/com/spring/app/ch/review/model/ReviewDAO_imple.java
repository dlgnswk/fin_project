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
	
	@Override
	public List<Map<String, Object>> reviewList(Map<String, String> paraMap) {
		
		List<Map<String, Object>> reviewList = sqlsession.selectList("ch_review.reviewList", paraMap);
	      
		
		return reviewList;
	}
	
	// 이용후기 작성
	@Override
	public int add(ReviewVO reviewvo) {
		
		int n = sqlsession.insert("ch_review.add", reviewvo);
		
		return n;
	}
	
	// 회원이 작성한 이용후기 목록 가져오기
	@Override
	public List<Map<String, Object>> myrvList(String userid) {
		
		List<Map<String, Object>> myrvList = sqlsession.selectList("ch_review.myrvList", userid);
		
		return myrvList;
	}
	
	// 검색하기 위한 글 리스트로 뽑기
	@Override
	public List<Map<String, String>> getReviewList(Map<String, Object> paraMap) {
		
		List<Map<String, String>> getReviewList = sqlsession.selectList("ch_review.getreviewList", paraMap);
		
		return getReviewList;
	}
	
	// 그래프 정보 가져오기
	@Override
	public List<Map<String, String>> getprogressinfoList(Map<String, String> paraMap) {
		
		List<Map<String, String>> getprogressinfoList = sqlsession.selectList("ch_review.getprogressinfoList", paraMap);
		
		return getprogressinfoList;
	}
	
	// 평점 평균, 이용후기 총 개수 가져오기
	@Override
	public List<Map<String, String>> getratingavgcntList(Map<String, String> paraMap) {
		
		List<Map<String, String>> getratingavgcntList = sqlsession.selectList("ch_review.getratingavgcntList", paraMap);
		
		return getratingavgcntList;
	}

	@Override
	public int getLike(Map<String, String> paraMap) {
		
		int n = sqlsession.insert("ch_review.getLike", paraMap);
		return n;
	}

	@Override
	public int deleteLike(Map<String, String> paraMap) {
		
		int n = sqlsession.insert("ch_review.deleteLike", paraMap);
		return n;
	}

	@Override
	public Map<String, Integer> getCnt(String rv_seq) {
		 
		Map<String, Integer> getCnt = sqlsession.selectOne("ch_review.getCnt", rv_seq);
		return getCnt;
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
