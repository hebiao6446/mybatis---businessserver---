package com.business.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import net.sf.json.JSONObject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.business.entity.AttendDescript;
import com.business.entity.Attendance;
import com.business.entity.User;
import com.business.service.AttendanceManager;

@Service
@Transactional
public class AttendanceManagerImpl implements AttendanceManager {
	@Autowired
	private SqlSessionTemplate sqlSession;

	@SuppressWarnings("unchecked")
	@Override
	public List<Attendance> findAttendanceList(HashMap<String, Object> param) {

		Integer size = (Integer) param.get("size");
		Integer page = (Integer) param.get("page");
		String fontTime = param.get("fontTime") == null ? null : param.get(
				"fontTime").toString();
		String backTime = param.get("backTime") == null ? null : param.get(
				"backTime").toString();

		if (fontTime != null && !"".equals(fontTime) && backTime != null
				&& !"".equals(backTime)) {
			java.sql.Date backDate = java.sql.Date.valueOf(backTime);
			java.sql.Date fontDate = java.sql.Date.valueOf(fontTime);
			if (fontDate.before(backDate)) {
				String tims = fontTime;
				fontTime = backTime;
				backTime = tims;
			}
		}
		Integer status = 0;
		if (param.get("status") == null || "".equals(param.get("status"))) {
			status = 0;
		} else {
			status = (Integer) param.get("status");
		}
		Integer startNumber = (page - 1) * size;
		long dayTimeNumber = 24 * 60 * 60 * 1000L;

		Long dateTime;
		if (fontTime != null && !"".equals(fontTime)) {
			dateTime = java.sql.Date.valueOf(fontTime).getTime();
		} else {
			dateTime = new java.sql.Date(new Date().getTime()).getTime();
		}
		List<Attendance> list = new ArrayList<Attendance>();
		long times = dateTime + dayTimeNumber;
		int count = 0;
		int countOut = 0;
		while (count < startNumber + size) {
			countOut++;
			if (countOut > 366) {
				break;
			}
			times = times - dayTimeNumber;
			if (backTime != null && !"".equals(backTime)) {
				Long backDate = java.sql.Date.valueOf(backTime).getTime();
				if (backDate > times) {
					break;
				}
			}
			String dayTime = new java.sql.Date(times).toString();
			param.put("dayTime", dayTime);
			Attendance a = (Attendance) sqlSession.selectOne(
					"Attendance.findAttendance", param);
			if (a.getInTime() == null) {
				a.setStatus(6);// 没有签到与签退
			} else {
				if (a.getOutTime() == null) {
					if (a.getStatus() == 1) {
						a.setStatus(5);// 迟到,没有签退
					} else if (a.getStatus() == -1) {
						a.setStatus(4);// 没有签退
					}
				}
			}
			if (status == 0) {
				count++;
			} else if (status == a.getStatus()) {
				count++;
			}
			if (count > startNumber) {
				list.add(a);
			}
		}
		return list;

		/*
		 * java.sql.Date date = null; Long flong = (page - 1) * size * 24 * 60 *
		 * 60 * 1000L;
		 * 
		 * if (fontTime != null && !"".equals(fontTime)) { flong =
		 * java.sql.Date.valueOf(fontTime).getTime() - flong; } else { flong =
		 * new Date().getTime() - flong; } date = new java.sql.Date(flong);
		 * 
		 * Long blong = size * 24 * 60 * 60 * 1000L; if (backTime != null &&
		 * !"".equals(backTime)) { if (java.sql.Date.valueOf(backTime).after(
		 * new java.sql.Date(date.getTime() - blong))) { long e = date.getTime()
		 * - java.sql.Date.valueOf(backTime).getTime(); size = (int) (e / 1000 /
		 * 60 / 60 / 24) + 1; } } List<String> t = new ArrayList<String>(); for
		 * (int i = 0; i < size; i++) { t.add(new java.sql.Date(date.getTime() -
		 * i * 24 * 60 * 60 * 1000) .toString()); } if (t.size() > 0) {
		 * param.put("t", t); return (List<Attendance>) sqlSession.selectList(
		 * "Attendance.findAttendanceList", param); } return null;
		 */
	}

	@Override
	public Object findAttendanceListCount(HashMap<String, Object> param) {
		return sqlSession
				.selectOne("Attendance.findAttendanceListCount", param);
	}

	@Override
	public User findUserBaseInfo(Long userId) {
		return (User) sqlSession.selectOne("User.findUserBaseInfo", userId);
	}

	@Override
	public List<AttendDescript> findAttendDescriptList(
			HashMap<String, Object> param) {
		return (List<AttendDescript>) sqlSession.selectList(
				"AttendDescript.findAttendDescriptList", param);
	}

	@Override
	public Object findAttendDescriptListCount(HashMap<String, Object> param) {
		Object obj = sqlSession.selectOne(
				"AttendDescript.findAttendDescriptListCount", param);
		return obj;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Attendance> findSubUserAttendList(HashMap<String, Object> param) {
		return ((List<Attendance>) sqlSession.selectList(
				"Attendance.findSubUserAttendList", param));
	}

	@Override
	public void updateSignAttendance(HashMap param) {
		sqlSession.update("Attendance.updateSignAttendance", param);
	}

	@Override
	public void insertSignAttendance(HashMap param) {
		sqlSession.insert("Attendance.insertSignAttendance", param);
	}

	@Override
	public void saveAttendDescInfo(HashMap<String, Object> map) {
		sqlSession.insert("AttendDescript.saveAttendDescInfo", map);
	}

	@Override
	public List<User> findSubUserList(User user) {
		return (List<User>) sqlSession.selectList("Attendance.findSubUserList",
				user);
	}

	@Override
	public Integer findUserChiDao(HashMap<String, Object> param) {
		return (Integer) sqlSession.selectOne("Attendance.findUserChiDao",
				param);
	}
	
	
	//获取上班时间
			@Override
			public HashMap<String, Object> findWorkOutTime(HashMap<String, Object> param) {
				return (HashMap<String, Object>) sqlSession.selectOne("findWorkOutTime",param);
			}

}
