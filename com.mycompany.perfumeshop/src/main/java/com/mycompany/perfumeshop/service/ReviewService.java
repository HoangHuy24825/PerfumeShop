package com.mycompany.perfumeshop.service;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.perfumeshop.entities.Review;

@Service
public class ReviewService extends BaseService<Review> {

	@Autowired
	private EntityManager entityManager;

	@Override
	protected Class<Review> clazz() {
		return Review.class;
	}

	@SuppressWarnings("unchecked")
	public List<Review> findAllByIdProduct(Integer idProduct) {
		Query query = entityManager.createQuery("FROM Review r WHERE r.product.id=:idProduct");
		query.setParameter("idProduct", idProduct);
		return query.getResultList();
	}
}
