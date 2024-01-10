package com.spring.app.jy.user.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.spring.app.expedia.domain.UserVO;

@Repository
public class UserDAO_imple implements UserDAO {

	@Autowired
	@Qualifier("sqlsession")
	private SqlSessionTemplate sqlsession;
	
	// userid 로 회원정보 가져오기(select)
	@Override
	public UserVO getLoginUser(String userid) {
		UserVO loginuser = sqlsession.selectOne("jy_user.getLoginUser",userid);
		return loginuser;
	}

	// 기존 회원의 비밀번호 업데이트(update)
	@Override
	public int updateUser_pw(Map<String, String> paraMap) {
		int n = sqlsession.update("jy_user.updateUser_pw", paraMap);
		return n;
	}
	
	// 신규 회원 가입(insert)
	@Override
	public int registerUser(Map<String, String> paraMap) {
		int n = sqlsession.insert("jy_user.registerUser", paraMap);
		return n;
	}

	// 기본 회원 정보 수정(update)
	@Override
	public int updateUserBasicInfo(Map<String, String> paraMap) {
		int n = sqlsession.update("jy_user.updateUserBasicInfo", paraMap);
		return n;
	}

	@Override
	public int updateUserContact(UserVO loginuser) {
		int n = sqlsession.update("jy_user.updateUserContact", loginuser);
		return n;
	}

	// 계정 삭제(update)
	@Override
	public int updateUserAccountStatus(String userid) {
		int n = sqlsession.update("jy_user.updateUserAccountStatus", userid);
		return n;
	}

	// 계정 삭제 이유(insert)
	@Override
	public int insertDeleteReason(Map<String, String> paraMap) {
		int n = sqlsession.insert("jy_user.insertDeleteReason",paraMap);
		return n;
	}

	@Override
	public List<Map<String, String>> get_user_point_list(String userid) {
		List<Map<String, String>> user_point_list = sqlsession.selectList("jy_user.get_user_point_list",userid);
		return user_point_list;
	}

	@Override
	public int get_user_rs_cnt(String userid) {
		int user_rs_cnt = sqlsession.selectOne("jy_user.get_user_rs_cnt",userid);
		return user_rs_cnt;
	}

	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int getTotalCount = sqlsession.selectOne("jy_user.getTotalCount",paraMap);
		return getTotalCount;
	}

	@Override
	public List<Map<String, String>> get_user_point_list_withPaging(Map<String, String> paraMap) {
		List<Map<String, String>> get_user_point_list_withPaging = sqlsession.selectList("jy_user.get_user_point_list_withPaging",paraMap);
		return get_user_point_list_withPaging;
	}

}
