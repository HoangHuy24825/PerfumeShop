package com.mycompany.perfumeshop.dto;

import org.springframework.web.multipart.MultipartFile;

public class BlogDTO extends BaseDTO {
	private String name;
	private String detail;
	private String description;
	private String seo;
	private Boolean isHot = Boolean.FALSE;
	private Integer id_category_blog;
	private MultipartFile avatar;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public Integer getId_category_blog() {
		return id_category_blog;
	}

	public void setId_category_blog(Integer id_category_blog) {
		this.id_category_blog = id_category_blog;
	}

	public MultipartFile getAvatar() {
		return avatar;
	}

	public void setAvatar(MultipartFile avatar) {
		this.avatar = avatar;
	}

}
