package com.mycompany.perfumeshop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.web.multipart.MultipartFile;

import com.mycompany.perfumeshop.entities.CategoryBlog;
import com.mycompany.perfumeshop.request.UserRequest;

public interface CategoryBlogService {

	CategoryBlog saveOrUpdate(CategoryBlog category, MultipartFile avatar, Integer idUserLogin) throws Exception;

	List<CategoryBlog> getCategorySlider() throws Exception;

	Page<CategoryBlog> findAllByUserRequest(UserRequest userRequest) throws Exception;

	CategoryBlog findBySeo(String seo) throws Exception;

	Optional<CategoryBlog> findById(String id) throws Exception;

	Boolean deleteById(Integer idCategory) throws Exception;
	
	List<CategoryBlog> findByStatus(Boolean status) throws Exception;
}
