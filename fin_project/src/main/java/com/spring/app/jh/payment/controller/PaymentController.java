package com.spring.app.jh.payment.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.expedia.domain.UserVO;
import com.spring.app.jh.payment.service.PaymentService;


@Controller
public class PaymentController { 


	@Autowired  // Type에 따라 알아서 Bean 을 주입해준다.
	private PaymentService service;

	
	// 재훈 : 메인페이지
	@GetMapping("/payment/paymentConfirm.exp") 
	public ModelAndView index(ModelAndView mav, HttpServletRequest request) {
		
		String email = request.getParameter("email");
		
		HttpSession session = request.getSession();
		UserVO loginuser = (UserVO) session.getAttribute("loginuser");
		
		String loginuser_name = "";
		
		if (loginuser != null) {
			
			loginuser_name = loginuser.getName();
			
			// 예약테이블에 insert 할 정보를 받아와서 예약정보 insert 해주기
			// service.insertReservationInfo();
			
		}

		mav.addObject("loginuser_name",loginuser_name);
		mav.addObject("email",email);
		
		mav.setViewName("jh/payment/paymentConfirm.tiles1");
		
		return mav;
	}
	
		
}
