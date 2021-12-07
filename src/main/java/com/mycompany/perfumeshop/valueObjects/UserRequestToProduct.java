package com.mycompany.perfumeshop.valueObjects;

import java.math.BigDecimal;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class UserRequestToProduct {
	private String keySearch;
	private BigDecimal minPrice;
	private BigDecimal maxPrice;
	private Integer typeOrder;
	private Integer idCategory;
	private Integer currentPage;
	private Integer sizeOfPage;
	private Boolean status;
}
