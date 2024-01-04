package com.spring.app.ch.tripboard.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import com.spring.app.expedia.domain.TripboardVO;

//==== #32. Repository(DAO) 선언 ====
@Repository
public class TripboardDAO_imple implements TripboardDAO {
	
	// === 의존객체 주입하기(DI: Dependency Injection) ===
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
	
		
		
	@Override
	public int add(TripboardVO tripboardvo) {
		
		int n = sqlsession.insert("ch_tripboard.add", tripboardvo);
		
		return n;
	}

	@Override
	public int add_withFile(TripboardVO tripboardvo) {
		
		int n = sqlsession.insert("ch_tripboard.add_withFile", tripboardvo);
		return n;
	}
		
	// 총 게시물 건수(totalCount) 구하기 - 검색이 있을 때와 검색이 없을때 로 나뉜다.
	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("ch_tripboard.getTotalCount", paraMap);
		return n;
	}
	
	
	
	// === #119. 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것) ===  
	@Override
	public List<TripboardVO> tripboardListSearch_withPaging(Map<String, String> paraMap) {
		List<TripboardVO> tripboardList = sqlsession.selectList("ch_tripboard.tripboardListSearch_withPaging", paraMap);
		return tripboardList;
	}
	
	// 글조회수 증가는 없고 단순히 글1개만 조회를 해주는 것
	@Override
	public TripboardVO getView(Map<String, String> paraMap) {
		TripboardVO tripboardvo = sqlsession.selectOne("ch_tripboard.getView", paraMap); // 글1개 조회하기
		return tripboardvo;
	}
	
	// 글조회수 증가와 함께 글1개를 조회를 해주는 것
	@Override
	public int increase_readCount(String tb_seq) {
		int n = sqlsession.update("ch_tripboard.increase_readCount", tb_seq);
		return n;
	}
	
	// 1개 글 수정하기
	@Override
	public int tbedit(TripboardVO tripboardvo) {
		
		int n = sqlsession.update("ch_tripboard.edit", tripboardvo);
		
		return n;
	}

	@Override
	public int tb_del(Map<String, String> paraMap) {
		int n = sqlsession.delete("ch_tripboard.del", paraMap);
		return n;
	}
	
	// 좋아요 버튼을 눌렀을 때 insert 해주는 것
	@Override
	public int getLike(Map<String, String> paraMap) {
		int n = sqlsession.insert("ch_tripboard.getLike", paraMap);
		return n;
	}

	// 좋아요 지워주는 것
	@Override
	public int deleteLike(Map<String, String> paraMap) {
		int n = sqlsession.insert("ch_tripboard.deleteLike", paraMap);
		return n;
	}

	// 좋아요 개수
	@Override
	public Map<String, Integer> getCnt(String tb_seq) {
		 Map<String, Integer> getCnt = sqlsession.selectOne("ch_tripboard.getCnt", tb_seq);
		return getCnt;
	}
	
}
