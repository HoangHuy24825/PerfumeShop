package com.mycompany.perfumeshop.specification;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.criteria.Predicate;

import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;

import com.mycompany.perfumeshop.entities.Order;
import com.mycompany.perfumeshop.valueObjects.CustomerOrder;

@Component
public class OrderSpecification {

	public Specification<Order> findByCustomerOrder(CustomerOrder customerOrder) {
		return (root, query, builder) -> {
			List<Predicate> predicates = new ArrayList<Predicate>();
			predicates.add(builder.equal(root.get("customerName"), customerOrder.getName()));
			predicates.add(builder.equal(root.get("customerPhone"), customerOrder.getPhone()));
			predicates.add(builder.equal(root.get("customerEmail"), customerOrder.getEmail()));
			if (customerOrder.getAddress() != null) {
				predicates.add(builder.equal(root.get("customerAddress"), customerOrder.getAddress()));
			}
			return builder.and(predicates.toArray(new Predicate[] {}));
		};
	}

	public Specification<Order> findByProcessStatus(Integer statusProcess) {
		return (root, query, builder) -> {
			if (statusProcess != 1 && statusProcess != 2) {
				return builder.equal(root.get("processingStatus"), statusProcess);
			} else {
				return builder.or(builder.equal(root.get("processingStatus"), 1),
						builder.equal(root.get("processingStatus"), 2));
			}
		};
	}

}
