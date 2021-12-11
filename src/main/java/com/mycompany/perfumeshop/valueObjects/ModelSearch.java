package com.mycompany.perfumeshop.valueObjects;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ModelSearch {
	private String keySearch;
	/**
	 * @byStatus: True: show False: hide
	 */

	private Boolean byStatus;

}
