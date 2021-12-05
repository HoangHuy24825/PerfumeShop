package com.mycompany.perfumeshop.service.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.mycompany.perfumeshop.entities.Order;
import com.mycompany.perfumeshop.entities.User;
import com.mycompany.perfumeshop.exceptions.EntityNotFoundCustomException;
import com.mycompany.perfumeshop.repository.OrderRepository;
import com.mycompany.perfumeshop.service.OrderService;
import com.mycompany.perfumeshop.specification.OrderSpecification;
import com.mycompany.perfumeshop.utils.Validate;
import com.mycompany.perfumeshop.valueObjects.CustomerOrder;

@Service
@Transactional
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrderRepository orderRepository;

	@Autowired
	private OrderSpecification orderSpecification;

	public Order getNewestOrderByCustomer(CustomerOrder customerOrder) {
		Pageable pageable = PageRequest.of(0, 1, Sort.by("createdDate", "updatedDate").descending());
		return orderRepository.findAll(orderSpecification.findByCustomerOrder(customerOrder), pageable).getContent()
				.get(0);
	}

	@Override
	public List<Order> findByUserID(Integer idAccount) throws Exception {
		if (idAccount == null) {
			return new ArrayList<Order>();
		}
		return orderRepository.findByUserIDOrderByCreatedDateDescUpdatedDateDesc(idAccount);
	}

	@Autowired
	public List<Order> findAllByCustomer(CustomerOrder customerOrder) {
		if (customerOrder == null || customerOrder.getName() == null || customerOrder.getPhone() == null
				|| customerOrder.getEmail() == null) {
			return new ArrayList<Order>();
		}
		return orderRepository.findAll(orderSpecification.findByCustomerOrder(customerOrder));
	}

	@Override
	public Page<Order> findAllByUserRequest(Integer status, Integer currentPage, Integer pageSize) throws Exception {
		if (status == null) {
			return null;
		}
		Pageable pageable = PageRequest.of(currentPage - 1, pageSize,
				Sort.by("createdDate", "updatedDate").descending());
		return orderRepository.findAll(orderSpecification.findByProcessStatus(status), pageable);
	}

	@Override
	public Boolean deleteById(Integer id) throws Exception {
		orderRepository.deleteById(id);
		return true;
	}

	@Override
	public Order findById(String id) throws Exception {
		if (!Validate.isNumber(id)) {
			return null;
		}
		return orderRepository.findById(Integer.parseInt(id))
				.orElseThrow(() -> new EntityNotFoundCustomException("Not found order"));
	}

	@Override
	public Order saveOrUpdate(Order order, User userChange) throws Exception {
		Integer idUserChange = userChange != null ? userChange.getId() : null;
		if (order.getId() != null) {
			Order oldOrder = orderRepository.findById(order.getId())
					.orElseThrow(() -> new EntityNotFoundCustomException("Not found order"));
			order.setCreatedBy(oldOrder.getCreatedBy());
			order.setCreatedDate(oldOrder.getCreatedDate());
		} else {
			order.setCreatedBy(idUserChange);
			order.setCreatedDate(Calendar.getInstance().getTime());
		}
		order.setUpdatedBy(idUserChange);
		order.setUpdatedDate(Calendar.getInstance().getTime());
		return orderRepository.save(order);
	}

}
