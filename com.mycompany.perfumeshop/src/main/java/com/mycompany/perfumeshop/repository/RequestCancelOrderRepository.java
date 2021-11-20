package com.mycompany.perfumeshop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mycompany.perfumeshop.entities.RequestCancelOrder;

@Repository
public interface RequestCancelOrderRepository extends JpaRepository<RequestCancelOrder, Integer> {

	Integer countByStatus(Boolean status);

	List<RequestCancelOrder> findByStatus(Boolean status);

	List<RequestCancelOrder> findTop3ByOrderByCreatedDateDesc();
}
