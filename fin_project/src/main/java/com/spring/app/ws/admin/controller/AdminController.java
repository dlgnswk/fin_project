package com.spring.app.ws.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.expedia.domain.UserVO;
import com.spring.app.ws.admin.service.AdminService;

@Controller
public class AdminController {

	@Autowired
	public AdminService service;
	
	
	@GetMapping(value="/searchUser.exp") 
	public ModelAndView searchUser(ModelAndView mav, HttpServletRequest request) {
		
		List<UserVO> userList = null;
		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String userLvlType = request.getParameter("userLvlType");
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		
		//확인용
		//System.out.println("searchType => " + searchType);
		//System.out.println("searchWord => " + searchWord);
		//System.out.println("userLvlType => " + userLvlType);
		//System.out.println("str_currentShowPageNo => " + str_currentShowPageNo);
		
		if(searchType == null) {
			searchType = "";
		}
		
		if(searchWord == null) {
			searchWord = "";
		}
		
		if(searchWord != null) {
			searchWord = searchWord.trim();
		}
		
		if(userLvlType == null) {
			userLvlType = "";
		}
		
		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("searchType",searchType);
		paraMap.put("searchWord",searchWord);
		paraMap.put("userLvlType",userLvlType);
	    
		int totalCnt = 0;				// 총 회원수
		int sizePerPage = 10;			// 한 페이지당 보여줄 회원수
		int currentShowPageNo = 0;		// 현재 페이지번호
		int totalPage = 0;				// 총 페이지 수
		
		// 총 회원수를 알아오는 메소드
		totalCnt = service.getTotalCnt(paraMap);
		//System.out.println("totalCnt => "+totalCnt);
		
		totalPage = (int) Math.ceil((double)totalCnt/sizePerPage);
		
		if(str_currentShowPageNo == null) {
			currentShowPageNo = 1;
		}
		else {
			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
    		   
				if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
    			   // 사용자가 str_currentShowPageNo 에 입력한 값이 0 또는 0이하의 값을 입력하여 장난친 경우
    			   // 사용자가 str_currentShowPageNo 에 입력한 값이 실제 데이터베이스에 존재하는 값보다 더 큰 값을 입력하여 장난친 경우
    			   currentShowPageNo = 1;
				}
    		   
			} catch (NumberFormatException e) {
			// get 방식이므로 사용자가 str_currentShowPageNo 에 입력한 값이 숫자가 아닌 문자를 입력하여 장난친 경우
			currentShowPageNo = 1;
			}
		}
		
		int startRno = ((currentShowPageNo - 1) * sizePerPage) + 1; 	// 시작 행번호
		int endRno = startRno + sizePerPage - 1;						// 끝 행번호
       
		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));
		
		// 페이징한 회원목록 가져오기
		userList = service.userListSearch(paraMap);
		
		mav.addObject("userList", userList);
		
		if("userid".equals(searchType)  || "email".equals(searchType) ||
           "name".equals(searchType) || "userLvlType".equals(userLvlType)) {
           mav.addObject("paraMap", paraMap);
        }
		
		
		// === 페이지바 만들기 시작 === //
		
		int blockSize = 3;
		int loop = 1;
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
		 
		String pageBar = "<ul style='list-style:none;'>";
	    String url = "searchUser.exp";
		
	    if(pageNo != 1) {
	    	   pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&userLvlType="+userLvlType+"&currentShowPageNo=1'>[처음]</a></li>";
	    	   pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&userLvlType="+userLvlType+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
	       }
	       
	       
	       while( !(loop > blockSize || pageNo > totalPage) ) {
	    	   
	    	   if(pageNo == currentShowPageNo) {
	    		   pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; padding:2px 4px;'>"+pageNo+"</li>";
	    	   }
	    	   else {
	    		   pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&userLvlType="+userLvlType+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
	    	   }
	    	   
	    	   loop++;
	    	   pageNo++;
	       } // end of while()------------------
	       
	       // === [다음][마지막] 만들기 === // 
	       if(pageNo <= totalPage ) {
	    	   pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&userLvlType="+userLvlType+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
	    	   pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&userLvlType="+userLvlType+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
	    	   	
	       }

	       pageBar += "</ul>"; 
	     
		
		// === 페이지바 만들기 끝 === //
	       
	    mav.addObject("pageBar", pageBar);
		mav.setViewName("ws/admin/searchUser.tiles1");

		return mav;
	}
	
	
	@ResponseBody
	@GetMapping(value="/searchUserShow.exp", produces="text/plain;charset=UTF-8")
	public String searchShow(HttpServletRequest request) {
		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		
		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("searchType",searchType);
		paraMap.put("searchWord",searchWord);
		
		List<String> searchList = service.searchUserShow(paraMap);
		
		JSONArray jsonArr = new JSONArray();
		
		if(searchList != null) {
			for(String search : searchList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("search", search);
				
				jsonArr.put(jsonObj);
			} // end of for------------
		}
		return jsonArr.toString();
	}
	
	
	
	
	@GetMapping(value="/searchHost.exp") 
	public ModelAndView searchHost(ModelAndView mav, HttpServletRequest request) {
		
		List<UserVO> hostList = null;
		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		
		//확인용
		//System.out.println("searchType => " + searchType);
		//System.out.println("searchWord => " + searchWord);
		//System.out.println("str_currentShowPageNo => " + str_currentShowPageNo);
		
		if(searchType == null) {
			searchType = "";
		}
		
		if(searchWord == null) {
			searchWord = "";
		}
		
		if(searchWord != null) {
			searchWord = searchWord.trim();
		}
		
		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("searchType",searchType);
		paraMap.put("searchWord",searchWord);
	    
		int totalCnt = 0;				// 총 판매자수
		int sizePerPage = 10;			// 한 페이지당 보여줄 판매자수
		int currentShowPageNo = 0;		// 현재 페이지번호
		int totalPage = 0;				// 총 페이지 수
		
		// 총 판매자수를 알아오는 메소드
		totalCnt = service.getHostCnt(paraMap);
		//System.out.println("totalCnt => "+totalCnt);
		
		totalPage = (int) Math.ceil((double)totalCnt/sizePerPage);
		
		if(str_currentShowPageNo == null) {
			currentShowPageNo = 1;
		}
		else {
			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
    		   
				if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
    			   // 사용자가 str_currentShowPageNo 에 입력한 값이 0 또는 0이하의 값을 입력하여 장난친 경우
    			   // 사용자가 str_currentShowPageNo 에 입력한 값이 실제 데이터베이스에 존재하는 값보다 더 큰 값을 입력하여 장난친 경우
    			   currentShowPageNo = 1;
				}
    		   
			} catch (NumberFormatException e) {
			// get 방식이므로 사용자가 str_currentShowPageNo 에 입력한 값이 숫자가 아닌 문자를 입력하여 장난친 경우
			currentShowPageNo = 1;
			}
		}
		
		int startRno = ((currentShowPageNo - 1) * sizePerPage) + 1; 	// 시작 행번호
		int endRno = startRno + sizePerPage - 1;						// 끝 행번호
       
		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));
		
		// 페이징한 판매자목록 가져오기
		hostList = service.hostListSearch(paraMap);
		
		mav.addObject("hostList", hostList);
		
		if("h_userid".equals(searchType)  || "h_name".equals(searchType) ||
           "h_lodgename".equals(searchType) || "h_businessNo".equals(searchType)) {
           mav.addObject("paraMap", paraMap);
        }
		
		
		// === 페이지바 만들기 시작 === //
		int blockSize = 3;
		int loop = 1;
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
		 
		String pageBar = "<ul style='list-style:none;'>";
	    String url = "searchHost.exp";
		
	    if(pageNo != 1) {
	    	   pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo=1'>[처음]</a></li>";
	    	   pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
	       }
	       
	       
	       while( !(loop > blockSize || pageNo > totalPage) ) {
	    	   
	    	   if(pageNo == currentShowPageNo) {
	    		   pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; padding:2px 4px;'>"+pageNo+"</li>";
	    	   }
	    	   else {
	    		   pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
	    	   }
	    	   
	    	   loop++;
	    	   pageNo++;
	       } // end of while()------------------
	       
	       // === [다음][마지막] 만들기 === // 
	       if(pageNo <= totalPage ) {
	    	   pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
	    	   pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
	       }
	       pageBar += "</ul>"; 
	     
		// === 페이지바 만들기 끝 === //
	       
	    mav.addObject("pageBar", pageBar);
		mav.setViewName("ws/admin/searchHost.tiles1");

		return mav;
	}
	
	
	@ResponseBody
	@GetMapping(value="/searchHostShow.exp", produces="text/plain;charset=UTF-8")
	public String searchHostShow(HttpServletRequest request) {
		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		
		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("searchType",searchType);
		paraMap.put("searchWord",searchWord);
		
		List<String> searchList = service.searchHostShow(paraMap);
		
		JSONArray jsonArr = new JSONArray();
		
		if(searchList != null) {
			for(String search : searchList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("search", search);
				
				jsonArr.put(jsonObj);
			} // end of for------------
		}
		return jsonArr.toString();
	}
	
	
	@ResponseBody
    @GetMapping(value = "/searchBusinessNo.exp", produces = "text/plain;charset=UTF-8")
	public String searchBusinessNo(HttpServletRequest request) {
		
		String hostName = request.getParameter("hostName");
		String legalName = request.getParameter("legalName");
		String businessNo = request.getParameter("businessNo");
		
		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("hostName",hostName);
		paraMap.put("legalName",legalName);
		paraMap.put("businessNo",businessNo);
		
		// tbl_irs 테이블에서 사업자번호의 유효성을 확인하는 메소드
		int n = service.searchBusinessNo(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}

	
	
	@ResponseBody
    @GetMapping(value = "/businessApprove.exp", produces = "text/plain;charset=UTF-8")
	public String businessApprove(HttpServletRequest request) {
		
		String hostId = request.getParameter("hostId");
		
		// tbl_host 테이블에서 status를 1로 update해주는 메소드
		int n = service.businessApprove(hostId);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	
	
	@ResponseBody
    @GetMapping(value = "/businessReject.exp", produces = "text/plain;charset=UTF-8")
	public String businessReject(HttpServletRequest request) {
		
		String hostId = request.getParameter("hostId");
		
		// tbl_host 테이블에서 status를 2로 update해주는 메소드
		int n = service.businessReject(hostId);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	
	
	
	// 숙박시설 관리
	@GetMapping(value="/searchLodge.exp") 
	public ModelAndView searchLodge(ModelAndView mav, HttpServletRequest request) {
		
		List<List<Map<String, String>>> lodgeIdMapList = null;
		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String lg_status = request.getParameter("lg_status");
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		
		//확인용
		//System.out.println("searchType => " + searchType);
		//System.out.println("searchWord => " + searchWord);
		//System.out.println("lg_status => " + lg_status);
		//System.out.println("str_currentShowPageNo => " + str_currentShowPageNo);
		
		if(searchType == null) {
			searchType = "";
		}
		
		if(searchWord == null) {
			searchWord = "";
		}
		
		if(searchWord != null) {
			searchWord = searchWord.trim();
		}
		
		if(lg_status == null) {
		   lg_status = "";
		}
		
		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("searchType",searchType);
		paraMap.put("searchWord",searchWord);
		paraMap.put("lg_status",lg_status);
	    
		int lodgeCnt = 0;				// 총 숙소 수
		int sizePerPage = 10;			// 한 페이지당 보여줄 회원수
		int currentShowPageNo = 0;		// 현재 페이지번호
		int totalPage = 0;				// 총 페이지 수
		
		// 총 숙소 수를 알아오는 메소드
		lodgeCnt = service.getLodgeCnt(paraMap);
		System.out.println("lodgeCnt => "+lodgeCnt);
		
		totalPage = (int) Math.ceil((double)lodgeCnt/sizePerPage);
		if(str_currentShowPageNo == null) {
			currentShowPageNo = 1;
		}
		else {
			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
    		   
				if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
    			   // 사용자가 str_currentShowPageNo 에 입력한 값이 0 또는 0이하의 값을 입력하여 장난친 경우
    			   // 사용자가 str_currentShowPageNo 에 입력한 값이 실제 데이터베이스에 존재하는 값보다 더 큰 값을 입력하여 장난친 경우
    			   currentShowPageNo = 1;
				}
    		   
			} catch (NumberFormatException e) {
			// get 방식이므로 사용자가 str_currentShowPageNo 에 입력한 값이 숫자가 아닌 문자를 입력하여 장난친 경우
			currentShowPageNo = 1;
			}
		}
		int startRno = ((currentShowPageNo - 1) * sizePerPage) + 1; 	// 시작 행번호
		int endRno = startRno + sizePerPage - 1;						// 끝 행번호
       
		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));
		
		// 페이징한 숙소목록 가져오기
		lodgeIdMapList = service.lodgeListSearch(paraMap);
		mav.addObject("lodgeIdMapList", lodgeIdMapList);
		
		if("fk_h_userid".equals(searchType)   || "lg_name".equals(searchType) ||
           "total_address".equals(searchType) || "lg_status".equals(lg_status)) {
			
           mav.addObject("paraMap", paraMap);
        }
		
		// 숙소 외관 사진 가져오기
		
		
		// === 페이지바 만들기 시작 === //
		
		int blockSize = 3;
		int loop = 1;
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
		String pageBar = "<ul style='list-style:none;'>";
	    String url = "searchLodge.exp";
		
	    if(pageNo != 1) {
	    	   pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&lg_status="+lg_status+"&currentShowPageNo=1'>[처음]</a></li>";
	    	   pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&lg_status="+lg_status+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
	       }
	       
	       
	       while( !(loop > blockSize || pageNo > totalPage) ) {
	    	   
	    	   if(pageNo == currentShowPageNo) {
	    		   pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; padding:2px 4px;'>"+pageNo+"</li>";
	    	   }
	    	   else {
	    		   pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&lg_status="+lg_status+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
	    	   }
	    	   
	    	   loop++;
	    	   pageNo++;
	       } // end of while()------------------
	       
	       // === [다음][마지막] 만들기 === // 
	       if(pageNo <= totalPage ) {
	    	   pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&lg_status="+lg_status+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
	    	   pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&lg_status="+lg_status+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
	    	   	
	       }

	       pageBar += "</ul>"; 
	     
		// === 페이지바 만들기 끝 === //
	       
	    mav.addObject("pageBar", pageBar);
		mav.setViewName("ws/admin/searchLodge.tiles1");

		return mav;
	}
	
	
	@ResponseBody
	@GetMapping(value="/searchLodgeShow.exp", produces="text/plain;charset=UTF-8")
	public String searchLodgeShow(HttpServletRequest request) {
		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		
		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("searchType",searchType);
		paraMap.put("searchWord",searchWord);
		
		List<String> searchList = service.searchLodgeShow(paraMap);
		
		JSONArray jsonArr = new JSONArray();
		
		if(searchList != null) {
			for(String search : searchList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("search", search);
				
				jsonArr.put(jsonObj);
			} // end of for------------
		}
		return jsonArr.toString();
	}
	
	
	
	@ResponseBody
    @GetMapping(value = "/lodgeRegistrationApprove.exp", produces = "text/plain;charset=UTF-8")
	public String lodgeRegistrationApprove(HttpServletRequest request) {
		
		String lodge_id = request.getParameter("lodge_id");
		
		// tbl_lodge 테이블에서 lg_status를 1로 update해주는 메소드
		int n = service.lodgeRegistrationApprove(lodge_id);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	
	
	@ResponseBody
    @GetMapping(value = "/lodgeRegistrationReject.exp", produces = "text/plain;charset=UTF-8")
	public String lodgeRegistrationReject(HttpServletRequest request) {
		
		String lodge_id = request.getParameter("lodge_id");
		
		// tbl_lodge 테이블에서 lg_status를 0로 update해주는 메소드
		int n = service.lodgeRegistrationReject(lodge_id);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	

	@ResponseBody
	@GetMapping(value="/statistics.exp", produces="text/plain;charset=UTF-8")
	public ModelAndView statistics(ModelAndView mav, HttpServletRequest request) {
		mav.setViewName("ws/admin/statistics.tiles1");
		return mav;
	}
	
	
	
	// 차트그리기(AJAX) 년도별 성별 등록 회원수
	@ResponseBody
	@RequestMapping(value="/admin/yearGenderUser.exp", produces="text/plain;charset=UTF-8")
	public String yearGenderUser() {
		
		return service.yearGenderUser();
	}
	
	
	
	
	// 차트그리기(AJAX) 행정구역별 숙박시설 점유율
	@ResponseBody
	@RequestMapping(value="/chart/regionOccupancy.exp", produces="text/plain;charset=UTF-8")
	public String regionOccupancy() {
		
		return service.regionOccupancy();
	}
	
	
	// 차트그리기(AJAX) 특정 행정구역에 존재하는 숙박시설들 중 객실수의 퍼센티지
	@ResponseBody
	@RequestMapping(value="/chart/lodgeQtyPercentage.exp", produces="text/plain;charset=UTF-8")
	public String lodgeQtyPercentage(@RequestParam(defaultValue = "")String lg_area) {
		
		return service.lodgeQtyPercentage(lg_area);
	}
	
	
	// 차트그리기(AJAX) 분기별 숙박시설 전체 예약건수
	@ResponseBody
	@RequestMapping(value="/chart/quatorTotalReservation.exp", produces="text/plain;charset=UTF-8")
	public String quatorTotalReservation() {
		
		return service.quatorTotalReservation();
	}
	
	
	
}