package com.mycompany.perfumeshop.controller.manager;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mycompany.perfumeshop.controller.BaseController;
import com.mycompany.perfumeshop.dto.MappingModel;
import com.mycompany.perfumeshop.entities.AttributeProduct;
import com.mycompany.perfumeshop.entities.Order;
import com.mycompany.perfumeshop.entities.OrderDetail;
import com.mycompany.perfumeshop.service.DetailOrderService;
import com.mycompany.perfumeshop.service.OrderService;
import com.mycompany.perfumeshop.service.ProductAttributeService;
import com.mycompany.perfumeshop.valueObjects.BaseVo;

@Controller
public class ManagerOrderController extends BaseController {

	@Autowired
	private JavaMailSender emailSender;

	@Autowired
	private OrderService orderService;

	@Autowired
	private DetailOrderService detailOrderService;

	@Autowired
	private ProductAttributeService attrService;

	private MappingModel mappingModel = new MappingModel();

	private static final Integer PAGE_SIZE = 10;

	@RequestMapping(value = { "/admin/order" }, method = RequestMethod.GET)
	public String index(final Model model, final HttpServletRequest request, final HttpServletResponse response)
			throws IOException {
		return "manager/order/order";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/admin/list-order" }, method = RequestMethod.GET)
	public ResponseEntity<JSONObject> getNewOrder(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException {
		JSONObject result = new JSONObject();
		Integer status;
		Integer page;
		try {
			page = Integer.parseInt(request.getParameter("page"));
			status = Integer.parseInt(request.getParameter("status"));
		} catch (Exception e) {
			page = 1;
			status = 0;
		}

		BaseVo<Order> baseVo = orderService.getListOrderByMutilStatus(status, page, PAGE_SIZE);
		List<Order> ordersFromDb = baseVo.getListEntity();
		List<JSONObject> ordersJSON = new ArrayList<JSONObject>();
		for (Order item : ordersFromDb) {
			ordersJSON.add(mappingModel.mappingModel(item));
		}
		result.put("currentPage", baseVo.getCurrentPage());
		result.put("totalPage", baseVo.getTotalPage());
		result.put("listOrder", ordersJSON);
		return ResponseEntity.ok(result);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/admin/detail-order" }, method = RequestMethod.GET)
	public ResponseEntity<JSONObject> getDetailOrder(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException {
		JSONObject result = new JSONObject();
		Integer idOrder;
		try {
			idOrder = Integer.parseInt(request.getParameter("idOrder"));
		} catch (Exception e) {
			return ResponseEntity.ok(null);
		}

		Order order = orderService.getById(idOrder);
		JSONObject orderJson = mappingModel.mappingModel(order);

		List<OrderDetail> orderDetails = detailOrderService.getListProductOrderByIdOrder(idOrder);
		List<JSONObject> orderDetailsJSON = new ArrayList<JSONObject>();

		for (OrderDetail saleOrderProduct : orderDetails) {
			orderDetailsJSON.add(mappingModel.mappingModel(saleOrderProduct));
		}

		result.put("order", orderJson);
		result.put("orderDetails", orderDetailsJSON);
		return ResponseEntity.ok(result);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/admin/status-order" }, method = RequestMethod.POST)
	public ResponseEntity<JSONObject> changeStatus(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException {
		JSONObject result = new JSONObject();

		Integer idOrder;
		Integer status;
		try {
			idOrder = Integer.parseInt(request.getParameter("idOrder"));
			status = Integer.parseInt(request.getParameter("status"));
		} catch (Exception e) {
			return ResponseEntity.ok(null);
		}

		Order order = orderService.getById(idOrder);

		if (isLogined()) {
			order.setUpdatedBy(getUserLogined().getId());
		}

		order.setUpdatedDate(Calendar.getInstance().getTime());

		if (status == 4) {
			List<OrderDetail> orderDetails = order.getOrderDetails();
			for (OrderDetail orderDetail : orderDetails) {
				AttributeProduct attributeProduct = orderDetail.getAttributeProduct();
				attributeProduct.setAmount(attributeProduct.getAmount() + orderDetail.getQuantity());
				attrService.saveOrUpdate(attributeProduct);
			}
			order.setProcessingStatus(4);
			orderService.saveOrUpdate(order);
		} else if (status == 0) {
			List<OrderDetail> orderDetails = order.getOrderDetails();
			for (OrderDetail orderDetail : orderDetails) {
				AttributeProduct attributeProduct = orderDetail.getAttributeProduct();
				attributeProduct.setAmount(attributeProduct.getAmount() + orderDetail.getQuantity());
				attrService.saveOrUpdate(attributeProduct);
			}
			order.setProcessingStatus(0);
			orderService.saveOrUpdate(order);
		} else {
			order.setUpdatedDate(Calendar.getInstance().getTime());
			order.setProcessingStatus(status);
			orderService.saveOrUpdate(order);
		}

		result.put("message", "Thành công!");
		return ResponseEntity.ok(result);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/admin/cancel-order-request" }, method = RequestMethod.POST)
	public ResponseEntity<JSONObject> cancelOrderRequest(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException, MessagingException {
		JSONObject result = new JSONObject();

		Integer idOrder;
		try {
			idOrder = Integer.parseInt(request.getParameter("idOrder"));
		} catch (Exception e) {
			return ResponseEntity.ok(null);
		}

		Order saleOrder = orderService.getById(idOrder);

		if (isLogined()) {
			saleOrder.setUpdatedBy(getUserLogined().getId());
		}

		saleOrder.setUpdatedDate(Calendar.getInstance().getTime());

		List<OrderDetail> orderDetails = saleOrder.getOrderDetails();
		for (OrderDetail orderDetail : orderDetails) {
			AttributeProduct attributeProduct = orderDetail.getAttributeProduct();
			attributeProduct.setAmount(attributeProduct.getAmount() + orderDetail.getQuantity());
			attrService.saveOrUpdate(attributeProduct);
		}
		saleOrder.setProcessingStatus(4);
		orderService.saveOrUpdate(saleOrder);

		result.put("message", "Thành công!");
		return ResponseEntity.ok(result);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/admin/sent-email-confirm" }, method = RequestMethod.POST)
	public ResponseEntity<JSONObject> sentEmailConfirm(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException, MessagingException {
		JSONObject result = new JSONObject();

		Integer idOrder;
		try {
			idOrder = Integer.parseInt(request.getParameter("idOrder"));
		} catch (Exception e) {
			return ResponseEntity.ok(null);
		}

		Integer status;
		try {
			status = Integer.parseInt(request.getParameter("status"));
		} catch (Exception e) {
			return ResponseEntity.ok(null);
		}

		if (status == 1) {
			Order saleOrder = orderService.getById(idOrder);
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
			Order saleOrder = orderService.getById(idOrder);
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
