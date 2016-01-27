package com.business.service.impl;

import java.util.HashMap;
import java.util.List;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.business.entity.Role;
import com.business.entity.User;
import com.business.service.RoleManager;

@Service
@Transactional
public class RoleManagerImpl implements RoleManager {
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<Role> findRoleList(HashMap<String, Object> param) {
		Object obj = sqlSession.selectList("Role.findRoleList", param);
		return (List<Role>) obj;
	}

	@Override
	public void updateRoleInfo(HashMap param) {
		if (param.get("roleId") != null && param.get("roleId").toString().trim().length() > 0) {
			sqlSession.update("Role.updateRoleInfo", param);
		} else {
			sqlSession.insert("Role.insertRoleInfo", param);

		}
	}

	@Override
	public Role findRoleInfoByField(HashMap param) {
		
		return (Role) sqlSession.selectOne("Role.findRoleInfoByField",param);
	}

	@Override
	public List<User> findUserRoleList(HashMap<String, Object> param) {
		Object obj = sqlSession.selectList("User.findUserRoleList", param);
		return (List<User>) obj;
	}
	
	
	@Override
	public Object findUserRoleListCount(HashMap<String, Object> param) {
		Object obj = sqlSession.selectOne("User.findUserRoleListCount", param);
		return obj;
	}

	



}
