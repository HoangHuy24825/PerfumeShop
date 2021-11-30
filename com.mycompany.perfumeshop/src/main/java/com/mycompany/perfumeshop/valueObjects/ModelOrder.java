package com.mycompany.perfumeshop.valueObjects;

public class ModelOrder {
	/**
	 * -1: Z->A; 0: normal; 1: A->Z
	 */
	private Integer byName;
	private Integer byCreatedDate;

	public Integer getByName() {
		return byName;
	}

	public void setByName(Integer byName) {
		this.byName = byName;
	}

	public Integer getByCreatedDate() {
		return byCreatedDate;
	}

	public void setByCreatedDate(Integer byCreatedDate) {
		this.byCreatedDate = byCreatedDate;
	}

}
