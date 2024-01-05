package com.spring.app.jh.trip.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.expedia.domain.UserVO;
import com.spring.app.jh.trip.service.TripService;


@Controller
public class TripController { 


	@Autowired  // Type에 따라 알아서 Bean 을 주입해준다.
	private TripService service;

	
	// 재훈 : 메인페이지
	@GetMapping("/trip.exp") 
	public ModelAndView index(ModelAndView mav, HttpServletRequest request) {
		
		mav.setViewName("jh/trip/trip.tiles1");
		
		return mav;
	}
	
	// 재훈 : 로드 날짜 기준 체크인 날짜가 지나지 않은 경우(최대 3개)
	@ResponseBody
	@GetMapping(value="/beforeReservationAjax.action", produces="text/plain;charset=UTF-8")
	public String beforeReservationAjax(HttpServletRequest request) {
		
		String userid = request.getParameter("userid");
		
		List<Map<String, String>> beforeReservationList = service.beforeReservation(userid);
		
		JSONArray jsonArr = new JSONArray(); // []
		
		for(Map<String, String> map : beforeReservationList) {
			JSONObject jsonObj = new JSONObject(); // {}
			jsonObj.put("fk_h_userid", map.get("fk_h_userid"));
			jsonObj.put("lodge_id", map.get("lodge_id"));
			jsonObj.put("lg_name", map.get("lg_name"));
			jsonObj.put("rs_month", map.get("rs_month"));
			jsonObj.put("rs_day", map.get("rs_day"));
			jsonObj.put("rs_no", map.get("rs_no"));
			jsonObj.put("lg_img_save_name", map.get("lg_img_save_name"));
			
			jsonArr.put(jsonObj);
		}// end of for---------
		
		// System.out.println(jsonArr);
		/*
			[{"rs_month":"12","rs_no":"11","lg_img_save_name":"2023121412400259243254235235234.png","rs_day":"21","lg_name":"제주신라호텔"}
			,{"rs_month":"12","rs_no":"8","lg_img_save_name":"2023121412400259243254235235234.png","rs_day":"16","lg_name":"제주신라호텔"}
			,{"rs_month":"12","rs_no":"6","lg_img_save_name":"2023121412400259243254235235234.png","rs_day":"24","lg_name":"제주신라호텔"}]
		*/
		
		return jsonArr.toString();
	}
	
	// 재훈 : 로드 날짜 기준 체크인 날짜가 지난 경우(최대 3개)
	@ResponseBody
	@GetMapping(value="/afterReservationAjax.action", produces="text/plain;charset=UTF-8")
	public String afterReservationAjax(HttpServletRequest request) {
		
		String userid = request.getParameter("userid");
		
		List<Map<String, String>> afterReservationList = service.afterReservation(userid);
		
		JSONArray jsonArr = new JSONArray(); // []
		
		for(Map<String, String> map : afterReservationList) {
			JSONObject jsonObj = new JSONObject(); // {}
			jsonObj.put("lodge_id", map.get("lodge_id"));
			jsonObj.put("fk_h_userid", map.get("fk_h_userid"));
			jsonObj.put("lg_name", map.get("lg_name"));
			jsonObj.put("rs_month", map.get("rs_month"));
			jsonObj.put("rs_day", map.get("rs_day"));
			jsonObj.put("rs_no", map.get("rs_no"));
			jsonObj.put("lg_img_save_name", map.get("lg_img_save_name"));
			jsonObj.put("rv_yn", map.get("rv_yn"));
			jsonObj.put("rs_cancel", map.get("rs_cancel"));
			
			jsonArr.put(jsonObj);
		}// end of for---------
		
		// System.out.println(jsonArr);
		/*
			[{"rs_month":"1","rs_no":"19","lg_img_save_name":"2023121912400259243254235235334.png","rs_day":"2","lg_name":"히든 클리프 호텔&네이쳐"}
			,{"rs_month":"12","rs_no":"15","lg_img_save_name":"2023121412400259243254235235234.png","rs_day":"29","lg_name":"제주신라호텔"}
			,{"rs_month":"12","rs_no":"7","lg_img_save_name":"2023121412400259243254235235234.png","rs_day":"30","lg_name":"제주신라호텔"}]
		*/
		
		return jsonArr.toString();
	}
	
	// 재훈 : 로드 날짜 기준 체크인 날짜가 지나지 않은 경우(전부)
	@ResponseBody
	@GetMapping(value="/beforeReservationAllAjax.action", produces="text/plain;charset=UTF-8")
	public String beforeReservationAllAjax(HttpServletRequest request) {
		
		String userid = request.getParameter("userid");
		
		List<Map<String, String>> beforeReservationAllList = service.beforeReservationAll(userid);
		
		JSONArray jsonArr = new JSONArray(); // []
		
		for(Map<String, String> map : beforeReservationAllList) {
			JSONObject jsonObj = new JSONObject(); // {}
			jsonObj.put("fk_h_userid", map.get("fk_h_userid"));
			jsonObj.put("lodge_id", map.get("lodge_id"));
			jsonObj.put("lg_name", map.get("lg_name"));
			jsonObj.put("rs_month", map.get("rs_month"));
			jsonObj.put("rs_day", map.get("rs_day"));
			jsonObj.put("rs_no", map.get("rs_no"));
			jsonObj.put("lg_img_save_name", map.get("lg_img_save_name"));
			
			jsonArr.put(jsonObj);
		}// end of for---------
		
		return jsonArr.toString();
	}
	
	// 재훈 : 로드 날짜 기준 체크인 날짜가 지난 경우(전부)
	@ResponseBody
	@GetMapping(value="/afterReservationAllAjax.action", produces="text/plain;charset=UTF-8")
	public String afterReservationAllAjax(HttpServletRequest request) {
		
		String userid = request.getParameter("userid");
		
		List<Map<String, String>> afterReservationAllList = service.afterReservationAll(userid);
		
		JSONArray jsonArr = new JSONArray(); // []
		
		for(Map<String, String> map : afterReservationAllList) {
			JSONObject jsonObj = new JSONObject(); // {}
			jsonObj.put("lodge_id", map.get("lodge_id"));
			jsonObj.put("lg_name", map.get("lg_name"));
			jsonObj.put("rs_month", map.get("rs_month"));
			jsonObj.put("rs_day", map.get("rs_day"));
			jsonObj.put("rs_no", map.get("rs_no"));
			jsonObj.put("lg_img_save_name", map.get("lg_img_save_name"));
			jsonObj.put("rv_yn", map.get("rv_yn"));
			jsonObj.put("rs_cancel", map.get("rs_cancel"));
			
			jsonArr.put(jsonObj);
		}// end of for---------
		
		return jsonArr.toString();
	}
	
	// 재훈 : 예약번호를 받아와서 테이블에서 delete 해주기
	@ResponseBody
	@GetMapping(value="/cancelReservationAjax.action", produces="text/plain;charset=UTF-8")
	public String cancelReservationAjax(HttpServletRequest request) {

		String rs_no = request.getParameter("rs_no");
		
		int n = 0;
		
		// 현재시간이 체크인시간 72시간 이전을 지났는지 확인하는 메소드
		int n1 = service.checkinTimeConfrim(rs_no);
		
		if(n1 > 0) {
			// 현재시간이 체크인시간 72시간 이전을 지나지 않은경우 취소상태로 업데이트 해주는 메소드
			int n2 = service.cancelReservation(rs_no);
			
			if(n2 > 0) {
				n = 1;
			}
		}
		
		JSONObject jsonObj = new JSONObject(); // {}
		jsonObj.put("n", n);
		

		return jsonObj.toString();
	}
	
	// 재훈 : 로그인 한 회원의 위시리스트를 가져오기
	@ResponseBody
	@GetMapping(value="/getWishListAjax.action", produces="text/plain;charset=UTF-8")
	public String getWishListAjax(HttpServletRequest request) {

		String userid = request.getParameter("userid");
		
		List<Map<String, String>> wishList = service.getWishList(userid);
		
		JSONArray jsonArr = new JSONArray(); // []
		
		for(Map<String, String> map : wishList) {
			JSONObject jsonObj = new JSONObject(); // {}
			jsonObj.put("lodge_id", map.get("lodge_id"));
			jsonObj.put("lg_name", map.get("lg_name"));
			jsonObj.put("min_price", map.get("min_price"));
			jsonObj.put("rating", map.get("rating"));
			jsonObj.put("review_cnt", map.get("review_cnt"));
			jsonObj.put("lg_img_save_name", map.get("lg_img_save_name"));
			
			jsonArr.put(jsonObj);
		}// end of for---------
		
		return jsonArr.toString();
	}
	
	
	// 재훈 : 숙소번호를 받아와서 테이블에서 delete 해주기
	@ResponseBody
	@GetMapping(value="/deleteWishlistAjax.action", produces="text/plain;charset=UTF-8")
	public String deleteWishlistAjax(HttpServletRequest request) {

		Map<String, String> paraMap = new HashMap<>();

		HttpSession session = request.getSession();
		UserVO loginuser = (UserVO) session.getAttribute("loginuser");

		paraMap.put("userid", loginuser.getUserid());
		paraMap.put("lodge_id", request.getParameter("lodge_id"));
		
		int n = service.deleteWishlist(paraMap);
		
		JSONObject jsonObj = new JSONObject(); // {}
		jsonObj.put("n", n);
		

		return jsonObj.toString();
	}
		
}
