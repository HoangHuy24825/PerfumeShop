package com.mycompany.perfumeshop.dto;

import java.math.BigDecimal;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class ProductDTO extends BaseDTO {
	private String title;
	private BigDecimal price;
	private BigDecimal priceSale;
	private String description;
	private String detail;
	private MultipartFile avatar;
	private String seo;
	private Boolean isHot;
	private Integer id_category;
	private MultipartFile[] images;
	private String model;
	private Integer amount;
	private String origin;
	private Integer manufactureYear;
}
