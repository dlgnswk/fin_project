package com.spring.app.jh.search.controller;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.expedia.domain.UserVO;
import com.spring.app.jh.search.service.SearchService;


@Controller
public class SearchController { 


	@Autowired  // Type에 따라 알아서 Bean 을 주입해준다!~!
	private SearchService service;
	
	
	// 재훈 : 조건에 맞는 호텔 검색한 결과 리스트 보여주기
	@GetMapping("/lodgeSearch.action") 
	public ModelAndView hotelSearch(ModelAndView mav, HttpServletRequest request) {
		
		// 오늘날짜 가져오기
		Calendar cal = Calendar.getInstance();
		String format = "yyyy-MM-dd";
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		String today_date = sdf.format(cal.getTime());
		// System.out.println(today_date); // 2023-12-14
		
		// 이틀뒤 날짜 가져오기
		cal = null;
		cal = Calendar.getInstance();
		sdf = new SimpleDateFormat(format);
		cal.add(cal.DATE, +2);
		String after_tommorrow_date = sdf.format(cal.getTime());
		// System.out.println(after_tommorrow_date); // 2023-12-16
		
		// 두달뒤 날짜 가져오기
		cal = null;
		cal = Calendar.getInstance();
		sdf = new SimpleDateFormat(format);
		cal.add(cal.MONTH, +12);
		String after_1year_date = sdf.format(cal.getTime());
		// System.out.println(after_2month_date); // 2024-02-14
        
		Map<String, String> date_map = new HashMap<>();
		date_map.put("today_date", today_date);
		date_map.put("after_tommorrow_date", after_tommorrow_date);
		date_map.put("after_1year_date", after_1year_date);
		
		mav.addObject("date_map", date_map);
		
		
		
		Map<String, String> paraMap = new HashMap<>();
		
		// 도시, 호텔이름, 체크인날짜, 체크아웃날짜, 인원수
		paraMap.put("lg_name", String.valueOf(request.getParameter("lg_name")));
		paraMap.put("lg_area_2", String.valueOf(request.getParameter("lg_area_2")));
		paraMap.put("lg_area", String.valueOf(request.getParameter("lg_area")));
		paraMap.put("check_in", String.valueOf(request.getParameter("check_in")));
		paraMap.put("check_out", String.valueOf(request.getParameter("check_out")));
		paraMap.put("travlers", String.valueOf(request.getParameter("travlers")));
		paraMap.put("adult", String.valueOf(request.getParameter("adult")));
		paraMap.put("kid", String.valueOf(request.getParameter("kid")));
		
		// 처음 검색한 페이지일 경우와 필터를 적용할 경우 구분
		// 금액대
		if(request.getParameter("price_min") == null && request.getParameter("price_max") == null) {
			paraMap.put("price_min", "");
			paraMap.put("price_max", "");
		}
		else {
			paraMap.put("price_min", String.valueOf(request.getParameter("price_min")));
			paraMap.put("price_max", String.valueOf(request.getParameter("price_max")));
		}

		// 성급
		if(request.getParameter("lg_star") == null) {
			paraMap.put("lg_star", "");
		}
		else {
			paraMap.put("lg_star", String.valueOf(request.getParameter("lg_star")));
		}

		// 시설타입
		if(request.getParameter("lodge_type") == null) {
			paraMap.put("lodge_type", "");
		}
		else {
			paraMap.put("lodge_type", String.valueOf(request.getParameter("lodge_type")));
		}

		// 편의시설 
		//	- 조식
		if(request.getParameter("breakfast") == null) {
			paraMap.put("breakfast", "off");
		}
		else {
			paraMap.put("breakfast", String.valueOf(request.getParameter("breakfast")));
		}
		//	- 수영장
		if(request.getParameter("pool") == null) {
			paraMap.put("pool", "off");
		}
		else {
			paraMap.put("pool", String.valueOf(request.getParameter("pool")));
		}
		//	- 와이파이
		if(request.getParameter("wifi") == null) {
			paraMap.put("wifi", "off");
		}
		else {
			paraMap.put("wifi", String.valueOf(request.getParameter("wifi")));
		}
		//	- 바다 전망
		if(request.getParameter("seaView") == null) {
			paraMap.put("seaView", "off");
		}
		else {
			paraMap.put("seaView", String.valueOf(request.getParameter("seaView")));
		}
		//	- 반려동물
		if(request.getParameter("pet") == null) {
			paraMap.put("pet", "off");
		}
		else {
			paraMap.put("pet", String.valueOf(request.getParameter("pet")));
		}
		//	- 스파
		if(request.getParameter("spa") == null) {
			paraMap.put("spa", "off");
		}
		else {
			paraMap.put("spa", String.valueOf(request.getParameter("spa")));
		}
		//	- 주차
		if(request.getParameter("parking") == null) {
			paraMap.put("parking", "off");
		}
		else {
			paraMap.put("parking", String.valueOf(request.getParameter("parking")));
		}
		//	- 주방
		if(request.getParameter("kitchen") == null) {
			paraMap.put("kitchen", "off");
		}
		else {
			paraMap.put("kitchen", String.valueOf(request.getParameter("kitchen")));
		}
		//	- 에어컨
		if(request.getParameter("aircon") == null) {
			paraMap.put("aircon", "off");
		}
		else {
			paraMap.put("aircon", String.valueOf(request.getParameter("aircon")));
		}
		//	- 레스토랑
		if(request.getParameter("restaurant") == null) {
			paraMap.put("restaurant", "off");
		}
		else {
			paraMap.put("restaurant", String.valueOf(request.getParameter("restaurant")));
		}
		//	- 유아용 침대
		if(request.getParameter("babyBed") == null) {
			paraMap.put("babyBed", "off");
		}
		else {
			paraMap.put("babyBed", String.valueOf(request.getParameter("babyBed")));
		}
		//	- 세탁기 및 건조대
		if(request.getParameter("washerDryer") == null) {
			paraMap.put("washerDryer", "off");
		}
		else {
			paraMap.put("washerDryer", String.valueOf(request.getParameter("washerDryer")));
		}
		
		// 고객 평점
		if(request.getParameter("rating") == null) {
			paraMap.put("rating", "");
		}
		else {
			paraMap.put("rating", String.valueOf(request.getParameter("rating")));
		}
		
		// 고객 평점
		if(request.getParameter("sort") == null) {
			paraMap.put("sort", "Recommended");
		}
		else {
			paraMap.put("sort", String.valueOf(request.getParameter("sort")));
		}
		
		mav.addObject("map", paraMap);
		
		
		// 이미지 리스트 가져오기
		JSONArray lodgeImgArr = new JSONArray(); // []
		List<Map<String, String>> lodgeImgList = service.lodgeImgList();
		
		if(lodgeImgList != null) {
			for(Map<String, String> lodgeImgMap : lodgeImgList) {
				JSONObject jsonObj = new JSONObject(); // {}
				jsonObj.put("fk_lodge_id", lodgeImgMap.get("fk_lodge_id"));
				jsonObj.put("lg_img_save_name", lodgeImgMap.get("lg_img_save_name"));
				
				lodgeImgArr.put(jsonObj); // [{"lodge_id":"JELC0003","lg_name":"롯데시티호텔 제주"}]
			}// end of for---------
		}
		
		
		// 위시리스트에 넣은 lodge_id 리스트 가져오기
		HttpSession session = request.getSession();
		UserVO loginuser = (UserVO) session.getAttribute("loginuser");

		JSONArray lodgeIdArr = new JSONArray(); // []
		
		if(loginuser != null) {
		
			String userid = loginuser.getUserid();
			
			List<Map<String, String>> lodgeIdList = service.lodgeIdList(userid);
			
			if(lodgeImgList != null) {
				for(Map<String, String> lodgeIdMap : lodgeIdList) {
					JSONObject jsonObj = new JSONObject(); // {}
					jsonObj.put("fk_lodge_id", lodgeIdMap.get("fk_lodge_id"));
					
					lodgeIdArr.put(jsonObj); // [{"lodge_id":"JELC0003","lg_name":"롯데시티호텔 제주"}]
				}// end of for---------
			}
			
		}
		
		mav.addObject("lodgeIdArr", lodgeIdArr);
		mav.addObject("lodgeImgArr", lodgeImgArr);
		
		mav.setViewName("jh/lodge/lodgeSearch.tiles1");
		
		return mav;
	}
	
	
	@ResponseBody
	@GetMapping(value="/lodgeSearchAjax.action", produces="text/plain;charset=UTF-8")
	public String lodgeSearchAjax(HttpServletRequest request) {
		
		Map<String, Object> paraMap = new HashMap<>();
		
		// 도시, 호텔이름, 체크인날짜, 체크아웃날짜, 인원수, 가격대, 숙소 성급
		paraMap.put("lg_name", String.valueOf(request.getParameter("lg_name")));
		paraMap.put("lg_area_2", String.valueOf(request.getParameter("lg_area_2")));
		paraMap.put("lg_area", String.valueOf(request.getParameter("lg_area")));
		paraMap.put("check_in", String.valueOf(request.getParameter("check_in")));
		paraMap.put("check_out", String.valueOf(request.getParameter("check_out")));
		paraMap.put("travlers", String.valueOf(request.getParameter("travlers")));
		paraMap.put("adult", String.valueOf(request.getParameter("adult")));
		paraMap.put("kid", String.valueOf(request.getParameter("kid")));
		paraMap.put("price_min", String.valueOf(request.getParameter("price_min")));
		paraMap.put("price_max", String.valueOf(request.getParameter("price_max")));
		
		// 숙소 성급 배열화 하기
		String lg_star;
		String[] lg_star_arr = new String[] {};
		if("".equals(request.getParameter("lg_star"))) {
			lg_star = null;
		}
		else {
			lg_star = request.getParameter("lg_star");
			lg_star_arr = lg_star.split("\\,");
		}
		
		paraMap.put("lg_star_arr", lg_star_arr);
		
		// 숙소 타입 배열화 하기
		String lodge_type;
		String[] lodge_type_arr = new String[] {};
		if("".equals(request.getParameter("lodge_type"))) {
			lodge_type = null;
		}
		else {
			lodge_type = request.getParameter("lodge_type");
			lodge_type_arr = lodge_type.split("\\,");
		}
		
		paraMap.put("lodge_type_arr", lodge_type_arr);
		
		// 편의시설/서비스
		// 조식 (breakfast)
		paraMap.put("breakfast", request.getParameter("breakfast"));
		// 수영장 (pool)
		paraMap.put("pool", request.getParameter("pool"));
		// wifi (wifi)
		paraMap.put("wifi", request.getParameter("wifi"));
		// 바다 전망 (seaView)
		paraMap.put("seaView", request.getParameter("seaView"));
		// 반려동물 (pet)
		paraMap.put("pet", request.getParameter("pet"));
		// 스파 (spa)
		paraMap.put("spa", request.getParameter("spa"));
		// 주차 (parking)
		paraMap.put("parking", request.getParameter("parking"));
		// 주방 (kitchen)
		paraMap.put("kitchen", request.getParameter("kitchen"));
		// 에어컨 (aircon)
		paraMap.put("aircon", request.getParameter("aircon"));
		// 레스토랑 (restaurant)
		paraMap.put("restaurant", request.getParameter("restaurant"));
		// 유아용 침대 (babyBed)
		paraMap.put("babyBed", request.getParameter("babyBed"));
		// 세탁기 및 건조기 (washerDryer)
		paraMap.put("washerDryer", request.getParameter("washerDryer"));
		
		
		// 고객 평점
		paraMap.put("rating", request.getParameter("rating"));

		
		// 정렬 기준
		paraMap.put("sort", request.getParameter("sort"));
		// Recommended, LowToHigh, HighToLow, ReviewRating
		
		
		// 검색된 내용을 통해 호텔 검색
		List<Map<String, String>> lodgeList = service.getLodgeList(paraMap);
		
		// System.out.println(lodgeList);
		/*
			[{lg_area_2=중구, lodge_id=lote0001, lg_name=롯데호텔 서울, lg_area=서울특별시}
			, {lg_area_2=해운대구, lodge_id=JSUN0231, lg_name=그랜드 조선 부산, lg_area=부산}
			, {lg_area_2=강릉시, lodge_id=GWGN0002, lg_name=세인트존스 호텔, lg_area=강원특별자치도}
			, {lg_area_2=강릉시, lodge_id=GWGN0001, lg_name=스카이베이 호텔 경포, lg_area=강원특별자치도}
			, {lg_area_2=서귀포시, lodge_id=JEHI0002, lg_name=히든 클리프 호텔&네이쳐, lg_area=제주특별자치도}
			, {lg_area_2=중구, lodge_id=PARA0001, lg_name=파라다이스시티, lg_area=인천광역시}
			, {lg_area_2=서귀포시, lodge_id=JESH0001, lg_name=제주신라호텔, lg_area=제주특별자치도}]
		*/
		
		JSONArray jsonArr = new JSONArray(); // []
		
		if(lodgeList != null) {
			
			// 검색된 내용 insert 해주기
			Map<String, String> searchMap = new HashMap<>();
			searchMap.put("lg_name", request.getParameter("lg_name"));
			searchMap.put("lg_area_2", request.getParameter("lg_area_2"));
			searchMap.put("lg_area", request.getParameter("lg_area"));
			service.insertSearchLog(searchMap);
			
			
			for(Map<String, String> lodgeMap : lodgeList) {
				JSONObject jsonObj = new JSONObject(); // {}
				jsonObj.put("lodge_id", lodgeMap.get("lodge_id"));
				jsonObj.put("lg_name", lodgeMap.get("lg_name"));
				jsonObj.put("check_in", lodgeMap.get("check_in"));
				jsonObj.put("check_out", lodgeMap.get("check_out"));
				jsonObj.put("travlers", lodgeMap.get("travlers"));
				jsonObj.put("sort", lodgeMap.get("sort"));
				
				jsonArr.put(jsonObj); 
				
			}// end of for---------
		}
		
		JSONArray jsonArr_2 = new JSONArray(); // []
		
		// 검색된 숙소의 lodge_id list 받아서 for문을 돌려주기
		for(int i=0; i<jsonArr.length(); i++) {
			
			JSONObject jsonObj = (JSONObject)jsonArr.get(i);
			
			// 검색된 숙소 리스트에서 하나의 숙소를 map에 저장
			Map<String, Object> map = new HashMap<>();
			map.put("lodge_id", (String)jsonObj.get("lodge_id"));
			map.put("lg_name", (String)jsonObj.get("lg_name"));
			map.put("check_in", paraMap.get("check_in"));
			map.put("check_out", paraMap.get("check_out"));
			map.put("travlers", paraMap.get("travlers"));
			
			// map에 저장한 하나의 숙소에 지정일에 예약가능한 객실이 있는 경우 해당숙소의 lodge_id를 jsonObj_2에 저장하기
			List<Map<String, String>> availableLodgeList = service.getAvailableLodgeList(map);
			
			// System.out.println(availableLodgeList);
			/*
				[{rest_room_cnt=50, fk_lodge_id=lote0001}]
				[{rest_room_cnt=27, fk_lodge_id=JSUN0231}]
				[{rest_room_cnt=40, fk_lodge_id=GWGN0002}]
				[{rest_room_cnt=40, fk_lodge_id=GWGN0001}]
				[{rest_room_cnt=5, fk_lodge_id=JEHI0002}]
				[{rest_room_cnt=40, fk_lodge_id=PARA0001}]
				[{rest_room_cnt=9, fk_lodge_id=JESH0001}]
			*/
			
			if(availableLodgeList != null) {
				for(Map<String, String> availableLodgeMap : availableLodgeList) {
					JSONObject jsonObj_2 = new JSONObject(); // {}
					jsonObj_2.put("fk_lodge_id", availableLodgeMap.get("fk_lodge_id"));
					jsonObj_2.put("rest_room_cnt", availableLodgeMap.get("rest_room_cnt"));
					
					jsonArr_2.put(jsonObj_2); // [{"lodge_id":"JESH0001"}]
				}// end of for---------
			}
		};
		
		JSONArray jsonArr_3 = new JSONArray(); // []
		
		for(int i=0; i<jsonArr_2.length(); i++) {
			
			JSONObject jsonObj = (JSONObject)jsonArr_2.get(i);
			
			// lodge_id와 예약가능한 객실수를 받아와서 map에 넣어줌
			int rest_room_cnt = Integer.parseInt((String)jsonObj.get("rest_room_cnt"));
			
			// 예약가능한 객실수가 1개 이상인 숙소인 경우
			if(rest_room_cnt > 0) {
				
				Map<String, Object> lodge_map = new HashMap<>();
				lodge_map.put("lodge_id", (String)jsonObj.get("fk_lodge_id"));
				lodge_map.put("check_in", paraMap.get("check_in"));
				lodge_map.put("check_out", paraMap.get("check_out"));
				lodge_map.put("price_min", paraMap.get("price_min"));
				lodge_map.put("price_max", paraMap.get("price_max"));
				
				// 편의시설 정보
				lodge_map.put("breakfast", paraMap.get("breakfast"));
				lodge_map.put("pool", paraMap.get("pool"));
				lodge_map.put("wifi", paraMap.get("wifi"));
				lodge_map.put("seaView", paraMap.get("seaView"));
				lodge_map.put("pet", paraMap.get("pet"));
				lodge_map.put("spa", paraMap.get("spa"));
				lodge_map.put("parking", paraMap.get("parking"));
				lodge_map.put("kitchen", paraMap.get("kitchen"));
				lodge_map.put("aircon", paraMap.get("aircon"));
				lodge_map.put("restaurant", paraMap.get("restaurant"));
				lodge_map.put("babyBed", paraMap.get("babyBed"));
				lodge_map.put("washerDryer", paraMap.get("washerDryer"));

				// 고객평점
				lodge_map.put("rating", paraMap.get("rating"));
				
				// 예약가능한 숙소의 정보를 가져오기
				List<Map<String, String>> lodgeInfoList = service.getLodgeInfoList(lodge_map);
				
				// System.out.println(lodgeInfoList);
				/*
					[{fk_cancel_opt= , review_cnt=0, lg_area_2=중구, rating=0, lodge_id=lote0001, rm_price=363000, lg_name=롯데호텔 서울, lg_area=서울특별시}]
					[{fk_cancel_opt= , review_cnt=0, lg_area_2=해운대구, rating=0, lodge_id=JSUN0231, rm_price=240000, lg_name=그랜드 조선 부산, lg_area=부산}]
					[{fk_cancel_opt= , review_cnt=0, lg_area_2=강릉시, rating=0, lodge_id=GWGN0002, rm_price=130000, lg_name=세인트존스 호텔, lg_area=강원특별자치도}, {fk_cancel_opt= , review_cnt=0, lg_area_2=강릉시, rating=0, lodge_id=GWGN0002, rm_price=130000, lg_name=세인트존스 호텔, lg_area=강원특별자치도}]
					[{fk_cancel_opt= , review_cnt=0, lg_area_2=강릉시, rating=0, lodge_id=GWGN0001, rm_price=145000, lg_name=스카이베이 호텔 경포, lg_area=강원특별자치도}]
					[{fk_cancel_opt= , review_cnt=1, lg_area_2=서귀포시, rating=10, lodge_id=JEHI0002, rm_price=410227, lg_name=히든 클리프 호텔&네이쳐, lg_area=제주특별자치도}]
					[{fk_cancel_opt= , review_cnt=2, lg_area_2=중구, rating=9, lodge_id=PARA0001, rm_price=490000, lg_name=파라다이스시티, lg_area=인천광역시}]
					[{fk_cancel_opt= , review_cnt=4, lg_area_2=서귀포시, rating=8, lodge_id=JESH0001, rm_price=550000, lg_name=제주신라호텔, lg_area=제주특별자치도}]

				*/
				
				
				if(lodgeInfoList != null) {
					for(Map<String, String> lodgeInfoMap : lodgeInfoList) {
						
						JSONObject jsonObj_3 = new JSONObject(); // {}
						jsonObj_3.put("lodge_id", 		lodgeInfoMap.get("lodge_id"));
						jsonObj_3.put("lg_name", 		lodgeInfoMap.get("lg_name"));
						jsonObj_3.put("lg_area_2", 		lodgeInfoMap.get("lg_area_2"));
						jsonObj_3.put("lg_area", 		lodgeInfoMap.get("lg_area"));
						jsonObj_3.put("fk_cancel_opt", 	lodgeInfoMap.get("fk_cancel_opt"));
						jsonObj_3.put("rm_price", 		lodgeInfoMap.get("rm_price"));
						jsonObj_3.put("rating", 		lodgeInfoMap.get("rating"));
						jsonObj_3.put("review_cnt", 	lodgeInfoMap.get("review_cnt"));
						jsonObj_3.put("check_in", 		paraMap.get("check_in"));
						jsonObj_3.put("check_out", 		paraMap.get("check_out"));
						
						jsonArr_3.put(jsonObj_3);
					}// end of for---------
				}
			}
		}
		
		return jsonArr_3.toString();
		
	}
	
	
	// 위시리스트에 추가하기
	@ResponseBody
	@GetMapping(value="/addWishlistAjax.action", produces="text/plain;charset=UTF-8")
	public String addWishlistAjax(HttpServletRequest request) {

		Map<String, String> paraMap = new HashMap<>();

		HttpSession session = request.getSession();
		UserVO loginuser = (UserVO) session.getAttribute("loginuser");

		paraMap.put("userid", loginuser.getUserid());
		paraMap.put("wishlist_lodge_id", request.getParameter("wishlist_lodge_id"));
		
		int n = service.addWishlist(paraMap);
		
		JSONObject jsonObj = new JSONObject(); // {}
		jsonObj.put("n", n);
		

		return jsonObj.toString();
	}
	
	
	// 위시리스트에 삭제하기
	@ResponseBody
	@GetMapping(value="/delWishlistAjax.action", produces="text/plain;charset=UTF-8")
	public String delWishlistAjax(HttpServletRequest request) {

		Map<String, String> paraMap = new HashMap<>();

		HttpSession session = request.getSession();
		UserVO loginuser = (UserVO) session.getAttribute("loginuser");

		paraMap.put("userid", loginuser.getUserid());
		paraMap.put("wishlist_lodge_id", request.getParameter("wishlist_lodge_id"));
		
		int n = service.deleteWishlist(paraMap);
		
		JSONObject jsonObj = new JSONObject(); // {}
		jsonObj.put("n", n);
		

		return jsonObj.toString();
	}
	
	
	
}
