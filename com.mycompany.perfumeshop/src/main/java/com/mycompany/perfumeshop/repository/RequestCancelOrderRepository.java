package com.mycompany.perfumeshop.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import com.mycompany.perfumeshop.entities.RequestCancelOrder;

@Repository
public interface RequestCancelOrderRepository
		extends JpaRepository<RequestCancelOrder, Integer>, JpaSpecificationExecutor<RequestCancelOrder> {

	Integer countByStatus(Boolean status);

	List<RequestCancelOrder> findTop3ByOrderByCreatedDateDesc();

	List<RequestCancelOrder> findByStatus(Boolean status);

	Page<RequestCancelOrder> findAll(Specification<RequestCancelOrder> spec, Pageable pageable);
}
