package com.spring.app.ch.review.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ReviewDAO_imple implements ReviewDAO {
	
	@Resource
	private SqlSessionTemplate sqlsession;
	
	@Override
	public List<Map<String, Object>> reviewList(Map<String, String> paraMap) {
		
		List<Map<String, Object>> reviewList = sqlsession.selectList("ch_review.reviewList", paraMap);
	      
		
		return reviewList;
	}
	

}
