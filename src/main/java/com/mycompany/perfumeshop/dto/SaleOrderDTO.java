package com.mycompany.perfumeshop.dto;

import java.math.BigDecimal;

public class SaleOrderDTO extends BaseDTO {
	private String code;
	private BigDecimal total;
	private String customerName;
	private String customerAddress;
	private String customerPhone;
	private String customerEmail;
	private Integer processingStatus;
	private String seo;
	private Integer userID;

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public BigDecimal getTotal() {
		return total;
	}

	public void setTotal(BigDecimal total) {
		this.total = total;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getCustomerAddress() {
		return customerAddress;
	}

	public void setCustomerAddress(String customerAddress) {
		this.customerAddress = customerAddress;
	}

	public String getCustomerPhone() {
		return customerPhone;
	}

	public void setCustomerPhone(String customerPhone) {
		this.customerPhone = customerPhone;
	}

	public String getCustomerEmail() {
		return customerEmail;
	}

	public void setCustomerEmail(String customerEmail) {
		this.customerEmail = customerEmail;
	}

	public Integer getProcessingStatus() {
		return processingStatus;
	}

	public void setProcessingStatus(Integer processingStatus) {
		this.processingStatus = processingStatus;
	}

	public String getSeo() {
		return seo;
	}

	public void setSeo(String seo) {
		this.seo = seo;
	}

	public Integer getUserID() {
		return userID;
	}

	public void setUserID(Integer userID) {
		this.userID = userID;
	}

}
