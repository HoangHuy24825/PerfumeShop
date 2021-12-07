package com.mycompany.perfumeshop.valueObjects;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class AdminRequest {
	private Integer currentPage;
	private Integer totalPage;
	private Integer currentId;
	/**
	 * role=0: staff role=1: user
	 */
	private Integer role;
}
