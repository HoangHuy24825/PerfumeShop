package com.mycompany.perfumeshop.specification;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.criteria.Predicate;

import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;

import com.mycompany.perfumeshop.entities.Category;
import com.mycompany.perfumeshop.valueObjects.UserRequest;

@Component
public class CategorySpecification {

	public Specification<Category> findAllByUserRequest(UserRequest userRequest) {
		return (root, query, builder) -> {
			List<Predicate> predicates = new ArrayList<>();
			String keySearch = new StringBuilder("%").append(userRequest.getKeySearch()).append("%").toString();
			predicates.add(
					builder.or(builder.like(root.get("seo"), keySearch), builder.like(root.get("name"), keySearch)));
			if (userRequest.getStatus() != null) {
				predicates.add(builder.equal(root.get("status"), userRequest.getStatus()));
			}

			return builder.and(predicates.toArray(new Predicate[] {}));
		};
	}

}
