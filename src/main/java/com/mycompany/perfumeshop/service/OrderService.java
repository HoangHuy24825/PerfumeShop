package com.mycompany.perfumeshop.service;

import java.util.List;

import org.springframework.data.domain.Page;

import com.mycompany.perfumeshop.entities.Order;
import com.mycompany.perfumeshop.entities.User;
import com.mycompany.perfumeshop.valueObjects.CustomerOrder;

public interface OrderService {

	Order getNewestOrderByCustomer(CustomerOrder customerOrder) throws Exception;

	Page<Order> findAllByUserRequest(Integer status, Integer currentPage, Integer pageSize) throws Exception;

	List<Order> findByUserID(Integer idAccount) throws Exception;

	List<Order> findAllByCustomer(CustomerOrder customerOrder) throws Exception;

	Boolean deleteById(Integer id) throws Exception;

	Order findById(String id) throws Exception;

	Order saveOrUpdate(Order order, User userChange) throws Exception;

}
