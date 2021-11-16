package com.mycompany.perfumeshop.entities;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "tbl_orders")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Order extends BaseEntity {
	@Column(name = "code")
	private String code;

	@Column(name = "total", precision = 13, scale = 2, nullable = false)
	private BigDecimal total;

	@Column(name = "customer_name")
	private String customerName;

	@Column(name = "customer_address")
	private String customerAddress;

	@Column(name = "customer_phone")
	private String customerPhone;

	@Column(name = "customer_email")
	private String customerEmail;

	@Column(name = "seo")
	private String seo;

	@Column(name = "processing_status")
	private Integer processingStatus;

	@Column(name = "user_id")
	private Integer userID;

	@OneToMany(cascade = CascadeType.ALL, mappedBy = "order", fetch = FetchType.EAGER)
	private List<OrderDetail> orderDetails = new ArrayList<OrderDetail>();

	public void addOrderDetail(OrderDetail _saleOrderProducts) {
		_saleOrderProducts.setOrder(this);
		orderDetails.add(_saleOrderProducts);
	}

	public void removeOrderDetail(OrderDetail _saleOrderProducts) {
		_saleOrderProducts.setOrder(null);
		orderDetails.remove(_saleOrderProducts);
	}

	@OneToOne(cascade = CascadeType.ALL, mappedBy = "order", fetch = FetchType.EAGER)
	private RequestCancelOrder requestCancelOrder;

}
