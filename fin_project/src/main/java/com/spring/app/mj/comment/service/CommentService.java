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
	List<Map<String, Object>> getSearchList(Map<String, Object> paraMap);

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

	/** 
	* @Method Name  : edit 
	* @작성일   : 2024. 1. 5 
	* @작성자   : 손명진
	* @변경이력  : 
	* @Method 설명 : 기존 답변에 수정해주기
	* @param paraMap
	* @return 
	*/
	int edit(Map<String, String> paraMap);

	/** 
	* @Method Name  : goDelete 
	* @작성일   : 2024. 1. 5 
	* @작성자   : 먕지 
	* @변경이력  : 
	* @Method 설명 : 삭제구현하기
	* @param 
	* @return 
	*/
	int goDelete(String c_seq);

	/** 
	* @Method Name  : getLodgeIdList 
	* @작성일   : 2024. 1. 7 
	* @작성자   : 손명진 
	* @변경이력  : 
	* @Method 설명 : 사업자아이디랑 숙박시설 비교하는 것
	* @param userId
	* @return 
	*/
	List<String> getLodgeIdList(String userId);

	
	// 총 게시물 건수(totalCount) 구하기 - 검색이 있을 때와 검색이 없을때 로 나뉜다.
	int getTotalCount(Map<String, Object> paraMap);



	/** 
	* @Method Name  : gettotalComment 
	* @작성일   : 2024. 1. 10 
	* @작성자   : 먕지 
	* @변경이력  : 
	* @Method 설명 :  판매자 총 리뷰갯수
	* @param paraMap
	* @return 
	*/
	int gettotalComment(Map<String, Object> r_paraMap);


	/** 
	* @Method Name  : getRvcntByRate2 
	* @작성일   : 2024. 1. 11 
	* @작성자   : 먕지 
	* @변경이력  : 
	* @Method 설명 : 그래프만들기
	* @param r_paraMap
	* @return 
	*/
	Map<String, String> getRvcntByRate2(Map<String, Object> r_paraMap);

	/** 
	* @Method Name  : gettotalByRate 
	* @작성일   : 2024. 1. 11 
	* @작성자   : 먕지 
	* @변경이력  : 
	* @Method 설명 : 
	* @param paraMap
	* @return 
	*/
	int gettotalByRate(Map<String, Object> r_paraMap);

	


}
