package com.mycompany.perfumeshop.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "tbl_notifies")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Notify extends BaseEntity {
	
	@Column(name = "content", length = 1000, nullable = false)
	private String content;

	@Column(name = "short_description", length = 255, nullable = false)
	private String description;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "receiver_id")
	private User user;
	
}
