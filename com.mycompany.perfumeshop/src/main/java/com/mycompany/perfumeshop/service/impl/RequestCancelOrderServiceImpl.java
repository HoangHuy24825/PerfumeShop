package com.mycompany.perfumeshop.service.impl;

import java.util.Calendar;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.perfumeshop.entities.RequestCancelOrder;
import com.mycompany.perfumeshop.entities.User;
import com.mycompany.perfumeshop.exceptions.EntityNotFoundCustomException;
import com.mycompany.perfumeshop.repository.RequestCancelOrderRepository;
import com.mycompany.perfumeshop.service.RequestCancelOrderService;

@Service
@Transactional
public class RequestCancelOrderServiceImpl implements RequestCancelOrderService {

	@Autowired
	private RequestCancelOrderRepository requestRepository;

	public List<RequestCancelOrder> getTopThreeContact() throws Exception {
		return requestRepository.findTop3ByOrderByCreatedDateDesc();
	}

	public List<RequestCancelOrder> getUnreadNotify() throws Exception {
		return requestRepository.findByStatus(false);
	}

	public Integer countUnreadNotify() throws Exception {
		return requestRepository.countByStatus(false);
	}

	@Override
	public Boolean deleteById(Integer id) throws Exception {
		requestRepository.deleteById(id);
		return true;
	}

	@Override
	public RequestCancelOrder saveOrUpdate(RequestCancelOrder requestCancelOrder) throws Exception {
		return requestRepository.save(requestCancelOrder);
	}

	@Override
	public RequestCancelOrder saveOrUpdate(RequestCancelOrder requestCancelOrder, User userLogin) throws Exception {
		Integer idUserLogin = userLogin != null ? userLogin.getId() : null;
		if (requestCancelOrder.getId() != null) {
			RequestCancelOrder oldRequest = requestRepository.findById(requestCancelOrder.getId())
					.orElseThrow(() -> new EntityNotFoundCustomException("Not found request cancel order"));
			requestCancelOrder.setCreatedBy(oldRequest.getCreatedBy());
			requestCancelOrder.setCreatedDate(oldRequest.getCreatedDate());
		} else {
			requestCancelOrder.setCreatedBy(idUserLogin);
			requestCancelOrder.setCreatedDate(Calendar.getInstance().getTime());
		}
		requestCancelOrder.setUpdatedBy(idUserLogin);
		requestCancelOrder.setUpdatedDate(Calendar.getInstance().getTime());
		return requestRepository.save(requestCancelOrder);
	}

	@Override
	public List<RequestCancelOrder> findAll() throws Exception {
		return requestRepository.findAll();
	}

	@Override
	public RequestCancelOrder findById(Integer id) throws Exception {
		return requestRepository.findById(id)
				.orElseThrow(() -> new EntityNotFoundCustomException("Not found request cancel order"));
	}

}
