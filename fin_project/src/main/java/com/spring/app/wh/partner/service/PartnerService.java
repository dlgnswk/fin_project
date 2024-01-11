package com.spring.app.wh.partner.service;

import java.util.List;
import java.util.Map;



import com.spring.app.expedia.domain.ChatVO;
import com.spring.app.expedia.domain.HostVO;
import com.spring.app.expedia.domain.ReplyVO;

public interface PartnerService {


	
	// 로그인 처리하기
	// ModelAndView loginEnd(ModelAndView mav, Map<String, String> paraMap, HttpServletRequest request);

	// 로그인 처리하기
	HostVO getLoginHost(Map<String, String> paraMap);

	// 회원가입 시 입력한 아이디 값이 기존에 가입한 회원에 존재하는지 확인해주는 메소드
	int idDuplicateCheck(String userid);	
	
	// tbl_host 에 HostVO 에 저장된 정보를 insert 해주는 메소드
	int registerHost(HostVO host);

	
	// 월별 객실등급별 예약 인원 수 가져오기
	List<Map<String, String>> useLodgeCnt(Map<String, String> paraMap);

	// tbl_host 에 저장된 판매자의 정보를 update 해주는 메소드
	int editHost(Map<String, String> paraMap);

	
	
	
	// 채팅방 불러오기(구매자)
	ChatVO selectChat(Map<String,String> paraMap);

	// 사업장명 을 알아오기(구매자 입장의 채팅방에서 사업장명 쓰기 위함)
	String selectH_name(String fk_lodge_id);	
	
	// 기존 채팅방이 없는 경우 새로운 채팅방을 만들기
	int createChat(Map<String, String> paraMap);

	// 채팅쓰기(구매자)
	int addChat(Map<String,String> paraMap);

	// 채팅들을 페이징 처리해서 조회해오기 
	List<ReplyVO> getChatList(Map<String, String> paraMap);

	// 로그인한 유저의 예약한 lodge_id 리스트 가져오기 
	List<String> selectLodgeIdList(String userid);
	
	// 현재 로그인되어있는 회원(구매자)의 채팅방 목록 가져오기
	List<ChatVO> getChatRoomList(Map<String, Object> map);

	// 총 채팅방 갯수(totalChatRoomCount) 가져오기
	int getTotalChatRoomCount(Map<String, String> paraMap);

	// 판매자의 lodge_id 알아오기
	String selectLodgeID(String h_userid);

	// 판매자 총 채팅방 갯수(totalHostChatRoomCount) 가져오기
	int getTotalHostChatRoomCount(Map<String, String> paraMap);

	// 현재 로그인되어있는 사업자(판매자)의 채팅방 목록 가져오기
	List<ChatVO> getHostChatRoomList(Map<String, String> paraMap);

	// 채팅쓰기(판매자)
	int addHostChat(Map<String, String> paraMap);

	// 채팅들을 페이징 처리해서 조회해오기 (판매자)
	List<ReplyVO> getHostChatList(Map<String, String> paraMap);

	// 채팅방 불러오기(판매자)
	ChatVO selectHostChat(Map<String, String> paraMap);

	// 예약자 이름을 알아오기(판매자 입장의 채팅방에서 예약자명 쓰기 위함)
	String selectName(String fk_userid);



	
	
	
	
	
}
