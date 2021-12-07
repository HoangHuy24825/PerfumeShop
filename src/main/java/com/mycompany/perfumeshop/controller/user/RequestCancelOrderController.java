package com.mycompany.perfumeshop.controller.user;

import java.util.Calendar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mycompany.perfumeshop.controller.BaseController;
import com.mycompany.perfumeshop.entities.Order;
import com.mycompany.perfumeshop.entities.RequestCancelOrder;
import com.mycompany.perfumeshop.service.OrderService;
import com.mycompany.perfumeshop.service.RequestCancelOrderService;

@Controller
@RequestMapping("/perfume-shop/")
public class RequestCancelOrderController extends BaseController {

	@Autowired
	private OrderService orderService;

	@Autowired
	private RequestCancelOrderService requestCancelOrderService;

	@GetMapping("request-cancel-order")
	public ResponseEntity<Boolean> requestCancelOrder(@RequestParam("idOrder") String idOrder,
			@RequestParam("reason") String reason) throws Exception {
		Order saleOrder = orderService.findById(idOrder);
		RequestCancelOrder requestCancelOrder = new RequestCancelOrder();
		requestCancelOrder.setCreatedBy(saleOrder.getUserID());
		requestCancelOrder.setCustomerName(saleOrder.getCustomerName());
		requestCancelOrder.setEmail(saleOrder.getCustomerEmail());
		requestCancelOrder.setRequestType("hủy đơn hàng");
		requestCancelOrder.setMessage("Khách hàng gửi yêu cầu hủy đơn hàng có mã " + saleOrder.getCode());
		requestCancelOrder.setCreatedDate(Calendar.getInstance().getTime());
		requestCancelOrder.setStatus(false);
		requestCancelOrder.setOrder(saleOrder);
		requestCancelOrder.setReason(reason);
		requestCancelOrder.setProcessingStatus(false);
		requestCancelOrderService.saveOrUpdate(requestCancelOrder);
		return ResponseEntity.ok(Boolean.TRUE);
	}

}
