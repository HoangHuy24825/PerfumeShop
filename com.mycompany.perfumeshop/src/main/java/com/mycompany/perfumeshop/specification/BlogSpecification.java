package com.mycompany.perfumeshop.specification;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.criteria.Predicate;

import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;

import com.mycompany.perfumeshop.entities.Blog;
import com.mycompany.perfumeshop.valueObjects.UserRequest;

@Component
public class BlogSpecification {

	public Specification<Blog> findBlog(UserRequest userRequest) {
		return (root, query, builder) -> {
			String keySearchLike = new StringBuilder("%").append(userRequest.getKeySearch()).append("%").toString();
			List<Predicate> predicates = new ArrayList<>();
			if (userRequest.getIdParent() != null) {
				predicates.add(builder.equal(root.get("categoryBlog").get("id"), userRequest.getIdParent()));
			}
			if (userRequest.getStatus() != null) {
				predicates.add(builder.equal(root.get("status"), userRequest.getStatus()));
			}
			predicates.add(builder.or(builder.like(root.get("name"), keySearchLike),
					builder.like(root.get("seo"), keySearchLike),
					builder.like(root.get("description"), keySearchLike)));
			return builder.and(predicates.toArray(new Predicate[] {}));
		};
	}

}
