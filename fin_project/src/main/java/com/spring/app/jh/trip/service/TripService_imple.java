package com.spring.app.jh.trip.service;

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
import com.spring.app.jh.trip.model.TripDAO;


// ==== #31. Service 선언 ====
// 트랜잭션 처리를 담당하는 곳, 업무를 처리하는 곳, 비지니스(Business)단 
// @Component
@Service
public class TripService_imple implements TripService {

 	@Autowired
	private TripDAO dao;

 	
	// 예정된 예약 가져오기(최대 3개)
	@Override
	public List<Map<String, String>> beforeReservation(String userid) {
		List<Map<String, String>> beforeReservationList = dao.beforeReservation(userid);
		return beforeReservationList;
	}

	
	// 완료된 예약 가져오기(최대 3개)
	@Override
	public List<Map<String, String>> afterReservation(String userid) {
		List<Map<String, String>> afterReservationList = dao.afterReservation(userid);
		return afterReservationList;
	}

	
	// 예정된 예약 가져오기(전부)
	@Override
	public List<Map<String, String>> beforeReservationAll(String userid) {
		List<Map<String, String>> beforeReservationAllList = dao.beforeReservationAll(userid);
		return beforeReservationAllList;
	}


	// 완료된 예약 가져오기(전부)
	@Override
	public List<Map<String, String>> afterReservationAll(String userid) {
		List<Map<String, String>> afterReservationAllList = dao.afterReservationAll(userid);
		return afterReservationAllList;
	}


	// 현재시간이 체크인시간 72시간 이전을 지났는지 확인하는 메소드
	@Override
	public int checkinTimeConfrim(String rs_no) {
		int n = dao.checkinTimeConfrim(rs_no);
		return n;
	}


	// 현재시간이 체크인시간 72시간 이전을 지나지 않은경우 취소상태로 업데이트 해주는 메소드
	@Override
	public int cancelReservation(String rs_no) {
		int n = dao.cancelReservation(rs_no);
		return n;
	}


	// 로그인 한 회원의 위시리스트를 가져오기
	@Override
	public List<Map<String, String>> getWishList(String userid) {
		List<Map<String, String>> wishList = dao.getWishList(userid);
		return wishList;
	}


	// 숙소번호를 받아와서 테이블에서 delete 해주기
	@Override
	public int deleteWishlist(Map<String, String> paraMap) {
		int n = dao.deleteWishlist(paraMap);
		return n;
	}


	// 이용후기 작성하기
	@Override
	public int reviewInsert(Map<String, String> paraMap) {
		int n = dao.reviewInsert(paraMap);
		return n;
	}

	

	
}
