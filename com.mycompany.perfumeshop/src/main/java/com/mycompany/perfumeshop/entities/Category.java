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
@Table(name = "tbl_category")
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class Category extends BaseEntity {

	@Column(name = "name", length = 100, nullable = false)
	private String name;

	@Column(name = "description", length = 100, nullable = false)
	private String description;

	@Column(name = "seo", length = 10000, nullable = true)
	private String seo;

	@Column(name = "avatar", length = 200, nullable = true)
	private String avatar;

	@Column(name = "is_hot", nullable = true)
	private Boolean isHot = Boolean.FALSE;

	/*
	 * @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy =
	 * "parent") private Set<Category> categories = new HashSet<>();
	 */

	/*
	 * @ManyToOne(fetch = FetchType.EAGER)
	 * 
	 * @JoinColumn(name = "parent_id") private Category parent;
	 */

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "category")
	private Set<Product> products = new HashSet<>();

	/*
	 * public void addCategory(Category category) { categories.add(category);
	 * category.setParent(this); }
	 */

	/*
	 * public void removeCategory(Category category) { categories.remove(category);
	 * category.setCategories(null); }
	 */

	public void addProduct(Product product) {
		products.add(product);
		product.setCategory(this);
	}

	public void removeProduct(Product product) {
		products.remove(product);
		product.setCategory(null);
	}

}
