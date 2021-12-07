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
@Table(name = "tbl_reviews")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Review extends BaseEntity {

	@Column(name = "customer_name", length = 100, nullable = false)
	private String customerName;

	@Column(name = "customer_address", length = 255, nullable = false)
	private String customerAddress;

	@Column(name = "customer_phone", length = 20, nullable = false)
	private String customerPhone;

	@Column(name = "customer_email", length = 255, nullable = false)
	private String customerEmail;

	@Column(name = "content", length = 1000, nullable = false)
	private String content;

	@Column(name = "is_hide", nullable = true)
	private Boolean isHide = Boolean.FALSE;

	@Column(name = "number_star", nullable = false)
	private Integer numberStar;

	@JsonIgnore
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "product_id")
	private Product product;

	@JsonIgnore
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "customer_id")
	private User user;
}
