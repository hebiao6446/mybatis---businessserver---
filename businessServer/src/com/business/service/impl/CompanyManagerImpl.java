package com.business.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.business.entity.Company;
import com.business.service.CompanyManager;
import com.common.Commonparam;

@Service
@Transactional
public class CompanyManagerImpl implements CompanyManager {
	@Autowired
	private SqlSessionTemplate sqlSession;

	@SuppressWarnings("unchecked")
	@Override
	public List<Company> findCompanyList(HashMap<String, Object> param) {
		return (List<Company>) sqlSession.selectList("Company.findCompanyList",
				param);
	}

	@Override
	public Object findCompanyListCount(HashMap<String, Object> param) {
		return sqlSession.selectOne("Company.findCompanyListCount", param);
	}

	@Override
	public synchronized Integer updateCompanyInfo(HashMap<String, Object> param) {

		Integer ip = 0;

		if (param.get("companyId") != null&& param.get("companyId").toString().trim().length() > 0) {
			ip = sqlSession.update("Company.updateCompanyInfo", param);
		} else {
			ip = sqlSession.insert("Company.insertCompanyInfo", param);

			Long companyId = (Long) sqlSession.selectOne("Company.findLastId");
			

			HashMap<String, Object> role = new HashMap<String, Object>();
			role.put("companyId", companyId);
			role.put("name", "管理员");
			role.put("parentId", 0);
			role.put("updateTime", new Date());
			sqlSession.insert("Company.insertCompanyRole", role);
			
			Long roleId = (Long) sqlSession.selectOne("Role.findLastId");
			param.put("roleId", roleId);
			param.put("password", Commonparam.Md5String("123456"));
			param.put("firstLetter",Commonparam.getfirstLetter(param.get("name").toString()));
			
			sqlSession.insert("User.insertCompanyUser", param);
			
			Long userId = (Long) sqlSession.selectOne("Group.findLastId");
			param.put("userId", userId);
			param.put("name", "我的客户");
			
			sqlSession.insert("Group.insertUserGroup", param);
			
		}
		
		

		return ip;
	}


	@Override
	public Integer registerUser(HashMap<String, Object> param) {
		Integer ip = 0;
			ip = sqlSession.insert("Company.registerUser", param);
		    Long companyId = (Long) sqlSession.selectOne("Company.findLastId");
			HashMap<String, Object> role = new HashMap<String, Object>();
			role.put("companyId", companyId);
			role.put("name", "管理员");
			role.put("parentId", 0);
			role.put("updateTime", new Date());
			sqlSession.insert("Company.insertCompanyRole", role);		
			Long roleId = (Long) sqlSession.selectOne("Role.findLastId");
			param.put("roleId", roleId);
			param.put("password", Commonparam.Md5String("123456"));
			param.put("firstLetter",Commonparam.getfirstLetter(param.get("name").toString()));		
			sqlSession.insert("User.insertCompanyUser", param);	
			Long userId = (Long) sqlSession.selectOne("Group.findLastId");
			param.put("userId", userId);
			param.put("name", "我的客户");		
			sqlSession.insert("Group.insertUserGroup", param);
		
		return ip;
	}

	
	@Override
	public Company findCompanyInfo(Long companyId) {
		return (Company) sqlSession.selectOne("Company.findCompanyInfo",
				companyId);
	}

	@Override
	public void deleteComapnyQllData(HashMap param) {
		sqlSession.update("Company.deleteComapnyQllData", param);
	}

	@Override
	public void deleteComapnyAllData(HashMap param) {
		sqlSession.update("Company.deleteComapnyAllData", param);
	}

	@Override
	public List findCompanyAccountList(HashMap<String, Object> param) {
		return sqlSession.selectList("Company.findCompanyAccountList", param);
	}

	@Override
	public Object findCompanyAccountListCount(HashMap<String, Object> param) {
		return sqlSession.selectOne("Company.findCompanyAccountListCount", param);
	}


}
