package com.spring.app.ws.admin.model;

import java.util.List;
import java.util.Map;

import com.spring.app.expedia.domain.HostVO;
import com.spring.app.expedia.domain.UserVO;

public interface AdminDAO {

	String getName();

	// 총 회원수를 알아오는 메소드
	int getTotalCnt(Map<String, String> paraMap);

	// 페이징한 회원목록 가져오기
	List<UserVO> userListSearch(Map<String, String> paraMap);

	// 회원관리 검색어 입력시 자동완성하기
	List<String> searchUserShow(Map<String, String> paraMap);

	// 총 판매자수를 알아오는 메소드
	int getHostCnt(Map<String, String> paraMap);

	// 페이징한 판매자목록 가져오기
	List<HostVO> hostListSearch(Map<String, String> paraMap);

	// 판매자관리 검색어 입력시 자동완성하기
	List<String> searchHostShow(Map<String, String> paraMap);

	// tbl_irs 테이블에서 사업자번호의 유효성을 확인하는 메소드
	int searchBusinessNo(Map<String, String> paraMap);

	// tbl_host 테이블에서 status를 1로 update해주는 메소드
	int businessApprove(String hostId);

	// tbl_host 테이블에서 status를 2로 update해주는 메소드
	int businessReject(String hostId);

	// 총 숙소 수를 알아오는 메소드
	int getLodgeCnt(Map<String, String> paraMap);

	// 페이징한 숙소목록 가져오기
	List<List<Map<String, String>>> lodgeListSearch(Map<String, String> paraMap);

	// 숙소 검색어 입력시 자동완성하기
	List<String> searchLodgeShow(Map<String, String> paraMap);

	// tbl_lodge 테이블에서 lg_status를 1로 update해주는 메소드
	int lodgeRegistrationApprove(String lodge_id);

	// tbl_lodge 테이블에서 lg_status를 0로 update해주는 메소드
	int lodgeRegistrationReject(String lodge_id);

	// 차트그리기(AJAX) 년도별 성별 등록 회원수
	List<Map<String, String>> yearGenderUser();

	// 차트그리기(AJAX) 행정구역별 숙박시설 점유율
	List<Map<String, String>> regionOccupancy();

	// 특정 행정구역에 존재하는 숙박시설들 중 객실수의 퍼센티지
	List<Map<String, String>> lodgeQtyPercentage(String lg_area);

	// 차트그리기(AJAX) 분기별 숙박시설 전체 예약건수
	List<Map<String, String>> quatorTotalReservation();

}
