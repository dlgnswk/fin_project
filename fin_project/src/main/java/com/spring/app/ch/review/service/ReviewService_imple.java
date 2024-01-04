package com.spring.app.ch.review.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.ch.review.model.ReviewDAO;


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
	
	
	
	
}	
