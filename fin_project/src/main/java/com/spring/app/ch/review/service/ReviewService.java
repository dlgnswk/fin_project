package com.spring.app.ch.review.service;

import java.util.List;
import java.util.Map;



public interface ReviewService {

	List<Map<String, Object>> reviewList(Map<String, String> paraMap);

	int totalCount();

}
