package com.mycompany.perfumeshop.service.impl;

import java.io.File;
import java.util.Calendar;
import java.util.List;

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
import com.mycompany.perfumeshop.entities.Category;
import com.mycompany.perfumeshop.entities.User;
import com.mycompany.perfumeshop.exceptions.EntityNotFoundCustomException;
import com.mycompany.perfumeshop.repository.CategoryRepository;
import com.mycompany.perfumeshop.service.CategoryService;
import com.mycompany.perfumeshop.specification.CategorySpecification;
import com.mycompany.perfumeshop.utils.Constants;
import com.mycompany.perfumeshop.utils.Validate;
import com.mycompany.perfumeshop.valueObjects.UserRequest;

@Service
@Transactional
public class CategoryServiceImpl implements CategoryService {

	@Autowired
	private GlobalConfig globalConfig;

	@Autowired
	private CategoryRepository categoryRepository;

	@Autowired
	private CategorySpecification categorySpecification;

	@Override
	public Category saveOrUpdate(Category category, MultipartFile avatar, User userLogin) throws Exception {
		Integer idUserLogin = userLogin != null ? userLogin.getId() : null;
		category.setUpdatedDate(Calendar.getInstance().getTime());
		category.setSeo(new Slugify().slugify(category.getName()));
		category.setUpdatedBy(idUserLogin);
		if (category.getId() != null) {
			Category oldCategory = categoryRepository.findById(category.getId()).get();
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
		} else {
			category.setCreatedDate(Calendar.getInstance().getTime());
			category.setCreatedBy(idUserLogin);
			if (!Validate.isEmptyUploadFile(avatar)) {
				avatar.transferTo(
						new File(globalConfig.getUploadRootPath() + "category/" + avatar.getOriginalFilename()));
				category.setAvatar("category/" + avatar.getOriginalFilename());
			}
		}
		return categoryRepository.save(category);
	}

	public List<Category> getCategorySlider() {
		return categoryRepository.findTop5ByStatus(true);
	}

	@Override
	public Page<Category> findAllByUserRequest(UserRequest userRequest) throws Exception {
		if (userRequest.getKeySearch() == null) {
			userRequest.setKeySearch(Constants.STR_EMPTY);
		}
		Pageable pageable = PageRequest.of(userRequest.getCurrentPage() - 1, userRequest.getSizeOfPage(),
				Sort.by("createdDate", "updatedDate").descending());
		return categoryRepository.findAll(categorySpecification.findAllByUserRequest(userRequest), pageable);
	}

	@Override
	public Boolean deleteById(Integer id) throws Exception {
		Category category = categoryRepository.findById(id)
				.orElseThrow(() -> new EntityNotFoundCustomException("Not found category has id: " + id));
		new File(globalConfig.getUploadRootPath() + category.getAvatar()).delete();
		categoryRepository.delete(category);
		return true;
	}

	@Override
	public Category findBySeo(String seo) throws Exception {
		if (seo == null || seo.trim() == "") {
			return null;
		}
		return categoryRepository.findBySeo(seo);
	}

	@Override
	public List<Category> findByStatus(Boolean status) throws Exception {
		if (status == null) {
			return categoryRepository.findAll();
		}
		return categoryRepository.findByStatus(status);
	}

	@Override
	public Category findById(Integer id) throws Exception {
		return categoryRepository.findById(id)
				.orElseThrow(() -> new EntityNotFoundCustomException("Not found category"));
	}

}
