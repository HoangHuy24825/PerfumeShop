package com.mycompany.perfumeshop.valueObjects;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class SearchObject {
	private String keySearch;
	private Integer idCategory;
	private Boolean status;
}
