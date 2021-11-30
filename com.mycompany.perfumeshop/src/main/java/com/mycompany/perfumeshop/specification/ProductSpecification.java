package com.mycompany.perfumeshop.specification;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.criteria.Predicate;

import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;

import com.mycompany.perfumeshop.entities.Product;
import com.mycompany.perfumeshop.valueObjects.UserRequestToProduct;

@Component
public class ProductSpecification {

	public Specification<Product> findByUserRequestToProduct(UserRequestToProduct request) {
		return (root, query, builder) -> {
			List<Predicate> predicates = new ArrayList<>();
			if (request.getKeySearch() != null) {
				String keySearch = new StringBuilder("%").append(request.getKeySearch()).append("%").toString();
				predicates.add(builder.or(builder.like(root.get("seo"), keySearch),
						builder.like(root.get("title"), keySearch)));
			}
			if (request.getStatus() != null) {
				predicates.add(builder.equal(root.get("status"), request.getStatus()));
			}
			if (request.getIdCategory() != null && request.getIdCategory() != 0) {
				predicates.add(builder.equal(root.get("category").get("id"), request.getIdCategory()));
			}
			return builder.and(predicates.toArray(new Predicate[] {}));
		};
	}

}
