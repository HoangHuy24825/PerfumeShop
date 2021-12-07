package com.mycompany.perfumeshop.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import com.mycompany.perfumeshop.entities.AttributeProduct;
import com.mycompany.perfumeshop.entities.Product;

@Repository
public interface AttributeProductRepository
		extends JpaRepository<AttributeProduct, Integer>, JpaSpecificationExecutor<AttributeProduct> {

	List<AttributeProduct> findByProduct(Product product);

	List<AttributeProduct> findByStatus(Boolean status);

	Page<AttributeProduct> findAll(Specification<AttributeProduct> spec, Pageable pageable);

}
