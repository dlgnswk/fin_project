package com.spring.app.wh.schedule.service;

import java.util.List;
import java.util.Map;

import com.spring.app.expedia.domain.HostVO;
import com.spring.app.expedia.domain.ReservationVO;
import com.spring.app.expedia.domain.RoomVO;
import com.spring.app.expedia.domain.UserVO;
import com.spring.app.wh.schedule.domain.*;

public interface ScheduleService {

	
	/*
	// 사내 캘린더에 일정 추가하기
	int addComCalendar(Map<String, String> paraMap) throws Throwable;

	// 내 캘린더에 일정 추가하기
	int addMyCalendar(Map<String, String> paraMap) throws Throwable;

	// 사내 캘린더에서 사내캘린더 소분류  보여주기 
	List<Calendar_small_category_VO> showCompanyCalendar();


	*/
	
	// 내 캘린더에서 내캘린더 소분류  보여주기
	List<RoomVO> showMyCalendar(String fk_h_userid);
	
	
	// 일정 등록시 내캘린더,사내캘린더 선택에 따른 서브캘린더 종류를 알아오기 
	List<RoomVO> selectSmallCategory(String fk_h_userid);

	
	

	// 일정 등록하기
	int registerSchedule_end(Map<String, String> paraMap) throws Throwable;

	
	
	// 등록된 일정 가져오기
	List<ReservationVO> selectReservation(Map<String,String> paraMap);
	
	// 일정 상세 보기 
	Map<String, String> detailSchedule(String rs_seq);
	
	// 일정삭제하기 
	int deleteSchedule(String rs_seq) throws Throwable;


	// 일정 등록 시 예약자 아이디의 존재여부 확인하기
	UserVO confilctFk_userid(String fk_userid);

	
	// 총 일정 검색 건수(totalCount)
	int getTotalCount(Map<String, String> paraMap);

	// 페이징 처리한 캘린더 가져오기(검색어가 없다라도 날짜범위 검색은 항시 포함된 것임)
	List<Map<String,String>> scheduleListSearchWithPaging(Map<String, String> paraMap);
	
}
