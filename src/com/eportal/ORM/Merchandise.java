package com.eportal.ORM;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Merchandise entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class Merchandise implements java.io.Serializable {

	// Fields

	private Integer id;
	private Category category;
	private String merName;
	private Double price;
	private Double sprice;
	private String merModel;
	private String picture;
	private String video;
	private String merDesc;
	private String manufacturer;
	private Date leaveFactoryDate;
	private Integer special;
	private String htmlPath;
	private Integer status;	

	// Constructors

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	/** default constructor */
	public Merchandise() {
	}

	/** full constructor */
	public Merchandise(Category category, String merName, Double price,
			Double sprice, String merModel, String picture, String video,
			String merDesc, String manufacturer, Date leaveFactoryDate,
			Integer special, String htmlPath) {
		this.category = category;
		this.merName = merName;
		this.price = price;
		this.sprice = sprice;
		this.merModel = merModel;
		this.picture = picture;
		this.video = video;
		this.merDesc = merDesc;
		this.manufacturer = manufacturer;
		this.leaveFactoryDate = leaveFactoryDate;
		this.special = special;
		this.htmlPath = htmlPath;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Category getCategory() {
		return this.category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public String getMerName() {
		return this.merName;
	}

	public void setMerName(String merName) {
		this.merName = merName;
	}

	public Double getPrice() {
		return this.price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public Double getSprice() {
		return this.sprice;
	}

	public void setSprice(Double sprice) {
		this.sprice = sprice;
	}

	public String getMerModel() {
		return this.merModel;
	}

	public void setMerModel(String merModel) {
		this.merModel = merModel;
	}

	public String getPicture() {
		return this.picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	public String getVideo() {
		return this.video;
	}

	public void setVideo(String video) {
		this.video = video;
	}

	public String getMerDesc() {
		return this.merDesc;
	}

	public void setMerDesc(String merDesc) {
		this.merDesc = merDesc;
	}

	public String getManufacturer() {
		return this.manufacturer;
	}

	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}

	public Date getLeaveFactoryDate() {
		return this.leaveFactoryDate;
	}

	public void setLeaveFactoryDate(Date leaveFactoryDate) {
		this.leaveFactoryDate = leaveFactoryDate;
	}

	public Integer getSpecial() {
		return this.special;
	}

	public void setSpecial(Integer special) {
		this.special = special;
	}

	public String getHtmlPath() {
		return this.htmlPath;
	}

	public void setHtmlPath(String htmlPath) {
		this.htmlPath = htmlPath;
	}
}