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
public class AttributeProductDTO extends BaseDTO {
	private BigDecimal capacity;
	private BigDecimal price;
	private BigDecimal priceSale;
	private Integer amount;

	public AttributeProductDTO(Integer id, BigDecimal capacity, BigDecimal price, BigDecimal priceSale,
			Integer amount) {
		super(id);
		this.capacity = capacity;
		this.price = price;
		this.priceSale = priceSale;
		this.amount = amount;
	}

}
