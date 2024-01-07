package com.spring.app.db.lodge.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.spring.app.expedia.domain.LodgeVO;

public interface LodgeDAO {

	// == 숙박시설 유형 테이블에서 select == //
	List<Map<String, String>> getLodgeType();

	// == 환불 정책 옵션 select == //
	List<Map<String, String>> getCancelOption();

	// == 셀프 체크인 방법 select == //
	List<Map<String, String>> getSelfCheckinOption();

	// == 인터넷 옵션 체크박스 == //
	List<Map<String, String>> getInternetOption();
	
	// == 주차장 옵션 체크박스  == //
	List<Map<String, String>> getParkOption();
	
	// == 수영장 종류 체크박스 == //
	List<Map<String, String>> getPoolType();

	// == 다이닝 장소 종류 체크박스 == //
	List<Map<String, String>> getDiningPlace();
	
	// == 장애인 편의 시설 정보 체크박스 == //
	List<Map<String, String>> getFacilityInfo();

	// == 스파 서비스 종류 셀렉트 == //
	List<Map<String, String>> getSpaType();

	// == 고객서비스 종류 체크박스 == //
	List<Map<String, String>> getConsumerService();

	// == 룸 서비스 종류 체크박스  == //
	List<Map<String, String>> getRoomService();

	// == 비즈니스 공간 종류 체크박스 == //
	List<Map<String, String>> getBusinessType();

	// == 가족서비스 종류 체크박스 == //
	List<Map<String, String>> getFamilyServiceType();

	// === tbl_inet에 입력되어 있는 인터넷 옵션 가져오기 === //
	List<Map<String, String>> getInternetService(String fk_lodge_id);

	// === 숙박시설 등록 === //
	int insertLodge(Map<String, String> paraMap);

	// === 등록 또는 수정하려는 fk_lodge_id로 tbl_inet테이블에 입력되어 있는 데이터 삭제하기 === //
	void internetDataDelete(String fk_lodge_id);

	// === 삭제 이후 tbl_inet테이블에 현재 체크한 체크 박스 insert해 주기 === //
	int insertInterOption(Map<String, String> map);

	// 기존에 입력되어있는 lodge정보 가져오기
	LodgeVO getLodgeInfo(String fk_h_userid);

	// Lodge 데이터 수정하기
	int updateLodge(Map<String, String> paraMap);

	// === tbl_park테이블에 기존에 입력되어 있는 주차장 옵션 가져오기 === //
	List<Map<String, String>> getParkOptionData(String fk_lodge_id);
	
	// 기존에 	tbl_park 테이블에 입력된 주차장정보 제거하기
	void parkOptionDataDelete(String fk_lodge_id);

	// 현재 주차장 옵션 insert
	int insertParkOption(Map<String, String> map);

	// === tbl_din 테이블에 기존에 입력되어 있는 다이닝 종류 가져오기 === //
	List<Map<String, String>> getDiningTypeData(String fk_lodge_id);
	
	// 기존 tbl_din에 입력된 데이터 제거하기 //
	void diningTypeDataDelete(String fk_lodge_id);

	// 체크한 현재 다이닝 장소 종류 insert
	int insertDiningType(Map<String, String> map);
	
	// === tbl_pool 테이블에 기존에 입력되어 있는 수영장 타입 가져오기 === //
	List<Map<String, String>> getPoolTypeData(String fk_lodge_id);

	// 기존에 	tbl_pool 테이블에 입력된 수영장 정보 제거하기
	void poolTypeDataDelete(String fk_lodge_id);

	// 체크한 현재 수영장 종류 insert
	int insertPoolType(Map<String, String> map);

	// === tbl_fac 테이블에 기존에 입력되어 있는 장애인 편의시설 종류 가져오기 === //
	List<Map<String, String>> getFacilityTypeData(String fk_lodge_id);

	// 기존에 	tbl_fac 테이블에 입력된 편의시설 정보 제거하기
	void facilityTypeDataDelete(String fk_lodge_id);

	// 현재 체크한 장애인 편의시설 종류 insert
	int insertFacilityType(Map<String, String> map);

	// === tbl_cs 테이블에 기존에 입력되어 있는 고객서비스 종류 가져오기 === //
	List<Map<String, String>> getCustomerSurviceTypeData(String fk_lodge_id);

	// 기존에 	tbl_cs 테이블에 입력된 고객서비스 정보 제거하기
	void customerSurviceTypeDataDelete(String fk_lodge_id);

	// 현재 체크한 고객서비스 종류 insert
	int insertCustomerServiceType(Map<String, String> map);

	// === tbl_rmsvc 테이블에 기존에 입력되어 있는 룸서비스 종류 가져오기 === //
	List<Map<String, String>> getRoomSurviceTypeData(String fk_lodge_id);

	// 기존에 	tbl_rmsvc 테이블에 입력된 룸서비스 정보 제거하기
	void roomSurviceTypeDataDelete(String fk_lodge_id);

	// 현재 체크한 룸서비스 종류 insert
	int insertRoomServiceType(Map<String, String> map);

	// === tbl_bsns 테이블에 기존에 입력되어 있는 비즈니스 종류 가져오기 === //
	List<Map<String, String>> getBusinessRoomTypeData(String fk_lodge_id);

	// 기존에 	tbl_bsns 테이블에 입력된 비즈니스 정보 제거하기
	void businessRoomTypeDataDelete(String fk_lodge_id);

	// 현재 체크한 비즈니스 장소 종류 insert
	int insertBusinessRoomType(Map<String, String> map);

	// === tbl_fasvc 테이블에 기존에 입력되어 있는 가족여행(어린이시설) 종류 가져오기 === //
	List<Map<String, String>> getFamilyTypeData(String fk_lodge_id);

	// 기존에 	tbl_fasvc 테이블에 입력된 가족여행(어린이시설) 정보 제거하기
	void familyTypeDataDelete(String fk_lodge_id);

	// 현재 체크한 가족여행(어린이서비스) 종류 insert
	int insertFamilyType(Map<String, String> map);

	// DB에 입력되어 있는 숙박시설 ID 가져오기 //
	String getLodgeId(String lodge_id);

	// === 이미지 등록하기 === //
	void insertLodgeImages(Map<String, String> paraMap);

	// === 기존에 등록된 이미지 삭제하기 === //
	void delLodgeImg(String fk_lodge_id);

	// == 욕실 옵션 종류 == //
	List<Map<String, String>> getBathOpt();

	// == 주방(조리시설) 종류 == //
	List<Map<String, String>> getKitchenOpt();

	// == 객실 내 다과 옵션 종류 == //
	List<Map<String, String>> getSnackOpt();

	// == 객실 내 엔터테이먼트 옵션 종류 == //
	List<Map<String, String>> getEntertainmentOpt();

	// == 온도조절기 옵션 종류 == //
	List<Map<String, String>> getTemperatureControllerOpt();

	// == 전망 옵션 종류 == //
	List<Map<String, String>> getViewOpt();

	// ===================== 객실 등록 ================== //
	
	// insert에 사용할 rm_seq값 채번하기 
	String selectSeqTblRoomNextVal();
		
	// ==== 객실 정보 등록 ==== //
	int register_rm(HashMap<String, String> paraMap);

	// ==== 객실 정보 수정 ==== //
	int update_rm(HashMap<String, String> paraMap);
	
	// tbl_bath테이블에 입력되어 있는 정보 삭제
	void bathRoomDataDelete(String fk_rm_seq);

	// 전용 욕실 옵션 insert 하기
	int bathRoomDataInsert(Map<String, String> insertMap);

	// 현재 로그인한 판매자의 ID로 숙박시설의 lodge_id를 가져온다.
	String getLodgeIdByUserId(String fk_h_userid);

	// == ** 이미 입력된 room 정보가 있다면 수정과 추가를 하기위해서 체크 해야 된다 ** == //
	List<Map<String, String>> getRmInfo(String fk_lodge_id);

	// tbl_kitchen테이블에 입력되어 있는 정보 삭제
	void kitchenDataDelete(String fk_rm_seq);

	// 전용 욕실 옵션 insert 하기
	int kitchenDataInsert(Map<String, String> insertMap);

	// tbl_snack테이블에 입력되어 있는 정보 삭제
	void snackDataDelete(String fk_rm_seq);

	// 객실내 다과 옵션 insert 하기
	int snackDataInsert(Map<String, String> insertMap);

	// tbl_ent테이블에 입력되어 있는 정보 삭제
	void entDataDelete(String fk_rm_seq);

	// 객실내 엔터테인먼트 옵션 insert 하기
	int entDataInsert(Map<String, String> insertMap);

	// tbl_tmp테이블에 입력되어 있는 정보 삭제
	void tmpDataDelete(String fk_rm_seq);

	// 온도조절기능 옵션 insert 하기
	int tmpDataInsert(Map<String, String> insertMap);

	// 기존에 입력되어 있는 rm_type List 가져오기
	List<String> getRm_typeData(String fk_lodge_id);

	// === 객실 이미지 등록하기 === //
	void insertRoomImages(Map<String, String> paraMap);

	// 변경된 객실의 기존에 입력된 사진 정보를 가져온다.
	List<Map<String, String>> getRmImgData(String fk_rm_seq);

	// === DB에서 이미지를 삭제한다. === //
	int delIdxImg(Map<String, String> paraMap);

	// 다음 메인이미지 rm_img_seq 가져오기
	List<String> nextMainImgUpdate(String fk_rm_seq);

	// rm_img_seq값에 해당하는 이미지 정보의 rm_img_main를 "1"로 업데이트 하기
	void updateNextMainImg(String next_rm_img_seq);

	// 객실 사진등록 "사진 전체 제거" 버튼 클릭
	int delRoomImgFk_rm_seq(String fk_rm_seq);

	// DB에 fk_rm_seq객실에 메인이미지가 등록되어 있는지 체크한다.
	String getMainImgCheck(String fk_rm_seq);

	// DB에 등록된 이미지 파일명을 가지고 온다.
	List<Map<String, String>> getLodgeImgData(String fk_lodge_id);
	

}
