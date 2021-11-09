package com.mycompany.perfumeshop.service;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.perfumeshop.entities.AttributeProduct;

@Service
public class ProductAttributeService extends BaseService<AttributeProduct> {

	@Autowired
	private EntityManager entityManager;

	@Override
	protected Class<AttributeProduct> clazz() {
		return AttributeProduct.class;
	}

	@SuppressWarnings("unchecked")
	public List<AttributeProduct> getListByIdProduct(Integer idProduct) {
		Query query = entityManager.createQuery("FROM AttributeProduct ap where ap.product.id=:productAttrId");
		query.setParameter("productAttrId", idProduct);
		return query.getResultList();
	}

}
