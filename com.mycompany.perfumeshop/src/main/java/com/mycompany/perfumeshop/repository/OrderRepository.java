package com.mycompany.perfumeshop.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import com.mycompany.perfumeshop.entities.Order;

@Repository
public interface OrderRepository extends JpaRepository<Order, Integer>, JpaSpecificationExecutor<Order> {

	List<Order> findByUserIDOrderByCreatedDateDescUpdatedDateDesc(Integer userID);

	Order findBySeo(String seo);

	List<Order> findByStatusOrderByCreatedDateDescUpdatedDateDesc(Boolean status);

	Page<Order> findAll(Specification<Order> spec, Pageable pageable);

	List<Order> findByCustomerEmailAndCustomerPhoneAndCustomerNameOrderByCreatedDateDescUpdatedDateDesc(String email,
			String phone, String name);
}
