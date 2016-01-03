package com.eportal.ORM;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Member entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class Member implements java.io.Serializable {

	// Fields

	private Integer id;
	private Memberlevel memberlevel;
	private String loginName;
	private String loginPwd;
	private String memberName;
	private String phone;
	private String address;
	private String zip;
	private Date regDate;
	private Date lastDate;
	private Integer loginTimes;
	private String email;
	private Integer integral;
	
	// Constructors

	/** default constructor */
	public Member() {
	}

	/** full constructor */
	public Member(Memberlevel memberlevel, String loginName, String loginPwd,
			String memberName, String phone, String address, String zip,
			Date regDate, Date lastDate, Integer loginTimes, String email) {
		this.memberlevel = memberlevel;
		this.loginName = loginName;
		this.loginPwd = loginPwd;
		this.memberName = memberName;
		this.phone = phone;
		this.address = address;
		this.zip = zip;
		this.regDate = regDate;
		this.lastDate = lastDate;
		this.loginTimes = loginTimes;
		this.email = email;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Memberlevel getMemberlevel() {
		return this.memberlevel;
	}

	public void setMemberlevel(Memberlevel memberlevel) {
		this.memberlevel = memberlevel;
	}

	public String getLoginName() {
		return this.loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getLoginPwd() {
		return this.loginPwd;
	}

	public void setLoginPwd(String loginPwd) {
		this.loginPwd = loginPwd;
	}

	public String getMemberName() {
		return this.memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public String getPhone() {
		return this.phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getZip() {
		return this.zip;
	}

	public void setZip(String zip) {
		this.zip = zip;
	}

	public Date getRegDate() {
		return this.regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public Date getLastDate() {
		return this.lastDate;
	}

	public void setLastDate(Date lastDate) {
		this.lastDate = lastDate;
	}

	public Integer getLoginTimes() {
		return this.loginTimes;
	}

	public void setLoginTimes(Integer loginTimes) {
		this.loginTimes = loginTimes;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Integer getIntegral() {
		return integral;
	}

	public void setIntegral(Integer integral) {
		this.integral = integral;
	}
}