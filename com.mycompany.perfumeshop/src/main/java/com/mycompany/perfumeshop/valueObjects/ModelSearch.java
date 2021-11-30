package com.mycompany.perfumeshop.valueObjects;

public class ModelSearch {
	private String keySearch;
	/**
	 * @byStatus: True: show False: hide
	 */

	private Boolean byStatus;

	public String getKeySearch() {
		return keySearch;
	}

	public void setKeySearch(String keySearch) {
		this.keySearch = keySearch;
	}

	public Boolean getByStatus() {
		return byStatus;
	}

	public void setByStatus(Boolean byStatus) {
		this.byStatus = byStatus;
	}

}
