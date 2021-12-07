package com.mycompany.perfumeshop.entities;

import java.math.BigDecimal;

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
@Table(name = "tbl_attribute_products")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class AttributeProduct extends BaseEntity {

	@Column(name = "capacity", precision = 8, scale = 2, nullable = false)
	private BigDecimal capacity;

	@Column(name = "price", precision = 13, scale = 2, nullable = false)
	private BigDecimal price;

	@Column(name = "sale_price", precision = 13, scale = 2, nullable = true)
	private BigDecimal priceSale;

	@Column(name = "amount", nullable = false)
	private Integer amount;

	@JsonIgnore
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "product_id")
	private Product product;

}
