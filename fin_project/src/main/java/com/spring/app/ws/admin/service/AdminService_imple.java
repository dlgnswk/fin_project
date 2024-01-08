package com.spring.app.ws.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.spring.app.expedia.domain.UserVO;
import com.spring.app.ws.admin.model.AdminDAO;

@Service
public class AdminService_imple implements AdminService {

	@Autowired
	public AdminDAO dao;
	
	
	@Override
	public String getName() {

		String name = dao.getName();
		
		return name;
	}


	// 총 회원수를 알아오는 메소드
	@Override
	public int getTotalCnt(Map<String, String> paraMap) {
		int n = dao.getTotalCnt(paraMap);
		return n;
	}


	// 페이징한 회원목록 가져오기
	@Override
	public List<UserVO> userListSearch(Map<String, String> paraMap) {
		List<UserVO> userList = dao.userListSearch(paraMap);
		return userList;
	}


	// 회원관리 검색어 입력시 자동완성하기
	@Override
	public List<String> searchUserShow(Map<String, String> paraMap) {
		List<String> searchList = dao.searchUserShow(paraMap);
		return searchList;
	}


	// 총 판매자수를 알아오는 메소드
	@Override
	public int getHostCnt(Map<String, String> paraMap) {
		int n = dao.getHostCnt(paraMap);
		return n;
	}


	// 페이징한 판매자목록 가져오기
	@Override
	public List<UserVO> hostListSearch(Map<String, String> paraMap) {
		List<UserVO> hostList = dao.hostListSearch(paraMap);
		return hostList;
	}


	// 판매자관리 검색어 입력시 자동완성하기
	@Override
	public List<String> searchHostShow(Map<String, String> paraMap) {
		List<String> searchList = dao.searchHostShow(paraMap);
		return searchList;
	}


	// tbl_irs 테이블에서 사업자번호의 유효성을 확인하는 메소드
	@Override
	public int searchBusinessNo(Map<String, String> paraMap) {
		int n = dao.searchBusinessNo(paraMap);
		return n;
	}


	// tbl_host 테이블에서 status를 1로 update해주는 메소드
	@Override
	public int businessApprove(String hostId) {
		int n = dao.businessApprove(hostId);
		return n;
	}


	// tbl_host 테이블에서 status를 2로 update해주는 메소드
	@Override
	public int businessReject(String hostId) {
		int n = dao.businessReject(hostId);
		return n;
	}


	// 총 숙소 수를 알아오는 메소드
	@Override
	public int getLodgeCnt(Map<String, String> paraMap) {
		int n = dao.getLodgeCnt(paraMap);
		return n;
	}

	// 페이징한 숙소목록 가져오기
	@Override
	public List<List<Map<String, String>>> lodgeListSearch(Map<String, String> paraMap) {
		List<List<Map<String, String>>> lodgeListListMap = dao.lodgeListSearch(paraMap);
		return lodgeListListMap;
	}


	// 숙소 검색어 입력시 자동완성하기
	@Override
	public List<String> searchLodgeShow(Map<String, String> paraMap) {
		List<String> searchList = dao.searchLodgeShow(paraMap);
		return searchList;
	}


	// tbl_lodge 테이블에서 lg_status를 1로 update해주는 메소드
	@Override
	public int lodgeRegistrationApprove(String lodge_id) {
		int n = dao.lodgeRegistrationApprove(lodge_id);
		return n;
	}


	// tbl_lodge 테이블에서 lg_status를 0로 update해주는 메소드
	@Override
	public int lodgeRegistrationReject(String lodge_id) {
		int n = dao.lodgeRegistrationReject(lodge_id);
		return n;
	}

	
	// 차트그리기(AJAX) 년도별 성별 등록 회원수
	@Override
	public String yearGenderUser() {
		
		List<Map<String,String>> yearGenderUserList = dao.yearGenderUser();
		
		JsonArray jsonArr = new JsonArray();
		
		for(Map<String,String> map : yearGenderUserList) {
			
			JsonObject jsonObj = new JsonObject();
			jsonObj.addProperty("gender", 		map.get("gender")); 	// put  {"gender":"남"}
			jsonObj.addProperty("Y2017", 		map.get("Y2017")); 		// put  {"gender":"남","Y2001":"0","Y2002":"2"}
			jsonObj.addProperty("Y2018", 		map.get("Y2018")); 		// put  {"gender":"남","Y2001":"0","Y2002":"2", Y2003":"4"}
			jsonObj.addProperty("Y2019", 		map.get("Y2019")); 		// put  {"gender":"남","Y2001":"0","Y2002":"2", Y2003":"4", "Y2004":"4"}
			jsonObj.addProperty("Y2020", 		map.get("Y2020")); 		// put  {"gender":"남","Y2001":"0","Y2002":"2", Y2003":"4", "Y2004":"4", "Y2005":"15"}
			jsonObj.addProperty("Y2021", 		map.get("Y2021")); 		// put  {"gender":"남","Y2001":"0","Y2002":"2", Y2003":"4", "Y2004":"4", "Y2005":"15", "Y2006":"17"}
			jsonObj.addProperty("Y2022", 		map.get("Y2022")); 		// put  {"gender":"남","Y2001":"0","Y2002":"2", Y2003":"4", "Y2004":"4", "Y2005":"15", "Y2006":"17", "Y2007":"8"}
			jsonObj.addProperty("Y2023", 		map.get("Y2023"));
			jsonObj.addProperty("Y2024", 		map.get("Y2024"));
			
			jsonArr.add(jsonObj);
		}
		
		return new Gson().toJson(jsonArr);
	}
	
	
	
	// 차트그리기(AJAX) 행정구역별 숙박시설 점유율
	@Override
	public String regionOccupancy() {
		
		List<Map<String,String>> regionOccupancyList = dao.regionOccupancy();
		
		JsonArray jsonArr = new JsonArray();
		
		for(Map<String,String> map : regionOccupancyList ) {
			JsonObject jsonObj = new JsonObject();
			jsonObj.addProperty("lg_area", 		map.get("lg_area"));
			jsonObj.addProperty("cnt", 			map.get("cnt"));
			jsonObj.addProperty("percentage", 	map.get("percentage"));
			
			jsonArr.add(jsonObj);
		}
		return new Gson().toJson(jsonArr);
	}

	
	
	// 특정 행정구역에 존재하는 숙박시설들 중 객실수의 퍼센티지
	@Override
	public String lodgeQtyPercentage(String lg_area) {
		
		List<Map<String,String>> lodgeQtyList = dao.lodgeQtyPercentage(lg_area);
		
		JsonArray jsonArr = new JsonArray();
		
		for(Map<String,String> map : lodgeQtyList ) {
			JsonObject jsonObj = new JsonObject();
			jsonObj.addProperty("lg_name", 		map.get("lg_name"));
			jsonObj.addProperty("cnt", 			map.get("cnt"));
			jsonObj.addProperty("percentage", 	map.get("percentage"));
			
			jsonArr.add(jsonObj);
		}
		return new Gson().toJson(jsonArr);
	}


	// 차트그리기(AJAX) 분기별 숙박시설 전체 예약건수
	@Override
	public String quatorTotalReservation() {
		
		List<Map<String,String>> quatorTotalReservationList = dao.quatorTotalReservation();
		
		JsonArray jsonArr = new JsonArray();
		
		for(Map<String,String> map : quatorTotalReservationList ) {
			JsonObject jsonObj = new JsonObject();
			jsonObj.addProperty("quator", 	map.get("quator"));
			jsonObj.addProperty("cnt", 		map.get("cnt"));
			
			jsonArr.add(jsonObj);
		}
		return new Gson().toJson(jsonArr);
	}
	
	


	


	


	
	
	
	
	
	
	
	
	
	
	

}
