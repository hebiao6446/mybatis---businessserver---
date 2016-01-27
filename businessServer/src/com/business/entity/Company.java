package com.business.entity;

import java.io.Serializable;
import java.sql.Time;
import java.util.Date;

public class Company implements Serializable {

	private Long companyId;
	private String name;
	private String introduce;
	private String address;
	private String email;
	private String logo;
	private String linkman;
	private String phone;
	private Time outWork;
	private Time reportWork;
	private java.sql.Date enableTime;
	private Integer type;
	private Integer deleteFlag;
	private Integer status;
	private java.sql.Date disableTime;
	private Date updateTime;

	public Company() {
		super();
	}

	public Long getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Long companyId) {
		this.companyId = companyId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getIntroduce() {
		return introduce;
	}

	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getLogo() {
		return logo;
	}

	public void setLogo(String logo) {
		this.logo = logo;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Date getOutWork() {
		return outWork;
	}

	public Time getReportWork() {
		return reportWork;
	}

	public void setReportWork(Time reportWork) {
		this.reportWork = reportWork;
	}

	public void setOutWork(Time outWork) {
		this.outWork = outWork;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getDeleteFlag() {
		return deleteFlag;
	}

	public void setDeleteFlag(Integer deleteFlag) {
		this.deleteFlag = deleteFlag;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getLinkman() {
		return linkman;
	}

	public void setLinkman(String linkman) {
		this.linkman = linkman;
	}

	public java.sql.Date getEnableTime() {
		return enableTime;
	}

	public void setEnableTime(java.sql.Date enableTime) {
		this.enableTime = enableTime;
	}

	public java.sql.Date getDisableTime() {
		return disableTime;
	}

	public void setDisableTime(java.sql.Date disableTime) {
		this.disableTime = disableTime;
	}

	

}