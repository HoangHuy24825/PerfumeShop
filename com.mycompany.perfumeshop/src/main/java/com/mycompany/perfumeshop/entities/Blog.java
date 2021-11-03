package com.mycompany.perfumeshop.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "tbl_blog")
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

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "category_blog_id")
	private CategoryBlog categoryBlog;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getSeo() {
		return seo;
	}

	public void setSeo(String seo) {
		this.seo = seo;
	}

	public Boolean getIsHot() {
		return isHot;
	}

	public void setIsHot(Boolean isHot) {
		this.isHot = isHot;
	}

	public CategoryBlog getCategoryBlog() {
		return categoryBlog;
	}

	public void setCategoryBlog(CategoryBlog categoryBlog) {
		this.categoryBlog = categoryBlog;
	}

}
