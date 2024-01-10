package com.spring.app.jy.user.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.expedia.domain.UserVO;
import com.spring.app.jy.user.model.UserDAO;
import com.spring.app.jy.user.model.UserDAO_imple;

@Service
public class UserService_imple implements UserService {

	@Autowired
	UserDAO dao = new UserDAO_imple();
	
	// userid 확인 후 user정보 가져오기(selectOne)
	@Override
	public UserVO getLoginUser(String userid) {
		UserVO loginuser = dao.getLoginUser(userid);
		return loginuser;
	}
	
	// 기존 회원의 비밀번호 업데이트(update)
	@Override
	public int updateUser_pw(Map<String, String> paraMap) {
		int n = dao.updateUser_pw(paraMap);
		return n;
	}
	
	// 신규 회원 가입(insert)
	@Override
	public int registerUser(Map<String, String> paraMap) {
		int n = dao.registerUser(paraMap);
		return n;
	}

	// 기본 회원 정보 수정(update)
	@Override
	public int updateUserBasicInfo(Map<String, String> paraMap) {
		int n = dao.updateUserBasicInfo(paraMap);
		return n;
	}

	@Override
	public int updateUserContact(UserVO loginuser) {
		int n = dao.updateUserContact(loginuser);
		return n;
	}

	// 계정 삭제(update)
	@Override
	public int deleteUserAccount(String userid) {
		int n = dao.updateUserAccountStatus(userid);
		return n;
	}

	// 계정 삭제 이유(insert)
	@Override
	public int insertDeleteReason(Map<String, String> paraMap) {
		int n = dao.insertDeleteReason(paraMap);
		return n;
	}

	@Override
	public List<Map<String, String>> get_user_point_list(String userid) {
		List<Map<String, String>> user_point_list = dao.get_user_point_list(userid);
		return user_point_list;
	}

	@Override
	public int get_user_rs_cnt(String userid) {
		int user_rs_cnt = dao.get_user_rs_cnt(userid);
		return user_rs_cnt;
	}

	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int getTotalCount = dao.getTotalCount(paraMap);
		return getTotalCount;
	}

	@Override
	public List<Map<String, String>> get_user_point_list_withPaging(Map<String, String> paraMap) {
		List<Map<String, String>> get_user_point_list_withPaging = dao.get_user_point_list_withPaging(paraMap);
		return get_user_point_list_withPaging;
	}

}
