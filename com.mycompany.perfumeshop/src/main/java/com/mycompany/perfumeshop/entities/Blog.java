package com.mycompany.perfumeshop.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "tbl_blog")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Blog extends BaseEntity {

	@Column(name = "name", length = 1000, nullable = false)
	private String name;

	@Column(name = "avatar", length = 200, nullable = true)
	private String avatar;

	@Column(name = "detail", columnDefinition = "LONGTEXT", nullable = false)
	private String detail;

	@Column(name = "short_description", length = 30000, nullable = false)
	private String description;

	@Column(name = "seo", length = 10000, nullable = true)
	private String seo;

	@Column(name = "is_hot", nullable = true)
	private Boolean isHot = Boolean.FALSE;

	@JsonIgnore
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "category_blog_id", referencedColumnName = "id")
	private CategoryBlog categoryBlog;

}
