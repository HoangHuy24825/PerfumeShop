package com.mycompany.perfumeshop.dto;

import java.math.BigDecimal;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class CartItemDTO {
	private int attrProductId;
	private String productName;
	private int quantity;
	private BigDecimal priceUnit;
	private String avatarProduct;
	private Integer maxOrder;
	private BigDecimal capacity;
}
