package com.mycompany.perfumeshop.service;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.mycompany.perfumeshop.entities.OrderDetail;

@Service
@Transactional
public class DetailOrderService extends BaseService<OrderDetail> {

	@PersistenceContext
	private EntityManager entityManager;

	@Override
	protected Class<OrderDetail> clazz() {
		return OrderDetail.class;
	}

	public List<OrderDetail> getListProductOrderByIdOrder(Integer idOrder) {
		TypedQuery<OrderDetail> query = entityManager.createQuery("FROM OrderDetail o WHERE o.order.id=:idOrder",
				OrderDetail.class);
		query.setParameter("idOrder", idOrder);
		return query.getResultList();
	}
}
