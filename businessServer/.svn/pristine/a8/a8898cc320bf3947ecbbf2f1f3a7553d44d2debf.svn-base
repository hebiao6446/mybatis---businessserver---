package com.business.action;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import cn.eavic.framework.web.BaseAction;

import com.business.entity.Company;
import com.business.entity.Product;
import com.business.entity.ProductCategory;
import com.business.entity.ProductImg;
import com.business.entity.Role;
import com.business.entity.User;
import com.business.service.ProductManager;
import com.common.Commonparam;
import com.json.BaseBean;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

@Namespace("/")
@Results({ @Result(name = BaseAction.NONE, location = "productAction.action", type = "redirect") })
public class ProductAction extends ActionSupport {

	private static final long serialVersionUID = 1L;

	@Autowired
	ProductManager productManager;

	private String categoryId, productName, productId, content, price, addFile,
			delFile;
	private Integer page, size;

	public void findProductCategory() throws Exception {
		HttpServletResponse response = (HttpServletResponse) ActionContext
				.getContext().get(ServletActionContext.HTTP_RESPONSE);
		HttpServletRequest request = (HttpServletRequest) ActionContext
				.getContext().get(ServletActionContext.HTTP_REQUEST);
		Company company = (Company) request.getSession()
				.getAttribute("company");
		BaseBean bean = new BaseBean();
		try {
			HashMap<String, Object> param = new HashMap<String, Object>();
			param.put("companyId", company.getCompanyId());
			param.put("parentId", 0);
			List<ProductCategory> list = productManager
					.findProductCategory(param);
			for (ProductCategory pc : list) {
				param.put("parentId", pc.getProductCategoryId());
				List<ProductCategory> list1 = productManager
						.findProductCategory(param);
				pc.setList(list1);
			}
			bean.setStatus(200);
			bean.setRows(list);
		} catch (Exception e) {
			bean.setStatus(400);
			bean.setMsg(e.getLocalizedMessage());
		}
		String json = JSONObject.fromObject(bean, Commonparam.getJsonConfig())
				.toString();
		response.getOutputStream().write(json.getBytes("UTF-8"));
	}

	public void findChildrenCategory() throws Exception {
		HttpServletResponse response = (HttpServletResponse) ActionContext
				.getContext().get(ServletActionContext.HTTP_RESPONSE);
		HttpServletRequest request = (HttpServletRequest) ActionContext
				.getContext().get(ServletActionContext.HTTP_REQUEST);
		Company company = (Company) request.getSession()
				.getAttribute("company");
		BaseBean bean = new BaseBean();
		try {
			HashMap<String, Object> param = new HashMap<String, Object>();
			param.put("companyId", company.getCompanyId());
			param.put("parentId", categoryId);
			List<ProductCategory> list = productManager
					.findProductCategory(param);
			bean.setStatus(200);
			bean.setRows(list);
		} catch (Exception e) {
			bean.setStatus(400);
			bean.setMsg(e.getLocalizedMessage());
		}
		String json = JSONObject.fromObject(bean, Commonparam.getJsonConfig())
				.toString();
		response.getOutputStream().write(json.getBytes("UTF-8"));
	}

	public void findProductList() throws Exception {
		HttpServletResponse response = (HttpServletResponse) ActionContext
				.getContext().get(ServletActionContext.HTTP_RESPONSE);
		HttpServletRequest request = (HttpServletRequest) ActionContext
				.getContext().get(ServletActionContext.HTTP_REQUEST);
		Company company = (Company) request.getSession()
				.getAttribute("company");
		BaseBean bean = new BaseBean();
		try {
			HashMap<String, Object> param = new HashMap<String, Object>();
			param.put("size", size);
			param.put("startIndex", (page - 1) * size);
			param.put("companyId", company.getCompanyId());
			param.put("categoryId", categoryId);
			param.put("productName", productName);

			List<Product> list = productManager.findProductList(param);
			for (Product product : list) {

				String content = product.getContent();
				content = content.replaceAll("</?[^<]+>", "");
				// 去除字符串中的空格 回车 换行符 制表符 等
				content = content.replaceAll("\\s*|\t|\r|\n", "");
				// 去除空格
				content = content.replaceAll("&nbsp;", "");
				product.setContent(content);				
			}
			bean.setStatus(200);
			bean.setRows(list);
			bean.setTotal(productManager.findProductListCount(param));
		} catch (Exception e) {
			bean.setStatus(400);
			bean.setMsg(e.getLocalizedMessage());
		}
		String json = JSONObject.fromObject(bean, Commonparam.getJsonConfig())
				.toString();
		response.getOutputStream().write(json.getBytes("UTF-8"));
	}

	public void findProductInfo() throws Exception {
		HttpServletResponse response = (HttpServletResponse) ActionContext
				.getContext().get(ServletActionContext.HTTP_RESPONSE);
		HttpServletRequest request = (HttpServletRequest) ActionContext
				.getContext().get(ServletActionContext.HTTP_REQUEST);
		Company company = (Company) request.getSession()
				.getAttribute("company");
		String gotoPage = "pages/productManagerUpdate.jsp";
		try {
			Product product = null;
			HashMap<String, Object> param = new HashMap<String, Object>();
			param.put("companyId", company.getCompanyId());
			param.put("parentId", 0);
			List<ProductCategory> list = productManager
					.findProductCategory(param);
			request.setAttribute("category1List", list);

			if (productId == null || "".equals(productId)) {
				product = new Product();
				if (list.size() > 0) {
					param.put("parentId", list.get(0).getProductCategoryId());
					List<ProductCategory> list2 = productManager
							.findProductCategory(param);
					request.setAttribute("categoryList", list2);
				}
			} else {
				param.put("productId", productId);
				product = productManager.findProductInfo(param);
				Long parentCategoryId = productManager.parentCategoryId(product
						.getProductCategoryId());
				if (parentCategoryId == 0 && list.size() > 0) {
					param.put("parentId", list.get(0).getProductCategoryId());

				} else if (parentCategoryId == 0 && list.size() > 0) {
					param.put("parentId", parentCategoryId);

				}
				List<ProductCategory> list2 = productManager
						.findProductCategory(param);
				request.setAttribute("categoryList", list2);
				request.setAttribute("parentCategoryId", parentCategoryId);
				List<ProductImg> list1 = productManager.findProductImg(product
						.getProductId());
				request.setAttribute("productImg", list1);
			}
			request.setAttribute("product", product);

		} catch (Exception e) {
			request.setAttribute("javax.servlet.error.exception", e);
			gotoPage = "500.jsp";
		}
		request.getRequestDispatcher(gotoPage).forward(request, response);
	}

	public void updateProductInfo() throws Exception {
		HttpServletResponse response = (HttpServletResponse) ActionContext
				.getContext().get(ServletActionContext.HTTP_RESPONSE);
		HttpServletRequest request = (HttpServletRequest) ActionContext
				.getContext().get(ServletActionContext.HTTP_REQUEST);
		User user = (User) request.getSession().getAttribute("user");
		BaseBean bean = new BaseBean();

		try {
			if (user != null && user.getUserId() > 0) {
				Product p = new Product();
				p.setContent(content);
				p.setDeleteFlag(1);
				p.setPrice(new BigDecimal(price));
				p.setProductCategoryId(Long.valueOf(categoryId));
				if (productId != null && !"".equals(productId)) {
					p.setProductId(Long.valueOf(productId));
				}
				p.setProductName(productName);
				p.setUpdateTime(new Date());
				productManager.updateProductInfo(p, addFile, delFile);
				bean.setStatus(200);
			} else {
				bean.setStatus(400);
				bean.setMsg("用户没有登录！");
			}
		} catch (Exception e) {
			bean.setStatus(400);
			bean.setMsg(e.getLocalizedMessage());
		}
		String json = JSONObject.fromObject(bean, Commonparam.getJsonConfig())
				.toString();
		response.getOutputStream().write(json.getBytes("UTF-8"));
	}

	public void deleteProductData() throws Exception {
		HttpServletResponse response = (HttpServletResponse) ActionContext
				.getContext().get(ServletActionContext.HTTP_RESPONSE);
		HttpServletRequest request = (HttpServletRequest) ActionContext
				.getContext().get(ServletActionContext.HTTP_REQUEST);
		User user = (User) request.getSession().getAttribute("user");
		BaseBean bean = new BaseBean();
		try {
			if (user != null && user.getUserId() > 0) {
				productManager.deleteProductData(productId);
				bean.setStatus(200);
			} else {
				bean.setStatus(400);
				bean.setMsg("用户没有登录！");
			}
		} catch (Exception e) {
			bean.setStatus(400);
			bean.setMsg(e.getLocalizedMessage());
		}
		String json = JSONObject.fromObject(bean, Commonparam.getJsonConfig())
				.toString();
		response.getOutputStream().write(json.getBytes("UTF-8"));
	}

	public String getAddFile() {
		return addFile;
	}

	public void setAddFile(String addFile) {
		this.addFile = addFile;
	}

	public String getDelFile() {
		return delFile;
	}

	public void setDelFile(String delFile) {
		this.delFile = delFile;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public String getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}

	public Integer getPage() {
		return page;
	}

	public void setPage(Integer page) {
		this.page = page;
	}

	public Integer getSize() {
		return size;
	}

	public void setSize(Integer size) {
		this.size = size;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

}
