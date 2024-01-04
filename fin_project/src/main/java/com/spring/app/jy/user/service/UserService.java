package com.spring.app.jy.user.service;

import java.util.List;
import java.util.Map;

import com.spring.app.expedia.domain.UserVO;

public interface UserService {

	// userid 확인 후 user정보 가져오기(selectOne)
	UserVO getLoginUser(String userid);

	// 기존 회원의 비밀번호 업데이트(update)
	int updateUser_pw(Map<String, String> paraMap);

	// 신규 회원 가입(insert)
	int registerUser(Map<String, String> paraMap);

	// 기본 회원 정보 수정(update)
	int updateUserBasicInfo(Map<String, String> paraMap);

	// 연락처 수정(update)
	int updateUserContact(UserVO loginuser);

	// 계정 삭제(update)
	int deleteUserAccount(String userid);

	// 계정 삭제 이유(insert)
	int insertDeleteReason(Map<String, String> paraMap);

	List<Map<String, String>> get_user_point_list(String userid); // 유저의 포인트 적립,사용 내역 가져오기

	int get_user_rs_cnt(String userid); // 올해 유저의 예약 건수 가져오기

}
