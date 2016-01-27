package com.business.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

//import org.apache.naming.java.javaURLContextFactory;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import cn.eavic.framework.web.BaseAction;

import com.common.Commonparam;
import com.business.entity.AttendDescript;
import com.business.entity.Attendance;
import com.business.entity.Blessings;
import com.business.entity.BlessingsType;
import com.business.entity.Company;
import com.business.entity.Contacts;
import com.business.entity.Role;
import com.business.entity.User;

import com.business.service.AttendanceManager;
import com.business.service.BlessingsManager;
import com.business.service.CompanyManager;
import com.business.service.UserManager;
import com.common.MD5Util;
import com.json.BaseBean;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

@Namespace("/")
@Results({ @Result(name = BaseAction.NONE, location = "blessingsAction.action", type = "redirect") })
public class BlessingsAction extends ActionSupport {
	/**
	 * 节日祝福模块
	 */
	private static final long serialVersionUID = 7655056122242830524L;

	@Autowired
	BlessingsManager blessingsManager;

	private String username, password;
	private Integer size, page;
	private Long companyId;
	private String groupId, userId, roleId, parentId, name, blessingsTypeId,
			blessingsId;
	private String content;

	/**
	 * 节日祝福类别分类列表
	 * 
	 * @throws Exception
	 */

	public void findBlessingsTypeList() throws Exception {
		HttpServletResponse response = (HttpServletResponse) ActionContext
				.getContext().get(ServletActionContext.HTTP_RESPONSE);
		HttpServletRequest request = (HttpServletRequest) ActionContext
				.getContext().get(ServletActionContext.HTTP_REQUEST);
		BaseBean bean = new BaseBean();

		try {
			HashMap<String, Object> param = new HashMap<String, Object>();

			if (name != null) {
				param.put("name", name);
			}
			List<BlessingsType> blessingsTypeList = blessingsManager
					.findBlessingsTypeList(param);

			bean.setStatus(200);
			bean.setRows(blessingsTypeList);
			bean.setTotal(blessingsManager.findBlessingsTypeListCount(param));
		} catch (Exception e) {
			bean.setStatus(400);
			bean.setMsg(e.getLocalizedMessage());
		}
		String json = JSONObject.fromObject(bean,
				Commonparam.getJsonConfig("yyyy-MM-dd HH:mm:ss")).toString();
		response.getOutputStream().write(json.getBytes("UTF-8"));
	}

	/**
	 * 添加，修改祝福类别名称
	 * 
	 * @throws Exception
	 */

	public void updateBlessingsTypeInfo() throws Exception {
		HttpServletResponse response = (HttpServletResponse) ActionContext
				.getContext().get(ServletActionContext.HTTP_RESPONSE);
		HttpServletRequest request = (HttpServletRequest) ActionContext
				.getContext().get(ServletActionContext.HTTP_REQUEST);

		BaseBean bean = new BaseBean();
		try {

			HashMap param = new HashMap();
			param.put("blessingsTypeId", blessingsTypeId);
			param.put("name", name);

			blessingsManager.updateBlessingsTypeInfo(param);

			bean.setStatus(200);

		} catch (Exception e) {
			bean.setStatus(400);
			bean.setMsg("保存失败!");
		}

		String json = JSONObject.fromObject(bean,
				Commonparam.getJsonConfig("yyyy-MM-dd HH:mm:ss")).toString();
		response.getOutputStream().write(json.getBytes("UTF-8"));
	}

	/**
	 * 节日祝福列表
	 * 
	 * @throws Exception
	 */

	public void findBlessingsList() throws Exception {
		HttpServletResponse response = (HttpServletResponse) ActionContext
				.getContext().get(ServletActionContext.HTTP_RESPONSE);
		HttpServletRequest request = (HttpServletRequest) ActionContext
				.getContext().get(ServletActionContext.HTTP_REQUEST);
		BaseBean bean = new BaseBean();

		try {
			HashMap<String, Object> param = new HashMap<String, Object>();
			param.put("size", size);
			param.put("startIndex", (page - 1) * size);
			param.put("blessingsTypeId", blessingsTypeId);

			List<Blessings> blessingsList = blessingsManager
					.findBlessingsList(param);

			bean.setStatus(200);
			bean.setRows(blessingsList);
			bean.setTotal(blessingsManager.findBlessingsListCount(param));

		} catch (Exception e) {
			bean.setStatus(400);
			bean.setMsg(e.getLocalizedMessage());
		}
		String json = JSONObject.fromObject(bean,
				Commonparam.getJsonConfig("yyyy-MM-dd HH:mm:ss")).toString();
		response.getOutputStream().write(json.getBytes("UTF-8"));
	}

	/**
	 * 添加,新增 节日祝福
	 * 
	 * @throws Exception
	 */
	public void updateBlessingsInfo() throws Exception {
		HttpServletResponse response = (HttpServletResponse) ActionContext
				.getContext().get(ServletActionContext.HTTP_RESPONSE);
		HttpServletRequest request = (HttpServletRequest) ActionContext
				.getContext().get(ServletActionContext.HTTP_REQUEST);

		BaseBean bean = new BaseBean();
		try {
			HashMap param = new HashMap();
			param.put("blessingsId", blessingsId);
			param.put("blessingsTypeId", blessingsTypeId);
			param.put("content", content);

			blessingsManager.updateBlessingsInfo(param);

			bean.setStatus(200);
		} catch (Exception ee0) {
			bean.setStatus(400);
			bean.setMsg("保存失败!");
		}

		String json = JSONObject.fromObject(bean,
				Commonparam.getJsonConfig("yyyy-MM-dd HH:mm:ss")).toString();
		response.getOutputStream().write(json.getBytes("UTF-8"));
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public String getBlessingsId() {
		return blessingsId;
	}

	public void setBlessingsId(String blessingsId) {
		this.blessingsId = blessingsId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public BlessingsManager getBlessingsManager() {
		return blessingsManager;
	}

	public void setBlessingsManager(BlessingsManager blessingsManager) {
		this.blessingsManager = blessingsManager;
	}

	public String getBlessingsTypeId() {
		return blessingsTypeId;
	}

	public void setBlessingsTypeId(String blessingsTypeId) {
		this.blessingsTypeId = blessingsTypeId;
	}

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getRoleId() {
		return roleId;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public Long getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Long companyId) {
		this.companyId = companyId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Integer getSize() {
		return size;
	}

	public void setSize(Integer size) {
		this.size = size;
	}

	public Integer getPage() {
		return page;
	}

	public void setPage(Integer page) {
		this.page = page;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}

}
