package com.spring.app.wh.partner.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.common.AES256;
import com.spring.app.expedia.domain.HostVO;
import com.spring.app.wh.partner.model.PartnerDAO;

@Service
public class PartnerService_imple implements PartnerService {

	@Autowired
	private PartnerDAO dao;
	
	@Autowired
	private AES256 aES256;

	
	// 로그인 처리하기
	@Override
	public HostVO getLoginHost(Map<String, String> paraMap) {
		HostVO loginhost = dao.getLoginHost(paraMap);
		// System.out.println("확인용 : service loginhost : "+loginhost);
		// === #48. aes 의존객체를 사용하여 로그인 되어진 사용자(loginuser)의 이메일 값을 복호화 하도록 한다. === 
	    //          또한 암호변경 메시지와 휴면처리 유무 메시지를 띄우도록 업무처리를 하도록 한다.
		
		
		if(loginhost != null && loginhost.getH_pwdchangegap() >= 3 ) {
			// 마지막으로 암호를 변경한 날짜가 현재시각으로부터 3개월이 지났으면
			loginhost.setRequirePwdChange(true); // 로그인 시 암호를 변경하라는 alert 를 띄우도록 한다.
		}
		
		
		return loginhost;
	}

	// 회원가입 시 입력한 아이디 값이 기존에 가입한 회원에 존재하는지 확인해주는 메소드
	@Override
	public int idDuplicateCheck(String userid) {
		int isExists = dao.idDuplicateCheck(userid);
		return isExists;
	}
	
	
	
	// tbl_host 에 HostVO 에 저장된 정보를 insert 해주는 메소드
	@Override
	public int registerHost(HostVO host) {

		int n = dao.registerHost(host);
		return n;
	}

	
	// 월별 객실등급별 예약 인원 수 가져오기
	@Override
	public List<Map<String, String>> useLodgeCnt(Map<String, String> paraMap) {
		List<Map<String, String>> useLodgeCntList = dao.useLodgeCnt(paraMap);
		return useLodgeCntList;
	}

	
	// tbl_host 에 저장된 판매자의 정보를 update 해주는 메소드
	@Override
	public int editHost(Map<String, String> paraMap) {
		int n = dao.editHost(paraMap);
		return n;
	}

	

	
	


}