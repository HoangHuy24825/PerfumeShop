package com.mycompany.perfumeshop.dto;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.mycompany.perfumeshop.utils.ConvertUtils;

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
	private String description;
	private String detail;
	private MultipartFile avatar;
	private String seo;
	private Boolean isHot;
	private Integer id_category;
	private MultipartFile[] images;
	private String origin;
	private String trademark;
	private String fragrant;
	private Integer manufactureYear;
	private String idAttribute[];
	private String capacity[];
	private String price[];
	private String priceSale[];
	private String amount[];

	public List<AttributeProductDTO> getListAttibute() {

		List<AttributeProductDTO> attributeProductDTOs = new ArrayList<AttributeProductDTO>();
		for (int i = 0; i < amount.length; i++) {
			if (amount[i] != null && amount[i] != "") {
				attributeProductDTOs.add(new AttributeProductDTO(
						ConvertUtils.convertStringToInt(idAttribute.length > 0 ? idAttribute[i] : null, null),
						new BigDecimal(capacity[i]), new BigDecimal(price[i]),
						ConvertUtils.convertStringToBigDecimal(priceSale[i], null),
						ConvertUtils.convertStringToInt(amount[i], 0)));
			}
		}

		return attributeProductDTOs;
	}
}
