package com.mycompany.perfumeshop.dto;

import java.math.BigDecimal;

public class CartItemDTO {
	private int productId;
	private String productName;
	private int quanlity;
	private BigDecimal priceUnit;
	private String avatarProduct;
	private Integer maxOrder;

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public int getQuanlity() {
		return quanlity;
	}

	public void setQuanlity(int quanlity) {
		this.quanlity = quanlity;
	}

	public BigDecimal getPriceUnit() {
		return priceUnit;
	}

	public void setPriceUnit(BigDecimal priceUnit) {
		this.priceUnit = priceUnit;
	}

	public String getAvatarProduct() {
		return avatarProduct;
	}

	public void setAvatarProduct(String avatarProduct) {
		this.avatarProduct = avatarProduct;
	}

	public Integer getMaxOrder() {
		return maxOrder;
	}

	public void setMaxOrder(Integer maxOrder) {
		this.maxOrder = maxOrder;
	}

}
