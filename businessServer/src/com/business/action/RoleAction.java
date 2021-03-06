package com.business.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
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

import com.common.Commonparam;
import com.business.entity.Company;
import com.business.entity.Role;
import com.business.entity.User;

import com.business.service.RoleManager;
import com.json.BaseBean;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

@Namespace("/")
@Results({ @Result(name = BaseAction.NONE, location = "roleAction.action", type = "redirect") })
public class RoleAction extends ActionSupport {
	/**
	 * 角色模块
	 */
	private static final long serialVersionUID = 7655056122242830524L;

	@Autowired
	RoleManager roleManager;

	private String username, password;
	private Integer size, page;
	private Long companyId;
	private String groupId, userId, roleId, parentId;
	private String contactsId;
	private String name;
	private String isDefault;
	private Date updateTime;
	private Integer deleteFlag;
	private String address;
	private String email;
	private String company;
	private String phone;
	private String fax;
	private String mobile;
	private String qq;
	private String job;
	private String business;
	private String firstLetter;
	private String account;
	private String attendance;
	private String headImage;
	private Integer isLeader;

	/**
	 * 权限列表
	 * 
	 * @throws Exception
	 */

	public void findRoleList() throws Exception {
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

			List<Role> roleList = roleManager.findRoleList(param);

			bean.setStatus(200);
			bean.setRows(roleList);

		} catch (Exception e) {
			bean.setStatus(400);
			bean.setMsg(e.getLocalizedMessage());
		}
		String json = JSONObject.fromObject(bean,
				Commonparam.getJsonConfig("yyyy-MM-dd HH:mm:ss")).toString();
		response.getOutputStream().write(json.getBytes("UTF-8"));
	}

	/**
	 * 添加，修改角色信息
	 * 
	 * @throws Exception
	 */

	public void updateRoleInfo() throws Exception {
		HttpServletResponse response = (HttpServletResponse) ActionContext
				.getContext().get(ServletActionContext.HTTP_RESPONSE);
		HttpServletRequest request = (HttpServletRequest) ActionContext
				.getContext().get(ServletActionContext.HTTP_REQUEST);
		Company company = (Company) request.getSession()
				.getAttribute("company");

		BaseBean bean = new BaseBean();

		try {

			HashMap param = new HashMap();
			param.put("roleId", roleId);
			param.put("companyId", company.getCompanyId());
			param.put("parentId", parentId);
			param.put("name", name);
			param.put("updateTime", new Date());

			roleManager.updateRoleInfo(param);

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
	 * 查询角色
	 * 
	 * @throws Exception
	 */
	public void findRoleInfo() throws Exception {
		HttpServletResponse response = (HttpServletResponse) ActionContext
				.getContext().get(ServletActionContext.HTTP_RESPONSE);
		HttpServletRequest request = (HttpServletRequest) ActionContext
				.getContext().get(ServletActionContext.HTTP_REQUEST);

		BaseBean bean = new BaseBean();
		try {
			HashMap param = new HashMap();
			param.put("field", "role_id");
			param.put("fieldValue", roleId);
			Role role = (Role) roleManager.findRoleInfoByField(param);
			request.setAttribute("roleInfo", role);
			request.getRequestDispatcher("/pages/roleManagerList.jsp").forward(
					request, response);
		} catch (Exception ee0) {

		}

	}

	/**
	 * 用户列表
	 * 
	 * @throws Exception
	 */

	public void findUserRoleList() throws Exception {
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
			if (roleId == null || roleId.trim().equals("")) {
				param.put("roleId", user.getRoleId());
			} else {
				param.put("roleId", roleId);
			}

			List<User> userRoleList = roleManager.findUserRoleList(param);

			bean.setStatus(200);
			bean.setRows(userRoleList);
			bean.setTotal(roleManager.findUserRoleListCount(param));

		} catch (Exception e) {
			bean.setStatus(400);
			bean.setMsg(e.getLocalizedMessage());
		}
		String json = JSONObject.fromObject(bean,
				Commonparam.getJsonConfig("yyyy-MM-dd HH:mm:ss")).toString();
		response.getOutputStream().write(json.getBytes("UTF-8"));
	}

	
	
	/**
	 * 上传图片
	 */
	
	
	private File uploadFile;
	private String uploadFileFileName;

	public void uploadProductImage() throws Exception {
		HttpServletResponse response = (HttpServletResponse) ActionContext
				.getContext().get(ServletActionContext.HTTP_RESPONSE);
		HttpServletRequest request = (HttpServletRequest) ActionContext
				.getContext().get(ServletActionContext.HTTP_REQUEST);
		BaseBean bean = new BaseBean();
		long max = Commonparam.FALE_SIZE[size];
		if (this.uploadFile != null) {
			int length = 0;
			try {
				FileInputStream fis = new FileInputStream(uploadFile);
				try {
					length = fis.available();
				} catch (IOException e1) {
					e1.printStackTrace();
				}
			} catch (FileNotFoundException e2) {
				e2.printStackTrace();
			}
			if (max >= length) {
				String newfilename = Commonparam
						.makeNewFileName(uploadFileFileName);
				String targetFolder = "/upload/" + Commonparam.FILE_PATH[size]
						+ Commonparam.makeYearMonth(new Date());
				String absolute = request.getSession().getServletContext()
						.getRealPath("/")
						+ targetFolder;
				
				Commonparam.makeFile(uploadFile, absolute, newfilename);

				bean.setStatus(200);
				bean.setRows(targetFolder + newfilename);
			} else {
				bean.setStatus(400);
				bean.setMsg("图片大小" + max / 1024 + "K内!");
			}
		} else {
			bean.setStatus(400);
			bean.setMsg("请选择图片!");
		}
		String json = JSONObject.fromObject(bean).toString();
		response.getOutputStream().write(json.getBytes("UTF-8"));
	}

	public void deleteImgSourseStock() throws Exception {
		HttpServletResponse response = (HttpServletResponse) ActionContext
				.getContext().get(ServletActionContext.HTTP_RESPONSE);
		HttpServletRequest request = (HttpServletRequest) ActionContext
				.getContext().get(ServletActionContext.HTTP_REQUEST);
		try {
			String filePath = request.getSession().getServletContext()
					.getRealPath("/");
			long a = System.currentTimeMillis();
			LinkedList list = new LinkedList();
			File dir = new File(filePath + "/upload/");
			File file[] = dir.listFiles();
			for (int i = 0; i < file.length; i++) {
				if (file[i].isDirectory())
					list.add(file[i]);
				else
					System.out.println(file[i].getAbsolutePath());
			}
			File tmp;
			while (!list.isEmpty()) {
				tmp = (File) list.removeFirst();
				if (tmp.isDirectory()) {
					file = tmp.listFiles();
					if (file == null)
						continue;
					for (int i = 0; i < file.length; i++) {
						if (file[i].isDirectory())
							list.add(file[i]);
						else
							System.out.println(file[i].getAbsolutePath());
					}
				} else {
					System.out.println(tmp.getAbsolutePath());
				}
			}

			System.out.println(System.currentTimeMillis() - a);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	
	
	

	public String getUploadFileFileName() {
		return uploadFileFileName;
	}

	public void setUploadFileFileName(String uploadFileFileName) {
		this.uploadFileFileName = uploadFileFileName;
	}

	public File getUploadFile() {
		return uploadFile;
	}

	public void setUploadFile(File uploadFile) {
		this.uploadFile = uploadFile;
	}
	
	
	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getAttendance() {
		return attendance;
	}

	public void setAttendance(String attendance) {
		this.attendance = attendance;
	}

	public String getHeadImage() {
		return headImage;
	}

	public void setHeadImage(String headImage) {
		this.headImage = headImage;
	}

	public Integer getIsLeader() {
		return isLeader;
	}

	public void setIsLeader(Integer isLeader) {
		this.isLeader = isLeader;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public String getRoleId() {
		return roleId;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

	public String getContactsId() {
		return contactsId;
	}

	public void setContactsId(String contactsId) {
		this.contactsId = contactsId;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getQq() {
		return qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}

	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}

	public String getBusiness() {
		return business;
	}

	public void setBusiness(String business) {
		this.business = business;
	}

	public String getFirstLetter() {
		return firstLetter;
	}

	public void setFirstLetter(String firstLetter) {
		this.firstLetter = firstLetter;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getIsDefault() {
		return isDefault;
	}

	public void setIsDefault(String isDefault) {
		this.isDefault = isDefault;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public Integer getDeleteFlag() {
		return deleteFlag;
	}

	public void setDeleteFlag(Integer deleteFlag) {
		this.deleteFlag = deleteFlag;
	}

	public RoleManager getRoleManager() {
		return roleManager;
	}

	public void setRoleManager(RoleManager roleManager) {
		this.roleManager = roleManager;
	}

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
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

}
