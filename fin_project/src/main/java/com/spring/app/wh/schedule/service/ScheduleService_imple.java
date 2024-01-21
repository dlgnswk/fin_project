package com.spring.app.wh.schedule.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.expedia.domain.HostVO;
import com.spring.app.expedia.domain.ReservationVO;
import com.spring.app.expedia.domain.RoomVO;
import com.spring.app.expedia.domain.UserVO;
import com.spring.app.wh.schedule.domain.*;
import com.spring.app.wh.schedule.model.*;

@Service
public class ScheduleService_imple implements ScheduleService {

	@Autowired
	private ScheduleDAO dao;

	
	// 예약  정보를 담은 캘린더 불러오기
	@Override
	public List<ReservationVO> selectReservation(Map<String,String> paraMap) {
		List<ReservationVO> reservationList = dao.selectReservation(paraMap);
		return reservationList;
	}
	
	
	// 숙소 예약 캘린더에서 객실등급 보여주기
	@Override
	public List<RoomVO> showRoomType(String fk_h_userid) {
		List<RoomVO> roomTypeList = dao.showRoomType(fk_h_userid); 
		return roomTypeList;
	}

	// 풀캘린더에서 날짜 클릭할 때 발생하는 이벤트(예약 일정 추가)
	@Override
	public int addReservation_end(Map<String, String> paraMap) throws Throwable {
		int n = dao.addReservation_end(paraMap);
		return n;
	}
	
	// 일정 등록시 내캘린더,사내캘린더 선택에 따른 서브캘린더 종류를 알아오기 
	@Override
	public List<RoomVO> selectRoomType_price(String fk_h_userid) {
		List<RoomVO> roomList = dao.selectRoomType_price(fk_h_userid);
		return roomList;
	}


	// 예약 일정 추가 시 예약자 아이디의 존재여부 확인하기
	@Override
	public UserVO isExist_userid(String fk_userid) {
		UserVO uservo = dao.isExist_userid(fk_userid);
		return uservo;
	}
	
	

	
	// 예약 일정 상세보기
	@Override
	public Map<String,String> detailReservationSchedule(String rs_seq) {
		Map<String,String> map = dao.detailReservationSchedule(rs_seq);
		return map;
	}

	
	// 예약 일정 삭제하기
	@Override
	public int deleteReservationSchedule(String rs_seq) throws Throwable {
		int n = dao.deleteReservationSchedule(rs_seq);
		return n;
	}


	// 총 일정 검색 건수(totalCount)
	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int n = dao.getTotalCount(paraMap);
		return n;
	}


	// 페이징 처리한 캘린더 가져오기(검색어가 없다라도 날짜범위 검색은 항시 포함된 것임)
	@Override
	public List<Map<String,String>> scheduleListSearchWithPaging(Map<String, String> paraMap) {
		List<Map<String,String>> scheduleList = dao.scheduleListSearchWithPaging(paraMap);
		return scheduleList;
	}
	
	
	

	
	
}
