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
		
		if(loginhost == null) { // 로그인 실패시
			String message = "아이디 또는 암호가 틀립니다.";
			// String loc = "javascript:history.back()";
			
			String referer = request.getHeader("referer"); 
			// request.getHeader("referer"); 은 이전 페이지의 URL을 가져오는 것이다.
			String loc = request.getHeader("referer");
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
			// /WEB-INF/views/msg.jsp 파일을 생성한다.
		}
		else { // 아이디와 암호가 존재하는 경우
			
				
				HttpSession session = request.getSession();
				// 메모리에 생성되어져있는 session 을 불러온다.
				
				session.setAttribute("loginhost", loginhost);
				// session(세션)에 로그인 되어진 사용자 정보인 loginhost 의 키이름을 "loginhost" 으로 저장시켜두는 것이다.
				
				if(loginhost.isRequirePwdChange() == true){
					// 암호를 마지막으로 변경한 시점이 3개월 경과한 경우
					String message = "비밀번호를 변경하신지 3개월이 지났습니다.\\n암호를 변경하시는 것을 추천합니다.";
					String loc = request.getContextPath() + "/partner.exp";
					// 원래는 위와 같이 partner.exp 이 아니라 사용자의 비밀번호를 변경하는 페이지로 잡아주어야 한다.
					
					mav.addObject("message", message);
					mav.addObject("loc", loc);
					
					mav.setViewName("msg");
				}
				
				mav.setViewName("wh/partner/partnerIndex.tiles2"); // 시작페이지로 이동
		}
		
		return mav;
	}
		
		
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
		} // end of @GetMapping("/logout.action")
		
	
	
	
	
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
	
	
	
	// 시설 관리 페이지로 이동
	@PostMapping("/lodgeControl.exp")
	public String lodgeControl(HttpServletRequest request) {
		
		String h_userid = request.getParameter("userid");
		
		request.setAttribute("h_userid", h_userid);
		
		
		return "wh/partner/lodgeControl.tiles2";
	}
	
	
	
	
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
	
	
	
	
	// ==== 차트그리기(Ajax) 월별 객실등급별 예약 인원 수 가져오기 ==== //
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
	
	
	
	// ==== 차트그리기(Ajax) 월별 객실등급별 예약 인원 수 가져오기 ==== //
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
		  	
	
	// ==== #58. 글목록보기 페이지 요청 ==== //
	
	@GetMapping("/list.exp")
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		List<ChatVO> chatList = null;
		
		//////////////////////////////////////////////////////
		// === #69. 글조회수(readCount)증가 (DML문 update)는
		//          반드시 목록보기에 와서 해당 글제목을 클릭했을 경우에만 증가되고,
		//          웹브라우저에서 새로고침(F5)을 했을 경우에는 증가가 되지 않도록 해야 한다.
		//          이것을 하기 위해서는 session 을 사용하여 처리하면 된다.
		
		HttpSession session = request.getSession();
		session.setAttribute("readCountPermission", "yes");
		/*
		    session 에  "readCountPermission" 키값으로 저장된 value값은 "yes" 이다.
		    session 에  "readCountPermission" 키값에 해당하는 value값 "yes"를 얻으려면 
		        반드시 웹브라우저에서 주소창에 "/list.action" 이라고 입력해야만 얻어올 수 있다. 
		*/
		//////////////////////////////////////////////////////////////////////
		
		
		// == 페이징 처리를 안한 검색어가 없는 전체 글목록 보여주기 == //
	 //	boardList = service.boardListNoSearch();
		
		// === #102. 페이징 처리를 안한 검색어가 있는 전체 글목록 보여주기 == //
     /*
		  String searchType = request.getParameter("searchType");
	      String searchWord = request.getParameter("searchWord");
	      // System.out.println("확인용 searchType : " + searchType);
	      // 확인용 searchType : null (검색이 없는 경우)
	      // 확인용 searchType : subject
	      // 확인용 searchType : content
	      // 확인용 searchType : subject_content
	      // 확인용 searchType : name
	      
	      
	      // System.out.println("확인용 searchWord : " + searchWord);
	      // 확인용 searchWord : null (검색이 없는 경우)
	      // 확인용 searchWord : 입니다
	      // 확인용 searchWord : java
	      // 확인용 searchWord : java
	      // 확인용 searchWord : 최우현
	      
	      if(searchType == null) {
	         searchType = "";
	      }

	      if(searchWord == null) {
	         searchWord = "";
	      }

	      if(searchWord != null) {
	         searchWord = searchWord.trim();
	      }
	      
	      Map<String, String> paraMap = new HashMap<>();
	      paraMap.put("searchType", searchType);
	      paraMap.put("searchWord", searchWord);
	      
	      boardList = service.boardListSearch(paraMap);
	  */    
	      //////////////////////////////////////////////////
	      
	   // === #114. 페이징 처리를 한 검색어가 있는 전체 글목록 보여주기 == //
	   
	   /* 페이징 처리를 통한 글목록 보여주기는 
        
		    예를 들어 3페이지의 내용을 보고자 한다라면 검색을 할 경우는 아래와 같이
		  list.action?searchType=subject&searchWord=안녕&currentShowPageNo=3 와 같이 해주어야 한다.
		        
		    또는 
		    
		    검색이 없는 전체를 볼때는 아래와 같이 
          list.action 또는 
          list.action?searchType=&searchWord=&currentShowPageNo=3 또는 
          list.action?searchType=subject&searchWord=&currentShowPageNo=3 또는
          list.action?searchType=name&searchWord=&currentShowPageNo=3 와 같이 해주어야 한다.
      */  
		    
         
		  String searchType = request.getParameter("searchType");
	      String searchWord = request.getParameter("searchWord");
	      String str_currentShowPageNo = request.getParameter("currentShowPageNo");
	      
	      // System.out.println("확인용 searchType : " + searchType);
	      // 확인용 searchType : null (검색이 없는 경우)
	      // 확인용 searchType : subject
	      // 확인용 searchType : content
	      // 확인용 searchType : subject_content
	      // 확인용 searchType : name
	      
	      
	      // System.out.println("확인용 searchWord : " + searchWord);
	      // 확인용 searchWord : null (검색이 없는 경우)
	      // 확인용 searchWord : 입니다
	      // 확인용 searchWord : java
	      // 확인용 searchWord : java
	      // 확인용 searchWord : 최우현
	      
	      // System.out.println("확인용 str_currentShowPageNo : " + str_currentShowPageNo);
	      // 확인용 str_currentShowPageNo : null
	      // 확인용 str_currentShowPageNo : 3
	      // 확인용 str_currentShowPageNo : dasdasdasdass
	      // 확인용 str_currentShowPageNo : -34123
	      // 확인용 str_currentShowPageNo : 0
	      // 확인용 str_currentShowPageNo : 3321321
	      // 확인용 str_currentShowPageNo : 33213213891283902183
	      
	      
	      if(searchType == null) {
	         searchType = "";
	      }

	      if(searchWord == null) {
	         searchWord = "";
	      }

	      if(searchWord != null) {
	         searchWord = searchWord.trim();
	      }
		  
	      Map<String, String> paraMap = new HashMap<>();
	      paraMap.put("searchType", searchType);
	      paraMap.put("searchWord", searchWord);
	      
	      
	//    boardList = service.boardListSearch(paraMap);  // 글목록 가져오기(페이징 처리 안한 검색어가 없는 것 또는 검색어가 있는 것 모두 포함한 것)
	      
	      // 먼저, 총 게시물 건수(totalCount)를 구해와야 한다.
	      // 총 게시물 건수(totalCount)는 검색조건이 있을 때와 없을 때로 나뉘어진다.
	      int totalCount = 0;	// 총 게시물 건수
	      int sizePerPage = 10;	// 한 페이지당 보여줄 게시물 건수
	      int currentShowPageNo = 0; // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함.
	      int totalPage = 0;		 // 총 페이지수(웹브라우저 상에서 보여줄 총 페이지 개수, 페이지바)
	      
	      // 총 게시물 건수(totalCount)
	      //totalCount = service.getTotalCount(paraMap);
	      // System.out.println("~~~~ 확인용 totalCount : " + totalCount);
	      // ~~~~ 확인용 totalCount : 216
	      // ~~~~ 확인용 totalCount : 4
	      // ~~~~ 확인용 totalCount : 2
	      
	      
	      // EX) 만약에 총 게시물 건수(totalCount)가 124개인 경우
	      // 총 페이지수(totalPage)는 13페이지가 되어야 한다.
	      // EX) 만약에 총 게시물 건수(totalCount)가 120개인 경우
	      // 총 페이지수(totalPage)는 12페이지가 되어야 한다.
	      totalPage = (int) Math.ceil((double)totalCount/sizePerPage);
	      // (double)124/10 ==> 12.4 ==> Math.ceil(12.4) ==> int(13.0) ==> 13
	      // (double)120/10 ==> 12.0 ==> Math.ceil(12.0) ==> int(12.0) ==> 12
	      
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
	      
	      // **** 가져올 게시글의 범위를 구한다.(공식임!!!) **** 
	      /*
	           currentShowPageNo      startRno     endRno
	          --------------------------------------------
	               1 page        ===>    1           10
	               2 page        ===>    11          20
	               3 page        ===>    21          30
	               4 page        ===>    31          40
	               ......                ...         ...
	      */
	      int startRno = ((currentShowPageNo - 1) * sizePerPage) + 1; // 시작 행번호
	      int endRno = startRno + sizePerPage - 1; // 끝 행번호 
	      // System.out.println("startRno : "+startRno);
	      // System.out.println("endRno : "+endRno);
	      
	      paraMap.put("startRno", String.valueOf(startRno));
	      paraMap.put("endRno", String.valueOf(endRno));
	      
	      //boardList = service.boardListSearch_withPaging(paraMap);  
	      // 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함한 것)
	      
      
      
	      //mav.addObject("boardList", boardList);
	      
	      if("subject".equals(searchType) || "content".equals(searchType) || 
	    	 "subject_content".equals(searchType) || "name".equals(searchType)) {
	    	 
	    	  mav.addObject("paraMap", paraMap);
	      }
	      
	      
	      // ==== # 121. 페이지바 만들기 ==== //
	      int blockSize = 10;
	      // blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 개수이다.
      /*
	                       1  2  3  4  5  6  7  8  9 10 [다음][마지막]  -- 1개블럭
	         [맨처음][이전]  11 12 13 14 15 16 17 18 19 20 [다음][마지막]  -- 1개블럭
	         [맨처음][이전]  21 22 23
      */
	      
	      int loop = 1;
	      
      /*
          loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
      */
	      
	      int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
	      // *** !! 공식이다. !! *** //
	      
      /*
	       1  2  3  4  5  6  7  8  9  10  -- 첫번째 블럭의 페이지번호 시작값(pageNo)은 1 이다.
	       11 12 13 14 15 16 17 18 19 20  -- 두번째 블럭의 페이지번호 시작값(pageNo)은 11 이다.
	       21 22 23 24 25 26 27 28 29 30  -- 세번째 블럭의 페이지번호 시작값(pageNo)은 21 이다.
	       
	       currentShowPageNo         pageNo
	      ----------------------------------
	            1                      1 = ((1 - 1)/10) * 10 + 1
	            2                      1 = ((2 - 1)/10) * 10 + 1
	            3                      1 = ((3 - 1)/10) * 10 + 1
	            4                      1
	            5                      1
	            6                      1
	            7                      1 
	            8                      1
	            9                      1
	            10                     1 = ((10 - 1)/10) * 10 + 1
	           
	            11                    11 = ((11 - 1)/10) * 10 + 1
	            12                    11 = ((12 - 1)/10) * 10 + 1
	            13                    11 = ((13 - 1)/10) * 10 + 1
	            14                    11
	            15                    11
	            16                    11
	            17                    11
	            18                    11 
	            19                    11 
	            20                    11 = ((20 - 1)/10) * 10 + 1
	            
	            21                    21 = ((21 - 1)/10) * 10 + 1
	            22                    21 = ((22 - 1)/10) * 10 + 1
	            23                    21 = ((23 - 1)/10) * 10 + 1
	            ..                    ..
	            29                    21
	            30                    21 = ((30 - 1)/10) * 10 + 1
	   */
	      
	      
	      
	      String pageBar = "<ul style='list-style:none;'>";
	      String url = "list.action";
	      
	      // === [처음][이전] 만들기 == //
	      if(pageNo != 1) {
	    	  pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo=1'>[맨처음]</a></li>";
	    	  pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
	      }
	      
	      
	      
	      while(!(loop > blockSize || pageNo > totalPage) ) {
	    	  
	    	  if(pageNo == currentShowPageNo ) {
	    		  pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";
	    	  }
	    	  else {
	    		  pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
	    	  }
	    	  
	    	  loop++;
	    	  pageNo++;
	      }// end of while----------------------------------------
	      
	      // === [다음][마지막] 만들기 == //
	      if(pageNo <= totalPage) {
	    	  pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
	    	  pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
	      }
	      
	      
	      pageBar += "</ul>";
	      
	      mav.addObject("pageBar", pageBar);
	      
	      // === #123. 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
	      //           사용자가 "검색된결과목록보기" 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해
	      //           현재 페이지 주소를 뷰단으로 넘겨준다.
	      // String goBackURL = MyUtil.getCurrentURL(request);
//			      System.out.println("~~~확인용(list.action) goBackURL : " + goBackURL);
      /*
	      ~~~확인용(list.action) goBackURL : /list.action?searchType=subject&searchWord=java
	      ~~~확인용(list.action) goBackURL : /list.action?searchType=name&searchWord=최우현
	      ~~~확인용(list.action) goBackURL : /list.action?searchType=name&searchWord=최우현&currentShowPageNo=9
      */
	      
	      //mav.addObject("goBackURL", goBackURL);
	      
	      mav.setViewName("board/list.tiles1");
	      // /WEB-INF/views/tiles1/board/list.jsp 파일을 생성한다.
	      
	      return mav;
	   } // end of public ModelAndView list(ModelAndView mav)
	
	  	
	  	
	  		
	// ==== CS업무 관리 끝 ==== // 
	
	
	
}
