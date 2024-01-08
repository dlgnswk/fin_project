package com.spring.app.db.lodge.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.app.expedia.domain.LodgeVO;

@Repository
public class LodgeDAO_imple implements LodgeDAO {

	@Resource
	private SqlSessionTemplate sqlsession;
	
	
	// == 숙박시설 유형 테이블에서 select == //
	@Override
	public List<Map<String, String>> getLodgeType() {
		List<Map<String,String>> lodgeTypeMapList = sqlsession.selectList("db_register_lodge.getLodgeType"); 
		return lodgeTypeMapList;
	}
	
	// == 환불 정책 옵션 select == //
	@Override
	public List<Map<String, String>> getCancelOption() {
		List<Map<String,String>> CancelOptionMapList = sqlsession.selectList("db_register_lodge.getCancelOption");
		return CancelOptionMapList;
	}

	
	// == 셀프 체크인 방법 select == //
	@Override
	public List<Map<String, String>> getSelfCheckinOption() {
		List<Map<String,String>> selfCheckinOptionMapList = sqlsession.selectList("db_register_lodge.getSelfCheckinOption");
		return selfCheckinOptionMapList;
	}


	// == 인터넷 옵션 체크박스 == //
	@Override
	public List<Map<String, String>> getInternetOption() {
		List<Map<String,String>> internetOptionMapList = sqlsession.selectList("db_register_lodge.getInternetOption");
		return internetOptionMapList;
	}
	
	// == 주차장 옵션 체크박스  == //
	@Override
	public List<Map<String, String>> getParkOption() {
		List<Map<String,String>> parkOptionMapList = sqlsession.selectList("db_register_lodge.getParkOption");
		return parkOptionMapList;
	}
	
	// == 수영장 종류 체크박스 == //
	@Override
	public List<Map<String, String>> getPoolType() {
		List<Map<String,String>> poolTypeMapList = sqlsession.selectList("db_register_lodge.getPoolType");
		return poolTypeMapList;
	}
	
	
	// == 다이닝 장소 종류 체크박스 == //
	@Override
	public List<Map<String, String>> getDiningPlace() {
		
		List<Map<String,String>> diningPlaceMapList = sqlsession.selectList("db_register_lodge.getDiningPlace");
		return diningPlaceMapList;
	}
	
	// == 장애인 편의 시설 정보 체크박스 == //
	@Override
	public List<Map<String, String>> getFacilityInfo() {
		
		List<Map<String,String>> facilityInfoMapList = sqlsession.selectList("db_register_lodge.getFacilityInfo");
		return facilityInfoMapList;
	}

	// == 스파 서비스 종류 셀렉트 == //
	@Override
	public List<Map<String, String>> getSpaType() {
		List<Map<String,String>> spaTypeMapList = sqlsession.selectList("db_register_lodge.getSpaType");
		return spaTypeMapList;
	}

	// == 고객서비스 종류 체크박스 == //
	@Override
	public List<Map<String, String>> getConsumerService() {
		List<Map<String,String>> consumerServiceTypeMapList = sqlsession.selectList("db_register_lodge.getConsumerService");
		return consumerServiceTypeMapList;
	}

	
	// == 룸 서비스 종류 체크박스  == //
	@Override
	public List<Map<String, String>> getRoomService() {
		List<Map<String,String>> roomServiceMapList = sqlsession.selectList("db_register_lodge.getRoomService");
		return roomServiceMapList;
	}

	// == 비즈니스 공간 종류 체크박스 == //
	@Override
	public List<Map<String, String>> getBusinessType() {
		List<Map<String,String>> businessTypeMapList = sqlsession.selectList("db_register_lodge.getBusinessType");
		return businessTypeMapList;
	}

	// == 가족서비스 종류 체크박스 == //
	@Override
	public List<Map<String, String>> getFamilyServiceType() {
		List<Map<String,String>> familyServiceTypeMapList = sqlsession.selectList("db_register_lodge.getFamilyServiceType");
		return familyServiceTypeMapList;
	}

	// === 숙박시설 등록 === //
	@Override
	public int insertLodge(Map<String, String> paraMap) {
		int n1 = sqlsession.insert("db_register_lodge.insertLodge", paraMap);
		return n1;
	}

	// === tbl_inet에 입력되어 있는 인터넷 옵션 가져오기 === //
	@Override
	public List<Map<String, String>> getInternetService(String fk_lodge_id) {
		List<Map<String,String>> internetInsertDataMapList = sqlsession.selectList("db_register_lodge.getInternetService", fk_lodge_id);
		return internetInsertDataMapList;
	}

	
	// === 등록 또는 수정하려는 fk_lodge_id로 tbl_inet테이블에 입력되어 있는 데이터 삭제하기 === //
	@Override
	public void internetDataDelete(String fk_lodge_id) {
		sqlsession.delete("db_register_lodge.internetDataDelete", fk_lodge_id);
	}

	
	// === 삭제 이후 tbl_inet테이블에 현재 체크한 체크 박스 insert해 주기 === //
	@Override
	public int insertInterOption(Map<String, String> map) {
		int n2 = sqlsession.insert("db_register_lodge.insertInterOption", map);
		return n2;
	}

	// 기존에 입력되어있는 lodge정보 가져오기
	@Override
	public LodgeVO getLodgeInfo(String fk_h_userid) {
		LodgeVO LodgeInfo = sqlsession.selectOne("db_register_lodge.getLodgeInfo", fk_h_userid);
		return LodgeInfo;
	}

	// Lodge 데이터 수정하기
	@Override
	public int updateLodge(Map<String, String> paraMap) {
		int n1 = sqlsession.update("db_register_lodge.updateLodge", paraMap);
		return n1;
	}

	
	// === tbl_park테이블에 기존에 입력되어 있는 주차장 옵션 가져오기 === //
	@Override
	public List<Map<String, String>> getParkOptionData(String fk_lodge_id) {
		List<Map<String,String>> parkOptionInsertDataMapList = sqlsession.selectList("db_register_lodge.getParkOptionData", fk_lodge_id);
		return parkOptionInsertDataMapList;
	}

	// 기존에 	tbl_park 테이블에 입력된 주차장정보 제거하기
	@Override
	public void parkOptionDataDelete(String fk_lodge_id) {
		sqlsession.delete("db_register_lodge.parkOptionDataDelete", fk_lodge_id);
	}

	// 현재 주차장 옵션 insert
	@Override
	public int insertParkOption(Map<String, String> map) {
		int n3 = sqlsession.insert("db_register_lodge.insertParkOption", map);
		return n3;
	}

	// === tbl_din 테이블에 기존에 입력되어 있는 다이닝 종류 가져오기 === //
	@Override
	public List<Map<String, String>> getDiningTypeData(String fk_lodge_id) {
		List<Map<String,String>> diningTypeInsertDataMapList = sqlsession.selectList("db_register_lodge.getDiningTypeData", fk_lodge_id);
		return diningTypeInsertDataMapList;
	}

	
	// 기존 tbl_din에 입력된 데이터 제거하기 //
	@Override
	public void diningTypeDataDelete(String fk_lodge_id) {
		sqlsession.delete("db_register_lodge.diningTypeDataDelete", fk_lodge_id);
	}

	// 체크한 현재 다이닝 장소 종류 insert
	@Override
	public int insertDiningType(Map<String, String> map) {
		int n4 = sqlsession.insert("db_register_lodge.insertDiningType", map);
		return n4;
	}

	// === tbl_pool 테이블에 기존에 입력되어 있는 수영장 타입 가져오기 === //
	@Override
	public List<Map<String, String>> getPoolTypeData(String fk_lodge_id) {
		List<Map<String,String>> poolTypeDataMapList = sqlsession.selectList("db_register_lodge.getPoolTypeData", fk_lodge_id);
		return poolTypeDataMapList;
	}

	// 기존에 	tbl_pool 테이블에 입력된 수영장 정보 제거하기
	@Override
	public void poolTypeDataDelete(String fk_lodge_id) {
		sqlsession.delete("db_register_lodge.poolTypeDataDelete", fk_lodge_id);
	}

	// 체크한 현재 수영장 종류 insert
	@Override
	public int insertPoolType(Map<String, String> map) {
		int n5 = sqlsession.insert("db_register_lodge.insertPoolType", map);
		return n5;
	}

	// === tbl_fac 테이블에 기존에 입력되어 있는 장애인 편의시설 종류 가져오기 === //
	@Override
	public List<Map<String, String>> getFacilityTypeData(String fk_lodge_id) {
		List<Map<String,String>> facilityTypeInsertDataMapList = sqlsession.selectList("db_register_lodge.getFacilityTypeData", fk_lodge_id);
		return facilityTypeInsertDataMapList;
	}

	// 기존에 	tbl_fac 테이블에 입력된 편의시설 정보 제거하기
	@Override
	public void facilityTypeDataDelete(String fk_lodge_id) {
		sqlsession.delete("db_register_lodge.facilityTypeDataDelete", fk_lodge_id);
	}

	// 현재 체크한 장애인 편의시설 종류 insert
	@Override
	public int insertFacilityType(Map<String, String> map) {
		int n6 = sqlsession.insert("db_register_lodge.insertFacilityType", map);
		return n6;
	}

	// === tbl_cs 테이블에 기존에 입력되어 있는 고객서비스 종류 가져오기 === //
	@Override
	public List<Map<String, String>> getCustomerSurviceTypeData(String fk_lodge_id) {
		List<Map<String,String>> CusSurTypeInsertDataMapList = sqlsession.selectList("db_register_lodge.getCustomerSurviceTypeData", fk_lodge_id);
		return CusSurTypeInsertDataMapList;
	}

	// 기존에 	tbl_cs 테이블에 입력된 고객서비스 정보 제거하기
	@Override
	public void customerSurviceTypeDataDelete(String fk_lodge_id) {
		sqlsession.delete("db_register_lodge.customerSurviceTypeDataDelete", fk_lodge_id);
	}

	// 현재 체크한 고객서비스 종류 insert
	@Override
	public int insertCustomerServiceType(Map<String, String> map) {
		int n7 = sqlsession.insert("db_register_lodge.insertCustomerServiceType", map);
		return n7;
	}

	// === tbl_rmsvc 테이블에 기존에 입력되어 있는 룸서비스 종류 가져오기 === //
	@Override
	public List<Map<String, String>> getRoomSurviceTypeData(String fk_lodge_id) {
		List<Map<String,String>> RoomSurviceTypeInsertMapList = sqlsession.selectList("db_register_lodge.getRoomSurviceTypeData", fk_lodge_id);
		return RoomSurviceTypeInsertMapList;
	}

	// 기존에 	tbl_rmsvc 테이블에 입력된 룸서비스 정보 제거하기
	@Override
	public void roomSurviceTypeDataDelete(String fk_lodge_id) {
		sqlsession.delete("db_register_lodge.roomSurviceTypeDataDelete", fk_lodge_id);
	}

	// 현재 체크한 룸서비스 종류 insert
	@Override
	public int insertRoomServiceType(Map<String, String> map) {
		int n8 = sqlsession.insert("db_register_lodge.insertRoomServiceType", map);
		return n8;
	}

	
	// === tbl_bsns 테이블에 기존에 입력되어 있는 비즈니스 종류 가져오기 === //
	@Override
	public List<Map<String, String>> getBusinessRoomTypeData(String fk_lodge_id) {
		List<Map<String,String>> businessRoomTypeInsertMapList = sqlsession.selectList("db_register_lodge.getBusinessRoomTypeData", fk_lodge_id);
		return businessRoomTypeInsertMapList;
	}

	// 기존에 	tbl_bsns 테이블에 입력된 비즈니스 정보 제거하기
	@Override
	public void businessRoomTypeDataDelete(String fk_lodge_id) {
		sqlsession.delete("db_register_lodge.businessRoomTypeDataDelete", fk_lodge_id);
	}

	// 현재 체크한 비즈니스 장소 종류 insert
	@Override
	public int insertBusinessRoomType(Map<String, String> map) {
		int n9 = sqlsession.insert("db_register_lodge.insertBusinessRoomType", map);
		return n9;
	}

	
	// === tbl_fasvc 테이블에 기존에 입력되어 있는 가족여행(어린이시설) 종류 가져오기 === //
	@Override
	public List<Map<String, String>> getFamilyTypeData(String fk_lodge_id) {
		List<Map<String,String>> familyTypeInsertMapList = sqlsession.selectList("db_register_lodge.getFamilyTypeData", fk_lodge_id);
		return familyTypeInsertMapList;
	}

	// 기존에 	tbl_fasvc 테이블에 입력된 가족여행(어린이시설) 정보 제거하기
	@Override
	public void familyTypeDataDelete(String fk_lodge_id) {
		sqlsession.delete("db_register_lodge.familyTypeDataDelete", fk_lodge_id);
	}

	// 현재 체크한 가족여행(어린이서비스) 종류 insert
	@Override
	public int insertFamilyType(Map<String, String> map) {
		int n10 = sqlsession.insert("db_register_lodge.insertFamilyType", map);
		return n10;
	}

	// DB에 입력되어 있는 숙박시설 ID 가져오기 //
	@Override
	public String getLodgeId(String lodge_id) {
		String compareLodgeId = sqlsession.selectOne("db_register_lodge.getLodgeId", lodge_id);
		return compareLodgeId;
	}

	// === 이미지 등록하기 === //
	@Override
	public void insertLodgeImages(Map<String, String> paraMap) {
		sqlsession.insert("db_register_lodge.insertLodgeImages", paraMap);
	}

	// === 이미지 삭제하기 === //
	@Override
	public void delLodgeImg(String fk_lodge_id) {
		sqlsession.insert("db_register_lodge.delLodgeImg", fk_lodge_id);
		
	}

	// == 욕실 옵션 종류 == //
	@Override
	public List<Map<String, String>> getBathOpt() {
		List<Map<String,String>> bathOptMapList = sqlsession.selectList("db_register_lodge.getBathOpt");
		return bathOptMapList;
	}

	// == 주방(조리시설) 종류 == //
	@Override
	public List<Map<String, String>> getKitchenOpt() {
		List<Map<String,String>> kitchenOptMapList = sqlsession.selectList("db_register_lodge.getKitchenOpt");
		return kitchenOptMapList;
	}

	// == 객실 내 다과 옵션 종류 == //
	@Override
	public List<Map<String, String>> getSnackOpt() {
		List<Map<String,String>> snackOptMapList = sqlsession.selectList("db_register_lodge.getSnackOpt");
		return snackOptMapList;
	}

	// == 객실 내 엔터테이먼트 옵션 종류 == //
	@Override
	public List<Map<String, String>> getEntertainmentOpt() {
		List<Map<String,String>> entertainmentOptMapList = sqlsession.selectList("db_register_lodge.getEntertainmentOpt");
		return entertainmentOptMapList;
	}

	// == 온도조절기 옵션 종류 == //
	@Override
	public List<Map<String, String>> getTemperatureControllerOpt() {
		List<Map<String,String>> temperatureControllerOptMapList = sqlsession.selectList("db_register_lodge.getTemperatureControllerOpt");
		return temperatureControllerOptMapList;
	}

	// == 전망 옵션 종류 == //
	@Override
	public List<Map<String, String>> getViewOpt() {
		List<Map<String,String>> viewOptMapList = sqlsession.selectList("db_register_lodge.getViewOpt");
		return viewOptMapList;
	}

	// ==== 객실 정보 등록 ==== //
	@Override
	public int register_rm(HashMap<String, String> paraMap) {
		int n1 = sqlsession.insert("db_register_lodge.register_rm", paraMap);
		return n1;
	}
	
	// ==== 객실 정보 수정 ==== //
	@Override
	public int update_rm(HashMap<String, String> paraMap) {
		int n1 = sqlsession.insert("db_register_lodge.update_rm", paraMap);
		return n1;
	}

	// tbl_bath테이블에 입력되어 있는 정보 삭제
	@Override
	public void bathRoomDataDelete(String fk_rm_seq) {
		sqlsession.delete("db_register_lodge.bathRoomDataDelete", fk_rm_seq);
	}

	// 전용 욕실 옵션 insert 하기
	@Override
	public int bathRoomDataInsert(Map<String, String> insertMap) {
		int n2 = sqlsession.insert("db_register_lodge.bathRoomDataInsert", insertMap);
		return n2;
	}

	// insert에 사용할 rm_seq값 채번하기 
	@Override
	public String selectSeqTblRoomNextVal() {
		String rm_seq = sqlsession.selectOne("db_register_lodge.selectSeqTblRoomNextVal");
		return rm_seq;
	}

	// 현재 로그인한 판매자의 ID로 숙박시설의 lodge_id를 가져온다.
	@Override
	public String getLodgeIdByUserId(String fk_h_userid) {
		String lodge_id = sqlsession.selectOne("db_register_lodge.getLodgeIdByUserId", fk_h_userid);
		return lodge_id;
	}


	// == ** 이미 입력된 room 정보가 있다면 수정과 추가를 하기위해서 체크 해야 된다 ** == //
	@Override
	public List<Map<String, String>> getRmInfo(String fk_lodge_id) {
		List<Map<String,String>> updateRmInfoMapList = sqlsession.selectList("db_register_lodge.getRmInfo", fk_lodge_id);
		return updateRmInfoMapList;
	}

	// tbl_kitchen테이블에 입력되어 있는 정보 삭제
	@Override
	public void kitchenDataDelete(String fk_rm_seq) {
		sqlsession.delete("db_register_lodge.kitchenDataDelete",fk_rm_seq);
	}

	// 전용 욕실 옵션 insert 하기
	@Override
	public int kitchenDataInsert(Map<String, String> insertMap) {
		int n3 = sqlsession.insert("db_register_lodge.kitchenDataInsert", insertMap);
		return n3;
	}

	// tbl_snack테이블에 입력되어 있는 정보 삭제
	@Override
	public void snackDataDelete(String fk_rm_seq) {
		sqlsession.delete("db_register_lodge.snackDataDelete",fk_rm_seq);
	}

	// 객실내 다과 옵션 insert 하기
	@Override
	public int snackDataInsert(Map<String, String> insertMap) {
		int n4 = sqlsession.insert("db_register_lodge.snackDataInsert", insertMap);
		return n4;
	}

	// tbl_ent테이블에 입력되어 있는 정보 삭제
	@Override
	public void entDataDelete(String fk_rm_seq) {
		sqlsession.delete("db_register_lodge.entDataDelete",fk_rm_seq);
	}

	// 객실내 엔터테인먼트 옵션 insert 하기
	@Override
	public int entDataInsert(Map<String, String> insertMap) {
		int n5 = sqlsession.insert("db_register_lodge.entDataInsert", insertMap);
		return n5;
	}

	// tbl_tmp테이블에 입력되어 있는 정보 삭제
	@Override
	public void tmpDataDelete(String fk_rm_seq) {
		sqlsession.delete("db_register_lodge.tmpDataDelete",fk_rm_seq);
	}

	// 온도조절기능 옵션 insert 하기
	@Override
	public int tmpDataInsert(Map<String, String> insertMap) {
		int n6 = sqlsession.insert("db_register_lodge.tmpDataInsert", insertMap);
		return n6;
	}
	
	
	// 기존에 입력되어 있는 rm_type List 가져오기
	@Override
	public List<String> getRm_typeData(String fk_lodge_id) {
		List<String> rm_typeList = sqlsession.selectList("db_register_lodge.getRm_typeData", fk_lodge_id);
		return rm_typeList;
	}

	// === 객실 이미지 등록하기 === //
	@Override
	public void insertRoomImages(Map<String, String> paraMap) {
		sqlsession.insert("db_register_lodge.insertRoomImages", paraMap);
	}

	// 변경된 객실의 기존에 입력된 사진 정보를 가져온다.
	@Override
	public List<Map<String, String>> getRmImgData(String fk_rm_seq) {
		List<Map<String,String>> roomImgDataMapList = sqlsession.selectList("db_register_lodge.getRmImgData", fk_rm_seq);
		return roomImgDataMapList;
	}

	// === DB에서 이미지파일 정보를 삭제한다. === //
	@Override
	public int delIdxImg(Map<String, String> paraMap) {
		int result = sqlsession.delete("db_register_lodge.delIdxImg" ,paraMap);
		return result;
	}

	// 다음 메인이미지 rm_img_seq 가져오기
	@Override
	public List<String> nextMainImgUpdate(String fk_rm_seq) {
		List<String> nextMainImg_rm_img_seq = sqlsession.selectList("db_register_lodge.nextMainImgUpdate", fk_rm_seq);
		return nextMainImg_rm_img_seq;
	}

	// rm_img_seq값에 해당하는 이미지 정보의 rm_img_main를 "1"로 업데이트 하기
	@Override
	public void updateNextMainImg(String next_rm_img_seq) {
		sqlsession.update("db_register_lodge.updateNextMainImg", next_rm_img_seq);
	}
	
	// 객실 사진등록 "사진 전체 제거" 버튼 클릭
	@Override
	public int delRoomImgFk_rm_seq(String fk_rm_seq) {
		int result = sqlsession.delete("db_register_lodge.delRoomImgFk_rm_seq", fk_rm_seq);
		return result;
	}

	// DB에 fk_rm_seq객실에 메인이미지가 등록되어 있는지 체크한다.
	@Override
	public String getMainImgCheck(String fk_rm_seq) {
		String check = sqlsession.selectOne("db_register_lodge.getMainImgCheck", fk_rm_seq);
		return check;
	}

	// DB에 등록된 이미지 파일명을 가지고 온다.
	@Override
	public List<Map<String, String>> getLodgeImgData(String fk_lodge_id) {
		List<Map<String,String>> LodgeImgMapList = sqlsession.selectList("db_register_lodge.getLodgeImgData", fk_lodge_id);
		return LodgeImgMapList;
	}

	// === DB에서 시설 사진 정보를 삭제한다. === //
	@Override
	public int delIdxLodgeImg(Map<String, String> paraMap) {
		int result = sqlsession.insert("db_register_lodge.delIdxLodgeImg", paraMap);
		return result;
	}

	// == 경로에서 숙박시설 이미지 이름 DB에서 가져오기 == //
	@Override
	public List<String> getPathDelLodgeImgSaveName(Map<String, String> paraMap) {
		List<String> lg_img_save_name_List = sqlsession.selectList("db_register_lodge.getPathDelLodgeImgSaveName", paraMap);
		return lg_img_save_name_List;
	}

	// === DB에서 숙박시설 사진 정보를 삭제한다. === //
	@Override
	public int delCateLodgeImg(Map<String, String> paraMap) {
		int result = sqlsession.delete("db_register_lodge.delCateLodgeImg", paraMap);
		return result;
	}

	
}
