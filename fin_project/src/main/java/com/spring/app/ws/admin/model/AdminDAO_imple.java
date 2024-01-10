package com.spring.app.ws.admin.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.app.expedia.domain.UserVO;

@Repository
public class AdminDAO_imple implements AdminDAO {

	@Resource
	private SqlSessionTemplate sqlsession;
	
	@Override
	public String getName() {
		String name = sqlsession.selectOne("ws_admin.getName");
		return name;
	}

	
	// 총 회원수를 알아오는 메소드
	@Override
	public int getTotalCnt(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("ws_admin.getTotalCnt",paraMap);
		return n;
	}


	// 페이징한 회원목록 가져오기
	@Override
	public List<UserVO> userListSearch(Map<String, String> paraMap) {
		List<UserVO> userList = sqlsession.selectList("ws_admin.userListSearch",paraMap);
		return userList;
	}


	// 회원관리 검색어 입력시 자동완성하기
	@Override
	public List<String> searchUserShow(Map<String, String> paraMap) {
		List<String> searchList = sqlsession.selectList("ws_admin.searchUserShow",paraMap);
		return searchList;
	}


	// 총 판매자수를 알아오는 메소드
	@Override
	public int getHostCnt(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("ws_admin.getHostCnt",paraMap);
		return n;
	}


	// 페이징한 판매자목록 가져오기
	@Override
	public List<UserVO> hostListSearch(Map<String, String> paraMap) {
		List<UserVO> hostList = sqlsession.selectList("ws_admin.hostListSearch",paraMap);
		return hostList;
	}


	// 판매자관리 검색어 입력시 자동완성하기
	@Override
	public List<String> searchHostShow(Map<String, String> paraMap) {
		List<String> searchList = sqlsession.selectList("ws_admin.searchHostShow",paraMap);
		return searchList;
	}


	// tbl_irs 테이블에서 사업자번호의 유효성을 확인하는 메소드
	@Override
	public int searchBusinessNo(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("ws_admin.searchBusinessNo",paraMap);
		return n;
	}


	// tbl_host 테이블에서 status를 1로 update해주는 메소드
	@Override
	public int businessApprove(String hostId) {
		int n = sqlsession.update("ws_admin.businessApprove",hostId);
		return n;
	}


	// tbl_host 테이블에서 status를 2로 update해주는 메소드
	@Override
	public int businessReject(String hostId) {
		int n = sqlsession.update("ws_admin.businessReject",hostId);
		return n;
	}


	// 총 숙소 수를 알아오는 메소드
	@Override
	public int getLodgeCnt(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("ws_admin.getLodgeCnt",paraMap);
		return n;
	}


	// 페이징한 숙소목록 가져오기
	@Override
	public List<List<Map<String, String>>> lodgeListSearch(Map<String, String> paraMap) {
		// 숙소id를 가져오는 메소드
		List<Map<String, String>> lodgeIdMapList = sqlsession.selectList("ws_admin.getLodgeIdMapList",paraMap); // 1
		
		List<List<Map<String, String>>> lodgeListListMap = new ArrayList<>();
		
		System.out.println("lodgeIdMapList.size() => " + lodgeIdMapList.size());
		
		for(int i = 0; i < lodgeIdMapList.size(); i++){
			// System.out.println("lodgeIdMapList get(\"lodge_id\") :" + lodgeIdMapList.get(i).get("lodge_id"));
			String lodge_id = lodgeIdMapList.get(i).get("lodge_id");
			System.out.println(lodge_id);
			List<Map<String, String>> lodgeList = sqlsession.selectList("ws_admin.onelodgeinfoSearchtype",lodge_id);
			lodgeListListMap.add(lodgeList);
		}
		
		/*
		for(Map<String, String> map: lodgeIdMapList) {

			String lodge_id1 = map.get("lodge_id");
			System.out.println("lodge_id1" + lodge_id1);
			
			String lodge_id2 = map.get("lodge_id");
			System.out.println("lodge_id2" + lodge_id2);
			
			List<String> lodgeList = sqlsession.selectList("ws_admin.onelodgeinfoSearchtype",lodge_id);
			
			for(String aa:lodgeList) {
				//System.out.println(aa);
			}
		}
		*/
		return lodgeListListMap;
	}


	// 숙소 검색어 입력시 자동완성하기
	@Override
	public List<String> searchLodgeShow(Map<String, String> paraMap) {
		List<String> searchList = sqlsession.selectList("ws_admin.searchLodgeShow",paraMap);
		return searchList;
	}


	// tbl_lodge 테이블에서 lg_status를 1로 update해주는 메소드
	@Override
	public int lodgeRegistrationApprove(String lodge_id) {
		int n = sqlsession.update("ws_admin.lodgeRegistrationApprove",lodge_id);
		return n;
	}


	// tbl_lodge 테이블에서 lg_status를 0로 update해주는 메소드
	@Override
	public int lodgeRegistrationReject(String lodge_id) {
		int n = sqlsession.update("ws_admin.lodgeRegistrationReject",lodge_id);
		return n;
	}


	// 차트그리기(AJAX) 년도별 성별 등록 회원수
	@Override
	public List<Map<String, String>> yearGenderUser() {
		List<Map<String, String>> yearGenderUserList = sqlsession.selectList("ws_admin.yearGenderUser");
		return yearGenderUserList;
	}


	// 차트그리기(AJAX) 행정구역별 숙박시설 점유율
	@Override
	public List<Map<String, String>> regionOccupancy() {
		List<Map<String, String>> regionOccupancyList = sqlsession.selectList("ws_admin.regionOccupancy");
		return regionOccupancyList;
	}


	// 특정 행정구역에 존재하는 숙박시설들 중 객실수의 퍼센티지
	@Override
	public List<Map<String, String>> lodgeQtyPercentage(String lg_area) {
		List<Map<String, String>> lodgeQtyList = sqlsession.selectList("ws_admin.lodgeQtyPercentage",lg_area);
		return lodgeQtyList;
	}


	// 차트그리기(AJAX) 분기별 숙박시설 전체 예약건수
	@Override
	public List<Map<String, String>> quatorTotalReservation() {
		List<Map<String, String>> quatorTotalReservationList = sqlsession.selectList("ws_admin.quatorTotalReservation");
		return quatorTotalReservationList;
	}

}
