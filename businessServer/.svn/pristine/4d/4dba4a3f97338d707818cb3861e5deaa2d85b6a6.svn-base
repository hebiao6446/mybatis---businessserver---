package com.business.action;

import java.math.BigDecimal;
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
import com.business.entity.ContactsGroupUser;
import com.business.entity.Product;
import com.business.entity.Sell;
import com.business.entity.SellProduct;
import com.business.entity.User;
import com.business.service.ContactsManager;
import com.business.service.ProductManager;
import com.business.service.ProjectManager;
import com.business.service.SellManager;
import com.business.service.UserManager;
import com.common.Commonparam;
import com.json.BaseBean;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

@Namespace("/")
@Results({ @Result(name = BaseAction.NONE, location = "projectAction.action", type = "redirect") })
public class ProjectAction extends ActionSupport {

	private static final long serialVersionUID = 1L;

	@Autowired
	ProjectManager projectManager;

	private String userId, sellMethod, totalPrice, sellProductList, sellIdList;
	private Integer size, page, status;
	private String sellId, contactsId;

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public String getSellIdList() {
		return sellIdList;
	}

	public void setSellIdList(String sellIdList) {
		this.sellIdList = sellIdList;
	}

	public String getSellMethod() {
		return sellMethod;
	}

	public void setSellMethod(String sellMethod) {
		this.sellMethod = sellMethod;
	}

	public String getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(String totalPrice) {
		this.totalPrice = totalPrice;
	}

	public String getSellProductList() {
		return sellProductList;
	}

	public void setSellProductList(String sellProductList) {
		this.sellProductList = sellProductList;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getSellId() {
		return sellId;
	}

	public void setSellId(String sellId) {
		this.sellId = sellId;
	}

	public String getContactsId() {
		return contactsId;
	}

	public void setContactsId(String contactsId) {
		this.contactsId = contactsId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
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

}
