/**
 * 
 */
package com.spring.app.mj.comment.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.app.expedia.domain.CommentVO;

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
	public List<Map<String, Object>> getSearchList(Map<String, String> paraMap) {
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

}
