package com.spring.app.wh.partner.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.app.expedia.domain.ChatVO;
import com.spring.app.expedia.domain.HostVO;
import com.spring.app.expedia.domain.ReplyVO;

@Repository
public class PartnerDAO_imple implements PartnerDAO {

	@Resource // bean에 올라가 있는 것들 중 sqlsession 의 필드명을 가지고 있는 객체를 찾아서 연결해줌
	private SqlSessionTemplate sqlsession;

	
	// 로그인 처리하기 
	@Override
	public HostVO getLoginHost(Map<String, String> paraMap) {
		
		HostVO loginhost = sqlsession.selectOne("wh_partner.getLoginHost", paraMap);
		
		// System.out.println("확인용 : dao loginhost : "+loginhost);
		
		return loginhost;
	}

	// 회원가입 시 입력한 아이디 값이 기존에 가입한 회원에 존재하는지 확인해주는 메소드
	@Override
	public int idDuplicateCheck(String userid) {
		int isExists = sqlsession.selectOne("wh_partner.idDuplicateCheck", userid);
		return isExists;
	}
	
	// tbl_host 에 HostVO 에 저장된 정보를 insert 해주는 메소드
	@Override
	public int registerHost(HostVO host) {
		int n = sqlsession.insert("wh_partner.registerHost",host);
		return n;
	}

	
	
	// 월별 객실등급별 예약 인원 수 가져오기
	@Override
	public List<Map<String, String>> useLodgeCnt(Map<String, String> paraMap) {
		List<Map<String, String>> useLodgeCntList = sqlsession.selectList("wh_partner.useLodgeCnt", paraMap);
		return useLodgeCntList;
	}

	
	// tbl_host 에 저장된 판매자의 정보를 update 해주는 메소드
	@Override
	public int editHost(Map<String, String> paraMap) {
		int n = sqlsession.update("wh_partner.editHost", paraMap);
		return n;
	}

	
	// 채팅방 불러오기
	@Override
	public ChatVO selectChat(Map<String,String> paraMap) {
		ChatVO chatvo = sqlsession.selectOne("wh_partner.selectChat", paraMap);
		return chatvo;
	}

	// 사업장명 을 알아오기(구매자 입장의 채팅방에서 사업장명 쓰기 위함)
	@Override
	public String selectH_name(String fk_lodge_id) {
		String h_name = sqlsession.selectOne("wh_partner.selectH_name",fk_lodge_id);
		return h_name;
	}

	
	// 기존 채팅방이 없는 경우 새로운 채팅방을 만들기
	@Override
	public int createChat(Map<String, String> paraMap) {
		int n = sqlsession.insert("wh_partner.createChat", paraMap);
		return n;
	}

	
	// 채팅쓰기(tbl_reply 테이블에 insert)
	@Override
	public int addChat(Map<String,String> paraMap) {
		int n = sqlsession.insert("wh_partner.addChat",paraMap);
		return n;
	}
	
	// 로그인한 유저의 예약한 lodge_id 리스트 가져오기 
	@Override
	public List<String> selectLodgeIdList(String userid) {
		List<String> lodgeIdList = sqlsession.selectList("wh_partner.selectLodgeIdList",userid);
		return lodgeIdList;
	}
	
	
	// 채팅들을 페이징 처리해서 조회해오기
	@Override
	public List<ReplyVO> getChatList(Map<String, String> paraMap) {
		List<ReplyVO> chatList = sqlsession.selectList("wh_partner.getChatList",paraMap);
		return chatList;
	}


	
	// 현재 로그인되어있는 회원(구매자)의 채팅방 목록 가져오기
	@Override
	public List<ChatVO> getChatRoomList(Map<String, Object> map) {
		List<ChatVO> roomList = sqlsession.selectList("wh_partner.getChatRoomList", map);
		return roomList;
	}

	// 총 채팅방 갯수(totalChatRoomCount) 가져오기
	@Override
	public int getTotalChatRoomCount(Map<String, String> paraMap) {
		int totalChatRoomCount = sqlsession.selectOne("wh_partner.getTotalChatRoomCount", paraMap);
		return totalChatRoomCount;
	}

	// 판매자의 lodge_id 알아오기
	@Override
	public String selectLodgeID(String h_userid) {
		String lodge_id = sqlsession.selectOne("wh_partner.selectLodgeID", h_userid);
		return lodge_id;
	}

	// 판매자 총 채팅방 갯수(totalHostChatRoomCount) 가져오기
	@Override
	public int getTotalHostChatRoomCount(Map<String, String> paraMap) {
		int totalHostChatRoomCount = sqlsession.selectOne("wh_partner.getTotalHostChatRoomCount", paraMap);
		return totalHostChatRoomCount;
	}

	// 현재 로그인되어있는 사업자(판매자)의 채팅방 목록 가져오기
	@Override
	public List<ChatVO> getHostChatRoomList(Map<String, String> paraMap) {
		List<ChatVO> hostRoomList = sqlsession.selectList("wh_partner.getHostChatRoomList", paraMap);
		return hostRoomList;
	}

	// 채팅쓰기(판매자)
	@Override
	public int addHostChat(Map<String, String> paraMap) {
		int n = sqlsession.insert("wh_partner.addHostChat",paraMap);
		return n;
	}

	// 채팅들을 페이징 처리해서 조회해오기 (판매자)
	@Override
	public List<ReplyVO> getHostChatList(Map<String, String> paraMap) {
		List<ReplyVO> hostChatList = sqlsession.selectList("wh_partner.getHostChatList",paraMap);
		return hostChatList;
	}

	// 채팅방 불러오기(판매자)
	@Override
	public ChatVO selectHostChat(Map<String, String> paraMap) {
		ChatVO chatvo = sqlsession.selectOne("wh_partner.selectHostChat", paraMap);
		return chatvo;
	}

	// 예약자 이름을 알아오기(판매자 입장의 채팅방에서 예약자명 쓰기 위함)
	@Override
	public String selectName(String fk_userid) {
		String name = sqlsession.selectOne("wh_partner.selectName", fk_userid);
		return name;
	}

	

	
	

}
