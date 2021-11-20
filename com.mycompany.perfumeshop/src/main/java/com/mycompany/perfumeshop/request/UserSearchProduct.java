package com.mycompany.perfumeshop.request;

import java.math.BigDecimal;

public class UserSearchProduct {
	private String keySearch;
	private BigDecimal minPrice;
	private BigDecimal maxPrice;
	private Integer typeOrder;
	private Integer idCategory;

	public String getKeySearch() {
		return keySearch;
	}

	public void setKeySearch(String keySearch) {
		this.keySearch = keySearch;
	}

	public BigDecimal getMinPrice() {
		return minPrice;
	}

	public void setMinPrice(BigDecimal minPrice) {
		this.minPrice = minPrice;
	}

	public BigDecimal getMaxPrice() {
		return maxPrice;
	}

	public void setMaxPrice(BigDecimal maxPrice) {
		this.maxPrice = maxPrice;
	}

	public Integer getTypeOrder() {
		return typeOrder;
	}

	public void setTypeOrder(Integer typeOrder) {
		this.typeOrder = typeOrder;
	}

	public void setMaxMinPrice(Integer filterType) {
		switch (filterType) {
		case 0:
			minPrice = null;
			maxPrice = null;
			break;
		case 1:
			minPrice = new BigDecimal(1000000);
			maxPrice = new BigDecimal(3000000);
			break;
		case 2:
			minPrice = new BigDecimal(3000000);
			maxPrice = new BigDecimal(5000000);
			break;
		case 3:
			minPrice = new BigDecimal(5000000);
			maxPrice = new BigDecimal(7000000);
			break;
		case 4:
			minPrice = new BigDecimal(7000000);
			maxPrice = new BigDecimal(12000000);
			break;
		case 5:
			minPrice = new BigDecimal(12000000);
			maxPrice = null;
			break;
		default:
			minPrice = null;
			maxPrice = null;
			break;
		}
	}

	public Integer getIdCategory() {
		return idCategory;
	}

	public void setIdCategory(Integer idCategory) {
		this.idCategory = idCategory;
	}

}
