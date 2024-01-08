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
		  	
	
	// (구매자입장에서) 판매자와 채팅하기  
	@GetMapping("/chat.exp")
	public String requiredLogin_chat(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		
		UserVO loginuser = (UserVO)session.getAttribute("loginuser");
		
		String userid = loginuser.getUserid();
		System.out.println("컨트롤러 확인용 userid : "+userid);
		String lodge_id = request.getParameter("lodge_id");
		System.out.println("컨트롤러 확인용 lodge_id : "+lodge_id);
		
		
		Map<String,String> paraMap = new HashMap<>();
		
		paraMap.put("userid",userid);
		paraMap.put("lodge_id",lodge_id);
		
		
		// 채팅방 불러오기
		ChatVO chatvo = service.selectChat(paraMap);
		
		System.out.println("컨트롤러 확인용 chatvo : "+chatvo);
		
		// 기존 채팅방이 없는 경우 새로운 채팅방을 만들기
		if(chatvo == null) {
			
			int n = service.createChat(paraMap);
			
			System.out.println("컨트롤러 확인용 n : "+n);
			
			if(n == 1) {
				
				chatvo = service.selectChat(paraMap);
				
				request.setAttribute("chatvo", chatvo);
				
				return "wh/partner/chat.tiles2";
			}
			
		}
		
		
		request.setAttribute("chatvo", chatvo);
		
		return "wh/partner/chat.tiles2";
	}
	
	
	
	
	/*
	
	
	// === #84. 댓글쓰기(Ajax로 처리) === //
	 	@ResponseBody
	 	@PostMapping(value="/addChat.exp", produces="text/plain;charset=UTF-8" )
	  	public String addComment(ReplyVO replyvo) {
	 		// 댓글쓰기에 첨부파일이 없는 경우
	 		int n = 0;
	 		
	 		try {
				n = service.addChat(replyvo);
				
			} catch (Throwable e) {
				e.printStackTrace();
			}
	 		
	 		JSONObject jsonObj = new JSONObject();
	 		jsonObj.put("n", n); // {"n":1} {"n":0}
	 		jsonObj.put("r_status", replyvo.getR_status()); // {"n":1, "name":"이순신"} {"n":0, "name":"최우현"}
	 		
	 		return jsonObj.toString();	// "{"n":1,"name":"이순신"}"	또는  "{"n":0,"name":}"
	 	}
	 	
	 	// ==== #90. 원게시물에 딸린 댓글들을 조회해오기(Ajax로 처리) ==== //
	  	@ResponseBody
	  	@GetMapping(value="/readComment.action", produces="text/plain;charset=UTF-8" )
	  	public String readComment(HttpServletRequest request) {
	  		
	  		String parentSeq = request.getParameter("parentSeq");
	  		
	  		List<CommentVO> commentList = service.getCommentList(parentSeq);
	  		
	  		JSONArray jsonArr = new JSONArray(); // []
	  		
	  		if(commentList != null) {
	  			for(CommentVO cmtvo : commentList) {
	  				JSONObject jsonObj = new JSONObject();
	  				jsonObj.put("name",cmtvo.getName());
	  				jsonObj.put("content",cmtvo.getContent());
	  				jsonObj.put("regDate",cmtvo.getRegDate());
	  				
	  				jsonArr.put(jsonObj);
	  			}// end of for----------------------------------
	  			
	  		}
	  		
	  		return jsonArr.toString(); 
	  	}
	  	
	  	
	  	
	  	// === #108. 검색어 입력 시 자동글 완성하기 3 === //
	  	@ResponseBody
	  	@GetMapping(value="/wordSearchShow.action", produces="text/plain;charset=UTF-8" )
	  	public String wordSearchShow(HttpServletRequest request) {
	  		String searchType = request.getParameter("searchType");
	  		String searchWord = request.getParameter("searchWord");
	  		
	  		Map<String, String> paraMap = new HashMap<>();
	  		paraMap.put("searchType", searchType);
	  		paraMap.put("searchWord", searchWord);
	  		
	  		List<String> wordList =  service.wordSearchShow(paraMap);
	  		
	  		JSONArray jsonArr = new JSONArray();
	  		
	  		if(wordList != null) {
	  			
	  			for(String word :wordList) {
	  				JSONObject jsonObj = new JSONObject();
	  				jsonObj.put("word", word);
	  				
	  				jsonArr.put(jsonObj);
	  				
	  			}// end of for-------------------------------------------------
	  		}
	  		
	  		return jsonArr.toString();
	  	}
	  	
	  	// === #128. 원게시물에 딸린 댓글들을 페이징 처리해서 조회해오기(Ajax 로 처리) === //
	  	@ResponseBody
	  	@GetMapping(value="/commentList.action", produces="text/plain;charset=UTF-8" )
	  	public String commentList(HttpServletRequest request) {
	  		
	  		String parentSeq = request.getParameter("parentSeq");
	  		String currentShowPageNo = request.getParameter("currentShowPageNo");
	  		
	  		if(currentShowPageNo == null) {
	  			currentShowPageNo = "1";
	  		}
	  		
	  		int sizePerPage = 5; // 한 페이지당 5개의 댓글을 보여줄 것임.
	  		
		/*
	        currentShowPageNo      startRno     endRno
	        --------------------------------------------
	           1page        ==>       1           5
	           2page        ==>       6           10
	           3page        ==>       11          15
	           4page        ==>       16          20
	           ....  
	    */
	  	/*	
	  		int startRno = ((Integer.parseInt(currentShowPageNo) - 1) * sizePerPage) + 1; // 시작 행번호
		    int endRno = startRno + sizePerPage - 1; // 끝 행번호 
	  		
	  		Map<String,String> paraMap = new HashMap<>();
	  		paraMap.put("parentSeq", parentSeq);
	  		paraMap.put("startRno", String.valueOf(startRno));
	  		paraMap.put("endRno", String.valueOf(endRno));
	  		
	  		List<CommentVO> commentList = service.getCommentList_Paging(paraMap);
	  		
		    JSONArray jsonArr = new JSONArray();
		    
		    if(commentList != null) {
		    	for(CommentVO cmtvo : commentList) {
		    		JSONObject jsonObj = new JSONObject();
		    		jsonObj.put("name", cmtvo.getName());
		    		jsonObj.put("content", cmtvo.getContent());
		    		jsonObj.put("regdate", cmtvo.getRegDate());
		    		
		    		// ==== 댓글읽어오기에 있어서 첨부파일 기능을 넣은 경우 시작 ==== //
		    		jsonObj.put("seq", cmtvo.getSeq());
		    		jsonObj.put("fileName", cmtvo.getFileName());
		    		jsonObj.put("orgFilename", cmtvo.getOrgFilename());
		    		jsonObj.put("fileSize", cmtvo.getFileSize());
		    		// ==== 댓글읽어오기에 있어서 첨부파일 기능을 넣은 경우 끝 ==== //
		    		
		    		
		    		jsonArr.put(jsonObj);
		    	}// end of for----------------------------------------------
		    }
	  		
	  		return jsonArr.toString();
	  	}
	  	
	  	// === #132. 원게시물에 딸린 댓글의 totalPage 알아오기(JSON 으로 처리) === //
	  	@ResponseBody
	  	@GetMapping(value="getCommentTotalPage.action")
	  	public String getCommentTotalPage(HttpServletRequest request) {
	  		
	  		String parentSeq = request.getParameter("parentSeq");
	  		String sizePerPage = request.getParameter("sizePerPage");
	  		
	  		Map<String,String> paraMap = new HashMap<>();
	  		paraMap.put("parentSeq", parentSeq);
	  		paraMap.put("sizePerPage", sizePerPage);
	  		
	  		// 원글 글번호(parentSeq)에 해당하는 댓글의 totalPage 수 알아오기
	  		int totalPage = service.getCommentTotalPage(paraMap);
	  		
	  		JSONObject jsonObj = new JSONObject(); 
	  		jsonObj.put("totalPage", totalPage);  
	  		
	  		
	  		return jsonObj.toString();
	  	}
	  	
	
	  	
	*/ 	
	  		
	// ==== CS업무 관리 끝 ==== // 
	
	
	
}
