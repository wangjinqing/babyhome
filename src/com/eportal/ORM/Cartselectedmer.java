package com.eportal.ORM;

/**
 * Cartselectedmer entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class Cartselectedmer implements java.io.Serializable {

	// Fields

	private Integer id;
	private Merchandise merchandise;
	private Cart cart;
	private Integer number;
	private Double price;
	private Double money;

	// Constructors

	/** default constructor */
	public Cartselectedmer() {
	}

	/** full constructor */
	public Cartselectedmer(Merchandise merchandise, Cart cart, Integer number,
			Double price, Double money) {
		this.merchandise = merchandise;
		this.cart = cart;
		this.number = number;
		this.price = price;
		this.money = money;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Merchandise getMerchandise() {
		return this.merchandise;
	}

	public void setMerchandise(Merchandise merchandise) {
		this.merchandise = merchandise;
	}

	public Cart getCart() {
		return this.cart;
	}

	public void setCart(Cart cart) {
		this.cart = cart;
	}

	public Integer getNumber() {
		return this.number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}

	public Double getPrice() {
		return this.price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public Double getMoney() {
		return this.money;
	}

	public void setMoney(Double money) {
		this.money = money;
	}

}