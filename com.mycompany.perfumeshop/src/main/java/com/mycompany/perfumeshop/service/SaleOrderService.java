package com.mycompany.perfumeshop.service;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Service;

import com.mycompany.perfumeshop.entities.Order;

@Service
public class SaleOrderService extends BaseService<Order> {

	@PersistenceContext
	private EntityManager entityManager;

	@Override
	protected Class<Order> clazz() {
		return Order.class;
	}

	public Order getLastSaleOrderByCustomer(String name, String address, String phone, String email) {
		try {
			String sql = "SELECT * FROM electronicdeviceshop.tbl_saleorder WHERE customer_name=:name and"
					+ " customer_address=:address and customer_phone=:phone and customer_email=:email "
					+ "order by id DESC LIMIT 1";
			Query query = entityManager.createNativeQuery(sql, Order.class);
			query.setParameter("name", name);
			query.setParameter("address", address);
			query.setParameter("phone", phone);
			query.setParameter("email", email);
			return (Order) query.getResultList().get(0);
		} catch (Exception e) {
			e.printStackTrace();
			return new Order();
		}
	}

	@SuppressWarnings("unchecked")
	public List<Order> getListOrderByMutilStatus(Integer status, Integer page, Integer pageSize) {
		try {
			if (status != 1 && status != 2) {
				String sql = "SELECT * FROM electronicdeviceshop.tbl_saleorder WHERE processing_status=:processStatus ORDER BY updated_date DESC,created_date DESC";
				Query query = entityManager.createNativeQuery(sql, Order.class);
				query.setParameter("processStatus", status);
				query.setFirstResult((page - 1) * pageSize);
				query.setMaxResults(pageSize);
				return query.getResultList();
			} else {
				String sql = "SELECT * FROM electronicdeviceshop.tbl_saleorder WHERE processing_status=:processStatus1 OR processing_status=:processStatus2 ORDER BY updated_date DESC,created_date DESC";
				Query query = entityManager.createNativeQuery(sql, Order.class);
				query.setParameter("processStatus1", 1);
				query.setParameter("processStatus2", 2);
				query.setFirstResult((page - 1) * pageSize);
				query.setMaxResults(pageSize);
				return query.getResultList();
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<Order>();
		}
	}

	public Integer getTotalPageOrderByStatus(Integer status, Integer pageSize) {
		try {
			if (status != 1 && status != 2) {
				String sql = "SELECT * FROM electronicdeviceshop.tbl_saleorder WHERE processing_status=:processStatus ORDER BY updated_date DESC,created_date DESC";
				Query query = entityManager.createNativeQuery(sql, Order.class);
				query.setParameter("processStatus", status);
				Integer totalRecord = query.getResultList().size();
				return totalRecord % pageSize == 0 ? totalRecord / pageSize : (totalRecord / pageSize + 1);
			} else {
				String sql = "SELECT * FROM electronicdeviceshop.tbl_saleorder WHERE processing_status=:processStatus1 OR processing_status=:processStatus2 ORDER BY updated_date DESC,created_date DESC";
				Query query = entityManager.createNativeQuery(sql, Order.class);
				query.setParameter("processStatus1", 1);
				query.setParameter("processStatus2", 2);
				Integer totalRecord = query.getResultList().size();
				return totalRecord % pageSize == 0 ? totalRecord / pageSize : (totalRecord / pageSize + 1);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	public List<Order> getSaleOrderByAccount(Integer idAccount) {
		return super.executeNativeSql("SELECT * FROM electronicdeviceshop.tbl_saleorder WHERE user_id=" + idAccount);
	}

	public List<Order> getSaleOrderByUser(String fullname, String email, String phone) {
		return super.executeNativeSql("SELECT * FROM electronicdeviceshop.tbl_saleorder where customer_name='"
				+ fullname + "' and customer_email='" + email + "' and customer_phone='" + phone + "'");
	}
}
