package com.mycompany.perfumeshop.dto;

import org.springframework.web.multipart.MultipartFile;

public class CategoryBlogDTO extends BaseDTO {
	private String name;
	private MultipartFile avatar;
	private String seo;
	private Boolean isHot = Boolean.FALSE;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public MultipartFile getAvatar() {
		return avatar;
	}

	public void setAvatar(MultipartFile avatar) {
		this.avatar = avatar;
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

}
