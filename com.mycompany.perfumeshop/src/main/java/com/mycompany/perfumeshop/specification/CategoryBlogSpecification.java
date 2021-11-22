package com.mycompany.perfumeshop.specification;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.criteria.Predicate;

import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;

import com.mycompany.perfumeshop.entities.CategoryBlog;
import com.mycompany.perfumeshop.request.UserRequest;

@Component
public class CategoryBlogSpecification {

	public Specification<CategoryBlog> findByUserRequest(UserRequest userRequest) {
		return (root, query, builder) -> {
			String keySearchLike = new StringBuilder("%").append(userRequest.getKeySearch()).append("%").toString();
			List<Predicate> predicates = new ArrayList<>();
			if (userRequest.getStatus() != null) {
				predicates.add(builder.equal(root.get("status"), userRequest.getStatus()));
			}
			predicates.add(builder.or(builder.like(root.get("name"), keySearchLike),
					builder.like(root.get("seo"), keySearchLike)));
			return builder.and(predicates.toArray(new Predicate[] {}));
		};
	}

}
