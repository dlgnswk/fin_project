package com.spring.app.mj.comment.model;

import java.util.List;
import java.util.Map;

import com.spring.app.expedia.domain.CommentVO;
import com.spring.app.expedia.domain.LodgeVO;

/** 
* @FileName  : ReviewDAO.java 
* @Project   : final_project 
* @Date      : 2023. 12. 22 
* @작성자      : 손명진 
* @변경이력    : 
* @프로그램설명    : 
*/
public interface CommentDAO {

	/** 
	* @Method Name  : totalCount 
	* @작성일   : 2023. 12. 25 
	* @작성자   : 손명진
	* @변경이력  : 
	* @Method 설명 : // 후기 전체 갯수를 구하는 메소드
	* @param string
	* @return 
	*/
	int totalCount(String string);

	/** 
	* @Method Name  : selectByComment 
	* @작성일   : 2023. 12. 26 
	* @작성자   : 손명진 
	* @변경이력  : 
	* @Method 설명 : 더보기 방식(페이징처리)으로 댓글 8개씩 잘라서(start ~ end) 조회해오기 
	* @param paraMap
	* @return 
	*/
	List<CommentVO> selectByComment(Map<String, String> paraMap);

	/** 
	* @Method Name  : getSearchList 
	* @작성일   : 2023. 12. 26 
	* @작성자   : 손명진 
	* @변경이력  : 
	* @Method 설명 : 글목록 보여주기
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
	* @Method Name  : getComment 
	* @작성일   : 2024. 1. 1 
	* @작성자   : 손명진 
	* @변경이력  : 
	* @Method 설명 : 답변 달아주는 insert하기
	* @param paraMap
	* @return 
	*/
	int getComment(Map<String, String> paraMap);

	/** 
	* @Method Name  : changeUpdate 
	* @작성일   : 2024. 1. 5 
	* @작성자   : 먕지 
	* @변경이력  : 
	* @Method 설명 : 기존 답변에 수정해주기
	* @param paraMap
	* @return 
	*/
	int changeUpdate(Map<String, String> paraMap);

	/** 
	* @Method Name  : deleteComment 
	* @작성일   : 2024. 1. 5 
	* @작성자   : 먕지 
	* @변경이력  : 
	* @Method 설명 : 삭제하기
	* @param paraMap
	* @return 
	*/
	int deleteComment(String c_seq);

	/** 
	* @Method Name  : getLodgeIdList 
	* @작성일   : 2024. 1. 7 
	* @작성자   : 먕지 
	* @변경이력  : 
	* @Method 설명 : 사업자아이디랑 숙박시설 비교하는 것
	* @param userId
	* @return 
	*/
	List<String> getLodgeIdList(String userId);

	/** 
	* @Method Name  : getTotalCount 
	* @작성일   : 2024. 1. 9 
	* @작성자   : 먕지 
	* @변경이력  : 
	* @Method 설명 : 페이징처리를 위한 총 갯수 구하기
	* @param paraMap
	* @return 
	*/
	int getTotalCount(Map<String, Object> paraMap);


	/** 
	* @Method Name  : gettotalByRate 
	* @작성일   : 2024. 1. 10 
	* @작성자   : 먕지 
	* @변경이력  : 
	* @Method 설명 : 구매자 리뷰 총갯수
	* @param paraMap
	* @return 
	*/
	int gettotalByRate(Map<String, Object> paraMap);

	/** 
	* @Method Name  : gettotalComment 
	* @작성일   : 2024. 1. 10 
	* @작성자   : 먕지 
	* @변경이력  : 
	* @Method 설명 : 판매자 리뷰 총갯수
	* @param paraMap
	* @return 
	*/
	int gettotalComment(Map<String, Object> paraMap);

	/** 
	* @Method Name  : getRvcntByRate2 
	* @작성일   : 2024. 1. 11 
	* @작성자   : 먕지 
	* @변경이력  : 
	* @Method 설명 : 
	* @param r_paraMap
	* @return 
	*/
	Map<String, String> getRvcntByRate2(Map<String, Object> paraMap);

	/** 
	* @Method Name  : get__lodge_Id 
	* @작성일   : 2024. 1. 11 
	* @작성자   : 먕지 
	* @변경이력  : 
	* @Method 설명 : 
	* @param userId
	* @return 
	*/
	
	// lodge_id를 가져는 메소드
	List<LodgeVO> get__lodge_Id(String userId);

}
