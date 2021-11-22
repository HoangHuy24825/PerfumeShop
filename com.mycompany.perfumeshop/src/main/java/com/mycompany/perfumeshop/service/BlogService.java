package com.mycompany.perfumeshop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.web.multipart.MultipartFile;

import com.mycompany.perfumeshop.entities.Blog;
import com.mycompany.perfumeshop.request.UserRequest;

public interface BlogService {

	Boolean deleteById(String idBlog) throws Exception;

	Page<Blog> getListBlogByFilter(UserRequest userRequest) throws Exception;

	List<Blog> getRecentPost() throws Exception;

	Blog findBySeo(String seo) throws Exception;

	Optional<Blog> findById(String id) throws Exception;

	List<Blog> findByStatus(Boolean status) throws Exception;

	Blog saveOrUpdate(Blog blog, MultipartFile avatar, Integer idUserLogin) throws Exception;

}
