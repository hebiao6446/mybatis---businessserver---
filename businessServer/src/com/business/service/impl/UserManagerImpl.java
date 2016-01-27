package com.business.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import net.sf.json.JSONObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.business.entity.Attendance;
import com.business.entity.BlessingsType;
import com.business.entity.Company;
import com.business.entity.Push;
import com.business.entity.Role;
import com.business.entity.User;
import com.business.entity.Version;
import com.business.service.UserManager;
import com.json.BaseBean;

@Service
@Transactional
public class UserManagerImpl implements UserManager {
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public User findUserInfo(Long userId) {

		return (User) sqlSession.selectOne("User.findUserBaseInfo", userId);
	}

	@Override
	public Object findUserCompanyId(Long roleId) {
		return sqlSession.selectOne("User.findUserCompanyId", roleId);
	}

	@Override
	public Company findUserCompany(Long roleId) {
		return (Company) sqlSession
				.selectOne("Company.findUserCompany", roleId);
	}

	@Override
	public Long findUserRoleChidren(Long roleId) {
		return (Long) sqlSession.selectOne("User.findUserRoleChidren", roleId);
	}

	@Override
	public User userLogin(HashMap<String, String> param) {
		Object obj = sqlSession.selectOne("User.userLogin", param);
		return (User) obj;
	}

	@Override
	public void deleteAllData(HashMap param) {
		sqlSession.update("User.deleteAllData", param);
	}

	@Override
	public String findChildrenRole(Long userId) {
		return (String) sqlSession.selectOne("User.findUserSubRoleIdList",
				userId);
	}

	@Override
	public Attendance findAttendance(HashMap map) {
		return (Attendance) sqlSession.selectOne("Attendance.findAttendance",
				map);
	}

	@Override
	public List finduserAccountList(HashMap<String, Object> param) {
		return sqlSession.selectList("User.finduserAccountList", param);
	}

	@Override
	public Object finduserAccountListCount(HashMap<String, Object> param) {
		return sqlSession.selectOne("User.finduserAccountListCount", param);
	}

	@Override
	public void deleteUserQllData(HashMap param) {
		sqlSession.update("User.deleteUserQllData", param);
	}

	@Override
	public void deleteUserAllData(HashMap param) {
		sqlSession.update("User.deleteUserAllData", param);
	}

	@Override
	public List findUserAccountInfo(HashMap<String, Object> param) {
		return sqlSession.selectList("User.findUserAccountInfo", param);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public List<HashMap> findAllUserList(HashMap map) {
		return (List<HashMap>) sqlSession.selectList("User.findAllUserList",
				map);
	}

	@Override
	public void updateUserPass(HashMap param) {
		sqlSession.update("User.updateUserPass", param);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Push> findPushList(HashMap<String, Object> param) {
		Object obj = sqlSession.selectList("Push.findPushList", param);
		return (List<Push>) obj;
	}

	@Override
	public Object findPushListCount(HashMap<String, Object> param) {
		Object obj = sqlSession.selectOne("Push.findPushListCount", param);
		return obj;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Version> findVersionList(HashMap<String, Object> param) {
		Object obj = sqlSession.selectList("Version.findVersionList", param);
		return (List<Version>) obj;
	}

	@Override
	public Object findVersionListCount(HashMap<String, Object> param) {
		Object obj = sqlSession
				.selectOne("Version.findVersionListCount", param);
		return obj;
	}

	@Override
	public void insertPushInfo(HashMap<String, Object> param) {

		sqlSession.insert("Push.insertPushInfo", param);

	}

	@Override
	public void updateVersionInfo(HashMap<String, Object> param) {
		if (param.get("versionId") != null
				&& param.get("versionId").toString().trim().length() > 0) {
			sqlSession.update("Version.updateVersionInfo", param);
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public ArrayList<String> findDeviceToken(HashMap<String, Object> param) {
		return (ArrayList<String>) sqlSession.selectList("Push.findDeviceToken",param);
	}

	@Override
	public ArrayList<String> findAndroidTokens(HashMap<String, Object> param) {
		return (ArrayList<String>) sqlSession.selectList("Push.findAndroidTokens",param);
	}


}
