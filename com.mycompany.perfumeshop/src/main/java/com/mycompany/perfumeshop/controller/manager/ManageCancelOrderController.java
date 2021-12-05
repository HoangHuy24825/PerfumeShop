package com.mycompany.perfumeshop.controller.manager;

import java.util.ArrayList;
import java.util.List;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mycompany.perfumeshop.controller.BaseController;
import com.mycompany.perfumeshop.dto.MappingModel;
import com.mycompany.perfumeshop.entities.AttributeProduct;
import com.mycompany.perfumeshop.entities.Order;
import com.mycompany.perfumeshop.entities.OrderDetail;
import com.mycompany.perfumeshop.entities.RequestCancelOrder;
import com.mycompany.perfumeshop.service.OrderService;
import com.mycompany.perfumeshop.service.RequestCancelOrderService;
import com.mycompany.perfumeshop.utils.Validate;

@Controller
@RequestMapping("/perfume-shop/")
public class ManageCancelOrderController extends BaseController {

	@Autowired
	private RequestCancelOrderService requestCancelOrderService;

	@Autowired
	private JavaMailSender emailSender;

	@Autowired
	private OrderService orderService;

	@Autowired
	private MappingModel mappingModel;

	@Autowired
	private OrderService saleOrderService;

	@GetMapping("admin/request-cancel-order.html")
	public String getPage() throws Exception {
		return "manager/order/request-cancel-order";
	}

	@SuppressWarnings("unchecked")
	@GetMapping("admin/list-request-cancel-order")
	public ResponseEntity<JSONObject> getListRequest() throws Exception {
		JSONObject result = new JSONObject();
		List<RequestCancelOrder> requestCancelOrders = requestCancelOrderService.findAllRequestCancelOrder();
		List<JSONObject> requestCancelOrdersJSON = new ArrayList<JSONObject>();
		requestCancelOrders.forEach(r -> {
			requestCancelOrdersJSON.add(mappingModel.mappingModel(r));
		});
		result.put("listRequest", requestCancelOrdersJSON);
		return ResponseEntity.ok(result);
	}

	@SuppressWarnings("unchecked")
	@GetMapping("admin/load-all-notify")
	public ResponseEntity<JSONObject> getAll() throws Exception {
		JSONObject result = new JSONObject();
		List<RequestCancelOrder> requestCancelOrders = requestCancelOrderService.findAll();
		List<JSONObject> requestCancelOrdersJSON = new ArrayList<JSONObject>();
		requestCancelOrders.forEach(r -> {
			requestCancelOrdersJSON.add(mappingModel.mappingModel(r));
		});
		result.put("notifies", requestCancelOrdersJSON);
		result.put("amountUnread", requestCancelOrderService.countUnreadNotify());
		return ResponseEntity.ok(result);
	}

	@PostMapping("admin/delete-request/{id}")
	public ResponseEntity<Boolean> delete(@PathVariable String id) throws Exception {
		return ResponseEntity.ok(requestCancelOrderService.deleteById(id));
	}

	@SuppressWarnings("unchecked")
	@GetMapping("admin/detail-order-notify/{idOrder}/{idNotify}")
	public ResponseEntity<JSONObject> getDetailOrderNotify(@PathVariable String idOrder, @PathVariable String idNotify)
			throws Exception {
		JSONObject result = new JSONObject();
		RequestCancelOrder requestCancelOrder = requestCancelOrderService.findById(idNotify);
		requestCancelOrder.setStatus(true);
		result.put("notify", mappingModel.mappingModel(requestCancelOrderService.saveOrUpdate(requestCancelOrder)));
		result.put("order", mappingModel.mappingModel(saleOrderService.findById(idOrder)));
		return ResponseEntity.ok(result);
	}

	@SuppressWarnings("unchecked")
	@PostMapping("admin/cancel-order-request/{idOrder}")
	public ResponseEntity<JSONObject> cancelOrderRequest(@PathVariable String idOrder)
			throws Exception {
		JSONObject result = new JSONObject();
		Order saleOrder = orderService.findById(idOrder);
		List<OrderDetail> orderDetails = saleOrder.getOrderDetails();
		for (OrderDetail orderDetail : orderDetails) {
			AttributeProduct attributeProduct = orderDetail.getAttributeProduct();
			attributeProduct.setAmount(attributeProduct.getAmount() + orderDetail.getQuantity());
		}
		saleOrder.setProcessingStatus(4);
		orderService.saveOrUpdate(saleOrder, getUserLogined());
		result.put("message", "Thành công!");
		return ResponseEntity.ok(result);
	}

	@PostMapping("admin/sent-email-confirm")
	public ResponseEntity<Boolean> sentEmailConfirm(HttpServletRequest request) throws Exception {
		RequestCancelOrder cancelOrder = requestCancelOrderService.findById(request.getParameter("idRequest"));
		cancelOrder.setProcessingStatus(true);
		requestCancelOrderService.saveOrUpdate(cancelOrder);
		String idOrder = request.getParameter("idOrder");
		Integer status;
		if (!Validate.isNumber(request.getParameter("status"))) {
			return ResponseEntity.ok(Boolean.FALSE);
		}
		status = Integer.parseInt(request.getParameter("status"));
		Order order = orderService.findById(idOrder);
		MimeMessage message = emailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
		String htmlMsg = "<div>Dear " + order.getCustomerName() + " !</div> <br/><br/>";
		htmlMsg += "<div>Thank you for making transactions at <b>Perfume Shop</b>!</div> <br/>";
		if (status == 1) {
			htmlMsg += "<div>Request order cancellation code: <b>" + order.getCode() + "</b> is approved!</div><br/>";
		} else {
			htmlMsg += "<div>Request order cancellation code: <b>" + order.getCode()
					+ "</b>is not approved!</div><br/>";
			htmlMsg += "<div>Reason: " + request.getParameter("content").trim() + "</div><br/>";
		}
		htmlMsg += "<div>Thank you for using our service!</div><br/>";
		htmlMsg += "<div>Thanks & regards,</div><br/>";
		htmlMsg += "<div style=\"color: chartreuse;\"><b>Electronic Device</b></div><br/>";
		message.setContent(htmlMsg, "text/html");
		helper.setTo(order.getCustomerEmail());
		helper.setSubject("[Perfume Shop] Cancel order.");
		emailSender.send(message);
		return ResponseEntity.ok(Boolean.TRUE);
	}

}
