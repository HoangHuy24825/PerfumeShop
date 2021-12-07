package com.mycompany.perfumeshop.service;

import java.util.List;

import com.mycompany.perfumeshop.entities.Order;
import com.mycompany.perfumeshop.entities.OrderDetail;

public interface DetailOrderService {

	public List<OrderDetail> findAllByOrder(Order order) throws Exception;

	public Boolean deleteById(Integer id) throws Exception;

}
