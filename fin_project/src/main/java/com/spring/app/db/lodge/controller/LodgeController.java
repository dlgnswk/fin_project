package com.spring.app.db.lodge.controller;

import java.io.File;
import java.io.FileOutputStream;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.spring.app.common.FileManager;
import com.spring.app.db.lodge.service.LodgeService;
import com.spring.app.expedia.domain.HostVO;

@Controller
public class LodgeController {
	
	@Autowired
	private LodgeService service;
	
	@Autowired // Type에 따라 알아서 Bean 을 주입해준다.
	private FileManager fileManager;
	
	/////////////////////////// 시설 등록 /////////////////////////////////////	
	
	// *** 숙박 시설 등록 페이지 *** //
	@RequestMapping(value="/register_lodge.exp")
	public String requiredHostLogin_register_lodge(HttpServletRequest request,
												   HttpServletResponse response) {
		
		// !!!! 로그인 한 사용자(판매자)에게 사용자등록번호를 받아와 넣어줘야 한다.
		// 관리자 승인 유무 체크
		HttpSession session = request.getSession();
		HostVO loginhost = (HostVO) session.getAttribute("loginhost");
		
		String fk_h_userid = loginhost.getH_userid();
		
	//	System.out.println("fk_h_userid => "+ fk_h_userid); // 현재 로그인 호스트의 아이디 이다.
		
		// 현재 로그인한 판매자의 ID로 숙박시설의 lodge_id를 가져온다.
		String fk_lodge_id = service.getLodgeIdByUserId(fk_h_userid);
		
	//	System.out.println("fk_lodge_id => "+ fk_lodge_id); // 현재 로그인 호스트의 호텔아이디 이다.
		String front_id = "";
		String back_id = "";
		
		if(fk_lodge_id != null) {
			front_id = fk_lodge_id.substring(0,4);
			back_id = fk_lodge_id.substring(4);
		}
		
		
		// == 숙박시설 유형 테이블에서 select == //
		List<Map<String,String>> lodgeTypeMapList = service.getLodgeType();
		
		// == 환불 정책 select == //
		List<Map<String,String>> CancelOptionMapList = service.getCancelOption();
		
		// == 시간대 만들기 -시작- == //
		List<Map<String,String>> timesMapList = new ArrayList<>();
		for(int i=1; i<=24; i++) {
			Map<String,String> times = new HashMap<>();
			
			times.put("time", String.valueOf(i));
			
			if(i <= 12) {
				if(i == 12) {
					times.put("text_time","정오");
				}
				else if (i <= 9 && i != 12) {
					times.put("text_time","0"+i+":00 AM");
				}
				else if (i >= 10 && i != 12) {
					times.put("text_time",i+":00 AM");
				}
			}
			else if (i >= 13) {
				if (i-12 == 12) {
					times.put("text_time","자정");
				}
				else if (i-12 <= 9 && i-12 != 12) {
					times.put("text_time","0"+(i-12)+":00 PM");
				} 
				else if (i-12 >= 10 && i-12 != 12) {
					times.put("text_time",(i-12)+":00 PM");
				}
			}
			
			timesMapList.add(times);
		}
		// == 시간대 만들기 -끝- == //
		
		// == 셀프 체크인 방법 select == //
		List<Map<String,String>> selfCheckinOptionMapList = service.getSelfCheckinOption();
		
		// == 나이 제한 -시작- == //
		List<String> limitAgeRangeList = new ArrayList<>();
		
		for(int i=15; i<=25; i++) {
			limitAgeRangeList.add(String.valueOf(i));
		}
		// == 나이 제한 -끝- == //
		
		
		// == 인터넷 옵션 체크박스 == //
		List<Map<String,String>> internetOptionMapList = service.getInternetOption();
		
		// == 주차장 옵션 체크박스  == //
		List<Map<String,String>> parkOptionMapList = service.getParkOption();
		
		// == 수영장 종류 체크박스 == //
		List<Map<String,String>> poolTypeMapList = service.getPoolType();
		
		// == 스파 서비스 종류 셀렉트 == //
		List<Map<String,String>> spaTypeMapList = service.getSpaType();
		
		// == 다이닝 장소 종류 체크박스 == //
		List<Map<String,String>> diningPlaceMapList = service.getDiningPlace();
	
		// == 장애인 편의 시설 정보 체크박스 == //
		List<Map<String,String>> facilityInfoMapList = service.getFacilityInfo();
		
		// == 고객서비스 종류 체크박스 == //
		List<Map<String,String>> consumerServiceTypeMapList = service.getConsumerService();
		
		// == 룸 서비스 종류 체크박스  == //
		List<Map<String,String>> roomServiceMapList = service.getRoomService();
		
		// == 비즈니스 공간 종류 체크박스 == //
		List<Map<String,String>> businessTypeMapList = service.getBusinessType();
		
		// == 가족서비스 종류 체크박스 == //
		List<Map<String,String>> familyServiceTypeMapList = service.getFamilyServiceType();

		
		
		
		request.setAttribute("lodgeTypeMapList", lodgeTypeMapList); 					// 숙박시설 유형
		request.setAttribute("CancelOptionMapList", CancelOptionMapList); 				// 환불 정책
		request.setAttribute("timesMapList", timesMapList);								// 시간 선택지
		request.setAttribute("selfCheckinOptionMapList", selfCheckinOptionMapList); 	// 셀프체크인 방법
		request.setAttribute("limitAgeRangeList", limitAgeRangeList);					// 나이 제한
		request.setAttribute("internetOptionMapList", internetOptionMapList); 	// 인터넷 옵션 체크박스 (중복 가능)
		request.setAttribute("parkOptionMapList", parkOptionMapList);			// 주차장 옵션 체크박스 (중복 가능)
		request.setAttribute("poolTypeMapList", poolTypeMapList);				// 수영장 종류 체크박스 (중복 가능)
		request.setAttribute("spaTypeMapList", spaTypeMapList);					// 스파 종류 셀렉트 (중복 불가)
		request.setAttribute("diningPlaceMapList", diningPlaceMapList);			// 다이닝 장소 종류 체크박스 (중복가능)
		request.setAttribute("facilityInfoMapList", facilityInfoMapList);		// 장애인 편의 시설 정보 체크박스(중복가능)
		request.setAttribute("consumerServiceTypeMapList", consumerServiceTypeMapList);	// 고객서비스 종류 체크박스(중복가능)
		request.setAttribute("roomServiceMapList", roomServiceMapList);			// 룸서비스 종류 체크박스(중복가능)
		request.setAttribute("businessTypeMapList", businessTypeMapList);		// 비즈니스 공간 종류 체크박스(중복가능)
		request.setAttribute("familyServiceTypeMapList", familyServiceTypeMapList);		// 가족서비스 종류 체크박스(중복가능)
		
		// 이미 호텔이 등록되어 있는 경우 보여준다.
		request.setAttribute("fk_lodge_id", fk_lodge_id);
		request.setAttribute("front_id", front_id);
		request.setAttribute("back_id", back_id);
		
		return "db/register/register_lodge.tiles2";
		// /WEB-INF/views/tiles2/db/register/register_lodge.jsp
		// /WEB-INF/views/tiles2/{1}/{2}/{3}.jsp
	}
	
	
	// === *** 숙박시설 등록 *** === //
	@PostMapping(value="/lodge_register.exp", produces = "text/plain;charset=UTF-8")
	public String requiredHostLogin_lodgeRegister(HttpServletRequest request, HttpServletResponse response,
												  @RequestParam(required = false) HashMap<String,String> paraMap) {
		
		
		// 숙박시설 등록 데이터 -시작- //
		String lodge_id = paraMap.get("lodge_id");
		String fk_h_userid = paraMap.get("fk_h_userid");
		String lg_name = paraMap.get("lg_name");
		String lg_en_name = paraMap.get("lg_en_name");
		String lg_postcode = paraMap.get("lg_postcode");
		
		String lg_address = paraMap.get("lg_address");
		String lg_detailaddress = paraMap.get("lg_detailaddress");
		String lg_extraaddress = paraMap.get("lg_extraaddress");
		String lg_latitude = paraMap.get("lg_latitude");
		String lg_longitude = paraMap.get("lg_longitude"); // 10
		
		String lg_area = paraMap.get("lg_area");
		String lg_area_2 = paraMap.get("lg_area_2");
		String fk_lodge_type = paraMap.get("fk_lodge_type");
		
		String lg_hotel_star = paraMap.get("lg_hotel_star");
		if(lg_hotel_star == null) {
			lg_hotel_star ="";
			paraMap.put("lg_hotel_star", lg_hotel_star);
		}
		
		String lg_qty = paraMap.get("lg_qty");
		
		String fk_cancel_opt = paraMap.get("fk_cancel_opt");
		String fd_status = paraMap.get("fd_status");
		String fd_time = paraMap.get("fd_time");
		String fk_s_checkin_type = paraMap.get("fk_s_checkin_type");
		String lg_checkin_start_time = paraMap.get("lg_checkin_start_time"); // 20
		
		String lg_checkin_end_time = paraMap.get("lg_checkin_end_time");
		String lg_checkout_time = paraMap.get("lg_checkout_time");
		String lg_age_limit = paraMap.get("lg_age_limit");
		String lg_internet_yn = paraMap.get("lg_internet_yn");
		String lg_park_yn = paraMap.get("lg_park_yn");
		
		String lg_breakfast_yn = paraMap.get("lg_breakfast_yn");
		String lg_dining_place_yn = paraMap.get("lg_dining_place_yn");
		String lg_pool_yn = paraMap.get("lg_pool_yn");
		String lg_pet_yn = paraMap.get("lg_pet_yn");
		String lg_pet_fare = paraMap.get("lg_pet_fare");	// 30
	
		if(paraMap.get("lg_pet_fare") == null) {
			lg_pet_fare = "없음";
			paraMap.put("lg_pet_fare", lg_pet_fare);
		}
	
		
		String lg_fac_yn = paraMap.get("lg_fac_yn");
		String lg_service_yn = paraMap.get("lg_service_yn");
		String lg_rm_service_yn = paraMap.get("lg_rm_service_yn"); 
		String lg_beach_yn = paraMap.get("lg_beach_yn");
		String lg_business_yn = paraMap.get("lg_business_yn");
		
		String lg_fa_travel_yn = paraMap.get("lg_fa_travel_yn");
		String fk_spa_type = paraMap.get("fk_spa_type");
		String lg_smoke_yn = paraMap.get("lg_smoke_yn");
	//	String lg_status = paraMap.get("lg_status"); // default 삽입  // 39
		
		// 숙박시설 등록 데이터 -끝- //
		
		
		
//		String lg_pet_fare = paraMap.get("lg_pet_fare");
	/*
		if( lg_pet_fare == null ) {
			lg_pet_fare = "없음";
		} else {
			// number 태그 값이 0000 일경우 0으로 바꿔준다.
			int int_lg_pet_fare = Integer.parseInt(lg_pet_fare);
			lg_pet_fare = String.valueOf(int_lg_pet_fare);
		}
	*/
		
		System.out.println("lodge_id => " + lodge_id);
		System.out.println("fk_h_userid => " + fk_h_userid);
		System.out.println("lg_name => " + lg_name);
		System.out.println("lg_en_name => " + lg_en_name);
		System.out.println("lg_postcode => " + lg_postcode);
		
		System.out.println("lg_address => " + lg_address);
		System.out.println("lg_detailaddress => " + lg_detailaddress);
		System.out.println("lg_extraaddress => " + lg_extraaddress);
		System.out.println("lg_latitude => " + lg_latitude);
		System.out.println("lg_longitude => " + lg_longitude); // 10
		
		System.out.println("lg_area => " + lg_area);  // "없음"
		System.out.println("lg_area_2 => " + lg_area_2);
		System.out.println("fk_lodge_type => " + fk_lodge_type);
		System.out.println("lg_hotel_star => " + lg_hotel_star);
		System.out.println("lg_qty => " + lg_qty);
		
		System.out.println("fk_cancel_opt => " + fk_cancel_opt);
		System.out.println("fd_status => " + fd_status);
		System.out.println("fd_time => " + fd_time);
		System.out.println("fk_s_checkin_type => " + fk_s_checkin_type);
		System.out.println("lg_checkin_start_time => " + lg_checkin_start_time); // 20
		
		System.out.println("lg_checkin_end_time => " + lg_checkin_end_time);
		System.out.println("lg_checkout_time => " + lg_checkout_time);
		System.out.println("lg_age_limit => " + lg_age_limit);
		System.out.println("lg_internet_yn => " + lg_internet_yn);
		System.out.println("lg_park_yn => " + lg_park_yn);

		System.out.println("lg_breakfast_yn => " + lg_breakfast_yn);
		System.out.println("lg_dining_place_yn => " + lg_dining_place_yn);
		System.out.println("lg_pool_yn => " + lg_pool_yn);
		System.out.println("lg_pet_yn => " + lg_pet_yn);
		System.out.println("lg_pet_fare => " + lg_pet_fare); // 30
		
		System.out.println("lg_fac_yn => " + lg_fac_yn);
		System.out.println("lg_service_yn => " + lg_service_yn);
		System.out.println("lg_rm_service_yn => " + lg_rm_service_yn);
		System.out.println("lg_beach_yn => " + lg_beach_yn);
		System.out.println("lg_business_yn => " + lg_business_yn);
		
		System.out.println("lg_fa_travel_yn => " + lg_fa_travel_yn);
		System.out.println("fk_spa_type => " + fk_spa_type);
		System.out.println("lg_smoke_yn => " + lg_smoke_yn); // 39
	//	System.out.println("lg_status => " + lg_status); // defaulut 삽입
		
	
		int n = 0;
		try {
			// *** === 숙박시설테이블 데이터 등록 === *** //
			n = service.lodgeRegister(paraMap, request);
			
		} catch (Throwable e) {
			e.printStackTrace();
		}
		
		// 등록 이후
		if( n == 1 ) {
		// 숙박시설 등록 성공
		// 페이지 이동
			request.setAttribute("message", "숙박시설이 등록되었습니다.");
			request.setAttribute("loc", request.getContextPath()+"/lodgeControl.exp");
		}
		else {
		// 숙박시설등록 실패
			request.setAttribute("message", "시설 등록중 문제가 발생했습니다.");
			request.setAttribute("loc", request.getContextPath()+"/lodgeControl.exp");
		}
		
		/*
			Controller 에서  return "product/prodview"; 로 하면
	               자동적으로 view단 페이지는   "/WEB-INF/views/product/prodview.jsp"; 가 되어진다.
	               
       		위치는 숙박 시설 관리 페이지로 이동 /webapp/WEB-INF/views/msg.jsp
		 */
		return "msg";
	}
	
	
	// end time 가져오기
	@ResponseBody
	@GetMapping(value = "/getEndTime.exp", produces = "text/plain;charset=UTF-8") // GET 방식만 허락한 것이다.
	public String ajax_select(@RequestParam String start_time_val,
							  @RequestParam String anytime) {
		// 뷰단에서 선택된 체크인 시작 시간
	//	System.out.println(start_time_val);
		// start_time_val 1 ~ 24
		int start_time = 0;
		
		try {
			start_time = Integer.parseInt(start_time_val);
		} catch (Exception e) {
			System.out.println("end time controller error");
		}
		
		JsonArray jsonArr = new JsonArray();
		
		if("1".equals(anytime)) {
		// anytime이 "1"로 넘어온 경우 select에 "언제든지"선택지 추가.
			JsonObject jsonObj = new JsonObject();
			jsonObj.addProperty("text_time","언제든지");
			jsonArr.add(jsonObj);
		}
		
		for(int i=start_time+1; i<=start_time+23; i++) {
			JsonObject jsonObj = new JsonObject();
			
			// 체크인 시작 시간 1시간 전까지 최대 23시간 
			// start_time = 01:00AM		=> end_time_text = 02:00AM ~ 다음날 자정
			// start_time = 정오			=> end_time_text = 01:00PM ~ 다음날 11:00AM
			// start_time = 11pm		=> end_time_text = 자정 	   ~ 다음날 10:00PM 
			// start_time = 자정   		=> end_time_text = 다음날 01:00AM ~ 다음날 11:00PM
			// 정오 = 12
			if(i <= 24) {
			// 24시간 보다 작음
				if(i <= 12) {
					if(i == 12) {
						jsonObj.addProperty("text_time","정오");
					}
					else if (i <= 9 && i != 12) {
						jsonObj.addProperty("text_time","0"+i+":00 AM");
					}
					else if (i >= 10 && i != 12) {
						jsonObj.addProperty("text_time",i+":00 AM");
					}
				}
				else if (i >= 13) {
					if (i-12 == 12) {
						jsonObj.addProperty("text_time","자정");
					}
					else if (i-12 <= 9 && i-12 != 12) {
						jsonObj.addProperty("text_time","0"+(i-12)+":00 PM");
					} 
					else if (i-12 >= 10 && i-12 != 12) {
						jsonObj.addProperty("text_time",(i-12)+":00 PM");
					}
				}
			}
			else if(i >= 25) {
				
				if(i-24 <= 12) {
					if(i-24 == 12) {
						jsonObj.addProperty("text_time","다음날 정오");
					}
					else if (i-24 <= 9 && i-24 != 12) {
						jsonObj.addProperty("text_time","다음날 0"+(i-24)+":00 AM");
					}
					else if (i-24 >= 10 && i-24 != 12) {
						jsonObj.addProperty("text_time","다음날 "+(i-24)+":00 AM");
					}
				}
				else if (i-24 >= 13) {
					if (i-36 == 12) {
						jsonObj.addProperty("text_time","다음날 자정");
					}
					else if (i-36 <= 9 && i-36 != 12) {
						jsonObj.addProperty("text_time","다음날 0"+(i-36)+":00 PM");
					} 
					else if (i-36 >= 10 && i-36 != 12) {
						jsonObj.addProperty("text_time","다음날 "+(i-36)+":00 PM");
					}
				}
			}
			
			jsonArr.add(jsonObj);
		}// end of for ----------------
		
		return new Gson().toJson(jsonArr); 
	} // end of public String ajax_select() ---------
	
	
	// == 숙박시설 ID 중복 체크 ajax == //
	@ResponseBody
	@GetMapping(value = "/compareLodgeId.exp", produces = "text/plain;charset=UTF-8") // GET 방식만 허락한 것이다.
	public String compareLodgeId(@RequestParam String lodge_id) {
		
	//	System.out.println(lodge_id);
		
		// DB에 입력되어 있는 숙박시설 ID 가져오기 //
		String compareLodgeId = service.getLodgeId(lodge_id);
		
		JSONObject jsonObj = new JSONObject();
	//	System.out.println(lodge_id +" ?= " + compareLodgeId);
		
		if( lodge_id != null) {
		// 입력해온 lodge_id가 null 이 아닌 경우 
			if(lodge_id.equals(compareLodgeId)) {
				jsonObj.put("IdCheck", "0"); // "IdCheck":"0" 같은 아이디 존재
			} 
			else {
				jsonObj.put("IdCheck", "1"); // "IdCheck":"1" 사용가능 
			}
		}
		
		return jsonObj.toString(); 
	} // end of public String ajax_select() ---------
	
	
	/////////////////////////// 시설 사진 등록 /////////////////////////////////////
	
	// 시설 사진 등록 페이지
	@GetMapping(value="/image_lodge.exp")
	public String requiredHostLogin_image_lodge(HttpServletRequest request, HttpServletResponse response) {
		
		// ================= AOP 로그인한 사용자의 정보 -시작- ==================== //
		HttpSession session = request.getSession();
		HostVO loginhost = (HostVO) session.getAttribute("loginhost");
		String fk_h_userid = loginhost.getH_userid();
		// 현재 로그인한 판매자의 ID로 숙박시설의 lodge_id를 가져온다.
		String fk_lodge_id = service.getLodgeIdByUserId(fk_h_userid);
		// ================= AOP 로그인한 사용자의 정보 -끝- ====================== //
		
		// DB에 등록된 이미지 파일명을 가지고 온다.
		List<Map<String,String>> LodgeImgMapList = service.getLodgeImgData(fk_lodge_id);
		
		
		request.setAttribute("LodgeImgMapList", LodgeImgMapList);
		
		return "db/register/image_lodge.tiles2";
		// /WEB-INF/views/tiles2/db/register/register_lodge.jsp
		// /WEB-INF/views/tiles2/{1}/{2}/{3}.jsp
	}
	
	
	// 시설 사진 등록 버튼 클릭시
	@ResponseBody
	@PostMapping(value="/image_lodge.exp")
	public String requiredHostLogin_image_register(HttpServletRequest request, HttpServletResponse response,
												   MultipartHttpServletRequest mtp_request) {
		
		List<MultipartFile> mainImage_List  = mtp_request.getFiles("mainImage_arr");
		List<MultipartFile> outImage_List  = mtp_request.getFiles("outImage_arr");
		List<MultipartFile> publicImage_List  = mtp_request.getFiles("publicImage_arr");
		List<MultipartFile> poolImage_List  = mtp_request.getFiles("poolImage_arr");
		List<MultipartFile> diningImage_List  = mtp_request.getFiles("diningImage_arr");
		List<MultipartFile> serviceImage_List  = mtp_request.getFiles("serviceImage_arr");
		List<MultipartFile> viewImage_List  = mtp_request.getFiles("viewImage_arr");
		
		
		HttpSession session = request.getSession();
		HostVO loginhost = (HostVO) session.getAttribute("loginhost");
		
		String fk_h_userid = loginhost.getH_userid();
		// 현재 로그인한 판매자의 ID로 숙박시설의 lodge_id를 가져온다.
		String fk_lodge_id = service.getLodgeIdByUserId(fk_h_userid);
		System.out.println("fk_lodge_id => "+ fk_lodge_id);
		
	//	String fk_lodge_id = "JSUN0231";
		
		// 시설 이미지를 저장할 경로
//		HttpSession session = mtp_request.getSession();
//		String root = session.getServletContext().getRealPath("/");
//		String path = root + "resources"+File.separator+"images"+File.separator+fk_lodge_id+File.separator+"lodge_img";
		
		String root = "C:\\git\\fin_project\\fin_project\\src\\main\\webapp\\resources";
		String path = root +File.separator+"images"+File.separator+fk_lodge_id+File.separator+"lodge_img";
		
		System.out.println(path);
		// C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\final_project\resources\images\ "JSUN0231" \lodge_img
		File dir = new File(path);
		
		// ==== 등록전 사전에 등록된 이미지 제거 ==== // 
		if(dir.exists()) {
		// images\ "JSUN0231" \lodge_img 파일이 존재하면 제거한다.
		// 삭제하려는 파일이 폴더이고 폴더 안에 내용물이 있다면 삭제가 되지 않는다.
			File[] folderList = dir.listFiles(); // 폴더의 내용물이 있는지 확인하다.
			if( folderList.length > 0) {
			// 폴더의 내용물이 있다면 전부다 삭제해야 한다.
				for(int i=0; i<folderList.length; i++) {
					folderList[i].delete();
				} // end of for --------------
			} // end of if( folderList.length > 0) ------------
			
		} // end of if(dir.exists()) -----------
			
		// ==== tbl_lg_img 테이블 정보 제거 == //
		service.delLodgeImg(fk_lodge_id); // 테이블 값 제거하기
			
		
		if(!dir.exists()) {
		//	dir.mkdir(); // 상위 디렉토리 없으면 생성 불가
			dir.mkdirs(); // 상위 디렉토리 없으면 상위디렉토리도 같이 생성
		}
		
		Map<String,String> paraMap = new HashMap<>(); // insert 및 업데트이를 위한 맵
		paraMap.put("fk_lodge_id", fk_lodge_id); // 저장할 시설 ID
		
			
		// ==== 첨부파일을 위의 path 경로에 올리기 ==== //
		
			// 메인 이미지 
		if( mainImage_List != null && mainImage_List.size() > 0 ) {
		// 메인이미지가 등록되었다면
			paraMap.put("fk_img_cano", "6"); // 사진 카테고리
			
			for(int i = 0; i<mainImage_List.size(); i++) {
				MultipartFile imageFile = mainImage_List.get(i);
				
				try {
					Map<String, String> resultmap = fileManager.imageUpload(imageFile, path);
					// 운영경로에 파일생성 & 저장 파일명 & 파일명 가져오기
					
					paraMap.put("lg_img_name", resultmap.get("img_name"));
					paraMap.put("lg_img_save_name", resultmap.get("img_save_name"));
					
					service.insertLodgeImages(paraMap);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}// end of for ---------------------------
			
		}// end of if( mainImage_List != null && mainImage_List.size() > 0 )

		
			// 시설외부
		if( outImage_List != null && outImage_List.size() > 0 ) {
		// 시설외부 이미지가 등록되었다면
			paraMap.put("fk_img_cano", "0"); // 사진 카테고리
			
			for(int i = 0; i<outImage_List.size(); i++) {
				MultipartFile imageFile = outImage_List.get(i);
				
				try {
					Map<String, String> resultmap = fileManager.imageUpload(imageFile, path);
					// 운영경로에 파일생성 & 저장 파일명 & 파일명 가져오기
				
					paraMap.put("lg_img_name", resultmap.get("img_name"));
					paraMap.put("lg_img_save_name", resultmap.get("img_save_name"));
					
					service.insertLodgeImages(paraMap);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}// end of for ---------------------------
			
		}// end of if( outImage_List != null && outImage_List.size() > 0 )
		
		
			// 공용구역
		if( publicImage_List != null && publicImage_List.size() > 0 ) {
		// 공용구역 이미지가 등록되었다면
			paraMap.put("fk_img_cano", "1"); // 사진 카테고리
			
			for(int i = 0; i<publicImage_List.size(); i++) {
				MultipartFile imageFile = publicImage_List.get(i);
				
				try {
					Map<String, String> resultmap = fileManager.imageUpload(imageFile, path);
					// 운영경로에 파일생성 & 저장 파일명 & 파일명 가져오기
					
					paraMap.put("lg_img_name", resultmap.get("img_name"));
					paraMap.put("lg_img_save_name", resultmap.get("img_save_name"));
					
					service.insertLodgeImages(paraMap);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}// end of for ---------------------------
			
		}// end of if( publicImage_List != null && publicImage_List.size() > 0 )
		

			// 수영장
		if( poolImage_List != null && poolImage_List.size() > 0 ) {
		// 수영장 이미지가 등록되었다면
			paraMap.put("fk_img_cano", "2"); // 사진 카테고리
			
			for(int i = 0; i<poolImage_List.size(); i++) {
				MultipartFile imageFile = poolImage_List.get(i);
				
				try {
					Map<String, String> resultmap = fileManager.imageUpload(imageFile, path);
					// 운영경로에 파일생성 & 저장 파일명 & 파일명 가져오기
					
					paraMap.put("lg_img_name", resultmap.get("img_name"));
					paraMap.put("lg_img_save_name", resultmap.get("img_save_name"));
					
					service.insertLodgeImages(paraMap);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}// end of for ---------------------------
			
		}// end of if( poolImage_List != null && poolImage_List.size() > 0 )
		
		
			// 다이닝 이미지 
		if( diningImage_List != null && diningImage_List.size() > 0 ) {
		// 다이닝 이미지가 등록되었다면
			paraMap.put("fk_img_cano", "3"); // 사진 카테고리
			
			for(int i = 0; i<diningImage_List.size(); i++) {
				MultipartFile imageFile = diningImage_List.get(i);
				
				try {
					Map<String, String> resultmap = fileManager.imageUpload(imageFile, path);
					// 운영경로에 파일생성 & 저장 파일명 & 파일명 가져오기
					
					paraMap.put("lg_img_name", resultmap.get("img_name"));
					paraMap.put("lg_img_save_name", resultmap.get("img_save_name"));
					
					service.insertLodgeImages(paraMap);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}// end of for ---------------------------
			
		}// end of if( diningImage_List != null && diningImage_List.size() > 0 )
		
		
			// 편의시설/서비스
		if( serviceImage_List != null && serviceImage_List.size() > 0 ) {
		// 메인이미지가 등록되었다면
			paraMap.put("fk_img_cano", "4"); // 사진 카테고리
			
			for(int i = 0; i<serviceImage_List.size(); i++) {
				MultipartFile imageFile = serviceImage_List.get(i);
				
				try {
					Map<String, String> resultmap = fileManager.imageUpload(imageFile, path);
					// 운영경로에 파일생성 & 저장 파일명 & 파일명 가져오기
					
					paraMap.put("lg_img_name", resultmap.get("img_name"));
					paraMap.put("lg_img_save_name", resultmap.get("img_save_name"));
					
					service.insertLodgeImages(paraMap);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}// end of for ---------------------------
			
		}// end of if( serviceImage_List != null && serviceImage_List.size() > 0 )
		
		
			// 전망
		if( viewImage_List != null && viewImage_List.size() > 0 ) {
		// 메인이미지가 등록되었다면
			paraMap.put("fk_img_cano", "5"); // 사진 카테고리
			
			for(int i = 0; i<viewImage_List.size(); i++) {
				MultipartFile imageFile = viewImage_List.get(i);
				
				try {
					Map<String, String> resultmap = fileManager.imageUpload(imageFile, path);
					// 운영경로에 파일생성 & 저장 파일명 & 파일명 가져오기
					
					paraMap.put("lg_img_name", resultmap.get("img_name"));
					paraMap.put("lg_img_save_name", resultmap.get("img_save_name"));
					
					service.insertLodgeImages(paraMap);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}// end of for ---------------------------
			
		}// end of if( viewImage_List != null && viewImage_List.size() > 0 )
		
		JSONObject jsonObj = new JSONObject(); 
		
		jsonObj.put("result", "1");
		
		return jsonObj.toString();
		// /WEB-INF/views/tiles2/db/register/register_lodge.jsp
		// /WEB-INF/views/tiles2/{1}/{2}/{3}.jsp
	}
	
	
	///////////////////////////////////////////////////////////////
	
	// ==== 객실 등록 ==== //
	@GetMapping(value="/rm_register.exp")
	public String requiredHostLogin_rm_register(HttpServletRequest request, HttpServletResponse response) {
		
		// == 욕실 옵션 종류 checkbox == //
		List<Map<String,String>> bathOptMapList = service.getBathOpt();
		
		// == 주방(조리시설) 종류 checkbox == //
		List<Map<String,String>> kitchenOptMapList = service.getKitchenOpt();
		
		// == 객실 내 다과 옵션 종류 checkbox == //
		List<Map<String,String>> snackOptMapList = service.getSnackOpt();
		
		// == 객실 내 엔터테이먼트 옵션 종류 checkbox == //
		List<Map<String,String>> entertainmentOptMapList = service.getEntertainmentOpt();
		
		// == 온도조절기 옵션 종류 checkbox == //
		List<Map<String,String>> temperatureControllerOptMapList = service.getTemperatureControllerOpt();
		
		// == 전망 옵션 종류 select == // 
		List<Map<String,String>> viewOptMapList = service.getViewOpt();
		
		// ================= AOP 로그인한 사용자의 정보 -시작- ==================== //
		HttpSession session = request.getSession();
		HostVO loginhost = (HostVO) session.getAttribute("loginhost");
		String fk_h_userid = loginhost.getH_userid();
		// 현재 로그인한 판매자의 ID로 숙박시설의 lodge_id를 가져온다.
		String fk_lodge_id = service.getLodgeIdByUserId(fk_h_userid);
		// ================= AOP 로그인한 사용자의 정보 -끝- ==================== //
		
		// == ** 이미 입력된 room 정보가 있다면 수정과 추가를 하기위해서 체크 해야 된다 ** == //
		List<Map<String,String>> updateRmInfoMapList = service.getRmInfo(fk_lodge_id); // rm_seq, rm_type

		
		request.setAttribute("bathOptMapList", bathOptMapList);			// 욕실 옵션 종류 checkbox
		request.setAttribute("kitchenOptMapList", kitchenOptMapList);			// 주방(조리시설) 종류 checkbox
		request.setAttribute("snackOptMapList", snackOptMapList);				// 객실 내 다과 옵션 종류 checkbox
		request.setAttribute("entertainmentOptMapList", entertainmentOptMapList);	// 객실 내 엔터테이먼트 옵션 종류 checkbox
		request.setAttribute("temperatureControllerOptMapList", temperatureControllerOptMapList);	// 온도조절기 옵션 종류 checkbox
		request.setAttribute("viewOptMapList", viewOptMapList);			// 전망 옵션 종류 select
		
		// 입력 외 정보
		request.setAttribute("fk_lodge_id", fk_lodge_id);
		request.setAttribute("updateRmInfoMapList", updateRmInfoMapList);
		
		return "db/register/rm_register.tiles2";
		// /WEB-INF/views/tiles2/db/register/register_lodge.jsp
		// /WEB-INF/views/tiles2/{1}/{2}/{3}.jsp
	}

	// ==== 객실 등록 ==== //
	@PostMapping(value="/rm_register.exp")
	public String requiredHostLogin_register_rm(HttpServletRequest request, HttpServletResponse response,
												@RequestParam(required = false) HashMap<String,String> paraMap) {
		// 로그인한 사용자의 숙박시설 아이디 가져오기
		
		String update_room_seq = paraMap.get("update_room_seq");
		// == 객실 등록 정보 == //
	//	String rm_seq = paraMap.get("rm_seq");
		String fk_lodge_id = paraMap.get("fk_lodge_id");
		String rm_type = paraMap.get("rm_type");
		String rm_cnt = paraMap.get("rm_cnt");
		
		String rm_size_meter = paraMap.get("rm_size_meter");
		String rm_size_pyug = paraMap.get("rm_size_pyug");
		
		String rm_bedrm_cnt = ""; // 숫자로 변환
		try {
			rm_bedrm_cnt = String.valueOf(Integer.parseInt(paraMap.get("rm_bedrm_cnt")));
			paraMap.put("rm_bedrm_cnt", rm_bedrm_cnt);
		} catch (Exception e) {
			
		}
		
		String rm_extra_bed_yn = paraMap.get("rm_extra_bed_yn");
		String rm_single_bed = paraMap.get("rm_single_bed");	
		
		String rm_ss_bed = paraMap.get("rm_ss_bed");	 // 10
		String rm_double_bed = paraMap.get("rm_double_bed"); 
		String rm_queen_bed = paraMap.get("rm_queen_bed");
		String rm_king_bed = paraMap.get("rm_king_bed");
		
		String rm_bathroom_cnt = ""; // 숫자로 변환
		try {
			rm_bathroom_cnt = String.valueOf(Integer.parseInt(paraMap.get("rm_bathroom_cnt")));
			paraMap.put("rm_bathroom_cnt", rm_bathroom_cnt);
		} catch (Exception e) {
			
		}
		
		String rm_p_bathroom_yn = paraMap.get("rm_p_bathroom_yn");
		String rm_kitchen_yn = paraMap.get("rm_kitchen_yn");
		String rm_snack_yn = paraMap.get("rm_snack_yn");
		String rm_ent_yn = paraMap.get("rm_ent_yn");
		String rm_tmp_ctrl_yn = paraMap.get("rm_tmp_ctrl_yn"); 
		
		String rm_smoke_yn = paraMap.get("rm_smoke_yn");// 20
		
		String fk_view_no = paraMap.get("fk_view_no");
		String rm_wheelchair_yn = paraMap.get("rm_wheelchair_yn");
		
		String rm_guest_cnt = ""; // 숫자로 변환
		try {
			rm_guest_cnt = String.valueOf(Integer.parseInt(paraMap.get("rm_guest_cnt")));
			paraMap.put("rm_guest_cnt", rm_guest_cnt);
		} catch (Exception e) {
			
		}
		
		
		String rm_price = ""; // 숫자로 변환
		try {
			rm_price = String.valueOf(Integer.parseInt(paraMap.get("rm_price")));
			paraMap.put("rm_price", rm_price);
		} catch (Exception e) {
			
		}
		
		
		String rm_breakfast_yn = paraMap.get("rm_breakfast_yn"); // 25
		
		
		System.out.println("update_room_seq => "+ update_room_seq);
		
	//	System.out.println("rm_seq => " + rm_seq);
		System.out.println("fk_lodge_id => " + fk_lodge_id);
		System.out.println("rm_type => " + rm_type);
		System.out.println("rm_cnt => " + rm_cnt);
		
		System.out.println("rm_size_meter => " + rm_size_meter);
		System.out.println("rm_size_pyug => " + rm_size_pyug);
		System.out.println("rm_bedrm_cnt => " + rm_bedrm_cnt);
		System.out.println("rm_extra_bed_yn => " + rm_extra_bed_yn);
		System.out.println("rm_single_bed => " + rm_single_bed); 
		
		System.out.println("rm_ss_bed => " + rm_ss_bed);  // 10
		System.out.println("rm_double_bed => " + rm_double_bed);
		System.out.println("rm_queen_bed => " + rm_queen_bed);
		System.out.println("rm_king_bed => " + rm_king_bed);
		System.out.println("rm_bathroom_cnt => " + rm_bathroom_cnt);
		
		System.out.println("rm_p_bathroom_yn => " + rm_p_bathroom_yn);
		System.out.println("rm_kitchen_yn => " + rm_kitchen_yn);
		System.out.println("rm_snack_yn => " + rm_snack_yn);
		System.out.println("rm_ent_yn => " + rm_ent_yn);
		System.out.println("rm_tmp_ctrl_yn => " + rm_tmp_ctrl_yn); 
		
		System.out.println("rm_smoke_yn => " + rm_smoke_yn); // 20
		
		System.out.println("fk_view_no => " + fk_view_no);
		System.out.println("rm_wheelchair_yn => " + rm_wheelchair_yn);
		System.out.println("rm_guest_cnt => " + rm_guest_cnt);
		System.out.println("rm_price => " + rm_price);

		System.out.println("rm_breakfast_yn => " + rm_breakfast_yn); // 25
		

		int n = 0;
		try {
			// *** === 객실정보 데이터 등록 === *** //
			n = service.register_rm(paraMap, request);
			
		} catch (Throwable e) {
			e.printStackTrace();
		}
		
		// 등록 이후
		if( n == 1 ) {
		// 객실 등록 성공
		// 페이지 이동
			request.setAttribute("message", "객실이 등록되었습니다.");
			request.setAttribute("loc", request.getContextPath()+"/lodgeControl.exp");
		}
		else {
		// 객실 등록 실패
			request.setAttribute("message", "등록중 문제가 발생하였습니다.");
			request.setAttribute("loc", request.getContextPath()+"/lodgeControl.exp");
		}
		
		/*
			Controller 에서  return "product/prodview"; 로 하면
	               자동적으로 view단 페이지는   "/WEB-INF/views/product/prodview.jsp"; 가 되어진다.
	               
       		위치는 숙박 시설 관리 페이지로 이동 /webapp/WEB-INF/views/msg.jsp
		 */
		return "msg";
		// /WEB-INF/views/tiles2/db/register/register_lodge.jsp
		// /WEB-INF/views/tiles2/{1}/{2}/{3}.jsp
	}
	
	// 객실을 등록할 때 "추가" "수정"할지를 선택할 수 있는 select를 위한 정보이다.
	@ResponseBody
	@GetMapping(value = "/checkRm_type.exp", produces = "text/plain;charset=UTF-8") // GET 방식만 허락한 것이다.
	public String checkRm_type(@RequestParam String fk_lodge_id) {
		
	//	System.out.println("fk_lodge_id => "+ fk_lodge_id);
		
		// 기존에 입력되어 있는 rm_type List 가져오기
		List<String> rm_typeList = service.getRm_typeData(fk_lodge_id);
		
		JsonArray jsonArr = new JsonArray();
		
		if(rm_typeList.size() > 0) {
			
			for(String rm_type : rm_typeList) {
			//	System.out.println("rm_type => "+ rm_type);
				JsonObject jsonObj = new JsonObject();
				
				jsonObj.addProperty("rm_type", rm_type);
				jsonArr.add(jsonObj);
			}// end of for --------------------
			
		}// end of if(rm_typeList.size() > 0)
		
		return new Gson().toJson(jsonArr);
	} // end of public String ajax_select() ---------
	
	
	
	
	// ============ 객실 사진 등록 ================ //
	
	// 객실 사진 등록 페이지
	@GetMapping(value="/rm_image.exp")
	public String requiredHostLogin_rm_image(HttpServletRequest request, HttpServletResponse response) {
		
		// === 로그인한 사용자의 정보 -시작- === //
		HttpSession session = request.getSession();
		HostVO loginhost = (HostVO) session.getAttribute("loginhost");
		String fk_h_userid = loginhost.getH_userid();
	//	System.out.println("fk_h_userid => " + fk_h_userid);
		// 현재 로그인한 판매자의 ID로 숙박시설의 lodge_id를 가져온다.
		String fk_lodge_id = service.getLodgeIdByUserId(fk_h_userid);
	//	System.out.println("fk_lodge_id => " + fk_lodge_id);
		// === 로그인한 사용자의 정보 -끝- === //
		
		
		// == ** 이미 입력된 room 정보가 있다면 수정과 추가를 하기위해서 체크 해야 된다 ** == //
		List<Map<String,String>> updateRmInfoMapList = service.getRmInfo(fk_lodge_id); // rm_seq, rm_type

		
		request.setAttribute("fk_lodge_id", fk_lodge_id);
		request.setAttribute("updateRmInfoMapList", updateRmInfoMapList);
		
		return "db/register/rm_image.tiles2";
		// /WEB-INF/views/tiles2/db/register/register_lodge.jsp
		// /WEB-INF/views/tiles2/{1}/{2}/{3}.jsp
	}
	
	// 객실 사진 등록 버튼 클릭
	@ResponseBody
	@PostMapping(value="/rm_image.exp")
	public String requiredHostLogin_rm_image_register(HttpServletRequest request, HttpServletResponse response,
													  MultipartHttpServletRequest mtp_request) {
		
		List<MultipartFile> roomImage_List  = mtp_request.getFiles("roomImage_arr");
		String fk_rm_seq = mtp_request.getParameter("fk_rm_seq");
	//	System.out.println("fk_rm_seq => "+ fk_rm_seq);
		
	//	System.out.println(fk_rm_seq);
		
		// === 로그인한 사용자의 정보 -시작- === //
		HttpSession session = request.getSession();
		HostVO loginhost = (HostVO) session.getAttribute("loginhost");
		String fk_h_userid = loginhost.getH_userid();
		// 현재 로그인한 판매자의 ID로 숙박시설의 lodge_id를 가져온다.
		String fk_lodge_id = service.getLodgeIdByUserId(fk_h_userid);
		// === 로그인한 사용자의 정보 -끝- === //
		
		// 시설 이미지를 저장할 경로
	//	HttpSession session = mtp_request.getSession();
	//	String root = session.getServletContext().getRealPath("/");
	//	String path = root + "resources"+File.separator+"images"+File.separator+fk_lodge_id+File.separator+"room_img";
		String root = "C:\\git\\fin_project\\fin_project\\src\\main\\webapp\\resources";
		String path = root +File.separator+"images"+File.separator+fk_lodge_id+File.separator+"room_img";
	//	System.out.println(path);
		// C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\final_project\resources\images\JSUN0231\room_img
		
		// C:\git\fin_project\fin_project\src\main\webapp\resources
		File dir = new File(path);
		
		/*
		 	roomImage_List-이미지 배열, fk_rm_seq-객실 번호
			1. 이미지 등록 버튼 클릭 => 이미지 배열이 넘어온 경우(roomImage_List), 이미지 배열이 넘어오지 않은 경우
			<이미지 배열이 넘어옴>
				2. 기존 DB에 메인 이미지가 존재하는지 존재하지 않는지 체크해야됨
					배열의 첫번째로 넘어온 이미지 파일을 메인이미지로 설정해야되는지 하지말아야 되는지
					
					DB에서 메인이미지 여부 체크 -> 있을경우 새로 들어온 파일들을 메인이미지 여부 0으로 insert
										-> 없을을경우 배열의 첫번째 이미지파일은 메인여부 1로 insert
			
			<이미지 배열이 넘어오지 않은 경우>
				아무일도 일어나지 않음
		*/
		if(roomImage_List != null && roomImage_List.size() > 0) {
		// 이미지 파일이 넘어온 경우
			// DB에 fk_rm_seq객실에 메인이미지가 등록되어 있는지 체크한다.
			String check = service.getMainImgCheck(fk_rm_seq);
			
			Map<String,String> paraMap = new HashMap<>(); // insert 및 업데트이를 위한 맵
			paraMap.put("fk_rm_seq", fk_rm_seq); // 저장할 시설 ID
			
			if(check == null) {
			// 메인이미지가 없는경우
				// 배열의 첫번째 이미지파일은 메인여부 1로 insert
				
				if(!dir.exists()) {
				//	dir.mkdir(); // 상위 디렉토리 없으면 생성 불가
					dir.mkdirs(); // 상위 디렉토리 없으면 상위디렉토리도 같이 생성
				}
				
				for(int i = 0; i<roomImage_List.size(); i++) {
					MultipartFile imageFile = roomImage_List.get(i);
					
					try {
						Map<String, String> resultmap = fileManager.imageUpload(imageFile, path);
						// 운영경로에 파일생성 & 저장 파일명 & 파일명 가져오기
						if(i == 0) {
							paraMap.put("rm_img_main", "1"); // 첫번째로 들어온 이미지가 메인이미지 여부를 결정한다.
						}
						else {
							paraMap.put("rm_img_main", "0");
						}
						
						paraMap.put("rm_img_name", resultmap.get("img_name"));
						paraMap.put("rm_img_save_name", resultmap.get("img_save_name"));
						
						// === 객실 이미지 등록하기 === //
						service.insertRoomImages(paraMap);
					} catch (Exception e) {
						e.printStackTrace();
					}
				}// end of for ---------------------------
				
			}
			else {
			// 메인이미지가 있는 경우
				// 새로 들어온 파일들을 메인이미지 여부 0으로 insert
			
				for(int i = 0; i<roomImage_List.size(); i++) {
					MultipartFile imageFile = roomImage_List.get(i);
					
					try {
						Map<String, String> resultmap = fileManager.imageUpload(imageFile, path);
						// 운영경로에 파일생성 & 저장 파일명 & 파일명 가져오기

						paraMap.put("rm_img_main", "0");
						paraMap.put("rm_img_name", resultmap.get("img_name"));
						paraMap.put("rm_img_save_name", resultmap.get("img_save_name"));
						
						// === 객실 이미지 등록하기 === //
						service.insertRoomImages(paraMap);
					} catch (Exception e) {
						e.printStackTrace();
					}
				}// end of for ---------------------------
				
			}// end of if(check == null) 
			
		} // 이미지 파일이 넘어온 경우
		
		JSONObject jsonObj = new JSONObject(); 
		
		jsonObj.put("result", "1");
		
		return jsonObj.toString();
		// /WEB-INF/views/tiles2/db/register/register_lodge.jsp
		// /WEB-INF/views/tiles2/{1}/{2}/{3}.jsp
	}
	
	
	// 객실 사진 등록중 - 객실 select를 변경하는 경우
	@ResponseBody
	@PostMapping(value="/getRmImgData.exp")
	public String getRmImgData(@RequestParam(required = false) String fk_rm_seq,
							   HttpServletRequest request) {
		
		// 변경된 객실의 기존에 입력된 사진 정보를 가져온다.
		List<Map<String,String>> roomImgDataMapList = service.getRmImgData(fk_rm_seq);
		
		JsonArray jsonArr = new JsonArray();
		
		if(roomImgDataMapList.size() > 0 ) {
			
			for(Map<String,String> map :roomImgDataMapList) {
				JsonObject jsonObj = new JsonObject();
				
				jsonObj.addProperty("rm_img_name", map.get("rm_img_name"));
				jsonObj.addProperty("rm_img_save_name", map.get("rm_img_save_name"));
				jsonObj.addProperty("rm_img_main", map.get("rm_img_main"));
				
				jsonArr.add(jsonObj);
				
			} // end of for ---------
			
		}// end of if(roomImgDataMapList.size() > 0 ) {
		
		return new Gson().toJson(jsonArr);
		// /WEB-INF/views/tiles2/db/register/register_lodge.jsp
		// /WEB-INF/views/tiles2/{1}/{2}/{3}.jsp
	}
	
	
	// "X"버튼을 눌러서 이미지를 삭제했다.  --> DB와 저장 경로에서 이미지파일을 삭제한다.
	@ResponseBody
	@PostMapping(value="/delIdxImg.exp")
	public String requiredHostLogin_delIdxImg(HttpServletRequest request, HttpServletResponse response,
											  @RequestParam(required = false) Map<String,String> paraMap) {
		
		String fk_rm_seq = paraMap.get("fk_rm_seq");
		String rm_img_save_name = paraMap.get("rm_img_save_name");	// 저장 이름
		String fk_lodge_id = paraMap.get("fk_lodge_id");	// 시설 이름
	//	String rm_img_name = paraMap.get("rm_img_name");	// 이미지 이름
		String rm_img_main = paraMap.get("rm_img_main");	// 메인 이미지 여부
	//	System.out.println(fk_rm_seq +"    "+ rm_img_save_name +"    "+ rm_img_name+"    "+rm_img_main);
		// rm-47    프리미어2.png    2024010222343548229689336800.png    0
		// rm-45    슈페리어1.png    2024010222331848151868402000.png    1

		
		// === 개발 경로에서 이미지 삭제하기 === ///
		String root = "C:\\git\\fin_project\\fin_project\\src\\main\\webapp\\resources";
		String path = root +File.separator+"images"+File.separator+fk_lodge_id+File.separator+"room_img";
	//	System.out.println(path);
		// C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\final_project\resources\images\JSUN0231\room_img
		
		// C:\git\fin_project\fin_project\src\main\webapp\resources
	
		File dir = new File(path);
		if(dir.exists()) {
			// 경로 폴더가 존재한다면
			File[] folderList = dir.listFiles(); // 폴더의 내용물이 있는지 확인하다.
			if( folderList.length > 0) {
			// 경로 폴더안 이미지 파일들이 존재한다면 확인해야 한다.
				
				// DB에서 가져온 파일 이름을 저장폴더안에 이미지 파일들과 이름을 비교하여 같은 파일을 삭제한다.
				for(int i=0; i<folderList.length; i++) {
					if(folderList[i].getName().equals(rm_img_save_name)) {
					// 삭제해야할 파일과 이름이 같은 파일은 삭제한다.
						folderList[i].delete();
						break; // 한개의 "X"를 눌렀기 때문에 한개의 이미지 파일만 삭제하면 반복문을 빠져나온다.
					}
					
				}// end of for -----------------------------------
				
			} // end of if( folderList.length > 0) ------------
			
		} // end of if(dir.exists()) -----------
		
		// === DB에서 이미지를 삭제한다. === //
		int result = service.delIdxImg(paraMap);
		
		
		if( "1".equals(rm_img_main) ) {
		// 메인이미지가 삭제된 경우에
			// 바로 다음 이미지를 메인이미지로 업데이트  -> 다음 이미지 존재여부 확인
			
			// 다음 메인이미지 rm_img_seq 가져오기
			List<String> nextMainImg_rm_img_seq = service.nextMainImgUpdate(fk_rm_seq);
			// nextMainImg_rm_img_seq => 메인이미지 여부가 "1"로 변경될  이미지의 seq
			
			if( nextMainImg_rm_img_seq.size() > 0 ) {
			// 다음 이미지가 있는경우 ==> 업데이트 가능
				// rm_img_seq값에 해당하는 이미지 정보의 rm_img_main를 "1"로 업데이트 하기
				String next_rm_img_seq = nextMainImg_rm_img_seq.get(0);
				service.updateNextMainImg(next_rm_img_seq);
			}
			
		} // end of if( "1".equals(rm_img_main) )
		// 메인 이미지가 아닌 이미지가 삭제된 경우에는 업데이트가 발생하지 않는다. 
		
		
		JsonObject jsonObj = new JsonObject();
		
		if( result > 0 ) {
		// DB에서 이미지파일에 대한 정보가 삭제된 경우
			jsonObj.addProperty("result", result);
		}
		else {
		// 삭제가 정상적으로 진행되지 않은 경우
			jsonObj.addProperty("result", result);
		}
		
		return new Gson().toJson(jsonObj);
		// /WEB-INF/views/tiles2/db/register/register_lodge.jsp
		// /WEB-INF/views/tiles2/{1}/{2}/{3}.jsp
	}
	
	
	// "X"버튼을 눌러서 이미지를 삭제했다.  --> DB와 저장 경로에서 이미지파일을 삭제한다.
	@ResponseBody
	@PostMapping(value="/delRoomImgFk_rm_seq.exp")
	public String requiredHostLogin_delRoomImgFk_rm_seq(HttpServletRequest request, HttpServletResponse response,
											  			@RequestParam(required = false) String fk_rm_seq) {
		
		// ================= AOP 로그인한 사용자의 정보 -시작- ==================== //
		HttpSession session = request.getSession();
		HostVO loginhost = (HostVO) session.getAttribute("loginhost");
		String fk_h_userid = loginhost.getH_userid();
		// 현재 로그인한 판매자의 ID로 숙박시설의 lodge_id를 가져온다.
		String fk_lodge_id = service.getLodgeIdByUserId(fk_h_userid);
		// ================= AOP 로그인한 사용자의 정보 -끝- ====================== //
		
		
		// fk_rm_seq를 사용해서 제거할 이미지파일 정보를 가져온다.
		List<Map<String,String>> roomImgDataMapList = service.getRmImgData(fk_rm_seq);
		// rm_img_save_name를 사용하여 제거
		
		// === 개발 경로에서 이미지 삭제하기 === ///
		String root = "C:\\git\\fin_project\\fin_project\\src\\main\\webapp\\resources";
		String path = root +File.separator+"images"+File.separator+fk_lodge_id+File.separator+"room_img";
	//	System.out.println(path);
		// C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\final_project\resources\images\JSUN0231\room_img
		
		// === 운영 경로에서 이미지 삭제 === //
//		String root_2 = session.getServletContext().getRealPath("/");
//		String path_2 = root_2 + "resources"+File.separator+"images"+File.separator+fk_lodge_id+File.separator+"room_img";
//		File dir_2 = new File(path_2); // 운영 경로
		// 개발 경로에서 삭제되면 운영경로에서도 삭제된다
		// 개발 경로에서 추가되면 운영경로에서도 삭제된다.
			// 자바에서 삭제하면 삭제가 바로 적용되는데
			// 탐색기에서 삭제시 바로 적용되지 않는다. refresh 필요
		
		// C:\git\fin_project\fin_project\src\main\webapp\resources
	
		int roopCnt = 0;
		
		File dir = new File(path);
		if(dir.exists()) {
			// 경로 폴더가 존재한다면
			File[] folderList = dir.listFiles(); // 폴더의 내용물이 있는지 확인하다.
//			File[] folderList_2 = dir_2.listFiles(); // 폴더의 내용물이 있는지 확인하다.
			if( folderList.length > 0) {
			// 경로 폴더안 이미지 파일들이 존재한다면 확인해야 한다.
				
				if(roomImgDataMapList.size() > 0) {
					// DB에서 가져온 파일 이름을 저장폴더안에 이미지 파일들과 이름을 비교하여 같은 파일을 삭제한다.
					for(int i=0; i<folderList.length; i++) {
						
						for(Map<String,String> roomImgData : roomImgDataMapList) {
							
							if( folderList[i].getName().equals(roomImgData.get("rm_img_save_name")) ) {
								// 삭제해야할 파일과 이름이 같은 파일은 삭제한다.
								folderList[i].delete();
								roopCnt++;
								break; // 한개의 "X"를 눌렀기 때문에 한개의 이미지 파일만 삭제하면 반복문을 빠져나온다.
							}
							
						} // end of for ---------------
						
						if( roopCnt == roomImgDataMapList.size() ) {
							break;
						}
						
					}// end of for -----------------------------------
					
				}// end of if(roomImgDataMapList.size() > 0)
				
			} // end of if( folderList.length > 0) ------------
			
		} // end of if(dir.exists()) -----------
		
		// === DB에서 이미지를 삭제한다. === //
		int result=0;
		if(roomImgDataMapList.size() > 0) {
			// 객실 사진등록 "사진 전체 제거" 버튼 클릭
			result = service.delRoomImgFk_rm_seq(fk_rm_seq);
		}
		
		JsonObject jsonObj = new JsonObject();
		
		if( result > 0 ) {
		// DB에서 이미지파일에 대한 정보가 삭제된 경우
			jsonObj.addProperty("result", result);
		}
		else {
		// 삭제가 정상적으로 진행되지 않은 경우
			jsonObj.addProperty("result", result);
		}
		
		return new Gson().toJson(jsonObj);
		// /WEB-INF/views/tiles2/db/register/register_lodge.jsp
		// /WEB-INF/views/tiles2/{1}/{2}/{3}.jsp
	}
	
	
}
