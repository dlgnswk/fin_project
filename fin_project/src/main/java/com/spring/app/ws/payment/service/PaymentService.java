package com.spring.app.ws.payment.service;

import java.util.List;
import java.util.Map;

import com.spring.app.expedia.domain.LodgeVO;
import com.spring.app.expedia.domain.ReservationVO;
import com.spring.app.expedia.domain.RoomVO;
import com.spring.app.expedia.domain.UserVO;

public interface PaymentService {

	// 원석 개발전용 회원의 정보를 가져온다.
	List<UserVO> getMyUserInfo(String myUser);

	// 원석 개발전용  객실요금, 객실정보(인원,침대,개수,흡연유무), 객실이름 불러오기
	List<RoomVO> getRoomInfo(String rm_seq);

	// 원석 개발전용 취소정책 불러오기
	List<LodgeVO> getLodgeInfo(String h_userid);

	// 원석 개발전용 취소정책 날짜 계산 정보 가져오기
	List<Map<String, String>> getCancelDateInfo(Map<String, String> paraMap);

	// 결제 후, reservation 테이블에 insert 하기
	int goReservation(Map<String, String> paraMap);

	// 선할인을 받은 상태로 보유포인트만 update하기
	int updateSaleMyPoint(Map<String, String> paraMap);

	// 적립을 한 상태로 보유포인트 update하기
	int updateMyPoint(Map<String, String> paraMap);

	// 포인트만 update하기
	int updateUsedPoint(Map<String, String> paraMap);

	// 숙박업소 별 후기 가져오기
	List<Map<String, String>> getLodgeReview(String lodge_id);

	// reservation 테이블에서 방금 예약한 rs_seq 불러오기
	List<ReservationVO> getRsSeqNo();

	// rs_seq를 가져와서 tbl_point에 insert 하기
	// int updateTblPoint(Map<String, String> paraMap);
	
	// rs_seq를 가져와서 tbl_point에 insert 하기  (-사용한 point)
	int updateTblPointA1(Map<String, String> paraMap);

	// rs_seq를 가져와서 tbl_point에 insert 하기  (0넣기)
	int updateTblPointA2();

	// rs_seq를 가져와서 tbl_point에 insert 하기  (+point - 사용한 point)
	int updateTblPointB1(Map<String, String> paraMap);

	// rs_seq를 가져와서 tbl_point에 insert 하기  (+point만넣기)
	int updateTblPointB2(Map<String, String> paraMap);

}
