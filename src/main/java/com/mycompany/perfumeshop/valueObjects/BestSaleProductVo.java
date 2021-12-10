package com.mycompany.perfumeshop.valueObjects;

import java.math.BigDecimal;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class BestSaleProductVo {
	private String avatar;
	private String name;
	private Long totalSale;
	private BigDecimal totalMoney;
}
