package com.spring.app.ws.payment.controller;

import java.text.DecimalFormat;
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
import com.spring.app.expedia.domain.ReservationVO;
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
	@RequestMapping(value = "/payment/payment.exp")
	public ModelAndView requiredLogin_searchUser(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		String payType = request.getParameter("payType");
		String rm_seq = request.getParameter("rm_seq");
		String h_userid = request.getParameter("h_userid");
		String guest_cnt = request.getParameter("ttl_guest_cnt");
		String lodge_id = request.getParameter("lodge_id");
		
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

		// System.out.println("시작일: " + startDT.toLocalDate());
		// System.out.println("종료일: " + endDT.toLocalDate());

		Period diff = Period.between(startDT.toLocalDate(), endDT.toLocalDate());

		// System.out.printf("두 날짜 사이 기간: %d년 %d월 %d일", diff.getYears(),
		// diff.getMonths(), diff.getDays());

		int monthToDay = 0;

		if (diff.getMonths() == 2) {
			monthToDay = 29;
		} else if (diff.getMonths() == 4 && diff.getMonths() == 6 && diff.getMonths() == 9 && diff.getMonths() == 11) {
			monthToDay = 30;
		} else if (diff.getMonths() == 0) {
			monthToDay = 0;
		} else {
			monthToDay = 31;
		}

		int daysGap = 365 * diff.getYears() + monthToDay * diff.getMonths() + diff.getDays();
		String str_daysGap = Integer.toString(daysGap);

		// 객실요금, 객실정보(인원,침대,개수,흡연유무), 객실이름 불러오기
		List<RoomVO> roomInfoList = service.getRoomInfo(rm_seq);

		// 취소정책 불러오기
		List<LodgeVO> lodgeInfo = service.getLodgeInfo(h_userid);

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("payType", payType);
		paraMap.put("rm_seq", rm_seq);
		paraMap.put("h_userid", h_userid);
		paraMap.put("guest_cnt", guest_cnt);
		paraMap.put("startDate", startDate);
		paraMap.put("endDate", endDate);
		paraMap.put("inYear", str_inYear);
		paraMap.put("inMonth", str_inMonth);
		paraMap.put("inDay", str_inDay);
		paraMap.put("outYear", str_outYear);
		paraMap.put("outMonth", str_outMonth);
		paraMap.put("outDay", str_outDay);
		paraMap.put("daysGap", str_daysGap);

		HttpSession session = request.getSession();
		UserVO loginuser = (UserVO) session.getAttribute("loginuser");
		if (loginuser == null) {
			System.out.println("loginuser가 null");
		} else {
			System.out.println("loginuser가 null이 아님");
		}

		// 원석 개발전용 회원의 정보를 가져온다.
		String myUser = loginuser.getUserid();
		List<UserVO> myUserInfo = service.getMyUserInfo(myUser);

		// 원석 개발전용 취소정책 날짜 계산 정보 가져오기
		List<Map<String, String>> cancelDateInfo = service.getCancelDateInfo(paraMap);
		
		// 숙박업소 별 후기 가져오기
		List<Map<String, String>> lodgeReviewList = service.getLodgeReview(lodge_id);
		
		// 룸 이미지 이름 불러오기
		List<Map<String, String>> Rm_saveImg = service.getRm_saveImg(rm_seq);
		
		/*
		 * for (Map<String, String> map : cancelDateInfo) {
		 * System.out.println(map.get("currentTime"));
		 * System.out.println(map.get("B_1")); System.out.println(map.get("B_24"));
		 * System.out.println(map.get("B_48")); System.out.println(map.get("B_72"));
		 * System.out.println(map.get("checkout_time"));
		 * System.out.println(map.get("checkin_time")); }
		 */

		mav.addObject("cancelDateInfo", cancelDateInfo);
		mav.addObject("Rm_saveImg", Rm_saveImg);
		mav.addObject("daysGap", daysGap);
		mav.addObject("paraMap", paraMap);
		mav.addObject("myUserInfo", myUserInfo);
		mav.addObject("roomInfoList", roomInfoList);
		mav.addObject("lodgeInfo", lodgeInfo);
		mav.addObject("lodgeReviewList", lodgeReviewList);
		
		mav.setViewName("ws/payment/payment.tiles1");

		return mav;
	}

	// 결제하기
	@PostMapping(value = "/payment/paymentEnd.exp")
	public ModelAndView paymentEnd(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {

		String userid = request.getParameter("userid");
		String mobile = request.getParameter("mobile");
		String email = request.getParameter("email");

		// 원포트(구 아임포트) 결제창을 하기 위한 전제조건은 먼저 로그인을 해야 하는 것이다.
		if (userid != null) {
			// 로그인을 했으면

			HttpSession session = request.getSession();
			UserVO loginuser = (UserVO) session.getAttribute("loginuser");

			if (loginuser.getUserid().equals(userid)) {

				String price = request.getParameter("price");

				Map<String, String> paraMap = new HashMap<>();
				paraMap.put("userid", userid);
				paraMap.put("price", price);
				paraMap.put("mobile", mobile);
				paraMap.put("email", email);

				mav.addObject("paraMap", paraMap);
				// super.setRedirect(false);
				mav.setViewName("paymentGateway");
			}

		} else {
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

	
	
	// tbl_user에서 포인트 변경 + tbl_reservation에 insert + 결제후 이메일 보내기
	@ResponseBody
	@GetMapping(value = "/payment/reservation.exp", produces = "text/plain;charset=UTF-8")
	public String goReservation(HttpServletRequest request, ModelAndView mav) {

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
		String currentTimeD = request.getParameter("currentTimeD");
		String checkinTime = request.getParameter("checkinTime");
		String checkoutTime = request.getParameter("checkoutTime");

		
		// 소수점 없애기 시작 ===========================================
		if(point != "") {
			System.out.println("포인트 받자");
			double db_point = Double.parseDouble(point);
			db_point = Math.ceil(db_point);
			point = Double.toString(db_point);
			System.out.println(point);
		}
		
		if(to_insert_point != "") {
			System.out.println("포인트 쓰자");
			double db_to_insert_point = Double.parseDouble(to_insert_point);
			db_to_insert_point = Math.ceil(db_to_insert_point);
			to_insert_point = Double.toString(db_to_insert_point);
			System.out.println(to_insert_point);
		}
		
		
		double db_totalPrice = Double.parseDouble(total__price);
		db_totalPrice = Math.ceil(db_totalPrice);
		total__price = Double.toString(db_totalPrice);
		// 소수점 없애기 끝 ===========================================
		
		// decimalformat을 위한 double 타입을 int로 바꾸기
		int i_totalPrice = (int)db_totalPrice;
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		paraMap.put("h_userid", h_userid);
		paraMap.put("startDate", startDate);
		paraMap.put("endDate", endDate);
		paraMap.put("total__price", total__price);
		paraMap.put("paytype", paytype);
		paraMap.put("name", name);
		paraMap.put("mobile", mobile);
		paraMap.put("email", email);
		paraMap.put("guest_cnt", guest_cnt);
		paraMap.put("rm_seq", rm_seq);

		paraMap.put("used_point", used_point);
		paraMap.put("point", point);
		paraMap.put("to_insert_point", to_insert_point);

		int p = 0;
		
		
		// reservation 테이블에 insert 하기
		int a = service.goReservation(paraMap);
		
		
		// reservation 테이블에서 방금 예약한 rs_seq 불러오기
		List<ReservationVO> getRsSeqNo = service.getRsSeqNo();
		
		String rs_seq = "";
		
		for(ReservationVO rvo:getRsSeqNo) {
			rs_seq = rvo.getRs_seq();
		}
		
		paraMap.put("rs_seq", rs_seq);
				
		int s = 0;
		
		System.out.println("rs_seq => " + rs_seq);
		System.out.println("userid => " + userid);
		
		if(a==1) {
		
			if ("".equals(point)) {
				// 선할인포인트를 사용한 경우 보유포인트만 변동
				System.out.println("할인입니다.");
				if (used_point != "") {
					// 선할인을 받은 상태로 보유포인트만 update하기
					p = service.updateSaleMyPoint(paraMap);
					
					// rs_seq를 가져와서 tbl_point에 insert 하기  (-사용한 point)
					s = service.updateTblPointA1(paraMap);
				}
			} else {
				// 선할인포인트를 사용하지 않은 경우 포인트 적립 + 보유 포인트 변동
				System.out.println("적립입니다.");
	
				if (used_point != "") {
					// 적립을 한 상태로 point,used_point update하기
					p = service.updateMyPoint(paraMap);
					
					// rs_seq를 가져와서 tbl_point에 insert 하기  (+point - 사용한 point)
					s = service.updateTblPointB1(paraMap);
					
				} else {
					// 적립만 update하기
					p = service.updateUsedPoint(paraMap);
					
					// rs_seq를 가져와서 tbl_point에 insert 하기  (+point만넣기)
					s = service.updateTblPointB2(paraMap);
				}
			}
	
			if (p == 0) {
				System.out.println("적립에 실패했습니다.");
			}
		
		}
		else {
			System.out.println("예약에 실패했습니다.");
		}

		System.out.println("메일...");
		// 메일 보내기 시작=====================================================
		
		
		// 숙박업소명 읽어오기
		List<LodgeVO> lodgeInfo = service.getLodgeInfo(h_userid);
		
		String lodgeName = "";
		String lg_address = "";
		
		for(LodgeVO lvo : lodgeInfo) {
			lodgeName = lvo.getLg_name();
			lg_address = lvo.getLg_address();
		}
		
		DecimalFormat decFormat = new DecimalFormat("###,###");
		
		String totalPrice = decFormat.format(i_totalPrice);
		
		GoogleMail mail = new GoogleMail();
		
		String contents = "	<div style='background-color:#f5f5f5;border:solid 1px black;margin:0 auto;width:375px;padding:13px;height:100vh'>" +
						  "		<div style='font-family:'roboto' , 'arial' , sans-serif;color:#000000;background-color:#ffffff'>" + 
				          "			<div style='padding:32px;border-bottom:1px solid #c7c7c7'><img src='https://www.expedia.com/_dms/header/logo.png?locale=en_GB&amp;siteid=27&amp;2' height='30' loading='lazy'>" + 
				          "			</div>" + 
				          "			<div style='font-weight:400;font-size:16px;line-height:20px;color:#343b53;padding:24px 0'><h3>고객님께서 결제하신 내역입니다.</h3></div>" + 
				          "			<div style='font-weight:400;line-height:20px;color:#343b53;'><h4 style=\"font-weight:bold;\">" + lodgeName + "</h4></div>" + 
				          "			<div style='font-weight:500;font-size:13px;line-height:20px;color:#141d38'>" + 
				          "				<span style=\"color:#9b969c;\">" + lg_address + "</span>" + 
				          "			</div>" + 
				          "			<hr style=\"border-bottom:1px solid #c9c9c9\">" + 
				          "			<div style='background-color:white; font-weight:400;font-size:14px;line-height:18px;margin-top:30px;padding:16px 20px 16px;color:#343b53;border:2px solid #a2576a;'>" + 
				          "				<div style=\"font-weight:bold;\">결제정보</div>" + 
					      "				<hr style=\"border:1px solid #c7c7c7\">" + 
					      "				<div style=\"padding:3px 0 3px 0;\">예약자명<span style=\"float:right;\">" + name + "</span></div>" + 
					      "				<div style=\"padding:3px 0 3px 0;\">예약일시<span style=\"float:right;\">" + currentTimeD + "</span></div>" + 
					      "				<div style=\"padding:3px 0 3px 0;\">결제금액<span style=\"float:right;\">" + totalPrice + "</span></div>" + 
				          "			</div>" + 
				          "			<br>" + 
				          "			<div style='background-color:white; font-weight:400;font-size:14px;line-height:18px;margin-top:10px; padding:16px 20px 16px;color:#343b53;border:2px solid #a2576a;'>" + 
				          "				<div style=\"font-weight:bold;\">객실정보</div>" + 
				          "				<hr style=\"border:1px solid #c7c7c7\">" + 
				          "				<div style=\"padding:3px 0 3px 0;\">객실타입<span style=\"float:right;\">" + currentTimeD + "</span></div>" + 
				          "				<div style=\"padding:3px 0 3px 0;\">입실시간<span style=\"float:right;\">" + startDate + " " + checkinTime + "</span></div>" + 
				          "				<div style=\"padding:3px 0 3px 0;\">퇴실시간<span style=\"float:right;\">" + endDate + " " + checkoutTime + "</span></div>" + 
				          "				<div style=\"padding:3px 0 3px 0;\">투숙일수<span style=\"float:right;\">" + currentTimeD + "</span></div>" + 
				          "			</div>" + 
				          "		</div>" + 
				          "	</div>";
		
		String subject = " [Expedia] " + lodgeName + " 에서 " + userid + " 님이 결제하신 예약내역을 보내드립니다. ";

		paraMap.put("contents", contents);
		paraMap.put("subject", subject);
		
		
		try {
			mail.send_certification_code(paraMap);
			
		} catch (Exception e) {
			// 메일 전송이 실패한 경우
			e.printStackTrace();
			
			String message = "서버 오류로 인해 메일 전송이 실패했습니다. 1분 후 재시도 해주세요.";
			String loc ="javascript:history.back()";
			
			mav.addObject("message",message);
			mav.addObject("loc",loc);
			
			mav.setViewName("msg");
		}
		
		int n = 1;
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);

		return jsonObj.toString();
	}
	 
	 
	// 결제 완료창으로 email 보내기
	@RequestMapping(value = "payment/paymentConfirm.exp")
	public ModelAndView paymentConfirm(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String email = request.getParameter("email");
		// System.out.println(email);
		
		mav.addObject("email",email);
		mav.setViewName("jh/payment/paymentConfirm.tiles1");

		return mav;
	}

}
