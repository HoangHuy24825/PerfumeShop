package com.mycompany.perfumeshop.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public abstract class BaseDTO {
	private Integer id;
	private Boolean status;
	private Date createdDate;
	private Integer createdBy;
	private Date updatedDate;
	private Integer updatedBy;

	public BaseDTO(Integer id) {
		super();
		this.id = id;
	}

}
