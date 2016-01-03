package com.eportal.ORM;

import java.util.HashSet;
import java.util.Set;

/**
 * Cart entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class Cart implements java.io.Serializable {

	// Fields

	private Integer id;
	private Member member;
	private Double money;
	private Integer cartStatus;

	// Constructors

	/** default constructor */
	public Cart() {
	}

	/** full constructor */
	public Cart(Member member, Double money, Integer cartStatus) {
		this.member = member;
		this.money = money;
		this.cartStatus = cartStatus;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Member getMember() {
		return this.member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public Double getMoney() {
		return this.money;
	}

	public void setMoney(Double money) {
		this.money = money;
	}

	public Integer getCartStatus() {
		return this.cartStatus;
	}

	public void setCartStatus(Integer cartStatus) {
		this.cartStatus = cartStatus;
	}
}