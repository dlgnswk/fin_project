package com.spring.app.jh.payment.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.jh.index.model.IndexDAO;


// ==== #31. Service 선언 ====
// 트랜잭션 처리를 담당하는 곳, 업무를 처리하는 곳, 비지니스(Business)단 
// @Component
@Service
public class PaymentService_imple implements PaymentService {

	
	
}
