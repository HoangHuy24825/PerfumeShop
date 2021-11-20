package com.mycompany.perfumeshop.service;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.perfumeshop.entities.RequestCancelOrder;
import com.mycompany.perfumeshop.repository.RequestCancelOrderRepository;

@Service
@Transactional
public class RequestCancelOrderService extends BaseService<RequestCancelOrder> {

	@PersistenceContext
	private EntityManager entityManager;

	@Autowired
	private RequestCancelOrderRepository requestRepository;

	@Override
	protected Class<RequestCancelOrder> clazz() {
		return RequestCancelOrder.class;
	}

	public List<RequestCancelOrder> getTopThreeContact() {
		return requestRepository.findTop3ByOrderByCreatedDateDesc();
	}

	public List<RequestCancelOrder> getUnreadNotify() {
		return requestRepository.findByStatus(false);
	}

	public Integer countUnreadNotify() {
		return requestRepository.countByStatus(false);
	}

	public Boolean deleteNotifyById(Integer idNotify) {
		requestRepository.deleteById(idNotify);
		return true;
	}

}
