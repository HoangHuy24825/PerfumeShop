package com.mycompany.perfumeshop.service;

import java.io.File;
import java.util.Calendar;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.github.slugify.Slugify;
import com.mycompany.perfumeshop.conf.GlobalConfig;
import com.mycompany.perfumeshop.entities.Category;
import com.mycompany.perfumeshop.valueObjects.BaseVo;

@Service
public class CategoryService extends BaseService<Category> {

	@Autowired
	private GlobalConfig globalConfig;

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
			avatar.transferTo(new File(globalConfig.getUploadRootPath() + "category/" + avatar.getOriginalFilename()));
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
			new File(globalConfig.getUploadRootPath() + oldCategory.getAvatar()).delete();
			avatar.transferTo(new File(globalConfig.getUploadRootPath() + "category/" + avatar.getOriginalFilename()));
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

	@SuppressWarnings("unchecked")
	public List<Category> getCategorySlider() {
		return (List<Category>) entityManager.createQuery("FROM Category c WHERE c.isHot=1").setMaxResults(5);
	}

	@Transactional
	public Boolean deleteCategoryById(Integer idCategory) {
		try {
			Category category = super.getById(idCategory);
			if (category.getProducts().size() == 0) {
				new File(globalConfig.getUploadRootPath() + category.getAvatar()).delete();
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
	public BaseVo<Category> getListCategoryByFilter(Integer page, Integer pageSize, String keySearch) {
		try {
			String keySearchStr = "%" + keySearch + "%";
			CriteriaBuilder builder = entityManager.getCriteriaBuilder();
			CriteriaQuery<Category> criteriaQuery = builder.createQuery(Category.class);
			Root<Category> root = criteriaQuery.from(Category.class);
			criteriaQuery.select(root);

			if (keySearch != "" && keySearch != null) {
				criteriaQuery.where(builder.or(builder.like(root.get("seo"), keySearchStr),
						builder.like(root.get("name"), keySearchStr)));
			}

			criteriaQuery.orderBy(builder.desc(root.get("createdDate")), builder.desc(root.get("updatedDate")));
			Query query = entityManager.createQuery(criteriaQuery);

			int totalRecs = query.getResultList().size();
			int totalPage = totalRecs / pageSize;
			totalPage = totalRecs % pageSize == 0 ? totalPage : totalPage + 1;

			query.setMaxResults(pageSize);
			query.setFirstResult((page - 1) * pageSize);

			return new BaseVo<Category>(query.getResultList(), page, totalPage);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}
