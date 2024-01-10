package com.spring.app.ws.payment.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.spring.app.expedia.domain.LodgeVO;
import com.spring.app.expedia.domain.ReservationVO;
import com.spring.app.expedia.domain.RoomVO;
import com.spring.app.expedia.domain.UserVO;
import com.spring.app.ws.payment.model.PaymentDAO;
import org.springframework.stereotype.Service;

@Service
public class PaymentService_imple implements PaymentService {

	@Autowired
	private PaymentDAO dao;

	
	// 원석 개발전용 회원의 정보를 가져온다.
	@Override
	public List<UserVO> getMyUserInfo(String myUser) {
		List<UserVO> myUserInfo = dao.getMyUserInfo(myUser);

		return myUserInfo;
	}


	// 원석 개발전용  객실요금, 객실정보(인원,침대,개수,흡연유무), 객실이름 불러오기
	@Override
	public List<RoomVO> getRoomInfo(String rm_seq) {
		List<RoomVO> roomInfoList = dao.getRoomInfo(rm_seq);
		return roomInfoList;
	}


	// 원석 개발전용 취소정책 불러오기
	@Override
	public List<LodgeVO> getLodgeInfo(String h_userid) {
		List<LodgeVO> lodgeInfo = dao.getLodgeInfo(h_userid);
		return lodgeInfo;
	}


	// 원석 개발전용 취소정책 날짜 계산 정보 가져오기
	@Override
	public List<Map<String, String>> getCancelDateInfo(Map<String, String> paraMap) {
		List<Map<String, String>> cancelDateInfo = dao.getCancelDateInfo(paraMap);
		return cancelDateInfo;
	}


	// 결제 후, reservation 테이블에 insert 하기
	@Override
	public int goReservation(Map<String, String> paraMap) {
		int n = dao.goReservation(paraMap);
		return n;
	}


	// 선할인을 받은 상태로 보유포인트만 update하기
	@Override
	public int updateSaleMyPoint(Map<String, String> paraMap) {
		int p = dao.updateSaleMyPoint(paraMap);
		return p;
	}


	// 적립을 한 상태로 보유포인트 update하기
	@Override
	public int updateMyPoint(Map<String, String> paraMap) {
		int p = dao.updateMyPoint(paraMap);
		return p;
	}


	// 포인트만 update하기
	@Override
	public int updateUsedPoint(Map<String, String> paraMap) {
		int p = dao.updateUsedPoint(paraMap);
		return p;
	}


	// 숙박업소 별 후기 가져오기
	@Override
	public List<Map<String, String>> getLodgeReview(String lodge_id) {
		List<Map<String, String>> lodgeReviewList = dao.getLodgeReview(lodge_id);
		return lodgeReviewList;
	}


	// reservation 테이블에서 방금 예약한 rs_seq 불러오기
	@Override
	public List<ReservationVO> getRsSeqNo() {
		List<ReservationVO> getRsSeqNo = dao.getRsSeqNo();
		return getRsSeqNo;
	}


	// rs_seq를 가져와서 tbl_point에 insert 하기
	@Override
	public int updateTblPoint(String rs_seq) {
		int s = dao.updateTblPoint(rs_seq);
		return s;
	}

	
}
