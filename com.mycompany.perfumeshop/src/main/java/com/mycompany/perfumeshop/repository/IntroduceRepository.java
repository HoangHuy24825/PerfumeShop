package com.mycompany.perfumeshop.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import com.mycompany.perfumeshop.entities.Introduce;

@Repository
public interface IntroduceRepository extends JpaRepository<Introduce, Integer>, JpaSpecificationExecutor<Introduce> {

	Introduce findBySeo(String seo);

	List<Introduce> findByStatus(Boolean status);

	Page<Introduce> findAll(Specification<Introduce> spec, Pageable pageable);
}
