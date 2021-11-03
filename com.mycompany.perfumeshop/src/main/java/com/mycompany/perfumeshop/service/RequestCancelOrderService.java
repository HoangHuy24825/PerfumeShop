package com.mycompany.perfumeshop.service;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.mycompany.perfumeshop.entities.RequestCancelOrder;

@Service
public class RequestCancelOrderService extends BaseService<RequestCancelOrder> {

	@PersistenceContext
	private EntityManager entityManager;

	@Override
	protected Class<RequestCancelOrder> clazz() {
		return RequestCancelOrder.class;
	}

	public List<RequestCancelOrder> getTopThreeContact() {
		return super.executeNativeSql(
				"SELECT * FROM electronicdeviceshop.tbl_request_cancel_order order by created_date desc limit 3");
	}

	@SuppressWarnings("unchecked")
	public List<RequestCancelOrder> getUnreadNotify() {
		return entityManager.createNativeQuery("SELECT * FROM electronicdeviceshop.tbl_request_cancel_order "
				+ "WHERE status=0 ORDER BY created_date DESC", RequestCancelOrder.class).getResultList();
	}

	public Integer countUnreadNotify() {
		return getUnreadNotify().size();
	}

	@Transactional
	public Boolean deleteNotifyById(Integer idNotify) {
		try {
			entityManager.createNativeQuery("DELETE FROM electronicdeviceshop.tbl_request_cancel_order WHERE id=:notifyID")
					.setParameter("notifyID", idNotify).executeUpdate();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

}
