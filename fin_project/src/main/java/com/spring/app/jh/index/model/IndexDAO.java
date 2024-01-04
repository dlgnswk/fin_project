package com.spring.app.jh.index.model;

import java.util.List;
import java.util.Map;

public interface IndexDAO {
	
	// 큰 도시 검색 결과 갯수
	int search_lg_area_1(String searchWord);
	
	// 상세 도시 검색 결과 갯수
	int search_lg_area_2(String searchWord);

	// 시설 검색 결과 갯수
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
