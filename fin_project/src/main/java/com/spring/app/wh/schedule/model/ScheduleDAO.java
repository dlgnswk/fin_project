package com.spring.app.wh.schedule.model;

import java.util.List;
import java.util.Map;

import com.spring.app.expedia.domain.HostVO;
import com.spring.app.expedia.domain.ReservationVO;
import com.spring.app.expedia.domain.RoomVO;
import com.spring.app.expedia.domain.UserVO;
import com.spring.app.wh.schedule.domain.*;

public interface ScheduleDAO {

	
	
	// 예약  정보를 담은 캘린더 불러오기
	List<ReservationVO> selectReservation(Map<String,String> paraMap);
	
	// 숙소 예약 캘린더에서 객실등급 보여주기
	List<RoomVO> showRoomType(String fk_h_userid);
	
	// 풀캘린더에서 날짜 클릭할 때 발생하는 이벤트(예약 일정 추가)
	int addReservation_end(Map<String, String> paraMap) throws Throwable;
	
	// 일정 등록시 내캘린더,사내캘린더 선택에 따른 서브캘린더 종류를 알아오기
	List<RoomVO> selectRoomType_price(String fk_h_userid);
	
	

	
	// 예약 일정 상세보기 
	Map<String,String> detailReservationSchedule(String rs_seq);

	// 예약 일정 삭제하기
	int deleteReservationSchedule(String rs_seq) throws Throwable;

	// 일정 등록 시 예약자 아이디의 존재여부 확인하기
	UserVO isExist_userid(String fk_userid);
	
	// 총 일정 검색 건수(totalCount)
	int getTotalCount(Map<String, String> paraMap);

	// 페이징 처리한 캘린더 가져오기(검색어가 없다라도 날짜범위 검색은 항시 포함된 것임)
	List<Map<String,String>> scheduleListSearchWithPaging(Map<String, String> paraMap);
	
	
}
