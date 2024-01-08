package com.spring.app.jy.user.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

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

import com.google.gson.JsonObject;
import com.spring.app.common.AES256;
import com.spring.app.common.Sha256;
import com.spring.app.expedia.domain.UserVO;
import com.spring.app.jy.user.service.UserService;


@Controller
public class UserController {
	
	@Autowired
	private UserService service;
	
	// ==== #40. 로그인 폼 페이지 요청 ==== //
	@GetMapping("/login.exp")
	public ModelAndView login(ModelAndView mav) {

		mav.setViewName("jy/user/loginForm.tiles1");
		// /WEB-INF/views/tiles1/jy/login/loginform.jsp 파일을 생성한다.

		return mav;
	}

	// ==== #41. 로그인 처리하기 ==== //
	@PostMapping("/loginEnd.exp")
	public ModelAndView loginEnd(ModelAndView mav, HttpServletRequest request) {

		String userid = request.getParameter("userid");
		String pw = request.getParameter("pw");

		UserVO loginuser = service.getLoginUser(userid);

		if (loginuser == null) { // 가입된 이메일(아이디)이 존재하지 않는 경우
			String message = "등록된 회원이 없습니다.\\n회원가입을 하시겠습니까?.";
			String loc = request.getContextPath() + "/login_regFrm.exp";

			mav.addObject("message", message);
			mav.addObject("loc", loc);

			mav.setViewName("jy/confirm.tiles1");
		}
		
		else if (loginuser != null && loginuser.getIdle() == -1) {
			String message = "탈퇴된 회원입니다.\\n다른 이메일로 회원가입을 하시겠습니까?.";
			String loc = request.getContextPath() + "/login_regFrm.exp";

			mav.addObject("message", message);
			mav.addObject("loc", loc);

			mav.setViewName("jy/confirm.tiles1");
		}

		else { // 가입된 이메일(아이디)이 존재하고 탈퇴처리가 되지 않은 경우

			if (pw != null && !Sha256.encrypt(pw).equals(loginuser.getPw())) { // 로그인 실패 시
				String message = "아이디 또는 암호가 틀립니다";
				// String loc = "javascript:history.back()";
				String loc = request.getHeader("referer");
				// request.getHeader("referer"); 은 이전 페이지의 URL을 가져오는 것이다.
				// String loc = request.getHeader("referer");

				mav.addObject("message", message);
				mav.addObject("loc", loc);

				mav.setViewName("msg");
				// /WEB-INF/views/msg.jsp 파일을 생성한다
			} 
			else if (loginuser.getIdle() == 0) { // 아이디와 비밀번호가 일치 할때  // 로그인 한지 1년이 경과한 경우
				
				mav.addObject("loginuser",loginuser);
				
				String message = "로그인을 한지 1년이 지나서 휴면상태로 되었습니다.\\n휴면계정을 풀기위한 페이지로 이동합니다.";
				String loc = request.getContextPath() + "/idle.exp";
				
				mav.addObject("message", message);
				mav.addObject("loc", loc);

				mav.setViewName("msg");
			}
			else { //
				
				HttpSession session = request.getSession();
				// 메모리에 생성되어져 있는 session 을 불러온다.
				session.setAttribute("loginuser", loginuser);
				// session(세션)에 로그인 되어진 사용자 정보인 loginuser 을 키이름을 "loginuser" 으로 저장시켜두는 것이다.

				if (loginuser.isRequirePwdChange() == true) { // 암호를 마지막으로 변경한 것이 3개월 이상이 경과한 경우

					String message = "비밀번호를 변경하신지 3개월이 지났습니다.\\n암호를 변경하시는 것을 추천합니다.";
					String loc = request.getContextPath() + "/index.exp";

					mav.addObject("message", message);
					mav.addObject("loc", loc);

					mav.setViewName("msg");

				} else { // 암호를 마지막으로 변경한 것이 3개월 이내인 경우

					// 로그인을 해야만 접근할 수 있는 페이지에 로그인을 하지 않은 상태에서 접근을 시도한 경우
					// "먼저 로그인을 하세요!!" 라는 메시지를 받고서 사용자가 로그인을 성공했다라면
					// 화면에 보여주는 페이지는 시작페이지로 가는 것이 아니라
					// 조금전 사용자가 시도하였던 로그인을 해야만 접근할 수 있는 페이지로 가기 위한 것이다.
					String goBackURL = (String) session.getAttribute("goBackURL");

					if (goBackURL != null) {
						mav.setViewName("redirect:" + goBackURL);
						session.removeAttribute("goBackURL"); // 세션에서 반드시 제거해주어야 한다.
					} else {
						mav.setViewName("redirect:/index.exp"); // 시작페이지로 이동
					}
				}
			}

		}

		return mav;

	}// end of public ModelAndView loginEnd(ModelAndView mav, HttpServletRequest request) {})---------
	
	// 로그아웃 처리하기
	@GetMapping("/logout.exp")
	public ModelAndView logout(ModelAndView mav, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginuser")!=null) {// 로그인된 상태라면 세션 초기화 후 메인 페이지로 이동
			session.invalidate(); // 세션 초기화~
			   
			String message ="로그아웃 되었습니다.";
			String loc = request.getContextPath()+"/index.exp";
		   
			mav.addObject("message",message);
			mav.addObject("loc",loc);
		   
			mav.setViewName("msg");
		}
		else { // 로그인된 상태가 아니라면 메인 페이지로 이동
			String message ="로그인된 상태가 아닙니다.";
			String loc = request.getContextPath()+"/index.exp";
		   
			mav.addObject("message",message);
			mav.addObject("loc",loc);
		   
			mav.setViewName("msg");
		}
		
		return mav;
	}// end of public ModelAndView logout(ModelAndView mav, HttpServletRequest request) {}--------
	
	// 회원가입 폼 페이지로 이동
	@GetMapping("/login_regFrm.exp")
	public ModelAndView loginRegister(ModelAndView mav) {
		mav.setViewName("jy/user/login_regFrm.tiles1");
		return mav;
	}
	
	// 계정 삭제
	@GetMapping("/account/user_delete.exp")
	public ModelAndView requiredLogin_user_delete(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		UserVO loginuser = (UserVO) session.getAttribute("loginuser");
		
		if(request.getParameter("userid") !=null && request.getParameter("userid").equals(loginuser.getUserid())) {
			String message ="올바른 접근이 아닙니다.";
			String loc = request.getContextPath()+"/index.exp";
		   
			mav.addObject("message",message);
			mav.addObject("loc",loc);
		   
			mav.setViewName("msg");
		}
		else {
			mav.setViewName("jy/user/user_delete.tiles1");
		}
		
		return mav;
	}
	
	
	// 계정 삭제 처리
	@PostMapping("/account/user_deleteEnd.exp")
	public ModelAndView requiredLogin_user_deleteEnd(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		UserVO loginuser = (UserVO) session.getAttribute("loginuser");
		String userid = loginuser.getUserid();
		
		String tooManyEmail = request.getParameter("tooManyEmail");
		String haveOtherAccount = request.getParameter("haveOtherAccount");
		String endTrip = request.getParameter("endTrip");
		String badRsvExp = request.getParameter("badRsvExp");
		String etc = request.getParameter("etc");
		
		if(tooManyEmail == null) {
			tooManyEmail = "0";
		}
		if(haveOtherAccount == null) {
			haveOtherAccount = "0";
		}
		if(endTrip == null) {
			endTrip = "0";
		}
		if(badRsvExp == null) {
			badRsvExp = "0";
		}
		if(etc == null) {
			etc = "0";
		}
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		paraMap.put("tooManyEmail", tooManyEmail);
		paraMap.put("haveOtherAccount", haveOtherAccount);
		paraMap.put("endTrip", endTrip);
		paraMap.put("badRsvExp", badRsvExp);
		paraMap.put("etc", etc);
		
		int n1 = service.deleteUserAccount(userid);
		int n2 = service.insertDeleteReason(paraMap);
		if (n1 == 1) {
			
			session.invalidate(); // 세션 초기화~
			String message = "계정 삭제가 완료되었습니다.";
			String loc = request.getContextPath() + "/index.exp";

			mav.addObject("message", message);
			mav.addObject("loc", loc);

			mav.setViewName("msg");
		}
		
		
		
		return mav;
	}
	
	
	// PostMapping 으로 바꿔야함!!
	@PostMapping("/login_regSendCode.exp")
	public ModelAndView loginRegister(ModelAndView mav, HttpServletRequest request) {
		
		String userid = "";
		HttpSession session = request.getSession();
		UserVO s_loginuser = (UserVO) session.getAttribute("loginuser");
		if( s_loginuser == null) { // 로그인 하지 않은 상태에서 들어왔을 때(회원가입)
			userid = request.getParameter("userid");
			mav.addObject("userid_noExist",userid);
		}
		else { // 로그인 한 상태에서 들어왔을 때는 세션에서 가져온 id를 넘겨줌(비밀번호 변경)
			userid = s_loginuser.getUserid();
			mav.addObject("userid_isExist",userid);
		}
		UserVO loginuser = service.getLoginUser(userid);

		if( loginuser != null && loginuser.getIdle() == -1 ) { // 탈퇴된 회원 일때엔 회원가입 불가
			
			String message = "탈퇴한 회원은 재가입이 불가능 합니다.\n다른 이메일로 가입해주세요.";
			String loc ="javascript:history.back()";
			
			mav.addObject("message",message);
			mav.addObject("loc",loc);
			
			mav.setViewName("msg");	
		}
		else {
			// 인증키를 랜덤하게 생성하도록 한다.
			Random rnd = new Random();
			String certification_code = "";

			// 인증키는 숫자 6글자 로 만들겠습니다.
			int randnum = 0;
			for (int i = 0; i < 6; i++) {
				randnum = rnd.nextInt(9 - 0 + 1) + 0;
				certification_code += randnum;
			} // end of for---------------------

			GoogleMail mail = new GoogleMail();

			String contents = "<div style='background-color:#f5f5f5;margin:0 auto;width:375px;padding:13px;height:100vh'>"
							+ "  <div style='font-family:'roboto' , 'arial' , sans-serif;color:#000000;background-color:#ffffff'>"
							+ "    <div style='padding:32px;border-bottom:1px solid #c7c7c7'><img src='https://www.expedia.com/_dms/header/logo.png?locale=en_GB&amp;siteid=27&amp;2' height='30' loading='lazy'>"
							+ "    </div>"
							+ "    <div style='font-weight:400;font-size:16px;line-height:20px;color:#343b53;padding:24px 32px 0'>안녕하세요,</div>"
							+ "    <div style='font-weight:400;font-size:16px;line-height:20px;color:#343b53;padding:24px 32px 0'>보안 코드는 15분 후 만료됩니다.</div>"
							+ "    <div style='font-weight:500;font-size:24px;line-height:28px;padding:8px 32px 0;color:#141d38'>"
							+ "			<span style='font-weight:bold'>"+ certification_code + "</span>"
							+ "    </div>"
							+ "    <div style='font-weight:400;font-size:14px;line-height:18px;padding:16px 32px 307px;color:#343b53'>이 코드를 공유하거나 이메일을 전달하지 말아 주세요. 요청하신 적이 없으면 이 메일을 무시하시면 됩니다.</div>"
							+ "  </div>"
							+ "</div>";
			String subject = " [Expedia] " + certification_code + " 보안 로그인 코드입니다. ";
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("email", userid);
			paraMap.put("contents", contents);
			paraMap.put("subject", subject);

			try {
				// mail.send_certification_code(paraMap); // 주석풀어야함
				session.setAttribute("certification_code", certification_code); // 세션에 저장
				System.out.println("certification_code"+certification_code);
				if (loginuser != null) { // 회원가입
					mav.addObject("loginuser",loginuser);
				}
				else {
					mav.addObject("userid",userid);
				}
				
				mav.setViewName("jy/user/login_code.tiles1");
				
				
			} catch (Exception e) {
				// 메일 전송이 실패한 경우
				e.printStackTrace();
				
				String message = "서버 오류로 인해 메일 전송이 실패했습니다. 1분 후 재시도 해주세요.";
				String loc ="javascript:history.back()";
				
				mav.addObject("message",message);
				mav.addObject("loc",loc);
				
				mav.setViewName("jy/user/login_code.tiles1");
			}
		}
		
		return mav;

	}
	
	// @PostMapping("/user_EditPwFrm.exp")
	@PostMapping("/user_EditPwFrm.exp")
	public ModelAndView user_EditPwFrm(ModelAndView mav, HttpServletRequest request) {
		
		String userid_noExist = request.getParameter("userid_noExist");
		String userid_isExist = request.getParameter("userid_isExist");
		
		mav.addObject("userid_noExist",userid_noExist);
		mav.addObject("userid_isExist",userid_isExist);
		
		// 비밀번호 입력 페이지로 이동
		mav.setViewName("jy/user/user_editPwFrm.tiles1");
		
		return mav;
	}
	
	// @PostMapping("/user_EditPwEnd.exp")
	@PostMapping("/user_EditPwEnd.exp")
	public ModelAndView user_EditPwEnd(ModelAndView mav, HttpServletRequest request) {
	
		String pw = request.getParameter("pw");
		String userid_noExist = request.getParameter("userid_noExist");
		String userid_isExist = request.getParameter("userid_isExist");
		if(userid_noExist == null) {
			userid_noExist = "";
		}
		if(userid_isExist == null) {
			userid_isExist = "";
		}
		if(pw != null) {
			pw = Sha256.encrypt(request.getParameter("pw"));
		}
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("pw", pw);
		paraMap.put("userid_noExist", userid_noExist);
		paraMap.put("userid_isExist", userid_isExist);
		
		// userid_isExist 가 넘어올 경우 비밀번호 업데이트 후 index.exp 로 이동
		if(userid_isExist != "") {
			
			int n1 = service.updateUser_pw(paraMap);
			
			if(n1==1) {
				
				// 로그인 처리 
				UserVO loginuser = service.getLoginUser(userid_isExist);
				HttpSession session = request.getSession();
				// 메모리에 생성되어져 있는 session 을 불러온다.
				session.setAttribute("loginuser", loginuser);
				// session(세션)에 로그인 되어진 사용자 정보인 loginuser 을 키이름을 "loginuser" 으로 저장시켜두는 것이다.
				
				// 인덱스 페이지로 이동
				String message = "비밀번호 수정이 완료되었습니다.";
				String loc ="index.exp";
				
				mav.addObject("message",message);
				mav.addObject("loc",loc);
				
				mav.setViewName("msg");
			}
		}
		
		// userid_noExist 가 넘어올 경우 회원가입 후 기본정보 수정 페이지로 이동
		
		else if (userid_noExist != "") {
			
			// 회원가입 처리 후 
			int n2 = service.registerUser(paraMap);
			
			if(n2==1) {
				
				// 로그인 처리 
				UserVO loginuser = service.getLoginUser(userid_noExist);
				HttpSession session = request.getSession();
				// 메모리에 생성되어져 있는 session 을 불러온다.
				session.setAttribute("loginuser", loginuser);
				// session(세션)에 로그인 되어진 사용자 정보인 loginuser 을 키이름을 "loginuser" 으로 저장시켜두는 것이다.
				
				// 정보수정 페이지로 이동
				String message = "회원가입이 완료되었습니다. 기본정보 등록 후 이용해주세요.";
				String loc ="user_EditBasicInfo.exp";
				
				mav.addObject("message",message);
				mav.addObject("loc",loc);
				
				mav.setViewName("msg");
			}
			
		}
		
		else {
			String message = "비밀번호 수정 실패!!!";
			String loc ="javascript:history.back()";
			
			mav.addObject("message",message);
			mav.addObject("loc",loc);
			
			mav.setViewName("msg");	
		}
		
		return mav;
	}
	@ResponseBody
	@PostMapping(value="/check_code_json.exp", produces="text/plain;charset=UTF-8")
	public String check_code_json(HttpServletRequest request) {
		
		HttpSession session = request.getSession();		
		String certification_code = (String) session.getAttribute("certification_code");
		String user_code = request.getParameter("user_code");
		
		JSONObject jsonObj = new JSONObject();
		if(user_code.equals(certification_code)) {
			jsonObj.put("isMatch", true);
		}
		else {
			jsonObj.put("isMatch", false);
		}
		
		return jsonObj.toString();
	}
	
	// @PostMapping("/user_EditBasicInfo.exp")
	@GetMapping("/user_EditBasicInfo.exp")
	public ModelAndView requiredLogin_user_EditBasicInfo(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
				
		mav.setViewName("jy/user/user_EditBasicInfo.tiles1");
		
		return mav;
	}
	
	// @PostMapping("/user_EditBasicInfoEnd.exp")
	@PostMapping("/user_EditBasicInfoEnd.exp")
	public ModelAndView requiredLogin_user_EditBasicInfoEnd(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		UserVO loginuser = (UserVO) session.getAttribute("loginuser");
		String userid = loginuser.getUserid();
		String name = request.getParameter("name");
		String birth = request.getParameter("birth");
		String gender = request.getParameter("gender");
		String mobile = request.getParameter("mobile");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		paraMap.put("name", name);
		paraMap.put("birth", birth);
		paraMap.put("gender", gender);
		paraMap.put("mobile", mobile);
		
		loginuser.setUserid(userid);
		loginuser.setName(name);
		loginuser.setBirth(birth);
		loginuser.setGender(gender);
		loginuser.setMobile(mobile);
		
		
		// 입력받은 정보 update 후 account 페이지로 이동 (이름, 생년월일, 휴대전화, 성별)
		int n = service.updateUserBasicInfo(paraMap);
		
		if(n==1) {
			String message = "회원정보가 업데이트 되었습니다.";
			String loc =request.getContextPath() + "/account.exp";
			
			mav.addObject("message",message);
			mav.addObject("loc",loc);
			
			mav.setViewName("msg");	
		}
				
		return mav;
	}
	
	@GetMapping("/account.exp")
	public ModelAndView requiredLogin_account(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		UserVO loginuser = (UserVO) session.getAttribute("loginuser");
		
		String wrongUserid = request.getParameter("userid");
		
		if(wrongUserid!=null && !wrongUserid.equals(loginuser.getUserid())) {
			String message = "올바른 접근이 아닙니다.";
			String loc =request.getContextPath() + "/account.exp";
			
			mav.addObject("message",message);
			mav.addObject("loc",loc);
			
			mav.setViewName("msg");	
		}
		else {
			mav.setViewName("jy/user/account.tiles1");	
		}
		
		return mav;
	}
	
	// @PostMapping("/user_EditContact.exp")
	@GetMapping("/user_EditContact.exp")
	public ModelAndView requiredLogin_user_EditContact(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		mav.setViewName("jy/user/user_EditContact.tiles1");
		
		return mav;
	}
	
	// @PostMapping("/user_EditContactEnd.exp")
	@RequestMapping("/user_EditContactEnd.exp")
	public ModelAndView user_EditContactEnd(ModelAndView mav, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		UserVO loginuser = (UserVO) session.getAttribute("loginuser");
		String userid = loginuser.getUserid();
		String mobile = request.getParameter("mobile");
		String emer_name = request.getParameter("emer_name");
		String emer_phone = request.getParameter("emer_phone");
		String address = request.getParameter("address");
		String detailAddress = request.getParameter("detailAddress");
		String extraAddress = request.getParameter("extraAddress");
		String postcode = request.getParameter("postcode");
		
		loginuser.setMobile(mobile);
		loginuser.setEmer_name(emer_name);
		loginuser.setEmer_phone(emer_phone);
		loginuser.setAddress(address);
		loginuser.setDetailAddress(detailAddress);
		loginuser.setExtraAddress(extraAddress);
		loginuser.setPostcode(Integer.parseInt(postcode));
		
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		paraMap.put("mobile", mobile);
		paraMap.put("emer_name", emer_name);
		paraMap.put("emer_phone", emer_phone);
		paraMap.put("address", address);		
		paraMap.put("detailAddress", detailAddress);
		paraMap.put("extraAddress", extraAddress);
		paraMap.put("postcode", postcode);
		
		// 입력받은 정보 update 후 account 페이지로 이동
		int n = service.updateUserContact(loginuser);
		
		if(n==1) {
			String message = "회원정보가 업데이트 되었습니다.";
			String loc =request.getContextPath() + "/account.exp";
			
			mav.addObject("message",message);
			mav.addObject("loc",loc);
			
			mav.setViewName("msg");	
		}
				
		return mav;
	}
	
	@GetMapping("/user_rewards.exp")
	public ModelAndView user_rewards(ModelAndView mav, HttpServletRequest request) {
		// 넘어가야할 정보 - 올해 예약 건수(체크인 날짜 지난 것만), 예약된 내역에서 포인트 
		// 1. 포인트 테이블에서 로그인유저에 대한 내역 전부 가져오기  2. 올해 예약끝난 건수 (체크인 날짜 지난 것만)
		
		HttpSession session = request.getSession();
		UserVO loginuser = (UserVO) session.getAttribute("loginuser");
		String userid = loginuser.getUserid();
		
		List<Map<String, String>> user_point_list = service.get_user_point_list(userid);
		int user_rs_cnt = service.get_user_rs_cnt(userid);
		
		mav.addObject("user_point_list",user_point_list);
		
		mav.addObject("user_rs_cnt",user_rs_cnt);
		
		mav.setViewName("jy/user/user_rewards.tiles1");
		
		return mav;
	}
	
	@GetMapping("/account/setting.exp")
	public ModelAndView setting(ModelAndView mav, HttpServletRequest request) {
		
		mav.setViewName("jy/user/setting.tiles1");
		
		return mav;
	}
	
	// 만들어야할 view 단
	// account/point_history.exp => 계정 - 포인트 내역 ??
	// account/user_writeReviews.exp => 계정 - 이용후기 작성 (채혁)
	// 이메일 변경
	// account/user_delete.exp => 계정 삭제
	
	
}
