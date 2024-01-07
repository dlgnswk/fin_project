package com.spring.app.jy.lodge.model;

import java.util.List;
import java.util.Map;

public interface LodgeDAO {

	Map<String, String> getLodgeInfo(String lodge_id); // 숙박시설 기본 정보 가져오기

	List<Map<String, String>> getInet_opt_list(String lodge_id); // 숙박시설 옵션 - 인터넷 가져오기

	List<Map<String, String>> getPark_opt_list(String lodge_id); // 숙박시설 옵션 - 주차 및 교통 가져오기

	List<Map<String, String>> getDin_opt_list(String lodge_id); // 숙박시설 옵션 - 다이닝장소 가져오기

	List<Map<String, String>> getPool_opt_list(String lodge_id); // 숙박시설 옵션 - 수영장 정보 가져오기

	List<Map<String, String>> getFac_opt_list(String lodge_id); // 숙박시설 옵션 - 장애인편의시설 가져오기

	List<Map<String, String>> getCs_opt_list(String lodge_id); // 숙박시설 옵션 - 고객서비스 가져오기

	List<Map<String, String>> getRmsvc_opt_list(String lodge_id); // 숙박시설 옵션 - 객실 용품 및 서비스 가져오기

	List<Map<String, String>> getBsns_opt_list(String lodge_id); // 숙박시설 옵션 - 비즈니스 가져오기

	List<Map<String, String>> getFasvc_opt_list(String lodge_id); // 숙박시설 옵션 - 가족여행 편의 시설 가져오기

	List<Map<String, String>> getLg_img_list(Map<String, String> i_paraMap); // 숙박시설 사진 가져오기

	List<Map<String, String>> getBath_opt_list(String rm_seq); // 객실 옵션 - 욕실 

	List<Map<String, String>> getSnk_opt_list(String rm_seq); // 객실 옵션 - 객실 내 다과

	List<Map<String, String>> getKt_opt_list(String rm_seq); // 객실 옵션 - 조리시설

	List<Map<String, String>> getEnt_opt_list(String rm_seqt); // 객실 옵션 - 엔터테인먼트

	List<Map<String, String>> getTmp_opt_list(String rm_seq); // 객실 옵션 - 온도조절

	List<Map<String, String>> getRm_img_list(Map<String, String> paraMap); // 객실 사진 가져오기
	
	List<Map<String, String>> getCom_bath_opt_list(String lodge_id); // 숙박 시설의 전체 객실이 가진 옵션 가져오기  - 욕실

	List<Map<String, String>> getCom_snk_opt_list(String lodge_id); // 숙박 시설의 전체 객실이 가진 옵션 가져오기  - 객실 내 다과

	List<Map<String, String>> getCom_kt_opt_list(String lodge_id); // 숙박 시설의 전체 객실이 가진 옵션 가져오기  - 조리시설

	List<Map<String, String>> getCom_ent_opt_list(String lodge_id); // 숙박 시설의 전체 객실이 가진 옵션 가져오기  - 엔터테인먼트

	List<Map<String, String>> getCom_tmp_opt_list(String lodge_id); // 숙박 시설의 전체 객실이 가진 옵션 가져오기  - 온도조절

	List<Map<String, String>> getAvbl_rm_list(Map<String, String> paraMap); // 날짜 검색 후, 남은 객실에 대한 정보 가져오기	

	List<Map<String, String>> getLg_img_ca_list(String lodge_id); // 숙박 시설 카테고리 및 카테고리별 사진 갯수 가져오기
	
	List<Map<String, String>> getAll_rm_img_list(String lodge_id); // 객실 사진 가져오기 (전부)
	
	String getLg_ca_name(String img_cano); // 카테고리 이름

	boolean isExist_wish(Map<String, String> paraMap); // 위시리스트 추가 됐는지 안됐는지 확인 
	
	int delete_wishList(Map<String, String> paraMap); // 위시리스트에서 삭제

	int add_wishList(Map<String, String> paraMap); // 위시리스트에 추가
	
	// List<Map<String, String>> getLg_ca_img_list(String lodge_id, String img_cano); // 숙박시설 사진 카테고리별로 가져오기
}
