package com.mycompany.perfumeshop.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.mycompany.perfumeshop.entities.OrderDetail;

@Service
public class SaleOrderProductService extends BaseService<OrderDetail>{

	@Override
	protected Class<OrderDetail> clazz() {
		return OrderDetail.class;
	}

	public List<OrderDetail> getListProductOrderByIdOrder(Integer idOrder) {
		return executeNativeSql("SELECT * FROM electronicdeviceshop.tbl_saleorder_products WHERE saleorder_id="+idOrder);
	}
}
