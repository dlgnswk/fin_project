package com.spring.app.db.lodge.service;


import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.app.expedia.domain.HostVO;
import com.spring.app.expedia.domain.LodgeVO;
import com.spring.app.db.lodge.model.LodgeDAO;

@Service
public class LodgeService_imple implements LodgeService {

	@Autowired
	private LodgeDAO dao;

	
	// == 숙박시설 유형 테이블에서 select == //
	@Override
	public List<Map<String, String>> getLodgeType() {
		
		List<Map<String,String>> lodgeTypeMapList = dao.getLodgeType();
		
		return lodgeTypeMapList;
	}


	// == 환불 정책 옵션 select == //
	@Override
	public List<Map<String, String>> getCancelOption() {
		List<Map<String,String>> CancelOptionMapList = dao.getCancelOption();
		return CancelOptionMapList;
	}


	// == 셀프 체크인 방법 select == //
	@Override
	public List<Map<String, String>> getSelfCheckinOption() {
		
		List<Map<String,String>> selfCheckinOptionMapList = dao.getSelfCheckinOption();
		return selfCheckinOptionMapList;
	}

	// == 인터넷 옵션 체크박스 == //
	@Override
	public List<Map<String, String>> getInternetOption() {
		List<Map<String,String>> internetOptionMapList = dao.getInternetOption();
		return internetOptionMapList;
	}
	
	// == 주차장 옵션 체크박스  == //
	@Override
	public List<Map<String, String>> getParkOption() {
		
		List<Map<String, String>> parkOptionMapList = dao.getParkOption(); 
		return parkOptionMapList;
	}
	
	// == 수영장 종류 체크박스 == //
	@Override
	public List<Map<String, String>> getPoolType() {
		List<Map<String,String>> poolTypeMapList = dao.getPoolType();
		return poolTypeMapList;
	}
	
	
	// == 다이닝 장소 종류 체크박스 == //
	@Override
	public List<Map<String, String>> getDiningPlace() {
		List<Map<String,String>> diningPlaceMapList = dao.getDiningPlace();
		return diningPlaceMapList;
	}
	
	// == 장애인 편의 시설 정보 체크박스 == //
	@Override
	public List<Map<String, String>> getFacilityInfo() {
		List<Map<String,String>> facilityInfoMapList = dao.getFacilityInfo();
		return facilityInfoMapList;
	}

	
	// == 스파 서비스 종류 셀렉트 == //
	@Override
	public List<Map<String, String>> getSpaType() {
		List<Map<String,String>> spaTypeMapList = dao.getSpaType();
		return spaTypeMapList;
	}

	
	// == 고객서비스 종류 체크박스 == //
	@Override
	public List<Map<String, String>> getConsumerService() {
		List<Map<String,String>> consumerServiceTypeMapList = dao.getConsumerService();
		return consumerServiceTypeMapList;
	}

	// == 룸 서비스 종류 체크박스  == //
	@Override
	public List<Map<String, String>> getRoomService() {
		List<Map<String,String>> roomServiceMapList = dao.getRoomService();
		return roomServiceMapList;
	}

	
	// == 비즈니스 공간 종류 체크박스 == //
	@Override
	public List<Map<String, String>> getBusinessType() {
		List<Map<String,String>> businessTypeMapList = dao.getBusinessType();
		return businessTypeMapList;
	}

	
	// == 가족서비스 종류 체크박스 == //
	@Override
	public List<Map<String, String>> getFamilyServiceType() {
		List<Map<String,String>> familyServiceTypeMapList = dao.getFamilyServiceType();
		return familyServiceTypeMapList;
	}

	
	// *** === 숙박시설테이블 데이터 등록 === *** //
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	@Override
	public int lodgeRegister(Map<String, String> paraMap, HttpServletRequest request) throws Throwable {
		
		int n1=0, n2=0, n3=0, n4=0, n5=0, n6=0, n7=0, n8=0, n9=0, n10=0, result=0;
		
		// ================= AOP 로그인한 사용자의 정보 -시작- ==================== //
		HttpSession session = request.getSession();
		HostVO loginhost = (HostVO) session.getAttribute("loginhost");
		String fk_h_userid = loginhost.getH_userid();
		// ================= AOP 로그인한 사용자의 정보 -끝- ====================== //
		
		// 기존에 입력되어있는 lodge정보 가져오기
		LodgeVO LodgeInfo = dao.getLodgeInfo(fk_h_userid);

		// === 숙박시설 등록 === //  ※※※※ 
		if( LodgeInfo != null ) {
		// 기존에 입력된 lodge 정보가 있다.	 // 업데이트
			// 기존 status상태 추가 하기
			paraMap.put("lg_status", LodgeInfo.getLg_status()); 
			n1 = dao.updateLodge(paraMap); // Lodge 데이터 수정하기
		}
		else {
		// 새로 입력하는 경우				// 데이터추가
			n1 = dao.insertLodge(paraMap);
		}
		
		
		String fk_lodge_id = paraMap.get("lodge_id");
		String lg_internet_yn = paraMap.get("lg_internet_yn"); // 인터넷 제공  "0":없음, "1":있음
		String lg_park_yn = paraMap.get("lg_park_yn"); 		   // 주차장 옵션  "0":없음, "1":있음
		String lg_dining_place_yn = paraMap.get("lg_dining_place_yn"); 	// 다이닝 장소 종류 "0":없음, "1":있음
		String lg_pool_yn = paraMap.get("lg_pool_yn"); 			// 수영장 종류 "0":없음, "1":있음
		String lg_fac_yn = paraMap.get("lg_fac_yn"); 			// 장애인 편이시설 종류 "0":없음, "1":있음
		String lg_service_yn = paraMap.get("lg_service_yn"); 	// 고객서비스 종류 "0":없음, "1":있음
		String lg_rm_service_yn = paraMap.get("lg_rm_service_yn"); 		// 룸서비스 종류 "0":없음, "1":있음
		String lg_business_yn = paraMap.get("lg_business_yn"); 			// 비즈니스 장소 타입 "0":없음, "1":있음
		String lg_fa_travel_yn = paraMap.get("lg_fa_travel_yn"); 		// 가족시설(어린이) 종류 "0":없음, "1":있음
		
		
		// == tbl_inet테이블  인터넷 옵션 등록 == //
		if(n1 == 1) {
		// 숙박시설을 등록했다.
			
			// 코드 재사용을 위해서
			// 기존에 	tbl_inet테이블에 입력된 인터넷서비스가 존재한다면 제거해 주고 현재 체크한 값을 입력시켜야 한다.
				// === tbl_inet테이블에 기존에 입력되어 있는 인터넷 옵션 가져오기 === //
			List<Map<String,String>> internetInsertDataMapList = dao.getInternetService(fk_lodge_id);
			// "예"를 누른경우 -> 기존에 넣어져 있는 데이터를 삭제 -> 현재 체크해온값 넣어주기 -> 다음으로넘김
			// "아니오"를 누른경우 -> 기존에 넣어져 있는 데이터를 삭제 -> 다음으로 넘김
			
			// 즉,   "예"\"아니오" 둘다 먼저 삭제를 해줘야 한다.
			if( internetInsertDataMapList != null && internetInsertDataMapList.size() > 0 ) {
			// 기존에 	tbl_inet 테이블에 입력된 인터넷서비스가 존재한다면 제거하기
				dao.internetDataDelete(fk_lodge_id);
			}// end of if () -----------------
			
			// 기존 테이블에서 제거한 이후에
			if("1".equals(lg_internet_yn)) {
			// 인터넷제공을 "예"를 누른후 옵션을 체크해서 넘어온 경우
				// 현재 체크한 인테넷 옵션들
				String[] Arr_fk_inet_opt_no = request.getParameterValues("fk_inet_opt_no");
				
				System.out.println("<< 인터넷 옵션 >>");
				for(int i=0; i<Arr_fk_inet_opt_no.length; i++) {
				// 현재 체크해온 값들 insert 시켜주기
					System.out.println("fk_inet_opt_no => "+ Arr_fk_inet_opt_no[i]);
					
					Map<String,String> map = new HashMap<>();
					map.put("fk_inet_opt_no", Arr_fk_inet_opt_no[i]);
					map.put("fk_lodge_id", fk_lodge_id);
					
					n2 = dao.insertInterOption(map);
				}// end of for -----------------
				
			}
			else if ("0".equals(lg_internet_yn)) {
				// 인터넷 제공을 "아니요"를 체크한 경우
				n2 = 1;
			} 
			
		}// end of if(n1 == 1) 인터넷제공 -------------------


		// == tbl_park테이블  주차장 옵션 등록 == //
		// 
		if(n2 == 1) {
			
			// === tbl_park테이블에 기존에 입력되어 있는 주차장 옵션 가져오기 === //
			List<Map<String,String>> parkOptionInsertDataMapList = dao.getParkOptionData(fk_lodge_id);
			// "예"를 누른경우 -> 기존에 넣어져 있는 데이터를 삭제 -> 현재 체크해온값 넣어주기 -> 다음으로넘김
			// "아니오"를 누른경우 -> 기존에 넣어져 있는 데이터를 삭제 -> 다음으로 넘김
			
			// 즉,   "예"\"아니오" 둘다 먼저 삭제를 해줘야 한다.
			if( parkOptionInsertDataMapList != null && parkOptionInsertDataMapList.size() > 0 ) {
			// 기존에 	tbl_park 테이블에 입력된 주차장정보 존재한다면 제거하기
				dao.parkOptionDataDelete(fk_lodge_id);
			}// end of if () -----------------
			
			// 기존 테이블에서 제거한 이후에
			if("1".equals(lg_park_yn)) {
			// 주차장 종류 을 "예"를 누른후 옵션을 체크해서 넘어온 경우
				// 현재 체크한 주차장 옵션들
				String[] Arr_fk_park_opt_no = request.getParameterValues("fk_park_opt_no");
				
				System.out.println("<< 주차장 옵션 >>");
				for(int i=0; i<Arr_fk_park_opt_no.length; i++) {
				// 현재 체크해온 값들 insert 시켜주기
					System.out.println("fk_park_opt_no => "+ Arr_fk_park_opt_no[i]);
					
					Map<String,String> map = new HashMap<>();
					map.put("fk_park_opt_no", Arr_fk_park_opt_no[i]);
					map.put("fk_lodge_id", fk_lodge_id);
					
					// 현재 주차장 옵션 insert
					n3 = dao.insertParkOption(map);
				}// end of for -----------------
				
			}
			else if ("0".equals(lg_park_yn)) {
			// 주차장 옵션 "아니오"를 선택한 경우
				n3 = 1;
			}
			
		} // end of if(n2 == 1) ----------- 인터넷 다음에 실행


		// tbl_din 테이블  다이닝 종류
		if(n3 == 1) {
			
			// === tbl_din 테이블에 기존에 입력되어 있는 다이닝 종류 가져오기 === //
			List<Map<String,String>> diningTypeInsertDataMapList = dao.getDiningTypeData(fk_lodge_id);
			// "예"를 누른경우 -> 기존에 넣어져 있는 데이터를 삭제 -> 현재 체크해온값 넣어주기 -> 다음으로넘김
			// "아니오"를 누른경우 -> 기존에 넣어져 있는 데이터를 삭제 -> 다음으로 넘김
			
			// 데이터 삭제
			if( diningTypeInsertDataMapList != null && diningTypeInsertDataMapList.size() > 0 ) {
			// 기존에 	tbl_din 테이블에 입력된 다이닝 정보 제거하기
				dao.diningTypeDataDelete(fk_lodge_id);
			}// end of if () -----------------
			
			// 기존 테이블에서 제거한 이후에
			if("1".equals(lg_dining_place_yn)) {
			// 다이닝 유무 "예"를 누른후 옵션을 체크해서 넘어온 경우
				// 현재 체크한 다이닝 장소들
				String[] Arr_fk_din_opt_no = request.getParameterValues("fk_din_opt_no");
				System.out.println("<< 다이닝 종류 >>");
				for(int i=0; i<Arr_fk_din_opt_no.length; i++) {
				// 현재 체크해온 값들 insert 시켜주기
					System.out.println("fk_din_opt_no => "+ Arr_fk_din_opt_no[i]);
					
					Map<String,String> map = new HashMap<>();
					map.put("fk_din_opt_no", Arr_fk_din_opt_no[i]);
					map.put("fk_lodge_id", fk_lodge_id);
					
					// 체크한 현재 다이닝 장소 종류 insert
					n4 = dao.insertDiningType(map);
				}// end of for -----------------
				
			}
			else if ("0".equals(lg_dining_place_yn)) {
			// 다이닝 유무 "아니오"를 체크한 경우
				n4 = 1;
			}
			
		}// end of if(n3 == 1) 
		
		
		// tbl_pool 테이블 수영장 타입
		if(n4 == 1) {
			
			// === tbl_pool 테이블에 기존에 입력되어 있는 수영장 타입 가져오기 === //
			List<Map<String,String>> poolTypeDataMapList = dao.getPoolTypeData(fk_lodge_id);
			// "예"를 누른경우 -> 기존에 넣어져 있는 데이터를 삭제 -> 현재 체크해온값 넣어주기 -> 다음으로넘김
			// "아니오"를 누른경우 -> 기존에 넣어져 있는 데이터를 삭제 -> 다음으로 넘김
			
			// 데이터 삭제
			if( poolTypeDataMapList != null && poolTypeDataMapList.size() > 0 ) {
			// 기존에 	tbl_pool 테이블에 입력된 수영장 정보 제거하기
				dao.poolTypeDataDelete(fk_lodge_id);
			}// end of if () -----------------
			
			// 기존 테이블에서 제거한 이후에
			if("1".equals(lg_pool_yn)) {
			// 수영장 유무 "예"를 체크한 경우
				// 현재 체크한 수영장 종류 및 이용시간
				String[] Arr_fk_pool_opt_no = request.getParameterValues("fk_pool_opt_no");
				String[] Arr_pool_use_time = request.getParameterValues("pool_use_time");
				
				System.out.println("<< 수영장 타입 >>");
				for(int i=0; i<Arr_fk_pool_opt_no.length; i++) {
				// 현재 체크해온 값들 insert 시켜주기
					System.out.println("fk_pool_opt_no => "+ Arr_fk_pool_opt_no[i] + ","+ "pool_use_time => " + Arr_pool_use_time[i]);
					
					Map<String,String> map = new HashMap<>();
					map.put("fk_pool_opt_no", Arr_fk_pool_opt_no[i]);
					map.put("pool_use_time", Arr_pool_use_time[i]);
					map.put("fk_lodge_id", fk_lodge_id);
					
					// 체크한 현재 수영장 종류 insert
					n5 = dao.insertPoolType(map);
				}// end of for -----------------
				
			}
			else if ("0".equals(lg_pool_yn)) {
			// 수영장 유무 "아니오"를 체크한 경우
				n5=1;
			}			
			
		} // end of if(n4 == 1) ------- 수영장
		
		
		// tbl_fac테이블 장애인 편의 시설
		if(n5 == 1) {

			// === tbl_fac 테이블에 기존에 입력되어 있는 장애인 편의시설 종류 가져오기 === //
			List<Map<String,String>> facilityTypeInsertDataMapList = dao.getFacilityTypeData(fk_lodge_id);
			// "예"를 누른경우 -> 기존에 넣어져 있는 데이터를 삭제 -> 현재 체크해온값 넣어주기 -> 다음으로넘김
			// "아니오"를 누른경우 -> 기존에 넣어져 있는 데이터를 삭제 -> 다음으로 넘김
			
			// 데이터 삭제
			if( facilityTypeInsertDataMapList != null && facilityTypeInsertDataMapList.size() > 0 ) {
			// 기존에 	tbl_fac 테이블에 입력된 편의시설 정보 제거하기
				dao.facilityTypeDataDelete(fk_lodge_id);
			}// end of if () -----------------
			
			// 기존 테이블에서 제거한 이후에
			if("1".equals(lg_fac_yn)) {
			// 장애인편의시설 유무 "예"를 누른후 옵션을 체크해서 넘어온 경우
				// 현재 체크한 편의시설 종류
				String[] Arr_fk_fac_opt_no = request.getParameterValues("fk_fac_opt_no");
				
				System.out.println("<< 장애인 편의 시설 >>");
				for(int i=0; i<Arr_fk_fac_opt_no.length; i++) {
				// 현재 체크해온 값들 insert 시켜주기
					System.out.println("fk_fac_opt_no => "+ Arr_fk_fac_opt_no[i]);
					
					Map<String,String> map = new HashMap<>();
					map.put("fk_fac_opt_no", Arr_fk_fac_opt_no[i]);
					map.put("fk_lodge_id", fk_lodge_id);
					
					// 현재 체크한 장애인 편의시설 종류 insert
					n6 = dao.insertFacilityType(map);
				}// end of for -----------------
				
			}
			else if ("0".equals(lg_fac_yn)) {
			// 편의시설 유무 "아니오"를 체크한 경우
				n6=1;
			}		
			
		} // end of if(n5 == 1) --- 장애인 편의 시설 
		
		
		// tbl_cs테이블 고객 서비스
		if(n6 == 1) {
			
			// === tbl_cs 테이블에 기존에 입력되어 있는 고객서비스 종류 가져오기 === //
			List<Map<String,String>> CusSurTypeInsertDataMapList = dao.getCustomerSurviceTypeData(fk_lodge_id);
			// "예"를 누른경우 -> 기존에 넣어져 있는 데이터를 삭제 -> 현재 체크해온값 넣어주기 -> 다음으로넘김
			// "아니오"를 누른경우 -> 기존에 넣어져 있는 데이터를 삭제 -> 다음으로 넘김
			
			// 데이터 삭제
			if( CusSurTypeInsertDataMapList != null && CusSurTypeInsertDataMapList.size() > 0 ) {
			// 기존에 	tbl_cs 테이블에 입력된 고객서비스 정보 제거하기
				dao.customerSurviceTypeDataDelete(fk_lodge_id);
			}// end of if () -----------------
			
			// 기존 테이블에서 제거한 이후에
			if("1".equals(lg_service_yn)) {
			// 고객서비스 유무 "예"를 누른후 옵션을 체크해서 넘어온 경우
				// 현재 체크한 고객서비스 종류
				String[] Arr_fk_cs_opt_no = request.getParameterValues("fk_cs_opt_no");
				
				System.out.println("<< 고객 서비스 >>");
				for(int i=0; i<Arr_fk_cs_opt_no.length; i++) {
				// 현재 체크해온 값들 insert 시켜주기
					System.out.println("fk_cs_opt_no => "+ Arr_fk_cs_opt_no[i]);
					
					Map<String,String> map = new HashMap<>();
					map.put("fk_cs_opt_no", Arr_fk_cs_opt_no[i]);
					map.put("fk_lodge_id", fk_lodge_id);
					
					// 현재 체크한 고객서비스 종류 insert
					n7 = dao.insertCustomerServiceType(map);
				}// end of for -----------------
				
			}
			else if ("0".equals(lg_service_yn)) {
			// 고객서비스 유무 "아니오"를 체크한 경우
				n7=1;
			}
			
		} // end of if(n6 == 1)

		
		// tbl_rmsvc테이블 룸서비스
		if(n7 == 1) {
			
			// === tbl_rmsvc 테이블에 기존에 입력되어 있는 룸서비스 종류 가져오기 === //
			List<Map<String,String>> RoomSurviceTypeInsertMapList = dao.getRoomSurviceTypeData(fk_lodge_id);
			// "예"를 누른경우 -> 기존에 넣어져 있는 데이터를 삭제 -> 현재 체크해온값 넣어주기 -> 다음으로넘김
			// "아니오"를 누른경우 -> 기존에 넣어져 있는 데이터를 삭제 -> 다음으로 넘김
			
			// 데이터 삭제
			if( RoomSurviceTypeInsertMapList != null && RoomSurviceTypeInsertMapList.size() > 0 ) {
			// 기존에 	tbl_rmsvc 테이블에 입력된 룸서비스 정보 제거하기
				dao.roomSurviceTypeDataDelete(fk_lodge_id);
			}// end of if () -----------------
			
			// 기존 테이블에서 제거한 이후에
			if("1".equals(lg_rm_service_yn)) {
			// 룸서비스 유무 "예"를 누른후 옵션을 체크해서 넘어온 경우
				// 현재 체크한 룸서비스 종류
				String[] Arr_fk_rmsvc_opt_no = request.getParameterValues("fk_rmsvc_opt_no");
				
				System.out.println("<< 룸서비스 >>");
				for(int i=0; i<Arr_fk_rmsvc_opt_no.length; i++) {
				// 현재 체크해온 값들 insert 시켜주기
					System.out.println("fk_rmsvc_opt_no => "+ Arr_fk_rmsvc_opt_no[i]);
					
					Map<String,String> map = new HashMap<>();
					map.put("fk_rmsvc_opt_no", Arr_fk_rmsvc_opt_no[i]);
					map.put("fk_lodge_id", fk_lodge_id);
					
					// 현재 체크한 룸서비스 종류 insert
					n8 = dao.insertRoomServiceType(map);
				}// end of for -----------------
				
			}
			else if ("0".equals(lg_rm_service_yn)) {
			// 룸서비스 유무 "아니오"를 체크한 경우
				n8=1;
			}
			
		}// end of if(n7 == 1) ------------- 룸서비스 

		
		// tbl_bsns테이블 비즈니스
		if(n8 == 1) {
			
			// === tbl_bsns 테이블에 기존에 입력되어 있는 비즈니스 종류 가져오기 === //
			List<Map<String,String>> businessRoomTypeInsertMapList = dao.getBusinessRoomTypeData(fk_lodge_id);
			// "예"를 누른경우 -> 기존에 넣어져 있는 데이터를 삭제 -> 현재 체크해온값 넣어주기 -> 다음으로넘김
			// "아니오"를 누른경우 -> 기존에 넣어져 있는 데이터를 삭제 -> 다음으로 넘김
			
			// 데이터 삭제
			if( businessRoomTypeInsertMapList != null && businessRoomTypeInsertMapList.size() > 0 ) {
			// 기존에 	tbl_bsns 테이블에 입력된 비즈니스 정보 제거하기
				dao.businessRoomTypeDataDelete(fk_lodge_id);
			}// end of if () -----------------
			
			// 기존 테이블에서 제거한 이후에
			if("1".equals(lg_business_yn)) {
			// 비즈니스 유무 "예"를 누른후 옵션을 체크해서 넘어온 경우
				// 현재 체크한 비즈니스 장소 종류
				String[] Arr_fk_bsns_opt_no = request.getParameterValues("fk_bsns_opt_no");
				
				System.out.println("<< 비즈니스 >>");
				for(int i=0; i<Arr_fk_bsns_opt_no.length; i++) {
				// 현재 체크해온 값들 insert 시켜주기
					System.out.println("fk_bsns_opt_no => "+ Arr_fk_bsns_opt_no[i]);
					
					Map<String,String> map = new HashMap<>();
					map.put("fk_bsns_opt_no", Arr_fk_bsns_opt_no[i]);
					map.put("fk_lodge_id", fk_lodge_id);
					
					// 현재 체크한 비즈니스 장소 종류 insert
					n9 = dao.insertBusinessRoomType(map);
				}// end of for -----------------
				
			}
			else if ("0".equals(lg_business_yn)) {
			// 비즈니스 유무 "아니오"를 체크한 경우
				n9=1;
			}			
			
		}// end of if(n8 == 1) ------- 비즈니스
		
		/////////////////////////////////////////////////////////////////////////////////////		
		// tbl_fasvc테이블 가족여행
		if(n9 == 1) {

			// === tbl_fasvc 테이블에 기존에 입력되어 있는 가족여행(어린이시설) 종류 가져오기 === //
			List<Map<String,String>> familyTypeInsertMapList = dao.getFamilyTypeData(fk_lodge_id);
			// "예"를 누른경우 -> 기존에 넣어져 있는 데이터를 삭제 -> 현재 체크해온값 넣어주기 -> 다음으로넘김
			// "아니오"를 누른경우 -> 기존에 넣어져 있는 데이터를 삭제 -> 다음으로 넘김
			
			// 데이터 삭제
			if( familyTypeInsertMapList != null && familyTypeInsertMapList.size() > 0 ) {
			// 기존에 	tbl_fasvc 테이블에 입력된 가족여행(어린이시설) 정보 제거하기
				dao.familyTypeDataDelete(fk_lodge_id);
			}// end of if () -----------------
			
			// 기존 테이블에서 제거한 이후에
			if("1".equals(lg_fa_travel_yn)) {
			// 가족서비스 유무 "예"를 누른후 옵션을 체크해서 넘어온 경우
				// 현재 체크한 가족여행(어린이시설) 종류
				String[] Arr_fk_fasvc_opt_no = request.getParameterValues("fk_fasvc_opt_no");
				
				System.out.println("<< 가족 >>");
				for(int i=0; i<Arr_fk_fasvc_opt_no.length; i++) {
				// 현재 체크해온 값들 insert 시켜주기
					System.out.println("fk_fasvc_opt_no => "+ Arr_fk_fasvc_opt_no[i]);
					
					Map<String,String> map = new HashMap<>();
					map.put("fk_fasvc_opt_no", Arr_fk_fasvc_opt_no[i]);
					map.put("fk_lodge_id", fk_lodge_id);
					
					// 현재 체크한 가족여행(어린이서비스) 종류 insert
					n10 = dao.insertFamilyType(map);
				}// end of for -----------------
				
			}
			else if ("0".equals(lg_fa_travel_yn)) {
			// 가족서비스 유무 "아니오"를 체크한 경우
				n10 = 1;
			}
			
		}// end of if(n9 == 1) ------- 가족 여행
		/////////////////////////////////////////////////////////////////////////////////////
		
		
		result = n1*n2*n3*n4*n5*n6*n7*n8*n9*n10;
		
		return result;
	}

	
	// DB에 입력되어 있는 숙박시설 ID 가져오기 //
	@Override
	public String getLodgeId(String lodge_id) {
		String compareLodgeId = dao.getLodgeId(lodge_id);
		return compareLodgeId;
	}

	// === 이미지 등록하기 === //
	@Override
	public void insertLodgeImages(Map<String, String> paraMap) {
		dao.insertLodgeImages(paraMap);
	}

	// === 기존에 등록된 이미지 삭제하기 === //
	@Override
	public void delLodgeImg(String fk_lodge_id) {
		dao.delLodgeImg(fk_lodge_id);
	}

	// == 욕실 옵션 종류 == //
	@Override
	public List<Map<String, String>> getBathOpt() {
		List<Map<String,String>> bathOptMapList = dao.getBathOpt();
		return bathOptMapList;
	}

	// == 주방(조리시설) 종류 == //
	@Override
	public List<Map<String, String>> getKitchenOpt() {
		List<Map<String,String>> kitchenOptMapList = dao.getKitchenOpt();
		return kitchenOptMapList;
	}

	// == 객실 내 다과 옵션 종류 == //
	@Override
	public List<Map<String, String>> getSnackOpt() {
		List<Map<String,String>> snackOptMapList = dao.getSnackOpt();
		return snackOptMapList;
	}

	
	// == 객실 내 엔터테이먼트 옵션 종류 == //
	@Override
	public List<Map<String, String>> getEntertainmentOpt() {
		List<Map<String,String>> entertainmentOptMapList = dao.getEntertainmentOpt();
		return entertainmentOptMapList;
	}

	// == 온도조절기 옵션 종류 == //
	@Override
	public List<Map<String, String>> getTemperatureControllerOpt() {
		List<Map<String,String>> temperatureControllerOptMapList = dao.getTemperatureControllerOpt();
		return temperatureControllerOptMapList;
	}

	// == 전망 옵션 종류 == //
	@Override
	public List<Map<String, String>> getViewOpt() {
		List<Map<String,String>> viewOptMapList = dao.getViewOpt();
		return viewOptMapList;
	}

	// 현재 로그인한 판매자의 ID로 숙박시설의 lodge_id를 가져온다.
	@Override
	public String getLodgeIdByUserId(String fk_h_userid) {
		String lodge_id = dao.getLodgeIdByUserId(fk_h_userid);
		return lodge_id;
	}

	// == ** 이미 입력된 room 정보가 있다면 수정과 추가를 하기위해서 체크 해야 된다 ** == //
	@Override
	public List<Map<String, String>> getRmInfo(String fk_lodge_id) {
		List<Map<String,String>> updateRmInfoMapList = dao.getRmInfo(fk_lodge_id);
		return updateRmInfoMapList;
	}
	
	
	// *** === 객실정보 데이터 등록 === *** //
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	@Override
	public int register_rm(HashMap<String, String> paraMap, HttpServletRequest request) throws Throwable {
		
		int n1=0,n2=0,n3=0,n4=0,n5=0,n6=0,result=0;
		
		String update_room_seq = paraMap.get("update_room_seq");
		// 값이 "0"이면 새로운 객실 추가
		// 값이 "rm-**"이면 객실 수정
		// 값이 "" 이면 잘못된 값이다.
		
		String re_seq = ""; // 값 초기화
		String fk_rm_seq = "";
		
		if("0".equals(update_room_seq)) {
		// 새로운 객실을 등록하고자 한다.
			// 등록할 번호를 먼저 채번해온다.
			re_seq = dao.selectSeqTblRoomNextVal(); // tbl_room의 seq값 채번 숫자로 되어있다.  
			fk_rm_seq = "rm-"+re_seq; // tbl_room에 들어갈 rm_seq 값이다.
			// rm-33
			
			paraMap.put("rm_seq",fk_rm_seq); 
			
			// ==== 객실 정보 등록 ==== //
			n1 = dao.register_rm(paraMap);
		}
		else {
		// 기존에 있던 객실을 수정하고자 한다.
			fk_rm_seq = update_room_seq;
			paraMap.put("rm_seq", fk_rm_seq);
			
			// ==== 객실 정보 수정 ==== //
			n1 = dao.update_rm(paraMap);
		}
		
		
		
		// ==== 객실 옵션 정보 등록 ==== //
		Map<String,String> insertMap = new HashMap<>(); 
		insertMap.put("fk_rm_seq", fk_rm_seq); // 옵션들에 들어갈 fk_rm_seq값이다.
		
	//	System.out.println("fk_rm_seq => "+ insertMap.get("fk_rm_seq"));
		// rm-33
		
			// == 욕실 옵션 체크박스== //
		if(n1 == 1) {
		// 객실 정보 성공적으로 등록
			String rm_bathroom_cnt = paraMap.get("rm_bathroom_cnt");
			int int_rm_bathroom_cnt;
			
			try {
				int_rm_bathroom_cnt = Integer.parseInt(rm_bathroom_cnt);
			} catch (Exception e) {
				int_rm_bathroom_cnt = 0;
			}
			
			// 기존에 입력되어 있는 정보 삭제
			dao.bathRoomDataDelete(fk_rm_seq);
			
			if(int_rm_bathroom_cnt > 0) {
			// 전용 욕실이 있는 경우
				String[] arr_fk_bath_opt_no = request.getParameterValues("fk_bath_opt_no");
				
				System.out.println("// == 욕실 옵션 체크박스== //");
				if(arr_fk_bath_opt_no.length > 0) {
					
					for(int i=0; i<arr_fk_bath_opt_no.length ; i++) {
						System.out.println(arr_fk_bath_opt_no[i]);
						insertMap.put("fk_bath_opt_no", arr_fk_bath_opt_no[i]);
						
						// 전용 욕실 옵션 insert 하기
						n2 = dao.bathRoomDataInsert(insertMap);
					} // end of for ---------------------------
				} // end of if(arr_fk_bath_opt_no.length > 0)
				
			} // end of if(int_rm_bathroom_cnt > 0)
			else {
			// 전용 욕실이 없는 경우
				n2 = 1;
			}
			
		} // end if(n1 == 1)
		

		
			// == 주방 옵션 체크박스== //
		if(n2 == 1) {
		// 이전 정보 입력시
			
			// 기존에 입력되어 있는 정보 삭제
			dao.kitchenDataDelete(fk_rm_seq);
			
			String rm_kitchen_yn = paraMap.get("rm_kitchen_yn");
			if("1".equals(rm_kitchen_yn)) {
			// 주방이 있는 경우
				String[] arr_fk_kt_opt_no = request.getParameterValues("fk_kt_opt_no");
				
				System.out.println("// == 주방 옵션 체크박스 == //");
				for(int i=0; i<arr_fk_kt_opt_no.length ; i++) {
					System.out.println(arr_fk_kt_opt_no[i]);
					insertMap.put("fk_kt_opt_no", arr_fk_kt_opt_no[i]);
					
					// 전용 욕실 옵션 insert 하기
					n3 = dao.kitchenDataInsert(insertMap);
				}
			} // end of if("1".equals(rm_kitchen_yn))
			else {
			// 주방이 없는 경우
				n3 = 1;
			}
		} // end of if(n2 == 1)

		
			// == 객실내 다과 옵션 체크박스== //
		if(n3 == 1) {
		// 이전 정보 입력시
			
			// 기존에 입력되어 있는 정보 삭제
			dao.snackDataDelete(fk_rm_seq);
			
			String rm_snack_yn = paraMap.get("rm_snack_yn");
			if("1".equals(rm_snack_yn)) {
			// 객실내 다과가 있는 경우
				String[] arr_fk_snk_opt_no = request.getParameterValues("fk_snk_opt_no");
				
				System.out.println("// == 객실내 다과 옵션 체크박스== //");
				for(int i=0; i<arr_fk_snk_opt_no.length ; i++) {
					System.out.println(arr_fk_snk_opt_no[i]);
					insertMap.put("fk_snk_opt_no", arr_fk_snk_opt_no[i]);
					
					// 객실내 다과 옵션 insert 하기
					n4 = dao.snackDataInsert(insertMap);
				} // end of for ----------
				
			} // end of if("1".equals(rm_snack_yn)) --------
			else {
			// 객실내 다과가 없는 경우
				n4 = 1;
			}
			
		}// end of if(n3 == 1) -------------
		
		
			
		
			// == 객실내 엔터테인먼트 옵션 체크박스== //
		if(n4 == 1) {
			// 이전 정보 입력시
				
			// 기존에 입력되어 있는 정보 삭제
			dao.entDataDelete(fk_rm_seq);
			
			String rm_ent_yn = paraMap.get("rm_ent_yn");
			if("1".equals(rm_ent_yn)) {
			// 객실내 엔터테인먼트가 있는 경우
				String[] arr_fk_ent_opt_no = request.getParameterValues("fk_ent_opt_no");
				
				System.out.println("// == 객실내 엔터테인먼트 옵션 체크박스== //");
				for(int i=0; i<arr_fk_ent_opt_no.length ; i++) {
					System.out.println(arr_fk_ent_opt_no[i]);
					insertMap.put("fk_ent_opt_no", arr_fk_ent_opt_no[i]);
					
					// 객실내 엔터테인먼트 옵션 insert 하기
					n5 = dao.entDataInsert(insertMap);
				} // end of for ----------
				
			} // end of if("1".equals(rm_snack_yn)) --------
			else {
			// 객실내 엔터테인먼트가 없는 경우
				n5 = 1;
			}
			
		}// end of if(n3 == 1) -------------
		

		
			// == 온도조절 옵션 체크박스== //
		if(n5 == 1) {
		// 이전 정보 입력시
				
			// 기존에 입력되어 있는 정보 삭제
			dao.tmpDataDelete(fk_rm_seq);
			
			String rm_tmp_ctrl_yn = paraMap.get("rm_tmp_ctrl_yn");
			if("1".equals(rm_tmp_ctrl_yn)) {
			// 온도조절기능이 있는 경우
				String[] arr_fk_tmp_opt_no = request.getParameterValues("fk_tmp_opt_no");
				
				System.out.println("// == 온도조절 옵션 체크박스== //");
				for(int i=0; i<arr_fk_tmp_opt_no.length ; i++) {
					System.out.println(arr_fk_tmp_opt_no[i]);
					insertMap.put("fk_tmp_opt_no", arr_fk_tmp_opt_no[i]);
					
					// 온도조절기능 옵션 insert 하기
					n6 = dao.tmpDataInsert(insertMap);
				} // end of for ----------
				
			} // end of if("1".equals(rm_snack_yn)) --------
			else {
			// 객실내 엔터테인먼트가 없는 경우
				n6 = 1;
			}
			
		}// end of if(n3 == 1) -------------
		
		
		result = n1*n2*n3*n4*n5*n6;
		
		return result;
	}

	// === 객실 이미지 등록하기 === //
	@Override
	public void insertRoomImages(Map<String, String> paraMap) {
		dao.insertRoomImages(paraMap);
	}

	// 변경된 객실의 기존에 입력된 사진 정보를 가져온다.
	@Override
	public List<Map<String, String>> getRmImgData(String fk_rm_seq) {
		List<Map<String,String>> roomImgDataMapList = dao.getRmImgData(fk_rm_seq);
		return roomImgDataMapList;
	}

	// === DB에서 이미지를 삭제한다. === //
	@Override
	public int delIdxImg(Map<String, String> paraMap) {
		int result = dao.delIdxImg(paraMap);
		return result;
	}

	// 다음 메인이미지 rm_img_seq 가져오기
	@Override
	public List<String> nextMainImgUpdate(String fk_rm_seq) {
		List<String> nextMainImg_rm_img_seq = dao.nextMainImgUpdate(fk_rm_seq);
		return nextMainImg_rm_img_seq;
	}

	// rm_img_seq값에 해당하는 이미지 정보의 rm_img_main를 "1"로 업데이트 하기
	@Override
	public void updateNextMainImg(String next_rm_img_seq) {
		dao.updateNextMainImg(next_rm_img_seq);
	}

	// 객실 사진등록 "사진 전체 제거" 버튼 클릭
	@Override
	public int delRoomImgFk_rm_seq(String fk_rm_seq) {
		int result = dao.delRoomImgFk_rm_seq(fk_rm_seq);
		return result;
	}

	// DB에 fk_rm_seq객실에 메인이미지가 등록되어 있는지 체크한다.
	@Override
	public String getMainImgCheck(String fk_rm_seq) {
		String check = dao.getMainImgCheck(fk_rm_seq);
		return check;
	}

	// DB에 등록된 이미지 파일명을 가지고 온다.
	@Override
	public List<Map<String, String>> getLodgeImgData(String fk_lodge_id) {
		List<Map<String,String>> LodgeImgMapList = dao.getLodgeImgData(fk_lodge_id);
		return LodgeImgMapList;
	}

	// === DB에서 시설 사진 정보를 삭제한다. === //
	@Override
	public int delIdxLodgeImg(Map<String, String> paraMap) {
		int result = dao.delIdxLodgeImg(paraMap);
		return result;
	}

	// == 경로에서 숙박시설 이미지 이름 DB에서 가져오기 == //
	@Override
	public List<String> getPathDelLodgeImgSaveName(Map<String, String> paraMap) {
		List<String> lg_img_save_name_List = dao.getPathDelLodgeImgSaveName(paraMap);
		return lg_img_save_name_List;
	}

	
	// === DB에서 숙박시설 사진 정보를 삭제한다. === //
	@Override
	public int delCateLodgeImg(Map<String, String> paraMap) {
		int result = dao.delCateLodgeImg(paraMap);
		return result;
	}

	
	// 기존에 입력되어 있는 rm_type List 가져오기
	@Override
	public List<String> getRm_typeData(Map<String, String> paraMap) {
		List<String> rm_typeList = dao.getRm_typeData(paraMap);
		return rm_typeList;
	}


	
	
}
