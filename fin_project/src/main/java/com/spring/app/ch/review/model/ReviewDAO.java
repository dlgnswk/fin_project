package com.spring.app.ch.review.model;

import java.util.List;
import java.util.Map;



public interface ReviewDAO {


	List<Map<String, Object>> reviewList(Map<String, String> paraMap);

}
