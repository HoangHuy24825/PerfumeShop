package com.mycompany.perfumeshop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import com.mycompany.perfumeshop.entities.AttributeProduct;
import com.mycompany.perfumeshop.entities.OrderDetail;

@Repository
public interface OrderDetailRepository
		extends JpaRepository<OrderDetail, Integer>, JpaSpecificationExecutor<OrderDetail> {

	List<OrderDetail> findByAttributeProduct(AttributeProduct attributeProduct);

	List<OrderDetail> findByStatus(Boolean status);

}
