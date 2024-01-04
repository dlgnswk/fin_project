package com.spring.app.jh.search.model;

import java.util.List;
import java.util.Map;

public interface SearchDAO {

	// 숙박시설 리스트 가져오기
	List<Map<String, String>> getLodgeList(Map<String, Object> paraMap);

	// map에 저장한 하나의 숙소에 지정일에 예약가능한 객실이 있는 경우 jsonObj_2에 저장하기
	List<Map<String, String>> getAvailableLodgeList(Map<String, Object> map);

	// 캐러셀에 넣어줄 이미지 가져오기
	List<Map<String, String>> lodgeImgList();

	// 예약가능한 숙박시설 정보
	List<Map<String, String>> getLodgeInfoList(Map<String, Object> lodge_map);

	// 예약가능한 숙소의 이미지 리스트 가져오기
	List<Map<String, String>> getlodgeImgList(String lodge_id);

	// 검색된 내용을 통해 호텔 최저, 최고가 검색
	Map<String, String> getLodgePrice(Map<String, String> paraMap);

	// 검색된 내용 insert 해주기
	void insertSearchLog(Map<String, String> searchMap);

	// 위시리스트에 넣은 lodge_id 리스트 가져오기
	List<Map<String, String>> lodgeIdList(String userid);

	// 위시리스트에 추가하기
	int addWishlist(Map<String, String> paraMap);

	// 위시리스트에 삭제하기
	int deleteWishlist(Map<String, String> paraMap);
	
	
	
}
