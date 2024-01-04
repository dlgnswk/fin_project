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

	/*
	// 사내 캘린더에 캘린더 소분류 추가하기
	@Override
	public int addComCalendar(Map<String, String> paraMap) throws Throwable {
		
		int n=0;
		String com_smcatgoname = paraMap.get("com_smcatgoname");
		
		// 사내 캘린더에 캘린더 소분류 명 존재 여부 알아오기
		int m = dao.existComCalendar(com_smcatgoname);
		
		if(m==0) {
			n = dao.addComCalendar(paraMap);
		}
		
		return n;
	}

	
	// 내 캘린더에 캘린더 소분류 추가하기
	@Override
	public int addMyCalendar(Map<String, String> paraMap) throws Throwable {
		
		int n=0;
		
		// 내 캘린더에 캘린더 소분류 명 존재 여부 알아오기
		int m = dao.existMyCalendar(paraMap);
		
		if(m==0) {
			n = dao.addMyCalendar(paraMap);
		}
		
		return n;
	}


	// 사내 캘린더에서 사내캘린더 소분류  보여주기 
	@Override
	public List<Calendar_small_category_VO> showCompanyCalendar() {
		List<Calendar_small_category_VO> calendar_small_category_VO_CompanyList = dao.showCompanyCalendar(); 
		return calendar_small_category_VO_CompanyList;
	}


	*/
	
	// 내 캘린더에서 내캘린더 소분류  보여주기
	@Override
	public List<RoomVO> showMyCalendar(String fk_h_userid) {
		List<RoomVO> roomList = dao.showMyCalendar(fk_h_userid); 
		return roomList;
	}

	
	// 일정 등록시 내캘린더,사내캘린더 선택에 따른 서브캘린더 종류를 알아오기 
	@Override
	public List<RoomVO> selectSmallCategory(String fk_h_userid) {
		List<RoomVO> roomList = dao.selectSmallCategory(fk_h_userid);
		return roomList;
	}

	
	


	// 일정 등록하기
	@Override
	public int registerSchedule_end(Map<String, String> paraMap) throws Throwable {
		int n = dao.registerSchedule_end(paraMap);
		return n;
	}

	// 일정 등록 시 예약자 아이디의 존재여부 확인하기
	@Override
	public UserVO confilctFk_userid(String fk_userid) {
		UserVO uservo = dao.confilctFk_userid(fk_userid);
		return uservo;
	}
	
	// 등록된 일정 가져오기
	@Override
	public List<ReservationVO> selectReservation(Map<String,String> paraMap) {
		List<ReservationVO> reservationList = dao.selectReservation(paraMap);
		return reservationList;
	}

	
	// 일정 상세 보기 
	@Override
	public Map<String,String> detailSchedule(String rs_seq) {
		Map<String,String> map = dao.detailSchedule(rs_seq);
		return map;
	}

	
	// 일정삭제하기 
	@Override
	public int deleteSchedule(String rs_seq) throws Throwable {
		int n = dao.deleteSchedule(rs_seq);
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
