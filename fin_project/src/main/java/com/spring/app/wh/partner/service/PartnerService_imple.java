package com.spring.app.wh.partner.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.common.AES256;
import com.spring.app.expedia.domain.ChatVO;
import com.spring.app.expedia.domain.HostVO;
import com.spring.app.expedia.domain.ReplyVO;
import com.spring.app.wh.partner.model.PartnerDAO;

@Service
public class PartnerService_imple implements PartnerService {

	@Autowired
	private PartnerDAO dao;
	
	@Autowired
	private AES256 aES256;

	
	// 로그인 처리하기
	@Override
	public HostVO getLoginHost(Map<String, String> paraMap) {
		HostVO loginhost = dao.getLoginHost(paraMap);
		
		return loginhost;
	}

	// 회원가입 시 입력한 아이디 값이 기존에 가입한 회원에 존재하는지 확인해주는 메소드
	@Override
	public int idDuplicateCheck(String userid) {
		int isExists = dao.idDuplicateCheck(userid);
		return isExists;
	}
	
	
	
	// tbl_host 에 HostVO 에 저장된 정보를 insert 해주는 메소드
	@Override
	public int registerHost(HostVO host) {

		int n = dao.registerHost(host);
		return n;
	}

	
	// 월별 객실등급별 예약 인원 수 가져오기
	@Override
	public List<Map<String, String>> useLodgeCnt(Map<String, String> paraMap) {
		List<Map<String, String>> useLodgeCntList = dao.useLodgeCnt(paraMap);
		return useLodgeCntList;
	}

	
	// tbl_host 에 저장된 판매자의 정보를 update 해주는 메소드
	@Override
	public int editHost(Map<String, String> paraMap) {
		int n = dao.editHost(paraMap);
		return n;
	}

	
	// 채팅방 불러오기
	@Override
	public ChatVO selectChat(Map<String,String> paraMap) {
		ChatVO chatvo = dao.selectChat(paraMap);
		return chatvo;
	}

	// 사업장명 을 알아오기(구매자 입장의 채팅방에서 사업장명 쓰기 위함)
	@Override
	public String selectH_name(String fk_lodge_id) {
		String h_name = dao.selectH_name(fk_lodge_id);
		return h_name;
	}
	
	
	// 기존 채팅방이 없는 경우 새로운 채팅방을 만들기
	@Override
	public int createChat(Map<String, String> paraMap) {
		int n = dao.createChat(paraMap);
		return n;
	}

	
	// 채팅쓰기  
	@Override
	public int addChat(Map<String,String> paraMap) {

		int n = dao.addChat(paraMap);// 채팅쓰기(tbl_reply 테이블에 insert)
		
		return n;
	}

	// 로그인한 유저의 예약한 lodge_id 리스트 가져오기 
	@Override
	public List<String> selectLodgeIdList(String userid) {
		List<String> lodgeIdList = dao.selectLodgeIdList(userid);
		return lodgeIdList;
	}
	
	
	// 채팅들을 페이징 처리해서 조회해오기 
	@Override
	public List<ReplyVO> getChatList(Map<String, String> paraMap) {
		List<ReplyVO> chatList = dao.getChatList(paraMap);
		return chatList;
	}


	// 현재 로그인되어있는 회원의 채팅방 목록 가져오기
	@Override
	public List<ChatVO> getChatRoomList(Map<String, String> paraMap) {
		List<ChatVO> chatRoomList = dao.getChatRoomList(paraMap);
		return chatRoomList;
	}

	
	// 총 채팅방 갯수(totalChatRoomCount) 가져오기
	@Override
	public int getTotalChatRoomCount(Map<String, String> paraMap) {
		int totalChatRoomCount = dao.getTotalChatRoomCount(paraMap);
		return totalChatRoomCount;
	}

	// 판매자의 lodge_id 알아오기
	@Override
	public String selectLodgeID(String h_userid) {
		String lodge_id = dao.selectLodgeID(h_userid);
		return lodge_id;
	}

	// 판매자 총 채팅방 갯수(totalHostChatRoomCount) 가져오기
	@Override
	public int getTotalHostChatRoomCount(Map<String, String> paraMap) {
		int totalHostChatRoomCount = dao.getTotalHostChatRoomCount(paraMap);
		return totalHostChatRoomCount;
	}

	// 현재 로그인되어있는 사업자(판매자)의 채팅방 목록 가져오기
	@Override
	public List<ChatVO> getHostChatRoomList(Map<String, String> paraMap) {
		List<ChatVO> hostChatRoomList = dao.getHostChatRoomList(paraMap);
		return hostChatRoomList;
	}

	
	// 채팅쓰기(판매자)
	@Override
	public int addHostChat(Map<String, String> paraMap) {
		int n = dao.addHostChat(paraMap);// 채팅쓰기(tbl_reply 테이블에 insert)
		
		return n;
	}

	// 채팅들을 페이징 처리해서 조회해오기 (판매자)
	@Override
	public List<ReplyVO> getHostChatList(Map<String, String> paraMap) {
		List<ReplyVO> hostChatList = dao.getHostChatList(paraMap);
		return hostChatList;
	}
	
	// 채팅방 불러오기(판매자)
	@Override
	public ChatVO selectHostChat(Map<String, String> paraMap) {
		ChatVO chatvo = dao.selectHostChat(paraMap);
		return chatvo;
	}

	// 예약자 이름을 알아오기(판매자 입장의 채팅방에서 예약자명 쓰기 위함)
	@Override
	public String selectName(String fk_userid) {
		String name = dao.selectName(fk_userid);
		return name;
	}

	

	
	 
	 
	
	 
	 
	
	
	


}