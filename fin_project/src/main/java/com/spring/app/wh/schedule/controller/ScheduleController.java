package com.spring.app.wh.schedule.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.common.MyUtil;
import com.spring.app.expedia.domain.HostVO;
import com.spring.app.expedia.domain.ReservationVO;
import com.spring.app.expedia.domain.RoomVO;
import com.spring.app.expedia.domain.UserVO;
import com.spring.app.wh.schedule.domain.*;
import com.spring.app.wh.schedule.service.ScheduleService;

@Controller
public class ScheduleController {

	@Autowired
	private ScheduleService service;
	
	
	// === 일정관리 시작 페이지 ===
	@GetMapping("/schedule/reservationScheduleManagement.exp")
	public ModelAndView requiredHostLogin_reservationScheduleManagement(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) { 
		
		mav.setViewName("wh/schedule/reservationScheduleManagement.tiles2");

		return mav;
	}
	
	
	// === 예약  정보를 담은 캘린더 불러오기 ===
	@ResponseBody
	@RequestMapping(value="/schedule/selectReservationSchedule.exp", produces="text/plain;charset=UTF-8")
	public String selectReservationSchedule(HttpServletRequest request) {
		
		// 등록된 일정 가져오기
		
		String h_userid = request.getParameter("fk_h_userid");
		
		
		String[] colors = {"#f37976", "#f89c59", "#f59eae", "#d5b5c2", "#b96b95", "#b6cc83", "#01686d", "#01ac88", "#9dd0cb", "#0082c0", "#86c5ee"};
		
		
		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("h_userid", h_userid);
		
		
		
		List<ReservationVO> reservationList = service.selectReservation(paraMap);
		
		JSONArray jsArr = new JSONArray();
		
		if(reservationList != null && reservationList.size() > 0) {
			int colorIndex = 0;
			Map<String, String> roomColorMap = new HashMap<>(); // 각 fk_rm_seq 값에 대한 색상을 저장하기 위한 맵
			
			for(ReservationVO rvo : reservationList) {
				JSONObject jsObj = new JSONObject();
				jsObj.put("rs_seq", rvo.getRs_seq());
				jsObj.put("fk_userid", rvo.getFk_userid());
				jsObj.put("fk_h_userid", rvo.getFk_h_userid());
				jsObj.put("rs_date", rvo.getRs_date());
				jsObj.put("rs_checkinDate", rvo.getRs_checkinDate());
				jsObj.put("rs_checkoutDate", rvo.getRs_checkoutDate());
				jsObj.put("rs_price", rvo.getRs_price());
				jsObj.put("rs_paytype", rvo.getRs_payType());
				jsObj.put("rs_guest_cnt", rvo.getRs_guest_cnt());
				jsObj.put("rs_name", rvo.getRs_name());
				jsObj.put("rs_mobile", rvo.getRs_mobile());
				jsObj.put("rs_email", rvo.getRs_email());
				jsObj.put("fk_rm_seq", rvo.getFk_rm_seq());
				// jsObj.put("lodge_id", rvo.getLodge_id() );

				if (!roomColorMap.containsKey(rvo.getFk_rm_seq())) { // roomColorMap 맵에 해당하는 fk_rm_seq 값이 이미 포함되어 있는지 여부를 확인하는 조건
	                roomColorMap.put(rvo.getFk_rm_seq(), colors[colorIndex % colors.length]); // containsKey() 메소드는 맵에 특정 키가 이미 존재하는지를 확인하는 메소드
	                colorIndex++; // 다음 색상으로 진행
	            }
	            
	            String color = roomColorMap.get(rvo.getFk_rm_seq());
	            jsObj.put("color", color); // 해당 방 번호에 대한 순환 색깔 설정
				
				jsArr.put(jsObj);
				
				
				
			}// end of for-------------------------------------
		
		}
		return jsArr.toString();
	}
	
	
	
	
	// === 숙소 예약 캘린더에서 객실등급 보여주기  ===
	@ResponseBody
	@GetMapping(value="/schedule/showRoomType.exp", produces="text/plain;charset=UTF-8") 
	public String showRoomType(HttpServletRequest request) {
		
		String fk_h_userid = request.getParameter("fk_h_userid");
		
		List<RoomVO> roomTypeList = service.showRoomType(fk_h_userid);
		
		JSONArray jsonArr = new JSONArray();
		
		if(roomTypeList != null) {
			for(RoomVO roomvo : roomTypeList) {
				JSONObject jsObj = new JSONObject();
				jsObj.put("rm_seq", roomvo.getRm_seq());
				jsObj.put("rm_type", roomvo.getRm_type());
				jsObj.put("fk_lodge_id", roomvo.getFk_lodge_id());
				jsObj.put("fk_h_userid", roomvo.getFk_h_userid());
				jsonArr.put(jsObj);
			}
		}
		
		return jsonArr.toString();
	}
	
	
	// === 풀캘린더에서 날짜 클릭할 때 발생하는 이벤트(예약 일정 추가) ===
	@PostMapping("/schedule/addReservationSchedule.exp")
	public ModelAndView requiredHostLogin_addReservationSchedule(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) { 
		
		// form 에서 받아온 날짜
		String chooseDate = request.getParameter("chooseDate");
		
		mav.addObject("chooseDate", chooseDate);
		mav.setViewName("wh/schedule/addReservationSchedule.tiles2");
		
		return mav;
	}
	
	
	// === 일정 등록시 숙소 등급 선택에 따른 객실 가격을 알아오기 ===
	@ResponseBody
	@GetMapping(value="/schedule/selectRoomType_price.exp", produces="text/plain;charset=UTF-8") 
	public String selectRoomType_price(HttpServletRequest request) {
		
		String fk_h_userid = request.getParameter("fk_h_userid");       // 사용자아이디
		
		List<RoomVO> roomList = service.selectRoomType_price(fk_h_userid);
			
		JSONArray jsArr = new JSONArray();
		if(roomList != null) {
			for(RoomVO roomvo : roomList) {
				JSONObject jsObj = new JSONObject();
				jsObj.put("rm_seq", roomvo.getRm_seq());
				jsObj.put("rm_type", roomvo.getRm_type());
				jsObj.put("rm_price", roomvo.getRm_price());
				
				jsArr.put(jsObj);
			}
		}
		
		return jsArr.toString();
	}
	
	
	
	
	// === 예약 일정 추가하기 ===
	@PostMapping("/schedule/addReservation_end.exp")
	public ModelAndView addReservation_end(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) throws Throwable {
		
		String startdate= request.getParameter("startdate");
   	//  System.out.println("확인용 startdate => " + startdate);
	//  확인용 startdate => 20231129140000
   	    
		String enddate = request.getParameter("enddate");
		String rm_cnt = request.getParameter("rm_cnt");
		String fk_rm_seq = request.getParameter("fk_rm_seq");
		String rm_price = request.getParameter("rm_price");
		String rs_name = request.getParameter("rs_name");
		String rs_mobile = request.getParameter("rs_mobile");
		String rs_email = request.getParameter("rs_email");
		String rs_guest_cnt = request.getParameter("rs_guest_cnt");
		String rs_payType = request.getParameter("rs_payType");
		
		String fk_h_userid = request.getParameter("fk_h_userid");
		String fk_userid = request.getParameter("fk_userid");
		
		/*
		System.out.println("확인용 startdate => "+startdate);
		System.out.println("확인용 enddate => "+enddate);
		System.out.println("확인용 rm_cnt => "+rm_cnt);
		System.out.println("확인용 fk_rm_seq => "+fk_rm_seq);
		System.out.println("확인용 rm_price => "+rm_price);
		System.out.println("확인용 rs_name => "+rs_name);
		System.out.println("확인용 rs_mobile => "+rs_mobile);
		System.out.println("확인용 rs_email => "+rs_email);
		System.out.println("확인용 rs_guest_cnt => "+rs_guest_cnt);
		System.out.println("확인용 rs_payType => "+rs_payType);
		System.out.println("확인용 fk_h_userid => "+fk_h_userid);
		System.out.println("확인용 fk_userid => "+fk_userid);
		*/
		
		
		
		
		Map<String,String> paraMap = new HashMap<String, String>();
		paraMap.put("startdate", startdate);
		paraMap.put("enddate", enddate);
		paraMap.put("rm_cnt", rm_cnt);
		paraMap.put("fk_rm_seq",fk_rm_seq);
		paraMap.put("rm_price",rm_price);
		paraMap.put("rs_name", rs_name);
		paraMap.put("rs_mobile", rs_mobile);
		paraMap.put("rs_email", rs_email);
		paraMap.put("rs_guest_cnt", rs_guest_cnt);
		paraMap.put("rs_payType", rs_payType);
		
		paraMap.put("fk_h_userid", fk_h_userid);
		paraMap.put("fk_userid", fk_userid);
		
		
		int n = service.addReservation_end(paraMap);

		if(n == 0) {
			mav.addObject("message", "일정 등록에 실패하였습니다.");
		}
		else {
			mav.addObject("message", "일정 등록에 성공하였습니다.");
		}
		
		mav.addObject("loc", request.getContextPath()+"/schedule/reservationScheduleManagement.exp");
		
		mav.setViewName("msg");
		
		return mav;
	}
	
	// === 예약 일정 추가 시 예약자 아이디의 존재여부 확인하기 === //
	@ResponseBody
	@GetMapping(value="/schedule/isExist_userid.exp", produces="text/plain;charset=UTF-8") 
	public String isExist_userid(HttpServletRequest request) {
		
		String fk_userid = request.getParameter("fk_userid");       // 사용자아이디
		
		UserVO uservo = service.isExist_userid(fk_userid);
			
		JSONObject jsObj = new JSONObject();
		
		if(uservo != null) {
			
			jsObj.put("userid", uservo.getUserid());
				
		}
		
		return jsObj.toString();
	}
	
	
	// === 예약 일정 상세보기 ===
	@RequestMapping(value="/schedule/detailReservationSchedule.exp")
	public ModelAndView detailReservationSchedule(ModelAndView mav, HttpServletRequest request) {
		
		String rs_seq = request.getParameter("rs_seq");
		
		// 검색하고 나서 취소 버튼 클릭했을 때 필요함
		String listgobackURL_schedule = request.getParameter("listgobackURL_schedule");
		mav.addObject("listgobackURL_schedule",listgobackURL_schedule);
		
		
		try {
			Integer.parseInt(rs_seq);
			Map<String,String> map = service.detailReservationSchedule(rs_seq);
			mav.addObject("map", map);
			mav.setViewName("wh/schedule/detailReservationSchedule.tiles2");
		} catch (NumberFormatException e) {
			mav.setViewName("redirect:wh/schedule/reservationScheduleManagement.exp");
		}
		
		return mav;
	}
	
	
	
	// === 예약 일정 삭제하기 ===
	@ResponseBody
	@PostMapping("/schedule/deleteReservationSchedule.exp")
	public String requiredHostLogin_deleteReservationSchedule(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		
		String rs_seq = request.getParameter("rs_seq");
				
		int n = service.deleteReservationSchedule(rs_seq);
		
		JSONObject jsObj = new JSONObject();
		jsObj.put("n", n);
			
		return jsObj.toString();
	}
	
	
	
	
	
	
	
	
	// === 예약 일정 검색 기능 === //
	@GetMapping("/schedule/searchSchedule.exp")
	public ModelAndView searchSchedule(HttpServletRequest request, ModelAndView mav) { 
		
		List<Map<String,String>> scheduleList = null;
		
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String fk_h_userid = request.getParameter("fk_h_userid");  // 로그인한 사용자id
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		String str_sizePerPage = request.getParameter("sizePerPage");
	
		String rs_seq = request.getParameter("rs_seq");
		
		
		// System.out.println("컨트롤러 확인용 startdate : "+startdate);
		// System.out.println("컨트롤러 확인용 enddate : "+enddate);
		// System.out.println("컨트롤러 확인용 searchType : "+searchType);
		// System.out.println("컨트롤러 확인용 searchWord : "+searchWord);
		// System.out.println("컨트롤러 확인용 fk_h_userid : "+fk_h_userid);
		// System.out.println("컨트롤러 확인용 rs_seq : "+rs_seq);
		
		
		if(searchType==null ) {  
			searchType="";
		}
		
		if(searchWord==null || "".equals(searchWord) || searchWord.trim().isEmpty()) {  
			searchWord="";
		}
		
		if(startdate==null || "".equals(startdate)) {
			startdate="";
		}
		
		if(enddate==null || "".equals(enddate)) {
			enddate="";
		}
			
		if(str_sizePerPage == null || "".equals(str_sizePerPage) || 
		   !("10".equals(str_sizePerPage) || "15".equals(str_sizePerPage) || "20".equals(str_sizePerPage))) {
				str_sizePerPage ="10";
		}
		
		if(rs_seq == null ) {
			rs_seq="";
		}
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("startdate", startdate);
		paraMap.put("enddate", enddate);
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		paraMap.put("fk_h_userid", fk_h_userid);
		paraMap.put("str_sizePerPage", str_sizePerPage);

		
		int totalCount=0;          // 총 게시물 건수		
		int currentShowPageNo=0;   // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함.
		int totalPage=0;           // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)  
		int sizePerPage = Integer.parseInt(str_sizePerPage);  // 한 페이지당 보여줄 행의 개수
		int startRno=0;            // 시작 행번호
	    int endRno=0;              // 끝 행번호 
	    
	    // 총 일정 검색 건수(totalCount)
	    totalCount = service.getTotalCount(paraMap);
	//  System.out.println("~~~ 확인용 총 일정 검색 건수 totalCount : " + totalCount);
      
	    totalPage = (int)Math.ceil((double)totalCount/sizePerPage); 

		if(str_currentShowPageNo == null) {
			currentShowPageNo = 1;
		}
		else {
			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
				if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
					currentShowPageNo = 1;
				}
			} catch (NumberFormatException e) {
				currentShowPageNo=1;
			}
		}
		
		startRno = ((currentShowPageNo - 1 ) * sizePerPage) + 1;
	    endRno = startRno + sizePerPage - 1;
	      
	    paraMap.put("startRno", String.valueOf(startRno));
	    paraMap.put("endRno", String.valueOf(endRno));
	    
	    // System.out.println("컨트롤러 확인용 startRno : "+startRno);
	    // System.out.println("컨트롤러 확인용 endRno : "+endRno);
	    
	    scheduleList = service.scheduleListSearchWithPaging(paraMap);
	    // 페이징 처리한 캘린더 가져오기(검색어가 없다라도 날짜범위 검색은 항시 포함된 것임)
		
		mav.addObject("paraMap", paraMap);
		// 검색대상 컬럼과 검색어를 유지시키기 위한 것임.
		
		// === 페이지바 만들기 === //
		int blockSize= 5;
		
		int loop = 1;
		
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
	   
		String pageBar = "<ul style='list-style:none;'>";
		
		String url = "searchSchedule.exp";
		
		// === [맨처음][이전] 만들기 ===
		if(pageNo!=1) {
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?startdate="+startdate+"&enddate="+enddate+"&searchType="+searchType+"&searchWord="+searchWord+"&fk_h_userid="+fk_h_userid+"&rs_seq="+rs_seq+"&sizePerPage="+sizePerPage+"&currentShowPageNo=1'>[맨처음]</a></li>";
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?startdate="+startdate+"&enddate="+enddate+"&searchType="+searchType+"&searchWord="+searchWord+"&fk_h_userid="+fk_h_userid+"&rs_seq="+rs_seq+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
		}
		while(!(loop>blockSize || pageNo>totalPage)) {
			
			if(pageNo==currentShowPageNo) {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";
			}
			else {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?startdate="+startdate+"&enddate="+enddate+"&searchType="+searchType+"&searchWord="+searchWord+"&fk_h_userid="+fk_h_userid+"&rs_seq="+rs_seq+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
			}
			
			loop++;
			pageNo++;
		}// end of while--------------------
		
		// === [다음][마지막] 만들기 === //
		if(pageNo <= totalPage) {
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?startdate="+startdate+"&enddate="+enddate+"&searchType="+searchType+"&searchWord="+searchWord+"&fk_h_userid="+fk_h_userid+"&rs_seq="+rs_seq+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?startdate="+startdate+"&enddate="+enddate+"&searchType="+searchType+"&searchWord="+searchWord+"&fk_h_userid="+fk_h_userid+"&rs_seq="+rs_seq+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
		}
		pageBar += "</ul>";
		
		mav.addObject("pageBar",pageBar);
		
		String listgobackURL_schedule = MyUtil.getCurrentURL(request);
	//	System.out.println("~~~ 확인용 검색 listgobackURL_schedule : " + listgobackURL_schedule);
		
		mav.addObject("listgobackURL_schedule",listgobackURL_schedule);
		mav.addObject("scheduleList", scheduleList);
		mav.setViewName("wh/schedule/searchSchedule.tiles2");

		return mav;
	}

	
	
	
	
	
	
	
	
	
}
