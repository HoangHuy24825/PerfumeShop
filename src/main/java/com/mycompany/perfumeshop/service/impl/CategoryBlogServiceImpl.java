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
import com.mycompany.perfumeshop.entities.CategoryBlog;
import com.mycompany.perfumeshop.entities.User;
import com.mycompany.perfumeshop.repository.CategoryBlogRepository;
import com.mycompany.perfumeshop.service.CategoryBlogService;
import com.mycompany.perfumeshop.specification.CategoryBlogSpecification;
import com.mycompany.perfumeshop.utils.Constants;
import com.mycompany.perfumeshop.utils.Validate;
import com.mycompany.perfumeshop.valueObjects.UserRequest;

@Service
@Transactional
public class CategoryBlogServiceImpl implements CategoryBlogService {

	@Autowired
	private GlobalConfig globalConfig;

	@Autowired
	private CategoryBlogRepository categoryBlogRepository;

	@Autowired
	private CategoryBlogSpecification categoryBlogSpecification;

	@Override
	public CategoryBlog saveOrUpdate(CategoryBlog category, MultipartFile avatar, User userLogin) throws Exception {
		Integer idUserLogin = userLogin != null ? userLogin.getId() : null;
		category.setSeo(new Slugify().slugify(category.getName()));
		category.setUpdatedDate(Calendar.getInstance().getTime());
		category.setUpdatedBy(idUserLogin);
		if (category.getId() != null) {
			CategoryBlog oldCategory = categoryBlogRepository.findById(category.getId()).get();
			category.setCreatedDate(oldCategory.getCreatedDate());
			category.setCreatedBy(oldCategory.getCreatedBy());
			if (!Validate.isEmptyUploadFile(avatar)) {
				new File(globalConfig.getUploadRootPath() + oldCategory.getAvatar()).delete();
				avatar.transferTo(
						new File(globalConfig.getUploadRootPath() + "category/" + avatar.getOriginalFilename()));
				category.setAvatar("category/" + avatar.getOriginalFilename());
			} else {
				category.setAvatar(oldCategory.getAvatar());
			}
			category.setStatus(oldCategory.getStatus());
			category.setIsHot(oldCategory.getIsHot());
		} else {
			category.setCreatedDate(Calendar.getInstance().getTime());
			category.setCreatedBy(idUserLogin);
			if (!Validate.isEmptyUploadFile(avatar)) {
				avatar.transferTo(
						new File(globalConfig.getUploadRootPath() + "categoryBlog/" + avatar.getOriginalFilename()));
				category.setAvatar("categoryBlog/" + avatar.getOriginalFilename());
			}
		}
		return categoryBlogRepository.save(category);
	}

	public List<CategoryBlog> getCategorySlider() {
		return categoryBlogRepository.findTop5ByStatus(true);
	}

	@Override
	public Boolean deleteById(Integer idCategory) throws Exception {
		CategoryBlog categoryBlog = categoryBlogRepository.findById(idCategory).get();
		new File(globalConfig.getUploadRootPath() + categoryBlog.getAvatar()).delete();
		categoryBlogRepository.deleteById(idCategory);
		return true;
	}

	@Override
	public Page<CategoryBlog> findAllByUserRequest(UserRequest userRequest) throws Exception {
		if (userRequest.getKeySearch() == null) {
			userRequest.setKeySearch(Constants.STR_EMPTY);
		}
		Pageable pageable = PageRequest.of(userRequest.getCurrentPage() - 1, userRequest.getSizeOfPage(),
				Sort.by("createdDate", "updatedDate").descending());
		return categoryBlogRepository.findAll(categoryBlogSpecification.findByUserRequest(userRequest), pageable);
	}

	@Override
	public CategoryBlog findBySeo(String seo) throws Exception {
		if (seo == null || seo.trim() == "") {
			return null;
		}
		return categoryBlogRepository.findBySeo(seo);
	}

	@Override
	public Optional<CategoryBlog> findById(String id) throws Exception {
		if (id == null || id.trim() == "") {
			return null;
		}
		return categoryBlogRepository.findById(Integer.parseInt(id));
	}

	@Override
	public List<CategoryBlog> findByStatus(Boolean status) throws Exception {
		if (status == null) {
			return categoryBlogRepository.findAll();
		}
		return categoryBlogRepository.findByStatus(status);
	}

}
