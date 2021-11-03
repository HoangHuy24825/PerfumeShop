package com.mycompany.perfumeshop.controller.user;

import java.io.IOException;
import java.util.Calendar;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mycompany.perfumeshop.controller.BaseController;
import com.mycompany.perfumeshop.entities.RequestCancelOrder;
import com.mycompany.perfumeshop.entities.Order;
import com.mycompany.perfumeshop.service.RequestCancelOrderService;
import com.mycompany.perfumeshop.service.SaleOrderService;

@Controller
public class RequestCancelOrderController extends BaseController {

	@Autowired
	private SaleOrderService saleOrderService;

	@Autowired
	private RequestCancelOrderService requestCancelOrderService;
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/request-cancel-order" }, method = RequestMethod.GET)
	public ResponseEntity<JSONObject> requestCancelOrder(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException, MessagingException {
		JSONObject result = new JSONObject();
		Integer idOrder;
		try {
			idOrder = Integer.parseInt(request.getParameter("idOrder"));
		} catch (Exception e) {
			result.put("message", Boolean.FALSE);
			return ResponseEntity.ok(result);
		}

		String reason = request.getParameter("reason");
		Order saleOrder = saleOrderService.getById(idOrder);

		RequestCancelOrder requestCancelOrder = new RequestCancelOrder();
		requestCancelOrder.setCreatedBy(saleOrder.getUserID());
		requestCancelOrder
				.setFirstName(saleOrder.getCustomerName().substring(0, saleOrder.getCustomerName().lastIndexOf(" ")));
		requestCancelOrder
				.setLastName(saleOrder.getCustomerName().split(" ")[saleOrder.getCustomerName().split(" ").length - 1]);
		requestCancelOrder.setEmail(saleOrder.getCustomerEmail());
		requestCancelOrder.setRequestType("hủy đơn hàng");
		requestCancelOrder.setMessage("Khách hàng gửi yêu cầu hủy đơn hàng có mã " + saleOrder.getCode());
		requestCancelOrder.setCreatedDate(Calendar.getInstance().getTime());
		requestCancelOrder.setStatus(false);
		requestCancelOrder.setSaleOrder(saleOrder);
		requestCancelOrder.setReason(reason);
		
		requestCancelOrderService.saveOrUpdate(requestCancelOrder);
		result.put("message", Boolean.TRUE);
		return ResponseEntity.ok(result);
	}

}
