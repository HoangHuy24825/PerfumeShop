package com.mycompany.perfumeshop.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class CategoryDTO extends BaseDTO {
	private String name;
	private String description;
	private String seo;
	private MultipartFile avatar;
	private Boolean isHot;
}
