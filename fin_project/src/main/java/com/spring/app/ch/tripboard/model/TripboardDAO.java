package com.spring.app.ch.tripboard.model;

import java.util.List;
import java.util.Map;

import com.spring.app.expedia.domain.TripboardVO;

public interface TripboardDAO {
	
	// 글쓰기(파일첨부가 없는 글쓰기) 
	int add(TripboardVO tripboardvo);
	
	// 글쓰기(파일첨부가 있는 글쓰기)
	int add_withFile(TripboardVO tripboardvo);
	
	// 총 게시물 건수(totalCount) 구하기 - 검색이 있을 때와 검색이 없을때 로 나뉜다.
	int getTotalCount(Map<String, String> paraMap);
	
	// 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)  
	List<TripboardVO> tripboardListSearch_withPaging(Map<String, String> paraMap);
	
	// 글조회수 증가는 없고 단순히 글1개만 조회를 해주는 것
	TripboardVO getView(Map<String, String> paraMap);

	// 글조회수 증가와 함께 글1개를 조회를 해주는 것
	int increase_readCount(String tb_seq);
	
	// 1개 글 수정하기
	int tbedit(TripboardVO tripboardvo);
	
	// 1개글 삭제하기
	int tb_del(Map<String, String> paraMap);
	
	// 좋아요 버튼을 눌렀을 때 insert 해주는 것
	int getLike(Map<String, String> paraMap);

	// 좋아요 지우기
	int deleteLike(Map<String, String> paraMap);

	// 좋아요 개수 
	Map<String, Integer> getCnt(String tb_seq);

}
