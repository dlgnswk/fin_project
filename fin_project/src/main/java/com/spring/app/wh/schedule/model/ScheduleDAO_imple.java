package com.spring.app.wh.schedule.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.app.expedia.domain.HostVO;
import com.spring.app.expedia.domain.ReservationVO;
import com.spring.app.expedia.domain.RoomVO;
import com.spring.app.expedia.domain.UserVO;
import com.spring.app.wh.schedule.domain.*;

@Repository
public class ScheduleDAO_imple implements ScheduleDAO {

	@Resource
	private SqlSessionTemplate sqlsession;

	/*
	// 사내 캘린더에 캘린더 소분류 명 존재 여부 알아오기
	@Override
	public int existComCalendar(String com_smcatgoname) {
		int m = sqlsession.selectOne("schedule.existComCalendar", com_smcatgoname);
		return m;
	}
	
	// 사내 캘린더에 캘린더 소분류 추가하기
	@Override
	public int addComCalendar(Map<String, String> paraMap) throws Throwable {
		int n = sqlsession.insert("schedule.addComCalendar", paraMap);
		return n;
	}

	
	// 내 캘린더에 캘린더 소분류 명 존재 여부 알아오기
	@Override
	public int existMyCalendar(Map<String, String> paraMap) {
		int m = sqlsession.selectOne("schedule.existMyCalendar", paraMap);
		return m;
	}

	// 내 캘린더에 캘린더 소분류 추가하기
	@Override
	public int addMyCalendar(Map<String, String> paraMap) throws Throwable {
		int n = sqlsession.insert("schedule.addMyCalendar", paraMap);
		return n;
	}

	
	// 사내 캘린더에서 사내캘린더 소분류  보여주기 
	@Override
	public List<Calendar_small_category_VO> showCompanyCalendar() {
		List<Calendar_small_category_VO> calendar_small_category_VO_CompanyList = sqlsession.selectList("schedule.showCompanyCalendar");  
		return calendar_small_category_VO_CompanyList;
	}

	
	*/
	
	// 내 캘린더에서 내캘린더 소분류  보여주기
	@Override
	public List<RoomVO> showMyCalendar(String fk_h_userid) {
		List<RoomVO> roomList = sqlsession.selectList("wh_schedule.showMyCalendar", fk_h_userid);  
		return roomList;
	}

	
	
	// 일정 등록시 내캘린더,사내캘린더 선택에 따른 서브캘린더 종류를 알아오기
	@Override
	public List<RoomVO> selectSmallCategory(String fk_h_userid) {
		List<RoomVO> roomList = sqlsession.selectList("wh_schedule.selectSmallCategory", fk_h_userid);
		return roomList;
	}

	
	

	
	// 일정 등록하기
	@Override
	public int registerSchedule_end(Map<String, String> paraMap) throws Throwable {
		int n = sqlsession.insert("wh_schedule.registerSchedule_end", paraMap);
		return n;
	}

	
	
	// 등록된 일정 가져오기
	@Override
	public List<ReservationVO> selectReservation(Map<String,String> paraMap) {
		List<ReservationVO> reservationList = sqlsession.selectList("wh_schedule.selectReservation", paraMap);
		return reservationList;
	}

	
	// 일정 상세 보기 
	@Override
	public Map<String,String> detailSchedule(String rs_seq) {
		Map<String,String> map = sqlsession.selectOne("wh_schedule.detailSchedule", rs_seq);
		return map;
	}
	
	
	// 일정삭제하기
	@Override
	public int deleteSchedule(String rs_seq) throws Throwable {
		int n = sqlsession.delete("wh_schedule.deleteSchedule", rs_seq);
		return n;
	}

	


	// 일정 등록 시 예약자 아이디의 존재여부 확인하기
	@Override
	public UserVO confilctFk_userid(String fk_userid) {
		UserVO uservo = sqlsession.selectOne("wh_schedule.confilctFk_userid",fk_userid);
		return uservo;
	}
	
	 
	// 총 일정 검색 건수(totalCount)
	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("wh_schedule.getTotalCount", paraMap);
		return n;
	}


	// 페이징 처리한 캘린더 가져오기(검색어가 없다라도 날짜범위 검색은 항시 포함된 것임)
	@Override
	public List<Map<String,String>> scheduleListSearchWithPaging(Map<String, String> paraMap) { 
		List<Map<String,String>> scheduleList = sqlsession.selectList("wh_schedule.scheduleListSearchWithPaging", paraMap);
		return scheduleList;
	}
	

	
}
