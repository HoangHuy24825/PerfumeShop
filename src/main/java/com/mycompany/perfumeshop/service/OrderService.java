package com.mycompany.perfumeshop.service;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Page;

import com.mycompany.perfumeshop.entities.Order;
import com.mycompany.perfumeshop.entities.User;
import com.mycompany.perfumeshop.valueObjects.BestSaleProductVo;
import com.mycompany.perfumeshop.valueObjects.CustomerOrder;
import com.mycompany.perfumeshop.valueObjects.OrderStatistical;
import com.mycompany.perfumeshop.valueObjects.PageVo;
import com.mycompany.perfumeshop.valueObjects.RevenueDate;
import com.mycompany.perfumeshop.valueObjects.RevenueMonth;
import com.mycompany.perfumeshop.valueObjects.RevenueVo;

public interface OrderService {

	Order getNewestOrderByCustomer(CustomerOrder customerOrder) throws Exception;

	Page<Order> findAllByUserRequest(Integer status, Integer currentPage, Integer pageSize) throws Exception;

	List<Order> findByUserID(Integer idAccount) throws Exception;

	List<Order> findAllByCustomer(CustomerOrder customerOrder) throws Exception;

	Boolean deleteById(Integer id) throws Exception;

	Order findById(String id) throws Exception;

	Order saveOrUpdate(Order order, User userChange) throws Exception;

	Double getTotalRevenueRecentWeek() throws Exception;

	Double getTotalRevenueRecentMonth() throws Exception;

	List<RevenueDate> getRevenueByDate() throws Exception;

	List<Double> getRevenueByWeek() throws Exception;

	List<Long> getTotalOrderPerWeekRecentMonth() throws Exception;

	Long totalOrderRecentMonth() throws Exception;

	List<RevenueMonth> getRevenueFromJanuary() throws Exception;

	PageVo<RevenueVo> statisticRevenue(Date startDate, Date endDate, Integer currentPage, Integer sizeOfPage)
			throws Exception;

	PageVo<BestSaleProductVo> getListBestSaleOfProduct(String idCategory, String currentPage, Integer sizeOfPage);

	OrderStatistical getOrderStatistical() throws Exception;

}
