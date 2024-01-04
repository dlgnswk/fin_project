package com.spring.app.jh.index.controller;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.spring.app.jh.index.service.*;


@Controller
public class IndexController { 


	@Autowired  // Type에 따라 알아서 Bean 을 주입해준다.
	private IndexService service;

	
	// 재훈 : 메인페이지
	@GetMapping("/index.exp") 
	public ModelAndView index(ModelAndView mav) {
		
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
		
		mav.setViewName("jh/index/index.tiles1");
		
		return mav;
	}
	
	
	@ResponseBody
	@RequestMapping(value="/index/wordCloud.action", produces="text/plain;charset=UTF-8")
	public String getSearchLogList() {
		
		// 검색어를 list 로 받아오기
		List<Map<String, String>> searchLogList= service.getSearchLogList();
		
		String search_result = "";
		int i = 0;
		for(Map<String, String> map : searchLogList) {
			
			String search_text = map.get("search_text");
			
			if("전체".equalsIgnoreCase(search_text)) {
				
			}
			else {
				if("제주특별자치도".equalsIgnoreCase(search_text)) {
					search_text = "제주도";
				}
				if("강원특별자치도".equalsIgnoreCase(search_text)) {
					search_text = "강원도";
				}
				
				if(i == 0) {
					search_result += search_text;
				}
				else {
					search_result += "," + search_text;
				}
				i++;
			}
			
		}
		
		return search_result;
	}
	
	
	// 재훈 : Ajax로 목적지 검색하기
	@ResponseBody
	@RequestMapping(value="/index/destination_search.action", produces="text/plain;charset=UTF-8")
	public String destination_search(HttpServletRequest request) {
		
		String searchWord = request.getParameter("searchWord");
		// System.out.println(searchWord);
		
		// 검색어에 따라 큰 도시가 있는지 찾아보기(있으면 1, 없으면 0)
		int n1 = service.search_lg_area_1(searchWord);
		// System.out.println("n1 : " + n1);
		
		// 검색어에 따라 상세 도시가 있는지 찾아보기(있으면 1, 없으면 0)
		int n2 = service.search_lg_area_2(searchWord);
		// System.out.println("n1 : " + n1);
		
		// 검색어에 따라 호텔이 있는지 찾아보기(있으면 1, 없으면 0)
		int n3 = service.search_lg_name(searchWord);
		// System.out.println("n2 : " + n2);
		
		if(n1 == 0 && n2 == 0 && n3 == 0) {
			// 검색 결과가 없는경우
			JSONArray jsonArr = new JSONArray();
			
			return jsonArr.toString(); // []
		}
		else {
			// 검색 결과가  있는 경우
			JSONArray jsonArr = new JSONArray();
			
			// 큰 도시 검색
			List<Map<String, String>> lg_area_List = service.search_lg_area_List(searchWord);
			
			// 큰 도시 검색결과가 있는경우
			if(lg_area_List != null) {
				for(Map<String, String> lg_area_map : lg_area_List) {
					JSONObject jsObj = new JSONObject();
					jsObj.put("lg_nation", "한국"); // 국가
					jsObj.put("lg_area", lg_area_map.get("lg_area")); // 큰 도시
					
					jsonArr.put(jsObj);
				}
			}
			

			// 상세 도시 검색 리스트
			List<Map<String, String>> lg_area_2_List = service.search_lg_area_2_List(searchWord);

			// 상세 도시 검색결과가 있는경우
			if(lg_area_2_List != null) {
				for(Map<String, String> lg_area_2_map : lg_area_2_List) {
					JSONObject jsObj = new JSONObject();
					jsObj.put("lg_nation", "한국"); // 국가
					jsObj.put("lg_area", lg_area_2_map.get("lg_area")); // 큰 도시
					jsObj.put("lg_area_2", lg_area_2_map.get("lg_area_2")); // 상세 도시
					
					jsonArr.put(jsObj);
				}
			}

			// 시설 검색 리스트
			List<Map<String, String>> lg_name_List = service.search_lg_name_List(searchWord);

			// 시설 검색결과가 있는경우
			if(lg_name_List != null) {
				for(Map<String, String> lg_name_map : lg_name_List) {
					JSONObject jsObj = new JSONObject();
					jsObj.put("lg_nation", "한국"); // 국가
					jsObj.put("lg_area", lg_name_map.get("lg_area")); // 큰 도시
					jsObj.put("lg_area_2", lg_name_map.get("lg_area_2")); // 상세 도시
					jsObj.put("lg_name", lg_name_map.get("lg_name")); // 시설 이름
					
					jsonArr.put(jsObj);
				}
			}
			
			return jsonArr.toString();
		}
		
	}
	
}
