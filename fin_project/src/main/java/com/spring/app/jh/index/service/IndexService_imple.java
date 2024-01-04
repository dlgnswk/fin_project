package com.spring.app.jh.index.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.jh.index.model.IndexDAO;


// ==== #31. Service 선언 ====
// 트랜잭션 처리를 담당하는 곳, 업무를 처리하는 곳, 비지니스(Business)단 
// @Component
@Service
public class IndexService_imple implements IndexService {

	// === 의존객체 주입하기(DI: Dependency Injection) ===
 	@Autowired  // Type에 따라 알아서 Bean 을 주입해준다.
	private IndexDAO dao;
	// Type 에 따라 Spring 컨테이너가 알아서 bean 으로 등록된 com.spring.board.model.BoardDAO_imple 의 bean 을  dao 에 주입시켜준다. 
    // 그러므로 dao 는 null 이 아니다.

 	
	// 큰 도시 검색 결과 갯수
	@Override
	public int search_lg_area_1(String searchWord) {
		int n = dao.search_lg_area_1(searchWord);
		return n;
	}
 	
	
	// 상세 도시 검색 결과 갯수
	@Override
	public int search_lg_area_2(String searchWord) {
		int n = dao.search_lg_area_2(searchWord);
		return n;
	}

	
	// 시설 검색 결과 갯수
	@Override
	public int search_lg_name(String searchWord) {
		int n = dao.search_lg_name(searchWord);
		return n;
	}

	
	// 큰 도시 검색하기
	@Override
	public List<Map<String, String>> search_lg_area_List(String searchWord) {
		List<Map<String, String>> lg_area_List = dao.search_lg_area_List(searchWord);
		return lg_area_List;
	}

	
	// 상세 도시 검색하기
	@Override
	public List<Map<String, String>> search_lg_area_2_List(String searchWord) {
		List<Map<String, String>> lg_area_2_List = dao.search_lg_area_2_List(searchWord);
		return lg_area_2_List;
	}

	
	// 시설 검색하기
	@Override
	public List<Map<String, String>> search_lg_name_List(String searchWord) {
		List<Map<String, String>> lg_name_List = dao.search_lg_name_List(searchWord);
		return lg_name_List;
	}


	// 검색어를 list 로 받아오기
	@Override
	public List<Map<String, String>> getSearchLogList() {
		List<Map<String, String>> searchLogList = dao.getSearchLogList();
		return searchLogList;
	}
 	
 	
 	
	
	

	
}
