package com.mycompany.perfumeshop.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ReviewDTO extends BaseDTO {

	private String customerName;
	private String customerAddress;
	private String customerPhone;
	private String customerEmail;
	private String content;
	private Integer numberStar;
	private Integer idProduct;

}
