package com.mycompany.perfumeshop.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "tbl_introduce")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Introduce extends BaseEntity {

	@Column(name = "detail", columnDefinition = "LONGTEXT", nullable = false)
	private String detail;

	@Column(name = "seo", length = 10000, nullable = true)
	private String seo;

}
