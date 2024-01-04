package com.spring.app.jh.index.service;

import java.util.*;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

public interface IndexService {
	
	// 검색어에 따라 대도시가 있는지 찾아보기(있으면 1, 없으면 0)
	int search_lg_area_1(String searchWord);
	
	// 검색어에 따라 상세도시가 있는지 찾아보기(있으면 1, 없으면 0)
	int search_lg_area_2(String searchWord);

	// 검색어에 따라 호텔이 있는지 찾아보기(있으면 4, 없으면 2)
	int search_lg_name(String searchWord);

	// 큰 도시 검색하기
	List<Map<String, String>> search_lg_area_List(String searchWord);

	// 상세 도시 검색하기
	List<Map<String, String>> search_lg_area_2_List(String searchWord);

	// 시설 검색하기
	List<Map<String, String>> search_lg_name_List(String searchWord);

	// 검색어를 list 로 받아오기
	List<Map<String, String>> getSearchLogList();
	
	
	
}
