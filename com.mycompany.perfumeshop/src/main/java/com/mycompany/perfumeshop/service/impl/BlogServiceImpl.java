package com.mycompany.perfumeshop.service.impl;

import java.io.File;
import java.util.Calendar;
import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.github.slugify.Slugify;
import com.mycompany.perfumeshop.conf.GlobalConfig;
import com.mycompany.perfumeshop.entities.Blog;
import com.mycompany.perfumeshop.repository.BlogRepository;
import com.mycompany.perfumeshop.request.UserRequest;
import com.mycompany.perfumeshop.service.BlogService;
import com.mycompany.perfumeshop.specification.BlogSpecification;
import com.mycompany.perfumeshop.utils.Constants;
import com.mycompany.perfumeshop.utils.Validate;

@Service
@Transactional
public class BlogServiceImpl implements BlogService {

	@Autowired
	private GlobalConfig globalConfig;

	@Autowired
	private BlogRepository blogRepository;

	@Autowired
	private BlogSpecification blogSprecification;

	@Override
	public Blog saveOrUpdate(Blog blog, MultipartFile avatar, Integer idUserLogin) throws Exception {
		blog.setSeo(new Slugify().slugify(blog.getName()));
		blog.setUpdatedDate(Calendar.getInstance().getTime());
		blog.setUpdatedBy(idUserLogin);
		if (blog.getId() != null) {
			Blog oldBlog = blogRepository.getOne(blog.getId());
			blog.setCreatedDate(oldBlog.getCreatedDate());
			blog.setCreatedBy(oldBlog.getCreatedBy());
			if (!Validate.isEmptyUploadFile(avatar)) {
				new File(globalConfig.getUploadRootPath() + oldBlog.getAvatar()).delete();
				avatar.transferTo(new File(globalConfig.getUploadRootPath() + "blog/" + avatar.getOriginalFilename()));
				blog.setAvatar("blog/" + avatar.getOriginalFilename());
			} else {
				blog.setAvatar(oldBlog.getAvatar());
			}
		} else {
			blog.setCreatedDate(Calendar.getInstance().getTime());
			blog.setCreatedBy(idUserLogin);
			if (!Validate.isEmptyUploadFile(avatar)) {
				avatar.transferTo(new File(globalConfig.getUploadRootPath() + "blog/" + avatar.getOriginalFilename()));
				blog.setAvatar("blog/" + avatar.getOriginalFilename());
			}
		}
		return blogRepository.save(blog);
	}

	@Override
	public Boolean deleteById(String idBlog) throws Exception {
		if (!Validate.isNumber(idBlog)) {
			return false;
		}
		Blog blog = blogRepository.getOne(Integer.parseInt(idBlog));
		new File(globalConfig.getUploadRootPath() + blog.getAvatar()).delete();
		blogRepository.delete(blog);
		return true;
	}

	@Override
	public Page<Blog> getListBlogByFilter(UserRequest userRequest) throws Exception {
		if (userRequest.getKeySearch() == null) {
			userRequest.setKeySearch(Constants.STR_EMPTY);
		}
		Pageable pageable = PageRequest.of(userRequest.getCurrentPage() - 1, userRequest.getSizeOfPage(),
				Sort.by("createdDate").descending().and(Sort.by("updatedDate").descending()));
		return blogRepository.findAll(blogSprecification.findBlog(userRequest), pageable);
	}

	@Override
	public List<Blog> getRecentPost() throws Exception {
		return blogRepository.findTop5ByOrderByCreatedDateDescUpdatedDateDesc();
	}

	@Override
	public Blog findBySeo(String seo) throws Exception {
		if (seo == null || seo.trim() == Constants.STR_EMPTY) {
			return null;
		}
		return blogRepository.findBySeo(seo);
	}

	@Override
	public List<Blog> findByStatus(Boolean status) throws Exception {
		if (status == null) {
			return blogRepository.findAll();
		}
		return blogRepository.findByStatus(status);
	}

	@Override
	public Optional<Blog> findById(String id) throws Exception {
		if (!Validate.isNumber(id)) {
			return null;
		}
		return blogRepository.findById(Integer.parseInt(id));
	}

}
