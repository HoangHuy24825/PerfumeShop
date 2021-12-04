package com.mycompany.perfumeshop.controller.manager;

import java.util.ArrayList;
import java.util.List;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mycompany.perfumeshop.conf.GlobalConfig;
import com.mycompany.perfumeshop.controller.BaseController;
import com.mycompany.perfumeshop.dto.MappingModel;
import com.mycompany.perfumeshop.entities.AttributeProduct;
import com.mycompany.perfumeshop.entities.Order;
import com.mycompany.perfumeshop.entities.OrderDetail;
import com.mycompany.perfumeshop.entities.RequestCancelOrder;
import com.mycompany.perfumeshop.service.AttributeProductService;
import com.mycompany.perfumeshop.service.OrderService;
import com.mycompany.perfumeshop.service.RequestCancelOrderService;
import com.mycompany.perfumeshop.utils.ConvertUtils;
import com.mycompany.perfumeshop.utils.Validate;

@Controller
@RequestMapping("/perfume-shop/")
public class ManagerOrderController extends BaseController {

	@Autowired
	private JavaMailSender emailSender;

	@Autowired
	private OrderService orderService;

	@Autowired
	private AttributeProductService attrService;

	@Autowired
	private RequestCancelOrderService reqService;

	@Autowired
	private MappingModel mappingModel;

	@Autowired
	private GlobalConfig globalConfig;

	@GetMapping("admin/order.html")
	public String index() {
		return "manager/order/order";
	}

	@SuppressWarnings("unchecked")
	@GetMapping("admin/list-order")
	public ResponseEntity<JSONObject> getNewOrder(HttpServletRequest request) throws Exception {
		JSONObject result = new JSONObject();
		Integer status = ConvertUtils.convertStringToInt(request.getParameter("status"), 1);
		Integer currentPage = ConvertUtils.convertStringToInt(request.getParameter("page"), globalConfig.getInitPage());
		Page<Order> page = orderService.findAllByUserRequest(status, currentPage, globalConfig.getSizeManagePage());
		List<Order> ordersFromDb = page.getContent();
		List<JSONObject> ordersJSON = new ArrayList<JSONObject>();
		for (Order item : ordersFromDb) {
			ordersJSON.add(mappingModel.mappingModel(item));
		}
		result.put("currentPage", page.getNumber() + 1);
		result.put("totalPage", page.getTotalPages());
		result.put("listOrder", ordersJSON);
		return ResponseEntity.ok(result);
	}

	@SuppressWarnings("unchecked")
	@GetMapping("admin/detail-order")
	public ResponseEntity<JSONObject> getDetailOrder(@RequestParam(value = "idOrder", required = false) String idOrder)
			throws Exception {
		JSONObject result = new JSONObject();
		Order order = orderService.findById(idOrder);
		JSONObject orderJson = mappingModel.mappingModel(order);
		result.put("order", orderJson);
		return ResponseEntity.ok(result);
	}

	@PostMapping("admin/status-order")
	public ResponseEntity<Boolean> changeStatus(HttpServletRequest request) throws Exception {
		String idOrder = request.getParameter("idOrder");
		Integer status;
		try {
			status = Integer.parseInt(request.getParameter("status"));
		} catch (Exception e) {
			return ResponseEntity.ok(null);
		}
		Order order = orderService.findById(idOrder);
		if (order == null) {
			return ResponseEntity.ok(null);
		}
		if (status == 4 || status == 0) {
			List<OrderDetail> orderDetails = order.getOrderDetails();
			AttributeProduct attributeProduct = null;
			for (OrderDetail orderDetail : orderDetails) {
				attributeProduct = orderDetail.getAttributeProduct();
				attributeProduct.setAmount(status == 4 ? attributeProduct.getAmount() - orderDetail.getQuantity()
						: attributeProduct.getAmount() + orderDetail.getQuantity());
				attrService.saveOrUpdate(attributeProduct, getUserLogined());
			}
		}
		order.setProcessingStatus(status);
		orderService.saveOrUpdate(order, getUserLogined());
		return ResponseEntity.ok(Boolean.TRUE);
	}

	@SuppressWarnings("unchecked")
	@PostMapping("admin/cancel-order-request/{idOrder}")
	public ResponseEntity<JSONObject> cancelOrderRequest(@PathVariable String idOrder) throws Exception {
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
		String idOrder = request.getParameter("idOrder");
		Integer status;
		if (!Validate.isNumber(request.getParameter("status"))) {
			return ResponseEntity.ok(Boolean.FALSE);
		}
		status = Integer.parseInt(request.getParameter("status"));
		Order order = orderService.findById(idOrder);
		RequestCancelOrder cancelOrder = reqService.findByOrder(order);
		cancelOrder.setProcessingStatus(true);
		reqService.saveOrUpdate(cancelOrder);
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
