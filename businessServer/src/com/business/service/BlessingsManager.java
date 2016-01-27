package com.business.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;


import com.business.entity.AttendDescript;
import com.business.entity.Attendance;
import com.business.entity.Blessings;
import com.business.entity.BlessingsType;
import com.business.entity.Company;
import com.business.entity.User;
import com.json.BaseBean;


public interface BlessingsManager {

	List<BlessingsType> findBlessingsTypeList(HashMap<String, Object> param);

	Object findBlessingsTypeListCount(HashMap<String, Object> param);

	void updateBlessingsTypeInfo(HashMap param);

	List<Blessings> findBlessingsList(HashMap<String, Object> param);

	Object findBlessingsListCount(HashMap<String, Object> param);

	void updateBlessingsInfo(HashMap param);
	
	

}
