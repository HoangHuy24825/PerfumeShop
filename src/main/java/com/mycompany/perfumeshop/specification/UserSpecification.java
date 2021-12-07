package com.mycompany.perfumeshop.specification;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.criteria.Join;
import javax.persistence.criteria.Predicate;

import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;

import com.mycompany.perfumeshop.entities.Role;
import com.mycompany.perfumeshop.entities.User;
import com.mycompany.perfumeshop.entities.UserRole;
import com.mycompany.perfumeshop.valueObjects.AdminRequest;

@Component
public class UserSpecification {

	public Specification<User> findByRole(AdminRequest adminRequest) {
		return (root, query, builder) -> {
			Join<User, UserRole> rootUserRole = root.join("userRoles");
			Join<UserRole, Role> finalRoot = rootUserRole.join("role");
			List<Predicate> predicates = new ArrayList<Predicate>();
			predicates.add(builder.notEqual(root.get("id"), adminRequest.getCurrentId()));
			if (adminRequest.getRole() == 0) {
				predicates.add(builder.notEqual(finalRoot.get("code"), "G"));
				predicates.add(builder.notEqual(root.get("username"), "admin"));
			} else {
				predicates.add(builder.equal(finalRoot.get("code"), "G"));
			}
			query.distinct(true);
			return builder.and(predicates.toArray(new Predicate[] {}));
		};
	}
}
