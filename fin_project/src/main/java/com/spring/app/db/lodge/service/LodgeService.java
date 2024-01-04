package com.spring.app.db.lodge.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface LodgeService {

	// == 숙박시설 유형 테이블에서 select == //
	List<Map<String, String>> getLodgeType();

	// == 환불 정책 옵션 select == //
	List<Map<String, String>> getCancelOption();

	// == 셀프 체크인 방법 select == //
	List<Map<String, String>> getSelfCheckinOption();

	// == 인터넷 옵션 체크박스 == //
	List<Map<String, String>> getInternetOption();
	
	// == 주차장 옵션 체크박스  == //
	List<Map<String, String>> getParkOption();
	
	// == 수영장 종류 체크박스 == //
	List<Map<String, String>> getPoolType();
	
	// == 다이닝 장소 종류 체크박스 == //
	List<Map<String, String>> getDiningPlace();
	
	// == 장애인 편의 시설 정보 체크박스 == //
	List<Map<String, String>> getFacilityInfo();

	// == 스파 서비스 종류 셀렉트 == //
	List<Map<String, String>> getSpaType();

	// == 고객서비스 종류 체크박스 == //
	List<Map<String, String>> getConsumerService();

	// == 룸 서비스 종류 체크박스  == //
	List<Map<String, String>> getRoomService();

	// == 비즈니스 공간 종류 체크박스 == //
	List<Map<String, String>> getBusinessType();

	// == 가족서비스 종류 체크박스 == //
	List<Map<String, String>> getFamilyServiceType();

	// *** === 숙박시설테이블 데이터 등록 === *** //
	int lodgeRegister(Map<String, String> paraMap, HttpServletRequest request) throws Throwable;

	// DB에 입력되어 있는 숙박시설 ID 가져오기 //
	String getLodgeId(String lodge_id);

	// === 시설 이미지 등록하기 === //
	void insertLodgeImages(Map<String, String> paraMap);

	// === 기존에 등록된 이미지 삭제하기 === //
	void delLodgeImg(String fk_lodge_id);

	// == 욕실 옵션 종류 == //
	List<Map<String, String>> getBathOpt();

	// == 주방(조리시설) 종류 == //
	List<Map<String, String>> getKitchenOpt();

	// == 객실 내 다과 옵션 종류 == //
	List<Map<String, String>> getSnackOpt();

	// == 객실 내 엔터테이먼트 옵션 종류 == //
	List<Map<String, String>> getEntertainmentOpt();
	
	// == 온도조절기 옵션 종류 == //
	List<Map<String, String>> getTemperatureControllerOpt();

	// == 전망 옵션 종류 == //
	List<Map<String, String>> getViewOpt();
	
	// *** === 객실정보 데이터 등록 === *** //
	int register_rm(HashMap<String, String> paraMap, HttpServletRequest request) throws Throwable;

	// 현재 로그인한 판매자의 ID로 숙박시설의 lodge_id를 가져온다.
	String getLodgeIdByUserId(String fk_h_userid);

	// == ** 이미 입력된 room 정보가 있다면 수정과 추가를 하기위해서 체크 해야 된다 ** == //
	List<Map<String, String>> getRmInfo(String fk_lodge_id);

	// 기존에 입력되어 있는 rm_type List 가져오기
	List<String> getRm_typeData(String fk_lodge_id);
	
	// == 삭제 해야할 이미지 파일 이름 가져오기 == //
	List<String> getDeleteImgFileName(String fk_rm_seq);

	// == tbl_rm_img 테이블 정보 제거 == //
	void delRoomImg(String fk_rm_seq);

	// === 객실 이미지 등록하기 === //
	void insertRoomImages(Map<String, String> paraMap);

	// 기존에 등록된 객실의 이미지 정보를 가져온다. 
	List<Map<String, String>> getRmImgData(String fk_rm_seq);
}
