package com.mycompany.perfumeshop.controller.manager;

import java.util.ArrayList;
import java.util.Calendar;
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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mycompany.perfumeshop.conf.GlobalConfig;
import com.mycompany.perfumeshop.controller.BaseController;
import com.mycompany.perfumeshop.dto.MappingModel;
import com.mycompany.perfumeshop.entities.AttributeProduct;
import com.mycompany.perfumeshop.entities.Order;
import com.mycompany.perfumeshop.entities.OrderDetail;
import com.mycompany.perfumeshop.service.AttributeProductService;
import com.mycompany.perfumeshop.service.OrderService;
import com.mycompany.perfumeshop.utils.ConvertUtils;

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
	@PostMapping("admin/cancel-order-request")
	public ResponseEntity<JSONObject> cancelOrderRequest(HttpServletRequest request) throws Exception {
		JSONObject result = new JSONObject();
		String idOrder = request.getParameter("idOrder");
		Order saleOrder = orderService.findById(idOrder);
		if (isLogined()) {
			saleOrder.setUpdatedBy(getUserLogined().getId());
		}
		saleOrder.setUpdatedDate(Calendar.getInstance().getTime());
		List<OrderDetail> orderDetails = saleOrder.getOrderDetails();
		for (OrderDetail orderDetail : orderDetails) {
			AttributeProduct attributeProduct = orderDetail.getAttributeProduct();
			attributeProduct.setAmount(attributeProduct.getAmount() + orderDetail.getQuantity());
			attrService.saveOrUpdate(attributeProduct, getUserLogined());
		}
		saleOrder.setProcessingStatus(4);
		orderService.saveOrUpdate(saleOrder, getUserLogined());
		result.put("message", "Thành công!");
		return ResponseEntity.ok(result);
	}

	@SuppressWarnings("unchecked")
	@PostMapping("admin/sent-email-confirm")
	public ResponseEntity<JSONObject> sentEmailConfirm(HttpServletRequest request) throws Exception {
		JSONObject result = new JSONObject();
		String idOrder = request.getParameter("idOrder");
		Integer status;
		try {
			status = Integer.parseInt(request.getParameter("status"));
		} catch (Exception e) {
			return ResponseEntity.ok(null);
		}

		if (status == 1) {
			Order saleOrder = orderService.findById(idOrder);
			/* send email to customer */

			String emailReceiver = saleOrder.getCustomerEmail();
			String fullname = saleOrder.getCustomerName();

			MimeMessage message = emailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

			String htmlMsg = "<div>Dear " + fullname + " !</div> <br/><br/>";
			htmlMsg += "<div>Cảm ơn bạn thực hiện giao dịch trên <b>Electronic Device Shop</b>!</div> <br/>";
			htmlMsg += "<div>Yêu cầu hủy đơn hàng mã: <b>" + saleOrder.getCode() + "</b> đã được phê duyệt!</div><br/>";
			htmlMsg += "<div>Cảm ơn quý khách đã sử dụng dịch vụ của chúng tôi!</div><br/>";
			htmlMsg += "<div>Thanks & regards,</div><br/>";
			htmlMsg += "<div style=\"color: chartreuse;\"><b>Electronic Device</b></div><br/>";

			message.setContent(htmlMsg, "text/html");
			helper.setTo(emailReceiver);
			helper.setSubject("[Electronic Device Shop] Hủy đơn hàng.");

			emailSender.send(message);
		} else {
			Order saleOrder = orderService.findById(idOrder);
			/* send email to customer */

			String emailReceiver = saleOrder.getCustomerEmail();
			String fullname = saleOrder.getCustomerName();
			String reason = request.getParameter("content").trim();

			MimeMessage message = emailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

			String htmlMsg = "<div>Dear " + fullname + " !</div> <br/><br/>";
			htmlMsg += "<div>Cảm ơn bạn thực hiện giao dịch trên <b>Electronic Device Shop</b>!</div> <br/>";
			htmlMsg += "<div>Yêu cầu hủy đơn hàng mã: <b>" + saleOrder.getCode()
					+ "</b> không được phê duyệt!</div><br/>";
			htmlMsg += "<div>Lý do: " + reason + "</div><br/>";
			htmlMsg += "<div>Cảm ơn quý khách đã sử dụng dịch vụ của chúng tôi!</div><br/>";
			htmlMsg += "<div>Thanks & regards,</div><br/>";
			htmlMsg += "<div style=\"color: chartreuse;\"><b>Electronic Device</b></div><br/>";

			message.setContent(htmlMsg, "text/html");
			helper.setTo(emailReceiver);
			helper.setSubject("[Electronic Device Shop] Hủy đơn hàng.");
			emailSender.send(message);
		}

		result.put("message", "Thành công!");
		return ResponseEntity.ok(result);
	}

}
