package com.mycompany.perfumeshop.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "tbl_request_cancel_order")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class RequestCancelOrder extends BaseEntity {

	@Column(name = "customer_name", length = 45, nullable = false)
	private String customerName;

	@Column(name = "customer_email", length = 45, nullable = false)
	private String email;

	@Column(name = "request_type", length = 45, nullable = false)
	private String requestType;

	@Column(name = "message", length = 1000, nullable = false)
	private String message;

	@Column(name = "reason", length = 1000, nullable = false)
	private String reason;

	@JsonIgnore
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "id_order", referencedColumnName = "id")
	private Order order;

}
