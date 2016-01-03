package com.eportal.ORM;

import java.util.Date;

/**
 * Traffic entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class Traffic implements java.io.Serializable {

	// Fields

	private Integer id;
	private String sourceUrl;
	private String targetUrl;
	private String ip;
	private String area;
	private Date visitDate;

	// Constructors

	/** default constructor */
	public Traffic() {
	}

	/** full constructor */
	public Traffic(String sourceUrl, String targetUrl, String ip, String area,
			Date visitDate) {
		this.sourceUrl = sourceUrl;
		this.targetUrl = targetUrl;
		this.ip = ip;
		this.area = area;
		this.visitDate = visitDate;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getSourceUrl() {
		return this.sourceUrl;
	}

	public void setSourceUrl(String sourceUrl) {
		this.sourceUrl = sourceUrl;
	}

	public String getTargetUrl() {
		return this.targetUrl;
	}

	public void setTargetUrl(String targetUrl) {
		this.targetUrl = targetUrl;
	}

	public String getIp() {
		return this.ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getArea() {
		return this.area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public Date getVisitDate() {
		return this.visitDate;
	}

	public void setVisitDate(Date visitDate) {
		this.visitDate = visitDate;
	}

}