package com.mycompany.perfumeshop.service;

import java.io.File;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.github.slugify.Slugify;
import com.mycompany.perfumeshop.dto.Constant;
import com.mycompany.perfumeshop.entities.CategoryBlog;

@Service
public class CategoryBlogService extends BaseService<CategoryBlog> implements Constant {

	@Override
	protected Class<CategoryBlog> clazz() {
		return CategoryBlog.class;
	}

	@PersistenceContext
	private EntityManager entityManager;

	private boolean isEmptyUploadFile(MultipartFile image) {
		return image == null || image.getOriginalFilename().isEmpty();
	}

	@Transactional
	public CategoryBlog save(CategoryBlog category, MultipartFile avatar) throws Exception {
		if (!isEmptyUploadFile(avatar)) {
			avatar.transferTo(new File(UPLOAD_ROOT_PATH + "categoryBlog/" + avatar.getOriginalFilename()));
			category.setAvatar("categoryBlog/" + avatar.getOriginalFilename());
		}
		category.setSeo(new Slugify().slugify(category.getName()));
		category.setCreatedDate(Calendar.getInstance().getTime());
		return super.saveOrUpdate(category);
	}

	@Transactional
	public CategoryBlog edit(CategoryBlog category, MultipartFile avatar) throws Exception {

		CategoryBlog oldCategory = super.getById(category.getId());

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

	public List<CategoryBlog> getCategorySlider() {
		return entityManager.createQuery("FROM CategoryBlog cb WHERE cb.isHot=1", CategoryBlog.class).setMaxResults(5)
				.getResultList();
	}

	@Transactional
	public Boolean deleteCategoryById(Integer idCategory) {
		try {
			CategoryBlog category = super.getById(idCategory);
			if (category.getBlogs().size() == 0) {
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
	public List<CategoryBlog> getListCategoryByFilter(Integer page, Integer pageSize, String keySearch) {
		try {
			StringBuilder keySearchPatern = new StringBuilder("%");
			keySearchPatern.append(keySearch);
			keySearchPatern.append("%");

			CriteriaBuilder builder = entityManager.getCriteriaBuilder();
			CriteriaQuery<CategoryBlog> criteriaQuery = builder.createQuery(CategoryBlog.class);
			Root<CategoryBlog> root = criteriaQuery.from(CategoryBlog.class);
			criteriaQuery.select(root);
			List<Predicate> predicates = new ArrayList<>();
			if (keySearch != "" && keySearch != null) {
				predicates.add(builder.or(builder.like(root.get("name"), keySearchPatern.toString()),
						builder.like(root.get("seo"), keySearchPatern.toString())));
			}

			criteriaQuery.orderBy(builder.desc(root.get("createdDate")), builder.desc(root.get("updatedDate")));
			Query query = entityManager.createQuery(criteriaQuery);
			query.setMaxResults(pageSize);
			query.setFirstResult((page - 1) * pageSize);
			return query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<CategoryBlog>();
		}
	}

	public Long getTotalPageCategoryByFilter(Integer pageSize, String keySearch) {
		try {
			StringBuilder keySearchPatern = new StringBuilder("%");
			keySearchPatern.append(keySearch);
			keySearchPatern.append("%");

			CriteriaBuilder builder = entityManager.getCriteriaBuilder();
			CriteriaQuery<Long> criteriaQuery = builder.createQuery(Long.class);
			Root<CategoryBlog> root = criteriaQuery.from(CategoryBlog.class);
			criteriaQuery.select(builder.count(root));
			List<Predicate> predicates = new ArrayList<>();
			if (keySearch != "" && keySearch != null) {
				predicates.add(builder.or(builder.like(root.get("name"), keySearchPatern.toString()),
						builder.like(root.get("seo"), keySearchPatern.toString())));
			}

			criteriaQuery.orderBy(builder.desc(root.get("createdDate")), builder.desc(root.get("updatedDate")));
			Long totalRecord = entityManager.createQuery(criteriaQuery).getSingleResult();
			return totalRecord % pageSize == 0 ? totalRecord / pageSize : totalRecord / pageSize + 1;
		} catch (Exception e) {
			e.printStackTrace();
			return (long) 0;
		}
	}

}
