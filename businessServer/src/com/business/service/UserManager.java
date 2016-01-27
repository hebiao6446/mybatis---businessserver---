package com.business.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import net.sf.json.JSONObject;

import com.business.entity.Attendance;
import com.business.entity.Company;
import com.business.entity.Push;
import com.business.entity.Role;
import com.business.entity.User;
import com.business.entity.Version;
import com.json.BaseBean;

public interface UserManager {
	

	User findUserInfo(Long userId);

	Object findUserCompanyId(Long roleId);

	Company findUserCompany(Long roleId);

	Long findUserRoleChidren(Long roleId);

	User userLogin(HashMap<String, String> param);

	void deleteAllData(HashMap param);

	String findChildrenRole(Long userId);

	Attendance findAttendance(HashMap map);

	List finduserAccountList(HashMap<String, Object> param);

	Object finduserAccountListCount(HashMap<String, Object> param);

	void deleteUserQllData(HashMap param);

	void deleteUserAllData(HashMap param);

	List findUserAccountInfo(HashMap<String, Object> param);

	List<HashMap> findAllUserList(HashMap map);

	void updateUserPass(HashMap param);

	List<Push> findPushList(HashMap<String, Object> param);

	Object findPushListCount(HashMap<String, Object> param);

	List<Version> findVersionList(HashMap<String, Object> param);

	Object findVersionListCount(HashMap<String, Object> param);


	void insertPushInfo(HashMap<String, Object> param);

	void updateVersionInfo(HashMap<String, Object> param);

	ArrayList<String> findDeviceToken(HashMap<String, Object> param);

	ArrayList<String> findAndroidTokens(HashMap<String, Object> param);
	
}
