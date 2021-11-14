package com.mycompany.perfumeshop.service;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.Table;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mycompany.perfumeshop.entities.BaseEntity;

@Service
public abstract class BaseService<E extends BaseEntity> {

	@PersistenceContext
	private EntityManager entityManager;

	protected abstract Class<E> clazz();

	public E getById(int id) {
		return entityManager.find(clazz(), id);
	}

	public E getBySeo(String seo) {
		try {
			CriteriaBuilder builder = entityManager.getCriteriaBuilder();
			CriteriaQuery<E> criteriaQuery = builder.createQuery(clazz());
			Root<E> root = criteriaQuery.from(clazz());
			criteriaQuery.select(root);
			criteriaQuery.where(builder.equal(root.get("seo"), seo));
			return entityManager.createQuery(criteriaQuery).getSingleResult();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@SuppressWarnings("unchecked")
	public List<E> findAll() {
		Table tbl = clazz().getAnnotation(Table.class);
		return entityManager
				.createNativeQuery("SELECT * FROM " + tbl.name() + " ORDER BY updated_date DESC,created_date DESC",
						clazz())
				.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<E> findAllActive() {
		Table tbl = clazz().getAnnotation(Table.class);
		return entityManager.createNativeQuery(
				"SELECT * FROM " + tbl.name() + " WHERE status=1 ORDER BY updated_date DESC,created_date DESC", clazz())
				.getResultList();
	}

	@Transactional
	public E saveOrUpdate(E entity) {
		if (entity.getId() == null || entity.getId() <= 0) {
			entityManager.persist(entity); // thêm mới
			return entity;
		} else {
			return entityManager.merge(entity); // cập nhật
		}
	}

	public void delete(E entity) {
		entityManager.remove(entity);
	}

	public void deleteById(int id) {
		E entity = this.getById(id);
		delete(entity);
	}

	@SuppressWarnings("unchecked")
	public List<E> executeNativeSql(String sql) {
		try {
			Query query = entityManager.createNativeQuery(sql, clazz());
			return query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<>();
		}
	}

	@SuppressWarnings("unchecked")
	public List<E> executeSql(String sql) {
		try {
			Query query = entityManager.createQuery(sql, clazz());
			return query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<>();
		}
	}

	@SuppressWarnings("unchecked")
	public List<E> findByPage(Integer currentPage, Integer pageSize) {
		try {
			currentPage--;
			Table tbl = clazz().getAnnotation(Table.class);
			Query query = entityManager.createNativeQuery(
					"SELECT * FROM " + tbl.name() + " ORDER BY updated_date DESC,created_date DESC", clazz());
			query.setFirstResult(currentPage * pageSize);
			query.setMaxResults(pageSize);
			return query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<>();
		}
	}

	public Integer getTotalPageActive(Integer pageSize) {
		try {
			Integer totalRecord = findAllActive().size();
			return totalRecord % pageSize == 0 ? totalRecord / pageSize : (totalRecord / pageSize + 1);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	public Integer getTotalPage(Integer pageSize) {
		try {
			Integer totalRecord = findAll().size();
			return totalRecord % pageSize == 0 ? totalRecord / pageSize : (totalRecord / pageSize + 1);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

}
