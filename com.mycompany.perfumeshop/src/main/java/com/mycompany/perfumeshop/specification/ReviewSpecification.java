package com.mycompany.perfumeshop.specification;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.criteria.Join;
import javax.persistence.criteria.Predicate;

import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;

import com.mycompany.perfumeshop.entities.Product;
import com.mycompany.perfumeshop.entities.Review;
import com.mycompany.perfumeshop.utils.Validate;

@Component
public class ReviewSpecification {
	public Specification<Review> findAll(String keySearch, Integer status) {
		return (root, query, builder) -> {
			Join<Review, Product> joinReviewProduct = root.join("product");
			List<Predicate> predicates = new ArrayList<>();
			if (!Validate.isNullOrEmptyString(keySearch)) {
				String keySearchVal = "%" + keySearch + "%";
				predicates.add(builder.or(builder.like(root.get("customerName"), keySearchVal),
						builder.like(joinReviewProduct.get("title"), keySearchVal),
						builder.like(root.get("content"), keySearchVal)));
			}
			if (status != null) {
				switch (status) {
				case 0:
					predicates.add(builder.equal(root.get("status"), Boolean.FALSE));
					break;
				case 1:
					predicates.add(builder.equal(root.get("status"), Boolean.TRUE));
					break;
				case 2:
					predicates.add(builder.equal(root.get("isHide"), Boolean.TRUE));
					break;
				}
			}
			return builder.and(predicates.toArray(new Predicate[] {}));
		};
	}
}
