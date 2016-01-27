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
import com.business.service.SellManager;
import com.business.service.UserManager;
import com.common.Commonparam;
import com.json.BaseBean;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

@Namespace("/")
@Results({ @Result(name = BaseAction.NONE, location = "sellAction.action", type = "redirect") })
public class SellAction extends ActionSupport {

	private static final long serialVersionUID = 1L;

	@Autowired
	SellManager sellManager;
	@Autowired
	UserManager userManager;
	@Autowired
	ProductManager productManager;
	@Autowired
	ContactsManager contactsManager;

	private String userId, sellMethod, totalPrice, sellProductList,sellIdList;
	private Integer size, page, status;
	private Long sellId, contactsId;

	public void findUserSellList() throws Exception {
		HttpServletResponse response = (HttpServletResponse) ActionContext
				.getContext().get(ServletActionContext.HTTP_RESPONSE);
		HttpServletRequest request = (HttpServletRequest) ActionContext
				.getContext().get(ServletActionContext.HTTP_REQUEST);
		User user = (User) request.getSession().getAttribute("user");
		BaseBean bean = new BaseBean();

		try {
			HashMap<String, Object> param = new HashMap<String, Object>();
			param.put("size", size);
			param.put("startIndex", (page - 1) * size);

			if (userId == null || userId.trim().equals("")) {
				param.put("userId", user.getUserId());
				String roleIds = userManager.findChildrenRole(user.getUserId());
				if (roleIds == null || roleIds.trim().length() == 0) {
					roleIds = "-1";
				}
				param.put("roleIds", roleIds);
			} else {
				param.put("userId", userId);
				param.put("roleIds", "-1");
			}
			List<Sell> list = sellManager.findUserSellList(param);
			for (Sell sell : list) {
				Date d=sellManager.findLastUpdateTime(sell);
				if(d!=null){
					sell.setUpdateTime(d);
				}				
			}			
			bean.setTotal(sellManager.findUserSellListCount(param));
			bean.setRows(list);
			bean.setStatus(200);
		} catch (Exception e) {
			e.printStackTrace();
		}
		String json = JSONObject.fromObject(bean, Commonparam.getJsonConfig())
				.toString();
		response.getOutputStream().write(json.getBytes("UTF-8"));
	}

	public void findUserSellInfo() throws Exception {
		HttpServletResponse response = (HttpServletResponse) ActionContext
				.getContext().get(ServletActionContext.HTTP_RESPONSE);
		HttpServletRequest request = (HttpServletRequest) ActionContext
				.getContext().get(ServletActionContext.HTTP_REQUEST);
		User user = (User) request.getSession().getAttribute("user");
		Company company = (Company) request.getSession()
				.getAttribute("company");
		String gotoPage = "pages/sellManagerUpdate.jsp";
		try {
			HashMap<String, Object> param = new HashMap<String, Object>();
			param.put("companyId", company.getCompanyId());

			if (userId == null || userId.trim().equals("")) {
				param.put("userId", user.getUserId());
				param.put("roleIds", -1);
			}else{
				param.put("userId", userId);
				param.put("roleIds", -1);
			}
			List<ContactsGroupUser> contactsList = contactsManager
					.findGroupContactsList(param);
			request.setAttribute("contactsList", contactsList);

			List<Product> list = productManager.findProductList(param);
			request.setAttribute("productList", list);
			if (sellId != null) {
				Sell sell = sellManager.findUserSellInfo(sellId);
				List<SellProduct> productList = sellManager
						.findSellProductInfo(sellId);
				request.setAttribute("sell", sell);
				request.setAttribute("sellProductList", productList);
			} else {
				Sell sell = new Sell();
				sell.setTotalPrice(new BigDecimal(0));
				request.setAttribute("sell", sell);
			}
		} catch (Exception e) {
			e.printStackTrace();
			gotoPage = "common/500.jsp";
		}
		request.getRequestDispatcher(gotoPage).forward(request, response);
	}

	@SuppressWarnings({ "unchecked" })
	public void updateSellInfo() throws Exception {
		HttpServletResponse response = (HttpServletResponse) ActionContext
				.getContext().get(ServletActionContext.HTTP_RESPONSE);
		HttpServletRequest request = (HttpServletRequest) ActionContext
				.getContext().get(ServletActionContext.HTTP_REQUEST);
		User user = (User) request.getSession().getAttribute("user");
		BaseBean bean = new BaseBean();
		try {
			Sell sell = new Sell();
			sell.setSellId(sellId);
			sell.setContactsId(contactsId);
			sell.setUserId(user.getUserId());
			sell.setSellMethod(sellMethod);
			sell.setStatus(status);
			sell.setUpdateTime(new Date());
			sell.setDeleteFlag(1);
			sell.setTotalPrice(new BigDecimal(totalPrice));
			JSONArray json = JSONArray.fromObject(sellProductList);
			List<SellProduct> sellProductlist = (List<SellProduct>) JSONArray
					.toCollection(json, SellProduct.class);
			sellManager.updateSellInfo(sell,sellProductlist);
			
			bean.setStatus(200);
		} catch (Exception e) {
			e.printStackTrace();
		}
		String json = JSONObject.fromObject(bean, Commonparam.getJsonConfig())
				.toString();
		response.getOutputStream().write(json.getBytes("UTF-8"));
	}
	public void deleteSellData() throws Exception {
		HttpServletResponse response = (HttpServletResponse) ActionContext
				.getContext().get(ServletActionContext.HTTP_RESPONSE);
		HttpServletRequest request = (HttpServletRequest) ActionContext
				.getContext().get(ServletActionContext.HTTP_REQUEST);
		User user = (User) request.getSession().getAttribute("user");
		BaseBean bean = new BaseBean();
		try {
			if(user!=null&&user.getUserId()>0){
				sellManager.deleteSellData(sellIdList);				
				bean.setStatus(200);
			}else {
				bean.setStatus(400);
				bean.setMsg("用户没有登录！");
			}			
		} catch (Exception e) {
			e.printStackTrace();
		}
		String json = JSONObject.fromObject(bean, Commonparam.getJsonConfig())
				.toString();
		response.getOutputStream().write(json.getBytes("UTF-8"));
	}

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

	public Long getContactsId() {
		return contactsId;
	}

	public void setContactsId(Long contactsId) {
		this.contactsId = contactsId;
	}

	public Long getSellId() {
		return sellId;
	}

	public void setSellId(Long sellId) {
		this.sellId = sellId;
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
