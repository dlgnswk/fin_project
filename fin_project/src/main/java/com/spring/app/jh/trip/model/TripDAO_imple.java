package com.spring.app.jh.trip.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

//==== #32. Repository(DAO) 선언 ====
//@Component
@Repository
public class TripDAO_imple implements TripDAO {
	
	@Resource
	private SqlSessionTemplate sqlsession;
	
	
	// 예정된 예약 가져오기(최대 3개)
	@Override
	public List<Map<String, String>> beforeReservation(String userid) {
		List<Map<String, String>> beforeReservationList = sqlsession.selectList("jh_trip.beforeReservation", userid);
		return beforeReservationList;
	}

	
	// 완료된 예약 가져오기(최대 3개)
	@Override
	public List<Map<String, String>> afterReservation(String userid) {
		List<Map<String, String>> afterReservationList = sqlsession.selectList("jh_trip.afterReservation", userid);
		return afterReservationList;
	}


	// 예정된 예약 가져오기(전부)
	@Override
	public List<Map<String, String>> beforeReservationAll(String userid) {
		List<Map<String, String>> beforeReservationAllList = sqlsession.selectList("jh_trip.beforeReservationAll", userid);
		return beforeReservationAllList;
	}


	// 완료된 예약 가져오기(전부)
	@Override
	public List<Map<String, String>> afterReservationAll(String userid) {
		List<Map<String, String>> afterReservationAllList = sqlsession.selectList("jh_trip.afterReservationAll", userid);
		return afterReservationAllList;
	}


	// 현재시간이 체크인시간 72시간 이전을 지났는지 확인하는 메소드
	@Override
	public int checkinTimeConfrim(String rs_no) {
		String str_n = sqlsession.selectOne("jh_trip.checkinTimeConfrim", rs_no);
		int n = Integer.parseInt(str_n);
		return n;
	}


	// 현재시간이 체크인시간 72시간 이전을 지나지 않은경우 취소상태로 업데이트 해주는 메소드
	@Override
	public int cancelReservation(String rs_no) {
		int n = sqlsession.update("jh_trip.cancelReservation", rs_no);
		return n;
	}


	// 로그인 한 회원의 위시리스트를 가져오기
	@Override
	public List<Map<String, String>> getWishList(String userid) {
		List<Map<String, String>> wishList = sqlsession.selectList("jh_trip.getWishList", userid);
		return wishList;
	}


	// 숙소번호를 받아와서 테이블에서 delete 해주기
	@Override
	public int deleteWishlist(Map<String, String> paraMap) {
		int n = sqlsession.delete("jh_trip.deleteWishlist", paraMap);
		return n;
	}


	// 이용후기 작성하기
	@Override
	public int reviewInsert(Map<String, String> paraMap) {
		int n = sqlsession.insert("jh_trip.reviewInsert", paraMap);
		return n;
	}
	
	

	
}
