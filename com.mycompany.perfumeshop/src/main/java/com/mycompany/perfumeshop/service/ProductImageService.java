package com.mycompany.perfumeshop.service;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.perfumeshop.entities.ProductImage;

@Service
public class ProductImageService extends BaseService<ProductImage> {

	@Autowired
	private EntityManager entityManager;

	@Override
	protected Class<ProductImage> clazz() {
		return ProductImage.class;
	}

	@SuppressWarnings("unchecked")
	public List<ProductImage> findAllByIdProduct(Integer idProduct) {
		Query query = entityManager.createQuery("FROM ProductImage pi where pi.product.id=:productId");
		query.setParameter("productId", idProduct);
		return query.getResultList();
	}
}
