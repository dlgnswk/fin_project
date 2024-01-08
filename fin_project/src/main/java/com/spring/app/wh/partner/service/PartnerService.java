package com.spring.app.wh.partner.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

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

	// 채팅방 불러오기
	ChatVO selectChat(Map<String,String> paraMap);

	// 기존 채팅방이 없는 경우 새로운 채팅방을 만들기
	int createChat(Map<String, String> paraMap);

	// 채팅쓰기(transaction 처리)
	// int addChat(ReplyVO replyvo) throws Throwable;

	// 원게시물에 딸린 댓글들을 조회해오기
	// List<ReplyVO> getMsgList(String parentSeq);

	// 원게시물에 딸린 댓글들을 페이징 처리해서 조회해오기
	// List<ReplyVO> getMsgList_Paging(Map<String, String> paraMap);

	// 원글 글번호(parentSeq)에 해당하는 댓글의 totalPage 수 알아오기
	// int getMsgTotalPage(Map<String, String> paraMap);	
	
	
	
	
}
