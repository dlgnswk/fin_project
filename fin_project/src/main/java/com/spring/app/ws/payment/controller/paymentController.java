package com.spring.app.ws.payment.controller;

import java.time.LocalDateTime;
import java.time.Period;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.expedia.domain.LodgeVO;
import com.spring.app.expedia.domain.RoomVO;
import com.spring.app.expedia.domain.UserVO;
import com.spring.app.jy.user.controller.GoogleMail;
import com.spring.app.ws.payment.service.PaymentService;

@Controller
public class paymentController {
	
	@Autowired
	private PaymentService service;
	
	/*
	 * @GetMapping(value="/payment/payment.exp") public ModelAndView
	 * searchUser(ModelAndView mav, HttpServletRequest request) {
	 * 
	 * mav.setViewName("ws/payment/payment.tiles1");
	 * 
	 * return mav; }
	 */
	
	
	// 결제페이지
	@GetMapping(value="/payment/payment.exp") 
	public ModelAndView requiredLogin_searchUser(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		// 받을 값들
		String startDate = "2024-01-31"; //startDate
		String endDate = "2024-02-02"; // endDate
		String payType = "0";
	//  String payType = "1";
		String rm_seq = "rm-33";
		String h_userid = "p-city@paradian.com";
		String guest_cnt = "2"; // ttl_guest_cnt
		
		String str_inYear = startDate.substring(0, 4);
		String str_inMonth = startDate.substring(5, 7);
		String str_inDay = startDate.substring(8, 10);
		
		String str_outYear = endDate.substring(0, 4);
		String str_outMonth = endDate.substring(5, 7);
		String str_outDay = endDate.substring(8, 10);
		
		int inYear = Integer.parseInt(startDate.substring(0, 4));
		int inMonth = Integer.parseInt(startDate.substring(5, 7));
		int inDay = Integer.parseInt(startDate.substring(8, 10));
		
		int outYear = Integer.parseInt(endDate.substring(0, 4));
		int outMonth = Integer.parseInt(endDate.substring(5, 7));
		int outDay = Integer.parseInt(endDate.substring(8, 10));
		
		
		// 날짜 차이 구하기
		LocalDateTime startDT = LocalDateTime.of(inYear, inMonth, inDay, 0, 0);
		LocalDateTime endDT = LocalDateTime.of(outYear, outMonth, outDay, 0, 0);
		 
		//System.out.println("시작일: " + startDT.toLocalDate());
		//System.out.println("종료일: " + endDT.toLocalDate());

		Period diff = Period.between(startDT.toLocalDate(), endDT.toLocalDate());

		//System.out.printf("두 날짜 사이 기간: %d년 %d월 %d일", diff.getYears(), diff.getMonths(), diff.getDays());
		
		int monthToDay = 0;
		
		if(diff.getMonths() == 2) {
			monthToDay = 29;
		}
		else if(diff.getMonths() == 4 && diff.getMonths() == 6 &&
				diff.getMonths() == 9 && diff.getMonths() == 11 ) {
			monthToDay = 30;
		}
		else if(diff.getMonths() == 0) {
			monthToDay = 0;
		}
		else {
			monthToDay = 31;
		}
		
		int daysGap = 365 * diff.getYears() + monthToDay * diff.getMonths() + diff.getDays();
		String str_daysGap = Integer.toString(daysGap);		
		
		// 객실요금, 객실정보(인원,침대,개수,흡연유무), 객실이름 불러오기
		List<RoomVO> roomInfoList = service.getRoomInfo(rm_seq);
		
		// 취소정책 불러오기
		List<LodgeVO> lodgeInfo = service.getLodgeInfo(h_userid);
				
		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("payType",payType);
		paraMap.put("rm_seq",rm_seq); 
		paraMap.put("h_userid",h_userid);
		paraMap.put("guest_cnt",guest_cnt);
		paraMap.put("startDate",startDate);
		paraMap.put("endDate",endDate);
		paraMap.put("inYear",str_inYear);
		paraMap.put("inMonth",str_inMonth);
		paraMap.put("inDay",str_inDay);
		paraMap.put("outYear",str_outYear);
		paraMap.put("outMonth",str_outMonth);
		paraMap.put("outDay",str_outDay);
		paraMap.put("daysGap",str_daysGap);
		
		HttpSession session = request.getSession();
		UserVO loginuser = (UserVO) session.getAttribute("loginuser");
		if(loginuser == null ) {
			System.out.println("loginuser가 null");
		}
		else {
			System.out.println("loginuser가 null이 아님");
		}
		
		// 원석 개발전용 회원의 정보를 가져온다.
		String myUser = loginuser.getUserid();
		List<UserVO> myUserInfo = service.getMyUserInfo(myUser);
		
		
		// 원석 개발전용 취소정책 날짜 계산 정보 가져오기
		List<Map<String,String>> cancelDateInfo = service.getCancelDateInfo(paraMap);
		
		for(Map<String,String> map:cancelDateInfo) {
			System.out.println(map.get("currentTime"));
			System.out.println(map.get("B_1"));
			System.out.println(map.get("B_24"));
			System.out.println(map.get("B_48"));
			System.out.println(map.get("B_72"));
			System.out.println(map.get("checkout_time"));
		}
		
		
		mav.addObject("cancelDateInfo",cancelDateInfo);
		
		mav.addObject("daysGap",daysGap);
		mav.addObject("paraMap", paraMap);
		mav.addObject("myUserInfo", myUserInfo);
		mav.addObject("roomInfoList", roomInfoList);
		mav.addObject("lodgeInfo", lodgeInfo);
		
		mav.setViewName("ws/payment/payment.tiles1");
		
		return mav;
	}
	
	
	
	
	
	// 결제하기
	@PostMapping(value="/payment/paymentEnd.exp") 
	public ModelAndView paymentEnd(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String userid = request.getParameter("userid");
		String mobile = request.getParameter("mobile");
		String email = request.getParameter("email");

		// 원포트(구 아임포트) 결제창을 하기 위한 전제조건은 먼저 로그인을 해야 하는 것이다.
		if(userid != null) {
			// 로그인을 했으면
			
			HttpSession session = request.getSession();
			UserVO loginuser = (UserVO) session.getAttribute("loginuser");
			
			if(loginuser.getUserid().equals(userid)){
				
				String price = request.getParameter("price");
				
				Map<String,String> paraMap = new HashMap<>();
				paraMap.put("userid",userid);
				paraMap.put("price",price);
				paraMap.put("mobile",mobile);
				paraMap.put("email",email);

				mav.addObject("paraMap", paraMap);
				// super.setRedirect(false);
				mav.setViewName("paymentGateway");
			}
			
		}
		else {
			// 로그인을 안 했으면
			String message = "로그인 없이 결제는 불가능합니다!!";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);

			mav.setViewName("msg");
			// /WEB-INF/views/msg.jsp 파일을 생성한다
			}
		return mav;
	}
	
	
	@ResponseBody
    @GetMapping(value = "/payment/reservation.exp", produces = "text/plain;charset=UTF-8")
	public String goReservation(HttpServletRequest request) {
		
		String userid = request.getParameter("userid");
		String name = request.getParameter("name");
		String mobile = request.getParameter("mobile");
		String email = request.getParameter("email");
		String point = request.getParameter("point");
		String to_insert_point = request.getParameter("to_insert_point");
		String used_point = request.getParameter("used_point");
		String rm_seq = request.getParameter("rm_seq");
		String total__price = request.getParameter("total__price");
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");	
		String h_userid = request.getParameter("h_userid");
		String paytype = request.getParameter("paytype");
		String guest_cnt = request.getParameter("guest_cnt");
		
		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("userid",userid);
		paraMap.put("h_userid",h_userid);
		paraMap.put("startDate",startDate);
		paraMap.put("endDate",endDate);
		paraMap.put("total__price",total__price);
		paraMap.put("paytype",paytype);
		paraMap.put("name",name);
		paraMap.put("mobile",mobile);
		paraMap.put("email",email);
		paraMap.put("guest_cnt",guest_cnt);
		paraMap.put("rm_seq",rm_seq);
		
		paraMap.put("point",point);
		paraMap.put("to_insert_point",to_insert_point);
		
		
		int p = 0;
		if(point == "") {
			// 선할인포인트를 사용한 경우 보유포인트만 변동
			System.out.println("할인입니다.");
			if(used_point != "") {
				// 선할인을 받은 상태로 보유포인트만 update하기
				p = service.updateSaleMyPoint(paraMap);
			}
		}
		else {
			// 선할인포인트를 사용하지 않은 경우 포인트 적립 + 보유 포인트 변동
			System.out.println("적립입니다.");

			if(used_point != "") {
				// 적립을 한 상태로 보유포인트 update하기
				p = service.updateMyPoint(paraMap);
			}
			else {
				// 포인트만 update하기
				p = service.updateUsedPoint(paraMap);
			}
		}
		
		if(p==0) {
			System.out.println("적립에 실패했습니다.");
		}
		
		
		// 결제 후, reservation 테이블에 insert 하기
		int n = service.goReservation(paraMap);
		  
		JSONObject jsonObj = new JSONObject(); jsonObj.put("n", n);
		 
		
		return jsonObj.toString();
	}
	
	
	
	
	/*
	 * @GetMapping(value="/payment/paymentConfirm.exp") public ModelAndView
	 * paymentConfirm(HttpServletRequest request, HttpServletResponse response,
	 * ModelAndView mav) { System.out.println("메일보내기 시작"); GoogleMail mail = new
	 * GoogleMail();
	 * 
	 * 
	 * 
	 * 
	 * 
	 * 
	 * 
	 * mav.setViewName("ws/payment/mailTest.tiles1");
	 * 
	 * return mav; }
	 */
	
	
	
	@RequestMapping(value="/payment/mailTest.exp")
	public ModelAndView mailTest(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		System.out.println("왜안옴?");
		
		String userid = request.getParameter("userid");
		String name = request.getParameter("name");
		String mobile = request.getParameter("mobile");
		String email = request.getParameter("email");
		String point = request.getParameter("point");
		String to_insert_point = request.getParameter("to_insert_point");
		String used_point = request.getParameter("used_point");
		String rm_seq = request.getParameter("rm_seq");
		String total__price = request.getParameter("total__price");
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");	
		String h_userid = request.getParameter("h_userid");
		String paytype = request.getParameter("paytype");
		String guest_cnt = request.getParameter("guest_cnt");
		
		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("userid",userid);
		paraMap.put("h_userid",h_userid);
		paraMap.put("startDate",startDate);
		paraMap.put("endDate",endDate);
		paraMap.put("total__price",total__price);
		paraMap.put("paytype",paytype);
		paraMap.put("name",name);
		paraMap.put("mobile",mobile);
		paraMap.put("email",email);
		paraMap.put("guest_cnt",guest_cnt);
		paraMap.put("rm_seq",rm_seq);
		
		paraMap.put("point",point);
		paraMap.put("to_insert_point",to_insert_point);
		
		System.out.println(guest_cnt);
		
		mav.setViewName("ws/payment/mailTest.tiles1");
		
		return mav;
	}
	
}
