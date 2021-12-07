package com.mycompany.perfumeshop.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import com.mycompany.perfumeshop.entities.Order;
import com.mycompany.perfumeshop.entities.OrderDetail;

@Repository
public interface DetailOrderRepository
		extends JpaRepository<OrderDetail, Integer>, JpaSpecificationExecutor<OrderDetail> {

	List<OrderDetail> findByOrder(Order order);

	List<OrderDetail> findByStatus(Boolean status);

	Page<OrderDetail> findAll(Specification<OrderDetail> spec, Pageable pageable);

}
