package com.mycompany.perfumeshop.specification;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.criteria.Predicate;

import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;

import com.mycompany.perfumeshop.entities.Contact;

@Component
public class ContactSpecification {

	public Specification<Contact> finAll(String keySearch) {
		return (root, query, builder) -> {
			List<Predicate> predicates = new ArrayList<>();
			if (keySearch != null && keySearch.trim() != "") {
				predicates.add(builder.or(builder.like(root.get("subject"), keySearch),
						builder.like(root.get("customerName"), keySearch)));
			}
			return builder.and(predicates.toArray(new Predicate[] {}));
		};
	}
}
