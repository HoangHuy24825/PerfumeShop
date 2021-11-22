package com.mycompany.perfumeshop.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import com.mycompany.perfumeshop.entities.CategoryBlog;

@Repository
public interface CategoryBlogRepository
		extends JpaRepository<CategoryBlog, Integer>, JpaSpecificationExecutor<CategoryBlog> {

	List<CategoryBlog> findTop5ByStatus(Boolean status);

	CategoryBlog findBySeo(String seo);

	Page<CategoryBlog> findAll(Specification<CategoryBlog> spec, Pageable pageable);
	
	List<CategoryBlog> findByStatus(Boolean status);
}
