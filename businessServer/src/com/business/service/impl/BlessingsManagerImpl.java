package com.business.service.impl;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;


import com.common.Commonparam;
import com.business.entity.AttendDescript;
import com.business.entity.Attendance;
import com.business.entity.Blessings;
import com.business.entity.BlessingsType;
import com.business.entity.Company;
import com.business.entity.Group;
import com.business.entity.User;
import com.business.service.AttendanceManager;
import com.business.service.BlessingsManager;
import com.business.service.CompanyManager;
import com.business.service.UserManager;
import com.json.BaseBean;

@Service
@Transactional
public class BlessingsManagerImpl  implements BlessingsManager {
	@Autowired
	private SqlSessionTemplate  sqlSession;

	@Override
	public List<BlessingsType> findBlessingsTypeList(HashMap<String, Object> param) {
		Object obj = sqlSession.selectList("BlessingsType.findBlessingsTypeList", param);
		return (List<BlessingsType>) obj;
	}
	@Override
	public Object findBlessingsTypeListCount(HashMap<String, Object> param) {
		Object obj = sqlSession.selectOne("BlessingsType.findBlessingsTypeListCount", param);
		return obj;
	}
	@Override
	public void updateBlessingsTypeInfo(HashMap param) {
		if (param.get("blessingsTypeId") != null && param.get("blessingsTypeId").toString().trim().length() > 0) {
			sqlSession.update("BlessingsType.updateBlessingsTypeInfo", param);
		} else {
			sqlSession.insert("BlessingsType.insertBlessingsTypeInfo", param);

		}
	}
	@Override
	public List<Blessings> findBlessingsList(HashMap<String, Object> param) {
		Object obj = sqlSession.selectList("Blessings.findBlessingsList", param);
		return (List<Blessings>) obj;
	}
	@Override
	public Object findBlessingsListCount(HashMap<String, Object> param) {
		Object obj = sqlSession.selectOne("Blessings.findBlessingsListCount", param);
		return obj;
	}
	@Override
	public void updateBlessingsInfo(HashMap param) {
		if (param.get("blessingsId") != null && param.get("blessingsId").toString().trim().length() > 0) {
			sqlSession.update("Blessings.updateBlessingsInfo", param);
		} else {
			sqlSession.insert("Blessings.insertBlessingsInfo", param);

		}
	}
			

}
