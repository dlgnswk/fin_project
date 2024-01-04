/**
 * 
 */
package com.spring.app.mj.comment.service;

import java.util.List;
import java.util.Map;

import com.spring.app.expedia.domain.CommentVO;

/** 
* @FileName  : ReviewService.java 
* @Project   : final_project 
* @Date      : 2023. 12. 22 
* @작성자      : 손명진
* @변경이력    : 
* @프로그램설명    : 
*/
public interface CommentService {

	/** 
	* @Method Name  : totalAllCount 
	* @작성일   : 2023. 12. 25 
	* @작성자   : 손명진 
	* @변경이력  : 
	* @Method 설명 : 후기 전체 갯수를 구하는 메소드
	* @param string
	* @return 
	*/
	int totalAllCount(String string);

	/** 
	* @Method Name  : selectBySpecName 
	* @작성일   : 2023. 12. 26 
	* @작성자   : 손명진
	* @변경이력  : 
	* @Method 설명 : 더보기 방식(페이징처리)으로 댓글 8개씩 잘라서(start ~ end) 조회해오기 
	* @param paraMap
	* @return 
	*/
	List<CommentVO> selectBySpecComment(Map<String, String> paraMap);

	/** 
	* @Method Name  : getSearchList 
	* @작성일   : 2023. 12. 26 
	* @작성자   : 손명진 
	* @변경이력  : 
	* @Method 설명 : 글목록보기
	* @param paraMap
	* @return 
	*/
	List<Map<String, Object>> getSearchList(Map<String, String> paraMap);

	/** 
	* @Method Name  : getInsert 
	* @작성일   : 2023. 12. 30 
	* @작성자   : 손명진 
	* @변경이력  : 
	* @Method 설명 : 
	* @return 
	*/
	List<Map<String, Object>> getSelect();

	/** 
	* @Method Name  : add_Comment 
	* @작성일   : 2024. 1. 1 
	* @작성자   : 손명진 
	* @변경이력  : 
	* @Method 설명 : insert해주기 (답변달아주가)
	* @param paraMap
	* @return 
	*/
	int add_Comment(Map<String, String> paraMap);

}
