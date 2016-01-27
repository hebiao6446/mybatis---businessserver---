package com.business.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import cn.eavic.framework.web.BaseAction;

import com.business.entity.Company;
import com.business.entity.SellProduct;
import com.business.entity.Things;
import com.business.entity.ThingsFile;
import com.business.entity.ThingsFinish;
import com.business.entity.ThingsThingsFinish;
import com.business.entity.User;
import com.business.service.ThingsManager;
import com.business.service.UserManager;
import com.common.Commonparam;
import com.json.BaseBean;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

@Namespace("/")
@Results({ @Result(name = BaseAction.NONE, location = "thingsAction.action", type = "redirect") })
public class ThingsAction extends ActionSupport {

	@Autowired
	ThingsManager thingsManager;
	@Autowired
	UserManager userManager;

	private Integer size, page,periodType;
	private Long thingsId;
	private String content,isEmergency,startTime,endTime,addUsers,deleteUsers;

	
	public void findUserThingsList() throws Exception {
		HttpServletResponse response = (HttpServletResponse) ActionContext
				.getContext().get(ServletActionContext.HTTP_RESPONSE);
		HttpServletRequest request = (HttpServletRequest) ActionContext
				.getContext().get(ServletActionContext.HTTP_REQUEST);
		User user = (User) request.getSession().getAttribute("user");
		BaseBean bean = new BaseBean();

		try {
			HashMap<String, Object> param = new HashMap<String, Object>();
			param.put("userId", user.getUserId());
			param.put("size", size);
			param.put("startIndex", (page - 1) * size);
			List<ThingsThingsFinish> list = thingsManager.findUserThingsList(param);
			bean.setRows(list);
			bean.setTotal(thingsManager.findUserThingsListCount(param));
			bean.setStatus(200);
		} catch (Exception e) {
			e.printStackTrace();
		}
		String json = JSONObject.fromObject(bean, Commonparam.getJsonConfig())
				.toString();
		response.getOutputStream().write(json.getBytes("UTF-8"));
	}

	
	
	@SuppressWarnings("rawtypes")
	public void findThingsInfo() throws Exception {
		HttpServletResponse response = (HttpServletResponse) ActionContext
				.getContext().get(ServletActionContext.HTTP_RESPONSE);
		HttpServletRequest request = (HttpServletRequest) ActionContext
				.getContext().get(ServletActionContext.HTTP_REQUEST);
		User user = (User) request.getSession().getAttribute("user");
		Company c = (Company) request.getSession().getAttribute("company");
		String gotopage = "pages/thingsManagerUpdate.jsp";
		try {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("userId", user.getUserId());
			map.put("companyId", c.getCompanyId());
			map.put("thingsId", thingsId);

			Things things = null;
			if (thingsId != null && !"".equals(thingsId)) {
				things = thingsManager.findThingsInfo(map);
			} else {
				things = new Things();
			}
			List<HashMap> users = userManager.findAllUserList(map);
			request.setAttribute("things", things);
			request.setAttribute("users", users);
		} catch (Exception e) {
			e.printStackTrace();
			gotopage = "common/500.jsp";
		}
		request.getRequestDispatcher(gotopage).forward(request, response);
	}

	@SuppressWarnings("unchecked")
	public void updateThingsInfo() throws Exception {
		HttpServletResponse response = (HttpServletResponse) ActionContext
				.getContext().get(ServletActionContext.HTTP_RESPONSE);
		HttpServletRequest request = (HttpServletRequest) ActionContext
				.getContext().get(ServletActionContext.HTTP_REQUEST);
		User user = (User) request.getSession().getAttribute("user");
		BaseBean bean = new BaseBean();
		try {
			Things t=new Things();
			t.setContent(content);
			t.setCreateUserId(user.getUserId());
			t.setThingsId(thingsId);
			t.setIsEmergency(isEmergency);
			t.setPeriodType(periodType);
			t.setStartTime(Commonparam.shortStrtoDate(startTime));
			t.setEndTime(Commonparam.shortStrtoDate(endTime));
			t.setUpdateTime(new Date());
			t.setDeleteFlag(1);
			JSONArray json = JSONArray.fromObject(addUsers);
			List<String> addUsers = (List<String>) JSONArray
					.toCollection(json);
			
			JSONArray json1 = JSONArray.fromObject(deleteUsers);
			List<String> deleteUsers = (List<String>) JSONArray
					.toCollection(json1);
			thingsManager.updateThingsInfo(t,addUsers,deleteUsers);
			bean.setStatus(200);
		} catch (Exception e) {
			e.printStackTrace();
		}
		String json = JSONObject.fromObject(bean).toString();
		response.getOutputStream().write(json.getBytes("UTF-8"));
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

	public Long getThingsId() {
		return thingsId;
	}

	public void setThingsId(Long thingsId) {
		this.thingsId = thingsId;
	}

	public Integer getPeriodType() {
		return periodType;
	}

	public void setPeriodType(Integer periodType) {
		this.periodType = periodType;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getIsEmergency() {
		return isEmergency;
	}

	public void setIsEmergency(String isEmergency) {
		this.isEmergency = isEmergency;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getAddUsers() {
		return addUsers;
	}

	public void setAddUsers(String addUsers) {
		this.addUsers = addUsers;
	}

	public String getDeleteUsers() {
		return deleteUsers;
	}

	public void setDeleteUsers(String deleteUsers) {
		this.deleteUsers = deleteUsers;
	}

}
