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
import com.mycompany.perfumeshop.dto.SearchObject;
import com.mycompany.perfumeshop.entities.Blog;

@Service
public class BlogService extends BaseService<Blog> implements Constant {

	@Override
	protected Class<Blog> clazz() {
		return Blog.class;
	}

	@PersistenceContext
	private EntityManager entityManager;

	private boolean isEmptyUploadFile(MultipartFile image) {
		return image == null || image.getOriginalFilename().isEmpty();
	}

	@Transactional
	public Blog save(Blog blog, MultipartFile avatar) throws Exception {
		if (!isEmptyUploadFile(avatar)) {
			avatar.transferTo(new File(UPLOAD_ROOT_PATH + "blog/" + avatar.getOriginalFilename()));
			blog.setAvatar("blog/" + avatar.getOriginalFilename());
		}
		blog.setSeo(new Slugify().slugify(blog.getName()));
		blog.setCreatedDate(Calendar.getInstance().getTime());
		return super.saveOrUpdate(blog);
	}

	@Transactional
	public Blog edit(Blog blog, MultipartFile avatar) throws Exception {
		Blog oldBlog = super.getById(blog.getId());
		if (!isEmptyUploadFile(avatar)) {
			new File(UPLOAD_ROOT_PATH + oldBlog.getAvatar()).delete();
			avatar.transferTo(new File(UPLOAD_ROOT_PATH + "blog/" + avatar.getOriginalFilename()));
			blog.setAvatar("blog/" + avatar.getOriginalFilename());
		} else {
			blog.setAvatar(oldBlog.getAvatar());
		}
		blog.setSeo(new Slugify().slugify(blog.getName()));
		blog.setCreatedDate(oldBlog.getCreatedDate());
		blog.setCreatedBy(oldBlog.getCreatedBy());
		blog.setUpdatedDate(Calendar.getInstance().getTime());
		return super.saveOrUpdate(blog);
	}

	public List<Blog> getCategorySlider() {
		return entityManager.createQuery("FROM Blog b WHERE b.isHot=1", Blog.class).setMaxResults(5).getResultList();
	}

	@Transactional
	public Boolean deleteBlogById(Integer idBlog) {
		try {
			Blog blog = super.getById(idBlog);
			new File(UPLOAD_ROOT_PATH + blog.getAvatar()).delete();
			entityManager.createQuery("DELETE FROM Blog b WHERE b.id=:blogID").setParameter("blogID", idBlog)
					.executeUpdate();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@SuppressWarnings("unchecked")
	public List<Blog> getListBlogByFilter(Integer page, Integer pageSize, SearchObject searchObject) {
		try {
			StringBuilder keySearchPatern = new StringBuilder("%");
			keySearchPatern.append(searchObject.getKeySearch());
			keySearchPatern.append("%");

			CriteriaBuilder builder = entityManager.getCriteriaBuilder();
			CriteriaQuery<Blog> criteriaQuery = builder.createQuery(Blog.class);
			Root<Blog> root = criteriaQuery.from(Blog.class);
			criteriaQuery.select(root);
			List<Predicate> predicates = new ArrayList<>();
			if (searchObject.getKeySearch() != "" && searchObject.getKeySearch() != null) {
				predicates.add(builder.or(builder.like(root.get("name"), keySearchPatern.toString()),
						builder.like(root.get("seo"), keySearchPatern.toString())));
			}
			if (searchObject.getIdCategory() != 0) {
				predicates.add(builder.equal(root.get("categoryBlog").get("id"), searchObject.getIdCategory()));
			}
			criteriaQuery.orderBy(builder.desc(root.get("isHot")), builder.desc(root.get("createdDate")),
					builder.desc(root.get("updatedDate")));
			Query query = entityManager.createQuery(criteriaQuery);
			query.setMaxResults(pageSize);
			query.setFirstResult((page - 1) * pageSize);
			return query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<Blog>();
		}
	}

	public Long getTotalPageBlogByFilter(Integer pageSize, SearchObject searchObject) {
		try {
			StringBuilder keySearchPatern = new StringBuilder("%");
			keySearchPatern.append(searchObject.getKeySearch());
			keySearchPatern.append("%");

			CriteriaBuilder builder = entityManager.getCriteriaBuilder();
			CriteriaQuery<Long> criteriaQuery = builder.createQuery(Long.class);
			Root<Blog> root = criteriaQuery.from(Blog.class);
			criteriaQuery.select(builder.count(root));
			List<Predicate> predicates = new ArrayList<>();
			if (searchObject.getKeySearch() != "" && searchObject.getKeySearch() != null) {
				predicates.add(builder.or(builder.like(root.get("name"), keySearchPatern.toString()),
						builder.like(root.get("seo"), keySearchPatern.toString())));
			}
			if (searchObject.getIdCategory() != 0) {
				predicates.add(builder.equal(root.get("categoryBlog").get("id"), searchObject.getIdCategory()));
			}
			Long totalRecord = entityManager.createQuery(criteriaQuery).getSingleResult();
			return totalRecord % pageSize == 0 ? totalRecord / pageSize : totalRecord / pageSize + 1;
		} catch (Exception e) {
			e.printStackTrace();
			return (long) 0;
		}
	}

	@SuppressWarnings("unchecked")
	public List<Blog> getRecentPost() {
		try {
			return entityManager
					.createQuery("FROM Blog b where b.status=1 ORDER BY b.createdDate DESC, b.updatedDate DESC")
					.setMaxResults(5).getResultList();

		} catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<Blog>();
		}
	}

	@SuppressWarnings("unchecked")
	public List<Blog> getListBlogByFilter(Integer page, Integer pageSize, String keySearch) {
		try {
			StringBuilder keySearchPatern = new StringBuilder("%");
			keySearchPatern.append(keySearch);
			keySearchPatern.append("%");

			CriteriaBuilder builder = entityManager.getCriteriaBuilder();
			CriteriaQuery<Blog> criteriaQuery = builder.createQuery(Blog.class);
			Root<Blog> root = criteriaQuery.from(Blog.class);
			criteriaQuery.select(root);
			List<Predicate> predicates = new ArrayList<>();
			if (keySearch != "" && keySearch != null) {
				predicates.add(builder.or(builder.like(root.get("name"), keySearchPatern.toString()),
						builder.like(root.get("seo"), keySearchPatern.toString()),
						builder.like(root.get("description"), keySearch.toString())));
			}

			criteriaQuery.orderBy(builder.desc(root.get("createdDate")), builder.desc(root.get("updatedDate")));
			Query query = entityManager.createQuery(criteriaQuery);
			query.setMaxResults(pageSize);
			query.setFirstResult((page - 1) * pageSize);
			return query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<Blog>();
		}
	}

	public Long getTotalPageBlogByFilter(Integer pageSize, String keySearch) {
		try {

			StringBuilder keySearchPatern = new StringBuilder("%");
			keySearchPatern.append(keySearch);
			keySearchPatern.append("%");

			CriteriaBuilder builder = entityManager.getCriteriaBuilder();
			CriteriaQuery<Long> criteriaQuery = builder.createQuery(Long.class);
			Root<Blog> root = criteriaQuery.from(Blog.class);
			criteriaQuery.select(builder.count(root));
			List<Predicate> predicates = new ArrayList<>();
			if (keySearch != "" && keySearch != null) {
				predicates.add(builder.or(builder.like(root.get("name"), keySearchPatern.toString()),
						builder.like(root.get("seo"), keySearchPatern.toString()),
						builder.like(root.get("description"), keySearch.toString())));
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
