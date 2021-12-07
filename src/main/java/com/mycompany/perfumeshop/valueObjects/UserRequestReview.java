package com.mycompany.perfumeshop.valueObjects;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class UserRequestReview {
	private Integer currentPage;
	private Integer sizeOfPage;
	private String keySearch;
	private String status;
}
