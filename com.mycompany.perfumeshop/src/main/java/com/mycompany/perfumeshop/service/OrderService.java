package com.mycompany.perfumeshop.service;

import java.util.ArrayList;
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

import com.mycompany.perfumeshop.entities.Order;
import com.mycompany.perfumeshop.valueObjects.BaseVo;

@Service
@Transactional
public class OrderService extends BaseService<Order> {

	@PersistenceContext
	private EntityManager entityManager;

	@Override
	protected Class<Order> clazz() {
		return Order.class;
	}

	public Order getLastSaleOrderByCustomer(String name, String address, String phone, String email) {
		try {
			CriteriaBuilder builder = entityManager.getCriteriaBuilder();
			CriteriaQuery<Order> criteriaQuery = builder.createQuery(Order.class);
			Root<Order> root = criteriaQuery.from(Order.class);
			criteriaQuery.select(root);
			List<Predicate> predicates = new ArrayList<Predicate>();
			predicates.add(builder.equal(root.get("customerName"), name));
			predicates.add(builder.equal(root.get("customerAddress"), address));
			predicates.add(builder.equal(root.get("customerPhone"), phone));
			predicates.add(builder.equal(root.get("customerEmail"), email));
			criteriaQuery.where(predicates.toArray(new Predicate[] {}));
			return entityManager.createQuery(criteriaQuery).getSingleResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new Order();
		}
	}

	@SuppressWarnings("unchecked")
	public BaseVo<Order> getListOrderByMutilStatus(Integer status, Integer page, Integer pageSize) {
		BaseVo<Order> baseVo = new BaseVo<Order>();
		CriteriaBuilder builder = entityManager.getCriteriaBuilder();
		CriteriaQuery<Order> criteriaQuery = builder.createQuery(Order.class);
		Root<Order> root = criteriaQuery.from(Order.class);
		criteriaQuery.select(root);
		if (status != 1 && status != 2) {
			criteriaQuery.where(builder.equal(root.get("processingStatus"), status));
		} else {
			criteriaQuery.where(builder.or(builder.equal(root.get("processingStatus"), 1),
					builder.equal(root.get("processingStatus"), 2)));
		}
		criteriaQuery.orderBy(builder.desc(root.get("createdDate")), builder.desc(root.get("updatedDate")));
		Query query = entityManager.createQuery(criteriaQuery);

		int totalRecs = query.getResultList().size();
		int totalPage = totalRecs / pageSize;
		totalPage = totalRecs % pageSize == 0 ? totalPage : totalPage + 1;

		query.setFirstResult((page - 1) * pageSize);
		query.setMaxResults(pageSize);

		baseVo.setListEntity(query.getResultList());
		baseVo.setCurrentPage(page);
		baseVo.setTotalPage(totalPage);
		return baseVo;
	}


	public List<Order> getSaleOrderByAccount(Integer idAccount) {
		CriteriaBuilder builder = entityManager.getCriteriaBuilder();
		CriteriaQuery<Order> criteriaQuery = builder.createQuery(Order.class);
		Root<Order> root = criteriaQuery.from(Order.class);
		criteriaQuery.select(root);
		criteriaQuery.where(builder.equal(root.get("userID"), idAccount));
		return entityManager.createQuery(criteriaQuery).getResultList();
	}

	public List<Order> getSaleOrderByUser(String fullname, String email, String phone) {
		CriteriaBuilder builder = entityManager.getCriteriaBuilder();
		CriteriaQuery<Order> criteriaQuery = builder.createQuery(Order.class);
		Root<Order> root = criteriaQuery.from(Order.class);
		criteriaQuery.select(root);
		List<Predicate> predicates = new ArrayList<Predicate>();
		predicates.add(builder.equal(root.get("customerName"), fullname));
		predicates.add(builder.equal(root.get("customerPhone"), phone));
		predicates.add(builder.equal(root.get("customerEmail"), email));
		criteriaQuery.where(predicates.toArray(new Predicate[] {}));
		return entityManager.createQuery(criteriaQuery).getResultList();
	}
}
