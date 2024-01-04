package com.spring.app.jh.search.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.spring.app.jh.search.model.SearchDAO;


// ==== #31. Service 선언 ====
// 트랜잭션 처리를 담당하는 곳, 업무를 처리하는 곳, 비지니스(Business)단 
// @Component
@Service
public class SearchService_imple implements SearchService {

	// === 의존객체 주입하기(DI: Dependency Injection) ===
 	@Autowired  // Type에 따라 알아서 Bean 을 주입해준다.
	private SearchDAO dao;
	// Type 에 따라 Spring 컨테이너가 알아서 bean 으로 등록된 com.spring.board.model.BoardDAO_imple 의 bean 을  dao 에 주입시켜준다. 
    // 그러므로 dao 는 null 이 아니다.
	
	
	// 숙박시설 리스트 가져오기
	@Override
	public List<Map<String, String>> getLodgeList(Map<String, Object> paraMap) {
		List<Map<String, String>> lodgeList = dao.getLodgeList(paraMap);
		return lodgeList;
	}


	// map에 저장한 하나의 숙소에 지정일에 예약가능한 객실이 있는 경우 jsonObj_2에 저장하기
	@Override
	public List<Map<String, String>> getAvailableLodgeList(Map<String, Object> map) {
		List<Map<String, String>> availableLodgeList = dao.getAvailableLodgeList(map);
		return availableLodgeList;
	}

	
	// 캐러셀에 넣어줄 이미지 가져오기
	@Override
	public List<Map<String, String>> lodgeImgList() {
		List<Map<String, String>> lodgeImgList = dao.lodgeImgList();
		return lodgeImgList;
	}


	// 예약가능한 숙박시설 정보
	@Override
	public List<Map<String, String>> getLodgeInfoList(Map<String, Object> lodge_map) {
		List<Map<String, String>> lodgeInfoList = dao.getLodgeInfoList(lodge_map);
		return lodgeInfoList;
	}


	// 예약가능한 숙소의 이미지 리스트 가져오기
	@Override
	public List<Map<String, String>> getlodgeImgList(String lodge_id) {
		List<Map<String, String>> lodgeImgList = dao.getlodgeImgList(lodge_id);
		return lodgeImgList;
	}

	
	// 검색된 내용을 통해 호텔 최저, 최고가 검색
	@Override
	public Map<String, String> getLodgePrice(Map<String, String> paraMap) {
		Map<String, String> lodgePrice = dao.getLodgePrice(paraMap);
		return lodgePrice;
	}

	
	// 검색된 내용 insert 해주기
	@Override
	public void insertSearchLog(Map<String, String> searchMap) {
		dao.insertSearchLog(searchMap);
		
	}


	// 위시리스트에 넣은 lodge_id 리스트 가져오기
	@Override
	public List<Map<String, String>> lodgeIdList(String userid) {
		List<Map<String, String>> lodgeIdList = dao.lodgeIdList(userid);
		return lodgeIdList;
	}


	// 위시리스트에 추가하기
	@Override
	public int addWishlist(Map<String, String> paraMap) {
		int n = dao.addWishlist(paraMap);
		return n;
	}


	// 위시리스트에 삭제하기
	@Override
	public int deleteWishlist(Map<String, String> paraMap) {
		int n = dao.deleteWishlist(paraMap);
		return n;
	}
 	
 	
 	
	
	

	
}
