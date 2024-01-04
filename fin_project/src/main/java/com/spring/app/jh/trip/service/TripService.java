package com.spring.app.jh.trip.service;

import java.util.*;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

public interface TripService {
	
	// 예정된 예약 가져오기(최대 3개)
	List<Map<String, String>> beforeReservation(String userid);

	// 완료된 예약 가져오기(최대 3개)
	List<Map<String, String>> afterReservation(String userid);

	// 예정된 예약 가져오기(전부)
	List<Map<String, String>> afterReservationAll(String userid);

	// 완료된 예약 가져오기(전부)
	List<Map<String, String>> beforeReservationAll(String userid);

	// 현재시간이 체크인시간 72시간 이전을 지났는지 확인하는 메소드
	int checkinTimeConfrim(String rs_no);

	// 현재시간이 체크인시간 72시간 이전을 지나지 않은경우 취소상태로 업데이트 해주는 메소드
	int cancelReservation(String rs_no);

	// 로그인 한 회원의 위시리스트를 가져오기
	List<Map<String, String>> getWishList(String userid);

	// 숙소번호를 받아와서 테이블에서 delete 해주기
	int deleteWishlist(Map<String, String> paraMap);
	
}
