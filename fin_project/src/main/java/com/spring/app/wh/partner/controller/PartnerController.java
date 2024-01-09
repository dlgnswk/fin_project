package com.spring.app.wh.partner.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.digester.Substitutor;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.spring.app.common.Sha256;
import com.spring.app.expedia.domain.ChatVO;
import com.spring.app.expedia.domain.HostVO;
import com.spring.app.expedia.domain.ReplyVO;
import com.spring.app.expedia.domain.UserVO;
import com.spring.app.wh.partner.service.PartnerService;

@Controller
public class PartnerController {

	@Autowired  // Type에 따라 알아서 Bean 을 주입해준다.
	private PartnerService service;
	

	
	@GetMapping("/partner.exp") 
	public ModelAndView partner(HttpServletRequest request, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		
		HostVO loginhost = (HostVO)session.getAttribute("loginhost");
		
		if(loginhost == null) {
			
			mav.setViewName("wh/partner/login.tiles2");
		}
		else {
			
			mav.setViewName("wh/partner/partnerIndex.tiles2");
		}
		
		
		
		return mav;
	}
	
	// ==== 로그인 처리하기 ==== //
	@PostMapping("/partnerIndex.exp")
	public ModelAndView login(HttpServletRequest request, ModelAndView mav) {
		
		String h_userid = request.getParameter("userid");
		String h_pw = request.getParameter("pwd");
		
		
		// System.out.println("확인용 h_userid :"+h_userid);
		// System.out.println("확인용 Sha256.encrypt(h_pw) :"+Sha256.encrypt(h_pw));
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("h_userid", h_userid);
		paraMap.put("h_pw", Sha256.encrypt(h_pw));
		
		
		HostVO loginhost = service.getLoginHost(paraMap);
		
		if(loginhost == null) { // 로그인 실패 시
			String message = "아이디 또는 암호가 틀립니다.";
			// String loc = "javascript:history.back()";
			
			String loc = request.getHeader("referer");
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
		}
		
		else { // 계정이 존재하는 경우
			
				
				HttpSession session = request.getSession();
				
				session.setAttribute("loginhost", loginhost);
				
				// 관리자 승인을 받기 전인 계정으로 로그인 했을 시
				if(loginhost.getH_status() == 0){
					String message = "관리자 승인 후 접속 할 수 있습니다.";
					String loc = request.getContextPath() + "/partner.exp";
					
					mav.addObject("message", message);
					mav.addObject("loc", loc);
					
					session.removeAttribute("loginhost");
					
					mav.setViewName("msg");
				}
				
				// 관리자 승인을 받은 계정으로 로그인
				else {
					mav.setViewName("wh/partner/partnerIndex.tiles2");
				}
				 
		}
		
		return mav;
	}
		
	// ==== 로그아웃 처리하기 ==== //	
	@GetMapping("/hostLogout.exp")
	public ModelAndView logout(ModelAndView mav, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		session.invalidate();
		
		String message = "로그아웃 되었습니다.";
		String loc = request.getContextPath() + "/partner.exp";
		
		mav.addObject("message", message);
		mav.addObject("loc", loc);
		
		mav.setViewName("msg");
		
		return mav;
	} // end of @GetMapping("/logout.exp")
		
	
	
	
	
	// === 회원가입 시작 === //

	
	@GetMapping("/hostRegister1.exp")
	public ModelAndView register1(ModelAndView mav, HttpServletRequest request) {
		
		mav.setViewName("wh/partner/hostRegister1.tiles2");
		return mav;
	}
	
	
	
	@PostMapping("/hostRegister2.exp")
	public ModelAndView register2(ModelAndView mav, HttpServletRequest request) {
		
		String lodgename = request.getParameter("lodgename");
		String address = request.getParameter("address");
		String detailAddress = request.getParameter("detailAddress");
		String extraAddress = request.getParameter("extraAddress");
		String postcode = request.getParameter("postcode");

		
		
		
		mav.addObject("lodgename", lodgename);
		mav.addObject("address", address);
		mav.addObject("detailAddress", detailAddress);
		mav.addObject("extraAddress", extraAddress);
		mav.addObject("postcode", postcode);

		
		mav.setViewName("wh/partner/hostRegister2.tiles2");
		return mav;
	}
	
	
	
	// 아이디 중복검사 수정 필요
	@ResponseBody
	@PostMapping(value="useridDuplicateCheck.exp", produces="text/plain;charset=UTF-8") 
	public String idDuplicateCheck(HttpServletRequest request) {
        
		
        String userid = request.getParameter("userid");
        
        
        int isExists = service.idDuplicateCheck(userid);
      
		JsonObject jsonObj = new JsonObject(); // {}
		jsonObj.addProperty("isExists",isExists);
			
		return new Gson().toJson(jsonObj); 
		
	
	}	
		
	@PostMapping("/registerEnd.exp")
	public ModelAndView registerEnd(ModelAndView mav, HttpServletRequest request) {
		
		String userid = request.getParameter("userid");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		String mobile = request.getParameter("mobile");
		String email = request.getParameter("email");
		String lodgename = request.getParameter("lodgename");
		String address = request.getParameter("address");
		String detailAddress = request.getParameter("detailAddress");
		String extraAddress = request.getParameter("extraAddress");
		String postcode = request.getParameter("postcode");
		String legalName = request.getParameter("legalName");
		String businessNo = request.getParameter("businessNo");

/*
		System.out.println("확인용 userid : "+userid);
		System.out.println("확인용 pw : "+pw);
		System.out.println("확인용 name : "+name);
		System.out.println("확인용 mobile : "+mobile);
		System.out.println("확인용 email : "+email);
		System.out.println("확인용 lodgename : "+lodgename);
		System.out.println("확인용 address : "+address);
		System.out.println("확인용 detailAddress : "+detailAddress);
		System.out.println("확인용 extraAddress : "+extraAddress);
		System.out.println("확인용 postcode : "+postcode);
		System.out.println("확인용 legalName : "+legalName);
		System.out.println("확인용 businessNo : "+businessNo);
*/

		HostVO host = new HostVO();
		
		host.setH_userid(userid);
		host.setH_pw(Sha256.encrypt(pw));
		host.setH_name(name);
		host.setH_mobile(mobile);
		host.setH_email(email);
		host.setH_lodgename(lodgename);
		host.setH_address(address);
		host.setH_detailAddress(detailAddress);
		host.setH_extraAddress(extraAddress);
		host.setH_postcode(postcode);
		host.setH_legalName(legalName);
		host.setH_businessNo(businessNo);

		
		// tbl_host 에 HostVO 에 저장된 정보를 insert 해주는 메소드
		int n = service.registerHost(host);
		
		if(n==1) {
			String message = "회원가입이 완료되었습니다.";
			String loc = request.getContextPath() + "/partner.exp";
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
			
		}
		else {
			String message = "오류가 발생했습니다. 다시 가입해주세요.";
			String loc = request.getContextPath() + "/hostRegister1.exp";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
		}
		
		return mav;
	}	
	
	
	// === 회원가입 끝 === //	
	
	
	// === 시설 관리 페이지 이동 시작 == //
	@GetMapping("/lodgeControl.exp")
	public String requiredHostLogin_lodgeControl(HttpServletRequest request, HttpServletResponse response) {
		
		String h_userid = request.getParameter("userid");
		
		request.setAttribute("h_userid", h_userid);
		
		
		return "wh/partner/lodgeControl.tiles2";
	}
	// === 시설 관리 페이지 이동 끝  == //
	
	
	
	// 계정 관리 페이지로 이동
	@PostMapping("/partnerControl.exp")
	public String hostControl(HttpServletRequest request) {
		
		String h_userid = request.getParameter("userid");
		
		request.setAttribute("h_userid", h_userid);
		
		
		return "wh/partner/partnerControl.tiles2";
	}
	
	
	// ==== 차트(그래프)를 보여주는 페이지 ==== // 
	@PostMapping("chart.exp")
	public String requiredHostLogin_chart(HttpServletRequest request, HttpServletResponse response) {
		
		Date now = new Date();
		String nowTime = now.toString();
		String year = nowTime.substring(24);
		
		/*
		for(int i=0; i<3; i++) {
			int i_year = Integer.parseInt(year);
			i_year = i_year - i;
		}
		*/
		
		
		request.setAttribute("year", year);
		
		return "wh/partner/chart.tiles2";
	}
	
	
	
	
	// ==== 차트그리기(Ajax) 올해 월별 객실등급별 예약 인원 수 가져오기 ==== //
	@ResponseBody
	@GetMapping(value="useLodgeCnt.exp", produces="text/plain;charset=UTF-8") 
	public String useLodgeCnt(HttpServletRequest request) {
        
		Date now = new Date();
		String nowTime = now.toString();
		String year = nowTime.substring(24);
		
        String h_userid = request.getParameter("h_userid");
        
        Map<String, String> paraMap = new HashMap<>();
        paraMap.put("year", year);
        paraMap.put("h_userid", h_userid);
        
        
        List<Map<String, String>> useLodgeCntList = service.useLodgeCnt(paraMap);
        
        JsonArray jsonArr = new JsonArray(); // []
		
		for(Map<String,String> map : useLodgeCntList) {
			JsonObject jsonObj = new JsonObject(); // {}
			jsonObj.addProperty("rm_type", map.get("rm_type")); 
			jsonObj.addProperty("MON01", map.get("MON01")); 
			jsonObj.addProperty("MON02", map.get("MON02")); 
			jsonObj.addProperty("MON03", map.get("MON03")); 
			jsonObj.addProperty("MON04", map.get("MON04")); 
			jsonObj.addProperty("MON05", map.get("MON05")); 
			jsonObj.addProperty("MON06", map.get("MON06")); 
			jsonObj.addProperty("MON07", map.get("MON07")); 
			jsonObj.addProperty("MON08", map.get("MON08")); 
			jsonObj.addProperty("MON09", map.get("MON09")); 
			jsonObj.addProperty("MON10", map.get("MON10")); 
			jsonObj.addProperty("MON11", map.get("MON11")); 
			jsonObj.addProperty("MON12", map.get("MON12")); 
			
			
			jsonArr.add(jsonObj); 
			
		}// end of for-------------------------------------------------------------------------
		
		
		return new Gson().toJson(jsonArr); 
		
	
	}
	
	
	
	// ==== 차트그리기(Ajax) 2023년 월별 객실등급별 예약 인원 수 가져오기 ==== //
	@ResponseBody
	@GetMapping(value="beforeOneYearuseLodgeCnt.exp", produces="text/plain;charset=UTF-8") 
	public String beforeOneYearuseLodgeCnt(HttpServletRequest request) {
		
		Date now = new Date();
		String nowTime = now.toString();
		String s_year = nowTime.substring(24);
		int year = Integer.parseInt(s_year);
		int beforeyear = year-1;
		
		String s_beforeyear = String.valueOf(beforeyear);
		
		String h_userid = request.getParameter("h_userid");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("year", s_beforeyear);
		paraMap.put("h_userid", h_userid);
		
		
		List<Map<String, String>> useLodgeCntList = service.useLodgeCnt(paraMap);
		
		JsonArray jsonArr = new JsonArray(); // []
		
		for(Map<String,String> map : useLodgeCntList) {
			JsonObject jsonObj = new JsonObject(); // {}
			jsonObj.addProperty("rm_type", map.get("rm_type")); 
			jsonObj.addProperty("MON01", map.get("MON01")); 
			jsonObj.addProperty("MON02", map.get("MON02")); 
			jsonObj.addProperty("MON03", map.get("MON03")); 
			jsonObj.addProperty("MON04", map.get("MON04")); 
			jsonObj.addProperty("MON05", map.get("MON05")); 
			jsonObj.addProperty("MON06", map.get("MON06")); 
			jsonObj.addProperty("MON07", map.get("MON07")); 
			jsonObj.addProperty("MON08", map.get("MON08")); 
			jsonObj.addProperty("MON09", map.get("MON09")); 
			jsonObj.addProperty("MON10", map.get("MON10")); 
			jsonObj.addProperty("MON11", map.get("MON11")); 
			jsonObj.addProperty("MON12", map.get("MON12")); 
			
			
			jsonArr.add(jsonObj); 
			
		}// end of for-------------------------------------------------------------------------
		
		
		return new Gson().toJson(jsonArr); 
		
		
	}
	
	
	// === 회원정보 수정 시작 === //

	
	// 회원 수정 페이지 이동 
	@PostMapping("/hostEdit1.exp")
	public ModelAndView edit1(ModelAndView mav, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		
		HostVO loginhost = (HostVO)session.getAttribute("loginhost");
		
		if(loginhost == null) {
			
			mav.setViewName("wh/partner/login.tiles2");
		}
		else {
			
			mav.setViewName("wh/partner/hostEdit1.tiles2");
		}
		return mav;
	}
	
	
	
	@PostMapping("/hostEdit2.exp")
	public ModelAndView edit2(ModelAndView mav, HttpServletRequest request) {
		
		String lodgename = request.getParameter("lodgename");
		String address = request.getParameter("address");
		String detailAddress = request.getParameter("detailAddress");
		String extraAddress = request.getParameter("extraAddress");
		String postcode = request.getParameter("postcode");

		
		
		mav.addObject("lodgename", lodgename);
		mav.addObject("address", address);
		mav.addObject("detailAddress", detailAddress);
		mav.addObject("extraAddress", extraAddress);
		mav.addObject("postcode", postcode);

		
		mav.setViewName("wh/partner/hostEdit2.tiles2");
		return mav;
	}
	
	
	@PostMapping("/editEnd.exp")
	public ModelAndView editEnd(ModelAndView mav, HttpServletRequest request) {
		
		String userid = request.getParameter("userid");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		String mobile = request.getParameter("mobile");
		String email = request.getParameter("email");
		String lodgename = request.getParameter("lodgename");
		String address = request.getParameter("address");
		String detailAddress = request.getParameter("detailAddress");
		String extraAddress = request.getParameter("extraAddress");
		String postcode = request.getParameter("postcode");
		String legalName = request.getParameter("legalName");
		String businessNo = request.getParameter("businessNo");

/*
		System.out.println("확인용 userid : "+userid);
		System.out.println("확인용 pw : "+pw);
		System.out.println("확인용 name : "+name);
		System.out.println("확인용 mobile : "+mobile);
		System.out.println("확인용 email : "+email);
		System.out.println("확인용 lodgename : "+lodgename);
		System.out.println("확인용 address : "+address);
		System.out.println("확인용 detailAddress : "+detailAddress);
		System.out.println("확인용 extraAddress : "+extraAddress);
		System.out.println("확인용 postcode : "+postcode);
		System.out.println("확인용 legalName : "+legalName);
		System.out.println("확인용 businessNo : "+businessNo);
*/

		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		paraMap.put("pw", Sha256.encrypt(pw));
		paraMap.put("name", name);
		paraMap.put("mobile", mobile);
		paraMap.put("email", email);
		paraMap.put("lodgename", lodgename);
		paraMap.put("address", address);
		paraMap.put("detailAddress", detailAddress);
		paraMap.put("extraAddress", extraAddress);
		paraMap.put("postcode", postcode);
		paraMap.put("legalName", legalName);
		paraMap.put("businessNo", businessNo);
		
		
		
		// tbl_host 에 저장된 판매자의 정보를 update 해주는 메소드
		int n = service.editHost(paraMap);
		
		if(n==1) {
			HttpSession session = request.getSession();
			
			HostVO loginhost = (HostVO)session.getAttribute("loginhost");
			
			
			loginhost.setH_pw(Sha256.encrypt(pw));
			loginhost.setH_name(name);
			loginhost.setH_mobile(mobile);
			loginhost.setH_email(email);
			loginhost.setH_lodgename(lodgename);
			loginhost.setH_address(address);
			loginhost.setH_detailAddress(detailAddress);
			loginhost.setH_extraAddress(extraAddress);
			loginhost.setH_postcode(postcode);
			loginhost.setH_legalName(legalName);
			loginhost.setH_businessNo(businessNo);
			
			
			
			
			
			String message = "회원정보 수정이 완료되었습니다.";
			String loc = request.getContextPath() + "/partner.exp";
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
			
		}
		else {
			String message = "오류가 발생했습니다. 다시 수정해주세요.";
			String loc = request.getContextPath() + "/hostEdit1.exp";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
		}
		
		return mav;
	}	
	
	// === 회원정보 수정 끝 === //
	
	
	
	
	
	
	// ==== CS업무 관리 시작 ==== // 
	
	
	// CS 업무 인덱스 페이지 출력
	@PostMapping("csIndex.exp")
	public String requiredHostLogin_csIndex(HttpServletRequest request, HttpServletResponse response) {
		
		String h_userid = request.getParameter("userid");
		
		request.setAttribute("h_userid", h_userid);
		
		return "wh/partner/csIndex.tiles2";
	}
		  	
	
	// 구매자 입장에서 판매자와 채팅하기 시작
	
	@GetMapping("/chatList.exp")
	public ModelAndView requiredLogin_chatList(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
  		
		HttpSession session = request.getSession();
		UserVO loginuser = (UserVO)session.getAttribute("loginuser");
  		
		String userid = loginuser.getUserid();
		
		System.out.println("컨트롤러 userid : "+userid);
		
		
	    String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		
		int totalChatRoomCount = 0;	// 총 채팅방 개수
	    int sizePerPage = 10;	// 한 페이지당 보여줄 게시물 건수
	    int currentShowPageNo = 0; // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함.
	    int totalPage = 0;
		
	    // 총 채팅방 갯수(totalChatRoomCount) 가져오기
	    totalChatRoomCount = service.getTotalChatRoomCount(paraMap);
		
	    totalPage = (int) Math.ceil((double)totalChatRoomCount/sizePerPage);
	    
	    if(str_currentShowPageNo == null) {
	    	  // 게시판에 보여지는 초기화면
	    	  currentShowPageNo = 1;
	    }
	    
	    else {
	    	  
			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
	  
				if (currentShowPageNo < 1 || currentShowPageNo > totalPage) {
					// get 방식이므로 str_currentShowPageNo 에 입력한 값이 0 이하를 입력했을 경우 or 실제 데이터베이스에 존재하는 페이지 수 보다 큰 값을 입력한 경우. 
					currentShowPageNo = 1;
				}
  
			} catch (NumberFormatException e) {
			// get 방식이므로 str_currentShowPageNo 에 입력한 값이 숫자가 아닌 문자를 입력했을 경우이다.
			currentShowPageNo = 1;
			}
	  
	    }
	    
	    int startRno = ((currentShowPageNo - 1) * sizePerPage) + 1; // 시작 행번호
	    int endRno = startRno + sizePerPage - 1; // 끝 행번호
		
	    paraMap.put("startRno", String.valueOf(startRno));
	    paraMap.put("endRno", String.valueOf(endRno));
		
	    
	    // 현재 로그인되어있는 회원(구매자)의 채팅방 목록 가져오기
	    List<ChatVO> chatRoomList = service.getChatRoomList(paraMap);
	    
	    mav.addObject("chatRoomList", chatRoomList);
	    
	    // ==== # 121. 페이지바 만들기 ==== //
	    int blockSize = 10;
	    
	    int loop = 1;
	    
	    int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
	    
	    String pageBar = "<ul style='list-style:none;'>";
	    String url = "chatList.exp";
	    
	    // === [처음][이전] 만들기 == //
		if(pageNo != 1) {
			  pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?currentShowPageNo=1'>[맨처음]</a></li>";
			  pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
		}


		while(!(loop > blockSize || pageNo > totalPage) ) {
			  
			  if(pageNo == currentShowPageNo ) {
				  pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";
			  }
			  else {
				  pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
			  }
			  
			  loop++;
			  pageNo++;
		}// end of while----------------------------------------
		
		// === [다음][마지막] 만들기 == //
		if(pageNo <= totalPage) {
			  pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?currentShowPageNo="+pageNo+"'>[다음]</a></li>";
			  pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
		}
		
		
		pageBar += "</ul>";
		
		mav.addObject("pageBar", pageBar);
	    
		mav.setViewName("wh/chatting/chatList.tiles1");
	    
  		return mav;
  	}
	
	
	
	
	// (구매자입장에서) 판매자와 채팅하기  
	@GetMapping("/chat.exp")
	public String requiredLogin__chat(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		
		UserVO loginuser = (UserVO)session.getAttribute("loginuser");
		
		String fk_userid = loginuser.getUserid();
		String fk_lodge_id = request.getParameter("lodge_id");
		
		
		Map<String,String> paraMap = new HashMap<>();
		
		paraMap.put("fk_userid",fk_userid);
		paraMap.put("fk_lodge_id",fk_lodge_id);
		
		
		// 채팅방 불러오기
		ChatVO chatvo = service.selectChat(paraMap);
		
		// System.out.println("컨트롤러 확인용 chatvo : "+chatvo);
		
		// 기존 채팅방이 없는 경우 새로운 채팅방을 만들기
		if(chatvo == null) {
			
			int n = service.createChat(paraMap);
			
			// System.out.println("컨트롤러 확인용 n : "+n);
			
			if(n == 1) {
				
				chatvo = service.selectChat(paraMap);
				
				request.setAttribute("chatvo", chatvo);
				
				return "wh/chatting/chat.tiles1";
			}
			
		}
		
		
		request.setAttribute("chatvo", chatvo);
		
		return "wh/chatting/chat.tiles1";
	}
	

	
	
	
	
	
	// === 채팅쓰기 === //
 	@ResponseBody
 	@PostMapping(value="/addChat.exp", produces="text/plain;charset=UTF-8" )
  	public String addChat(HttpServletRequest request) {
 		
 		String chat_no = request.getParameter("chat_no");
 		String chat_comment = request.getParameter("chat_comment");
 		
 		Map<String,String> paraMap = new HashMap<>();
 		
 		paraMap.put("chat_no", chat_no);
 		paraMap.put("chat_comment", chat_comment);
 		
		int n = service.addChat(paraMap);
			
 		JSONObject jsonObj = new JSONObject();
 		jsonObj.put("n", n);
 		
 		return jsonObj.toString();	
 	}
	  	
	  	
 	// === 채팅들을 페이징 처리해서 조회해오기  === //
  	@ResponseBody
  	@GetMapping(value="/viewChatList.exp", produces="text/plain;charset=UTF-8" )
  	public String viewChatList(HttpServletRequest request) {
  		
  		String fk_chat_no = request.getParameter("chat_no");
  		String currentShowPageNo = request.getParameter("currentShowPageNo");
  		
  		if(currentShowPageNo == null) {
  			currentShowPageNo = "1";
  		}
  		
  		int sizePerPage = 10; // 한 페이지당 5개의 댓글을 보여줄 것임.
  		
	/*
        currentShowPageNo      startRno     endRno
        --------------------------------------------
           1page        ==>       1           10
           2page        ==>       6           10
           3page        ==>       11          15
           4page        ==>       16          20
           ....  
    */
  	
  		int startRno = ((Integer.parseInt(currentShowPageNo) - 1) * sizePerPage) + 1; // 시작 행번호
	    int endRno = startRno + sizePerPage - 1; // 끝 행번호 
  		
  		Map<String,String> paraMap = new HashMap<>();
  		paraMap.put("fk_chat_no", fk_chat_no);
  		paraMap.put("startRno", String.valueOf(startRno));
  		paraMap.put("endRno", String.valueOf(endRno));
  		
  		List<ReplyVO> chatList = service.getChatList(paraMap);
  		
	    JSONArray jsonArr = new JSONArray();
	    
	    if(chatList != null) {
	    	for(ReplyVO replyvo : chatList) {
	    		JSONObject jsonObj = new JSONObject();
	    		jsonObj.put("reply_no", replyvo.getReply_no());
	    		jsonObj.put("fk_chat_no", replyvo.getFk_chat_no());
	    		jsonObj.put("reply_comment", replyvo.getReply_comment());
	    		jsonObj.put("reply_date", replyvo.getReply_date());
	    		jsonObj.put("r_status", replyvo.getR_status());
	    		
	    		
	    		jsonArr.put(jsonObj);
	    	}// end of for----------------------------------------------
	    }
  		
  		return jsonArr.toString();
  	}
	  	
	  	
  	// === 채팅방 번호에 해당하는 채팅의 totalCount 수 알아오기 === //
  	@ResponseBody
  	@GetMapping(value="getChatTotalCount.exp")
  	public String getChatTotalCount(HttpServletRequest request) {
  		
  		String fk_chat_no = request.getParameter("chat_no");
  		String sizePerPage = request.getParameter("sizePerPage");
  		
  		Map<String,String> paraMap = new HashMap<>();
  		paraMap.put("fk_chat_no", fk_chat_no);
  		paraMap.put("sizePerPage", sizePerPage);
  		
  		int totalCount = service.getChatTotalCount(paraMap);
  		
  		JSONObject jsonObj = new JSONObject(); 
  		jsonObj.put("totalCount", totalCount);  
  		
  		
  		return jsonObj.toString();
  	}
  	

	// 구매자 입장에서 판매자와 채팅하기 끝
  	
  	
	// 판매자 입장에서 판매자와 채팅하기 시작
  	
  	@PostMapping("/replylist.exp")
	public ModelAndView requiredHostLogin_replylist(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
  		
  		
  		
  		
  		return mav;
  	}
  	
  	
  	
  	
  	
  	
  	// 판매자 입장에서 판매자와 채팅하기 끝

  		
	// ==== CS업무 관리 끝 ==== // 
	
	
	
}
