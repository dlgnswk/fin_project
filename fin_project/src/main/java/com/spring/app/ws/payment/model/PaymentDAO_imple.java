package com.spring.app.ws.payment.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.app.expedia.domain.LodgeVO;
import com.spring.app.expedia.domain.RoomVO;
import com.spring.app.expedia.domain.UserVO;

@Repository
public class PaymentDAO_imple implements PaymentDAO {

	@Resource
	private SqlSessionTemplate sqlsession;

	
	// 원석 개발전용 회원의 정보를 가져온다.
	@Override
	public List<UserVO> getMyUserInfo(String myUser) {
		List<UserVO> myUserInfo = sqlsession.selectList("ws_payment.ws_getMyUserInfo",myUser);
		return myUserInfo;
	}


	// 원석 개발전용  객실요금, 객실정보(인원,침대,개수,흡연유무), 객실이름 불러오기
	@Override
	public List<RoomVO> getRoomInfo(String rm_seq) {
		List<RoomVO> roomInfoList = sqlsession.selectList("ws_payment.ws_getRoomInfo",rm_seq);
		return roomInfoList;
	}


	// 원석 개발전용 취소정책 불러오기
	@Override
	public List<LodgeVO> getLodgeInfo(String h_userid) {
		List<LodgeVO> lodgeInfo = sqlsession.selectList("ws_payment.ws_getLodgeInfo",h_userid);
		return lodgeInfo;
	}


	// 원석 개발전용 취소정책 날짜 계산 정보 가져오기
	@Override
	public List<Map<String, String>> getCancelDateInfo(Map<String, String> paraMap) {
		List<Map<String, String>> cancelDateInfo = sqlsession.selectList("ws_payment.ws_getCancelDateInfo",paraMap);
		return cancelDateInfo;
	}


	// 결제 후, reservation 테이블에 insert 하기
	@Override
	public int goReservation(Map<String, String> paraMap) {
		int n = sqlsession.insert("ws_payment.ws_goReservation",paraMap);
		return n;
	}


	// 선할인을 받은 상태로 보유포인트만 update하기
	@Override
	public int updateSaleMyPoint(Map<String, String> paraMap) {
		int p = sqlsession.update("ws_payment.ws_updateSaleMyPoint",paraMap);
		return p;
	}


	// 적립을 한 상태로 보유포인트 update하기
	@Override
	public int updateMyPoint(Map<String, String> paraMap) {
		int p = sqlsession.update("ws_payment.ws_updateMyPoint",paraMap);
		return p;
	}


	// 포인트만 update하기
	@Override
	public int updateUsedPoint(Map<String, String> paraMap) {
		int p = sqlsession.update("ws_payment.ws_updateUsedPoint",paraMap);
		return p;
	}


	// 숙박업소 별 후기 가져오기
	@Override
	public List<Map<String, String>> getLodgeReview(String lodge_id) {
		List<Map<String, String>> lodgeReviewList = sqlsession.selectList("ws_payment.ws_getLodgeReview",lodge_id);
		return lodgeReviewList;
	}

}
