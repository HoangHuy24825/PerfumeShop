package com.mycompany.perfumeshop.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.perfumeshop.entities.Order;
import com.mycompany.perfumeshop.entities.OrderDetail;
import com.mycompany.perfumeshop.repository.DetailOrderRepository;
import com.mycompany.perfumeshop.service.DetailOrderService;

@Service
@Transactional
public class DetailOrderServiceImpl implements DetailOrderService {

	@Autowired
	private DetailOrderRepository detailOrderRepository;

	@Override
	public List<OrderDetail> findAllByOrder(Order order) throws Exception {
		if (order == null || order.getId() == null) {
			return new ArrayList<OrderDetail>();
		}
		return findAllByOrder(order);
	}

	@Override
	public Boolean deleteById(Integer id) throws Exception {
		detailOrderRepository.deleteById(id);
		return true;
	}
}
