package com.mycompany.perfumeshop.service;

import java.util.List;

import com.mycompany.perfumeshop.entities.RequestCancelOrder;
import com.mycompany.perfumeshop.entities.User;

public interface RequestCancelOrderService {

	List<RequestCancelOrder> getTopThreeContact() throws Exception;

	List<RequestCancelOrder> getUnreadNotify() throws Exception;

	Integer countUnreadNotify() throws Exception;

	RequestCancelOrder saveOrUpdate(RequestCancelOrder requestCancelOrder) throws Exception;

	RequestCancelOrder saveOrUpdate(RequestCancelOrder requestCancelOrder, User userLogin) throws Exception;

	public Boolean deleteById(Integer id) throws Exception;

	List<RequestCancelOrder> findAll() throws Exception;

	RequestCancelOrder findById(Integer id) throws Exception;

}
