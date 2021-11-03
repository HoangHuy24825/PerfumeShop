package com.mycompany.perfumeshop.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "tbl_contact")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Contact extends BaseEntity {
	@Column(name = "content", columnDefinition = "LONGTEXT", nullable = false)
	private String content;

	@Column(name = "subject", length = 255, nullable = false)
	private String subject;

	@Column(name = "customer_name", length = 100, nullable = false)
	private String customerName;

	@Column(name = "customer_email", length = 255, nullable = false)
	private String customerEmail;

	@Column(name = "customer_phone", length = 20, nullable = false)
	private String customerPhone;

}
