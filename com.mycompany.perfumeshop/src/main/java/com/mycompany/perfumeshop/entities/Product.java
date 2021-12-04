package com.mycompany.perfumeshop.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "tbl_products")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Product extends BaseEntity {

	@Column(name = "title", length = 1000, nullable = false)
	private String title;

	@Column(name = "short_description", length = 30000, nullable = false)
	private String description;

	@Column(name = "detail_description", columnDefinition = "LONGTEXT", nullable = false)
	private String detail;

	@Column(name = "avatar", length = 200, nullable = true)
	private String avatar;

	@Column(name = "trademark", length = 200, nullable = false)
	private String trademark;

	@Column(name = "origin", length = 200, nullable = false)
	private String origin;

	@Column(name = "manufacture_year", nullable = false)
	private Integer manufactureYear;

	@Column(name = "seo", length = 10000, nullable = true)
	private String seo;

	@Column(name = "fragrant", length = 255, nullable = false)
	private String fragrant;

	@Column(name = "is_hot", nullable = true)
	private Boolean isHot = Boolean.FALSE;

	@JsonIgnore
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "category_id")
	private Category category;

	@OneToMany(cascade = CascadeType.ALL, mappedBy = "product")
	private List<ProductImage> productImages = new ArrayList<>();

	public void addImage(ProductImage image) {
		productImages.add(image);
		image.setProduct(this);
	}

	public void removeImage(ProductImage image) {
		productImages.remove(image);
		image.setProduct(null);
	}

	@OneToMany(cascade = CascadeType.ALL, mappedBy = "product")
	private List<AttributeProduct> attributeProducts = new ArrayList<>();

	public void addAttribute(AttributeProduct attributeProduct) {
		attributeProducts.add(attributeProduct);
		attributeProduct.setProduct(this);
	}

	public void removeAttribute(AttributeProduct attributeProduct) {
		attributeProducts.remove(attributeProduct);
		attributeProduct.setProduct(null);
	}

	@OneToMany(cascade = CascadeType.ALL, mappedBy = "product")
	private List<Review> reviews = new ArrayList<>();

	public void addReview(Review review) {
		reviews.add(review);
		review.setProduct(this);
	}

	public void removeReview(Review review) {
		reviews.remove(review);
		review.setProduct(null);
	}

	public Product(Integer id) {
		super(id);
	}

}
