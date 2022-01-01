package com.mycompany.perfumeshop.service.impl;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.Month;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.mycompany.perfumeshop.conf.GlobalConfig;
import com.mycompany.perfumeshop.entities.Order;
import com.mycompany.perfumeshop.entities.OrderDetail;
import com.mycompany.perfumeshop.entities.User;
import com.mycompany.perfumeshop.exceptions.EntityNotFoundCustomException;
import com.mycompany.perfumeshop.repository.OrderRepository;
import com.mycompany.perfumeshop.service.OrderService;
import com.mycompany.perfumeshop.specification.OrderSpecification;
import com.mycompany.perfumeshop.utils.Constants;
import com.mycompany.perfumeshop.utils.DateUtils;
import com.mycompany.perfumeshop.utils.Log4jUtils;
import com.mycompany.perfumeshop.utils.Validate;
import com.mycompany.perfumeshop.valueObjects.BestSaleProductVo;
import com.mycompany.perfumeshop.valueObjects.CustomerOrder;
import com.mycompany.perfumeshop.valueObjects.OrderStatistical;
import com.mycompany.perfumeshop.valueObjects.PageVo;
import com.mycompany.perfumeshop.valueObjects.RevenueDate;
import com.mycompany.perfumeshop.valueObjects.RevenueMonth;
import com.mycompany.perfumeshop.valueObjects.RevenueVo;

@Service
@Transactional
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrderRepository orderRepository;

	@Autowired
	private OrderSpecification orderSpecification;

	@Autowired
	private GlobalConfig globalConfig;

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
			if (order.getOrderDetails() != null && order.getOrderDetails().size() != 0) {
				for (OrderDetail detail : order.getOrderDetails()) {
					detail.setCreatedDate(oldOrder.getCreatedDate());
					detail.setCreatedBy(oldOrder.getCreatedBy());
				}
			}
			order.setCreatedDate(oldOrder.getCreatedDate());
		} else {
			order.setCreatedBy(idUserChange);
			order.setCreatedDate(Calendar.getInstance().getTime());
			if (order.getOrderDetails() != null && order.getOrderDetails().size() != 0) {
				for (OrderDetail detail : order.getOrderDetails()) {
					detail.setCreatedDate(Calendar.getInstance().getTime());
					detail.setCreatedBy(idUserChange);
				}
			}
		}
		if (order.getOrderDetails() != null && order.getOrderDetails().size() != 0) {
			for (OrderDetail detail : order.getOrderDetails()) {
				detail.setUpdatedBy(idUserChange);
				detail.setUpdatedDate(Calendar.getInstance().getTime());
			}
		}
		order.setUpdatedBy(idUserChange);
		order.setUpdatedDate(Calendar.getInstance().getTime());
		return orderRepository.save(order);
	}

	@Override
	public Double getTotalRevenueRecentWeek() throws Exception {
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DAY_OF_YEAR, -7);
		return orderRepository.getRevenueOneWeek(cal.getTime(), globalConfig.getOrderSuccessStatus());
	}

	@Override
	public Double getTotalRevenueRecentMonth() throws Exception {
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.MONTH, -1);
		return orderRepository.getRevenueOneWeek(cal.getTime(), globalConfig.getOrderSuccessStatus());
	}

	@Override
	public List<RevenueDate> getRevenueByDate() throws Exception {
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DAY_OF_YEAR, -7);
		List<RevenueDate> revenueDates = orderRepository.getRevenuePerDate(cal.getTime(),
				globalConfig.getOrderSuccessStatus());
		List<String> listDate = new ArrayList<String>();
		for (int i = 1; i <= 7; i++) {
			cal.add(Calendar.DAY_OF_YEAR, 1);
			listDate.add(DateUtils.sdf.format(cal.getTime()));
		}
		List<String> listDateFromDb = new ArrayList<String>();
		revenueDates.forEach(r -> listDateFromDb.add(DateUtils.sdf.format(r.getDate())));
		for (String date : listDate) {
			if (!listDateFromDb.contains(date)) {
				revenueDates.add(new RevenueDate(DateUtils.parseToDate(date), BigDecimal.valueOf(0.0)));
			}
		}
		revenueDates.sort((revenueDate1, revenueDate2) -> revenueDate1.getDate().compareTo(revenueDate2.getDate()));
		/*
		 * revenueDates = revenueDates.stream() .sorted((revenueDate1, revenueDate2) ->
		 * revenueDate1.getDate().compareTo(revenueDate2.getDate()))
		 * .collect(Collectors.toList());
		 */
		return revenueDates;
	}

	@Override
	public List<Double> getRevenueByWeek() throws Exception {
		int i = 4;
		Calendar cal = Calendar.getInstance();
		Date endDate = cal.getTime();
		cal.add(Calendar.DAY_OF_YEAR, -7);
		List<Double> revenueWeeks = new ArrayList<Double>();
		Double revenue = null;
		do {
			revenue = orderRepository.getRevenueBetweenDate(cal.getTime(), endDate,
					globalConfig.getOrderSuccessStatus());
			revenueWeeks.add(revenue == null ? 0 : revenue);
			i--;
			endDate = cal.getTime();
			cal.add(Calendar.DAY_OF_YEAR, -(7 * (4 - i)));
		} while (i > 0);
		Collections.reverse(revenueWeeks);
		return revenueWeeks;
	}

	@Override
	public Long totalOrderRecentMonth() throws Exception {
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.MONTH, -1);
		return orderRepository.getTotalOrderRecentMonth(cal.getTime(), globalConfig.getOrderSuccessStatus());
	}

	@Override
	public List<Long> getTotalOrderPerWeekRecentMonth() throws Exception {
		int i = 4;
		Calendar cal = Calendar.getInstance();
		Date endDate = cal.getTime();
		cal.add(Calendar.DAY_OF_YEAR, -7);
		List<Long> revenueWeeks = new ArrayList<>();
		Long revenue = null;
		do {
			revenue = orderRepository.getTotalOrderBetweenDate(cal.getTime(), endDate,
					globalConfig.getOrderSuccessStatus());
			revenueWeeks.add(revenue == null ? 0 : revenue);
			i--;
			endDate = cal.getTime();
			cal.add(Calendar.DAY_OF_YEAR, -(7 * (4 - i)));
		} while (i > 0);
		Collections.reverse(revenueWeeks);
		return revenueWeeks;
	}

	@Override
	public List<RevenueMonth> getRevenueFrom12PreviousMonth() throws Exception {
		List<RevenueMonth> revenueMonths = new ArrayList<>();
		LocalDate date = LocalDate.now();
		LocalDate startDate = date.withDayOfMonth(1);
		LocalDate lastDate = date.withDayOfMonth(date.lengthOfMonth());
		LocalDate previousDate = date;
		BigDecimal revenuePerMonth = null;
		for (int i = 1; i <= 12; i++) {
			revenuePerMonth = orderRepository.getRevenueDate(
					Date.from(startDate.atStartOfDay(ZoneId.systemDefault()).toInstant()),
					Date.from(lastDate.atStartOfDay(ZoneId.systemDefault()).toInstant()),
					globalConfig.getOrderSuccessStatus());
			revenueMonths.add(new RevenueMonth(previousDate.getMonth().getValue() + "/" + previousDate.getYear(),
					revenuePerMonth == null ? BigDecimal.valueOf(0.0) : revenuePerMonth));
			previousDate = date.minusMonths(i);
			startDate = previousDate.withDayOfMonth(1);
			lastDate = previousDate.withDayOfMonth(previousDate.lengthOfMonth());

		}
		Collections.reverse(revenueMonths);
		return revenueMonths;
	}

	@Override
	public PageVo<RevenueVo> statisticRevenue(Date startDate, Date endDate, Integer currentPage, Integer sizeOfPage)
			throws Exception {
		PageVo<RevenueVo> pageOfRevenue = new PageVo<RevenueVo>();
		List<RevenueVo> listRevenueVos = orderRepository.getRevenue(startDate, endDate);
		pageOfRevenue.setTotalPage(listRevenueVos.size() % sizeOfPage == 0 ? (listRevenueVos.size() / sizeOfPage)
				: (listRevenueVos.size() / sizeOfPage + 1));
		pageOfRevenue.setCurrentPage(currentPage);
		listRevenueVos = listRevenueVos.stream().skip((currentPage - 1) * sizeOfPage).limit(sizeOfPage)
				.sorted((revenueVo1, revenueVo2) -> revenueVo1.getDate().compareTo(revenueVo2.getDate()))
				.collect(Collectors.toList());
		pageOfRevenue.setContent(listRevenueVos);
		return pageOfRevenue;
	}

	@Override
	public PageVo<BestSaleProductVo> getListBestSaleOfProduct(String idCategory, String currentPage,
			Integer sizeOfPage) {
		Integer currentPageVal = !Validate.isNumber(currentPage) ? globalConfig.getInitPage()
				: Integer.parseInt(currentPage);
		PageVo<BestSaleProductVo> pageVo = new PageVo<BestSaleProductVo>();
		if (!Validate.isNumber(idCategory)) {
			pageVo.setContent(orderRepository.getAllBestSaleProduct());
		} else {
			pageVo.setContent(orderRepository.getBestSaleProductByCategory(Integer.parseInt(idCategory)));
		}
		pageVo.setTotalPage(pageVo.getContent().size() % sizeOfPage == 0 ? (pageVo.getContent().size() / sizeOfPage)
				: (pageVo.getContent().size() / sizeOfPage + 1));
		pageVo.setCurrentPage(currentPageVal);
		pageVo.setContent(pageVo.getContent().stream().skip((currentPageVal - 1) * sizeOfPage).limit(sizeOfPage)
				.sorted((bestSaleProduct1, bestSaleProduct2) -> bestSaleProduct2.getTotalSale()
						.compareTo(bestSaleProduct1.getTotalSale()))
				.collect(Collectors.toList()));
		return pageVo;
	}

	@Override
	public OrderStatistical getOrderStatistical() throws Exception {
		OrderStatistical orderStatistical = orderRepository.getOrderStatistical();
		Log4jUtils.getLogger().info(orderStatistical);
		return orderStatistical;
	}

}
