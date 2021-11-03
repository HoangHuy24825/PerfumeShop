package com.mycompany.perfumeshop.service;

import java.io.File;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.github.slugify.Slugify;
import com.mycompany.perfumeshop.dto.Constant;
import com.mycompany.perfumeshop.entities.Category;

@Service
public class CategoryService extends BaseService<Category> implements Constant {

	@Override
	protected Class<Category> clazz() {
		return Category.class;
	}

	@PersistenceContext
	private EntityManager entityManager;

	private boolean isEmptyUploadFile(MultipartFile image) {
		return image == null || image.getOriginalFilename().isEmpty();
	}

	@Transactional
	public Category save(Category category, MultipartFile avatar) throws Exception {
		if (!isEmptyUploadFile(avatar)) {
			avatar.transferTo(new File(UPLOAD_ROOT_PATH + "category/" + avatar.getOriginalFilename()));
			category.setAvatar("category/" + avatar.getOriginalFilename());
		}
		category.setSeo(new Slugify().slugify(category.getName()));
		category.setCreatedDate(Calendar.getInstance().getTime());
		return super.saveOrUpdate(category);
	}

	@Transactional
	public Category edit(Category category, MultipartFile avatar) throws Exception {

		Category oldCategory = super.getById(category.getId());

		if (!isEmptyUploadFile(avatar)) {
			new File(UPLOAD_ROOT_PATH + oldCategory.getAvatar()).delete();
			avatar.transferTo(new File(UPLOAD_ROOT_PATH + "category/" + avatar.getOriginalFilename()));
			category.setAvatar("category/" + avatar.getOriginalFilename());
		} else {
			category.setAvatar(oldCategory.getAvatar());
		}
		category.setSeo(new Slugify().slugify(category.getName()));
		category.setCreatedDate(oldCategory.getCreatedDate());
		category.setCreatedBy(oldCategory.getCreatedBy());
		category.setUpdatedDate(Calendar.getInstance().getTime());
		return super.saveOrUpdate(category);
	}

	public List<Category> getCategorySlider() {
		return executeNativeSql("SELECT * FROM electronicdeviceshop.tbl_category WHERE is_hot=1  LIMIT 5");
	}

	@Transactional
	public Boolean deleteCategoryById(Integer idCategory) {
		try {
			Category category = super.getById(idCategory);
			if (category.getProducts().size() == 0) {
				new File(UPLOAD_ROOT_PATH + category.getAvatar()).delete();
				super.delete(category);
				return true;
			}
			return false;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@SuppressWarnings("unchecked")
	public List<Category> getListCategoryByFilter(Integer page, Integer pageSize, String keySearch) {
		try {
			String sql = "SELECT * FROM electronicdeviceshop.tbl_category where 1=1 ";

			if (keySearch != "" && keySearch != null) {
				sql += " and ( name like '%" + keySearch + "%'";
				sql += " or seo like '%" + keySearch + "%' )";
			}

			sql += " ORDER BY updated_date DESC,created_date DESC";

			Query query = entityManager.createNativeQuery(sql, Category.class);
			query.setMaxResults(pageSize);
			query.setFirstResult((page - 1) * pageSize);
			return query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<Category>();
		}
	}

	public Integer getTotalPageCategoryByFilter(Integer pageSize, String keySearch) {
		try {
			String sql = "SELECT * FROM electronicdeviceshop.tbl_category where 1=1 ";

			if (keySearch != "" && keySearch != null) {
				sql += " and ( name like '%" + keySearch + "%'";
				sql += " or seo like '%" + keySearch + "%' )";
			}

			Query query = entityManager.createNativeQuery(sql, Category.class);
			Integer totalRecord = query.getResultList().size();
			return totalRecord % pageSize == 0 ? totalRecord / pageSize : totalRecord / pageSize + 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
}
