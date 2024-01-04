package com.spring.app.jh.search.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

//==== #32. Repository(DAO) 선언 ====
//@Component
@Repository
public class SearchDAO_imple implements SearchDAO {

	// === #33. 의존객체 주입하기(DI: Dependency Injection) ===
	// >>> 의존 객체 자동 주입(Automatic Dependency Injection)은
	//     스프링 컨테이너가 자동적으로 의존 대상 객체를 찾아서 해당 객체에 필요한 의존객체를 주입하는 것을 말한다. 
	//     단, 의존객체는 스프링 컨테이너속에 bean 으로 등록되어 있어야 한다. 

	//     의존 객체 자동 주입(Automatic Dependency Injection)방법 3가지 
	//     1. @Autowired ==> Spring Framework에서 지원하는 어노테이션이다. 
	//                       스프링 컨테이너에 담겨진 의존객체를 주입할때 타입을 찾아서 연결(의존객체주입)한다.
	
	//     2. @Resource  ==> Java 에서 지원하는 어노테이션이다.
	//                       스프링 컨테이너에 담겨진 의존객체를 주입할때 필드명(이름)을 찾아서 연결(의존객체주입)한다.
	
	//     3. @Inject    ==> Java 에서 지원하는 어노테이션이다.
    //                       스프링 컨테이너에 담겨진 의존객체를 주입할때 타입을 찾아서 연결(의존객체주입)한다.
	
/*	
	@Autowired  // Type에 따라 알아서 Bean 을 주입해준다.
	private SqlSessionTemplate abc;
	// Type 에 따라 Spring 컨테이너가 알아서 root-context.xml 에 생성된 org.mybatis.spring.SqlSessionTemplate 의 bean 을  abc 에 주입시켜준다. 
    // 그러므로 abc 는 null 이 아니다.
*/
	
	@Resource
	private SqlSessionTemplate sqlsession;
	
	// 숙박시설 리스트 가져오기
	@Override
	public List<Map<String, String>> getLodgeList(Map<String, Object> paraMap) {
		List<Map<String, String>> lodgeList = sqlsession.selectList("jh_search.getLodgeList", paraMap);
		return lodgeList;
	}

	
	// map에 저장한 하나의 숙소에 지정일에 예약가능한 객실이 있는 경우 jsonObj_2에 저장하기
	@Override
	public List<Map<String, String>> getAvailableLodgeList(Map<String, Object> map) {
		List<Map<String, String>> availableLodgeList = sqlsession.selectList("jh_search.getAvailableLodgeList", map);
		return availableLodgeList;
	}


	// 캐러셀에 넣어줄 이미지 가져오기
	@Override
	public List<Map<String, String>> lodgeImgList() {
		List<Map<String, String>> lodgeImgList = sqlsession.selectList("jh_search.lodgeImgList");
		return lodgeImgList;
	}

	
	// 예약가능한 숙박시설 정보
	@Override
	public List<Map<String, String>> getLodgeInfoList(Map<String, Object> lodge_map) {
		List<Map<String, String>> lodgeInfoList = sqlsession.selectList("jh_search.getLodgeInfoList", lodge_map);
		return lodgeInfoList;
	}


	// 예약가능한 숙소의 이미지 리스트 가져오기
	@Override
	public List<Map<String, String>> getlodgeImgList(String lodge_id) {
		List<Map<String, String>> lodgeImgList = sqlsession.selectList("jh_search.getlodgeImgList", lodge_id);
		return lodgeImgList;
	}


	// 검색된 내용을 통해 호텔 최저, 최고가 검색
	@Override
	public Map<String, String> getLodgePrice(Map<String, String> paraMap) {
		Map<String, String> lodgePrice = sqlsession.selectOne("jh_search.getLodgePrice", paraMap);
		return lodgePrice;
	}


	// 검색된 내용 insert 해주기
	@Override
	public void insertSearchLog(Map<String, String> searchMap) {
		sqlsession.insert("jh_search.insertSearchLog", searchMap);
		
	}


	// 위시리스트에 넣은 lodge_id 리스트 가져오기
	@Override
	public List<Map<String, String>> lodgeIdList(String userid) {
		List<Map<String, String>> lodgeIdList = sqlsession.selectList("jh_search.lodgeIdList", userid);
		return lodgeIdList;
	}


	// 위시리스트에 추가하기
	@Override
	public int addWishlist(Map<String, String> paraMap) {
		int n = sqlsession.insert("jh_search.addWishlist", paraMap);
		return n;
	}


	// 위시리스트에 삭제하기
	@Override
	public int deleteWishlist(Map<String, String> paraMap) {
		int n = sqlsession.delete("jh_search.deleteWishlist", paraMap);
		return n;
	}
	
	
	
}
