/**
 * 
 */
package com.spring.app.mj.comment.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.tomcat.jdbc.pool.interceptor.StatementCacheMBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.app.expedia.domain.CommentVO;
import com.spring.app.expedia.domain.LodgeVO;

/** 
* @FileName  : mj_commentDAO_imple.java 
* @Project   : final_project 
* @Date      : 2023. 12. 22 
* @작성자      : 먕지 
* @변경이력    : 
* @프로그램설명    : 
*/
//==== #32. Repository(DAO) 선언 ====
@Repository
public class CommentDAO_imple implements CommentDAO {

	
	

	@Resource
	private SqlSessionTemplate sqlsession;

	
	// 후기 전체 갯수를 구하는 메소드
	@Override
	public int totalCount(String string) {
		int n = sqlsession.selectOne("mj_comment.getTotalCount", string);
		return n;
	}


	// 더보기 방식(페이징처리)으로 댓글 8개씩 잘라서(start ~ end) 조회해오기 
	@Override
	public List<CommentVO> selectByComment(Map<String, String> paraMap) {
		List<CommentVO> selectByComment = sqlsession.selectList("mj_comment.selectComment", paraMap);
		return selectByComment;
	}
	
	
	// 글목록보기
	@Override
	public List<Map<String, Object>> getSearchList(Map<String, Object> paraMap) {
		List<Map<String, Object>> getSearchList = sqlsession.selectList("mj_comment.selectReview", paraMap);
		return  getSearchList;
	}

    // 검색어 없는 글목록
	@Override
	public List<Map<String, Object>> getSelect() {
		List<Map<String, Object>> getSelect = sqlsession.selectList("mj_comment.selectView");
		return getSelect;
	}

	// 답변 달아주는 insert하기
	@Override
	public int getComment(Map<String, String> paraMap) {
		int n =  sqlsession.insert("mj_comment.commentInsert", paraMap);
		return n;
	}

    // 기존 답변에 수정해주기
	@Override
	public int changeUpdate(Map<String, String> paraMap) {
		int n = sqlsession.update("mj_comment.changeComment", paraMap);
		return n;
	}


	// 삭제하기
	@Override
	public int deleteComment(String c_seq) {
		int n = sqlsession.delete("mj_comment.deleteComment", c_seq);
		return n;
	}


	@Override
	public List<String> getLodgeIdList(String userId) {
		 List<String> getLodgeIdList = sqlsession.selectList("mj_comment.selectLodgeIdList", userId);
		return getLodgeIdList;
	}


	// === #116. 총 게시물 건수(totalCount) 구하기 - 검색이 있을 때와 검색이 없을때 로 나뉜다. === 
	@Override
	public int getTotalCount(Map<String, Object> paraMap) {
		int n = sqlsession.selectOne("mj_comment.getTotalCount", paraMap);
		return n;
	}



	@Override
	public int gettotalByRate(Map<String, String> r_paraMap) {
		int gettotalByRate =  sqlsession.selectOne("mj_comment.gettotalByRate",r_paraMap);
		return gettotalByRate;
	}


	@Override
	public int gettotalComment(Map<String, String> r_paraMap) {
		int gettotalComment = sqlsession.selectOne("mj_comment.gettotalComment",r_paraMap);
		return gettotalComment;
	}

	//  평점 별 후기 갯수 가져오기

	@Override
	public Map<String, String> getRvcntByRate2(Map<String, String> r_paraMap) {
		Map<String, String> getRvcntByRate2 = sqlsession.selectOne("mj_comment.getRvcntByRate2", r_paraMap);
		return getRvcntByRate2;
	}


	// lodge_id를 가져는 메소드
	@Override
	public String get__lodge_Id(String userId) {
		String get__lodge_Id = sqlsession.selectOne("mj_comment.get__lodge_Id",userId);
		return get__lodge_Id;
	}


	
	
}
