package com.mycompany.perfumeshop.entities;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "tbl_category_blog")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class CategoryBlog extends BaseEntity {

	@Column(name = "name", length = 1000, nullable = false)
	private String name;

	@Column(name = "avatar", length = 200, nullable = true)
	private String avatar;

	@Column(name = "seo", length = 10000, nullable = true)
	private String seo;

	@Column(name = "is_hot", nullable = true)
	private Boolean isHot = Boolean.FALSE;

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "categoryBlog")
	private Set<Blog> blogs = new HashSet<>();

	public void addProduct(Blog blog) {
		blogs.add(blog);
		blog.setCategoryBlog(this);
	}

	public void removeProduct(Blog blog) {
		blogs.remove(blog);
		blog.setCategoryBlog(null);
	}

}
