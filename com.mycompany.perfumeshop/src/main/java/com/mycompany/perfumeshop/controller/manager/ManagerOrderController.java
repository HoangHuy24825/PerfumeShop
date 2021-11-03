package com.mycompany.perfumeshop.controller.manager;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.mycompany.perfumeshop.entities.Product;
import com.mycompany.perfumeshop.entities.Order;
import com.mycompany.perfumeshop.entities.OrderDetail;
import com.mycompany.perfumeshop.service.ProductService;
import com.mycompany.perfumeshop.service.SaleOrderProductService;
import com.mycompany.perfumeshop.service.SaleOrderService;

@Controller
public class ManagerOrderController extends BaseController {

	@Autowired
	private JavaMailSender emailSender;

	@Autowired
	private SaleOrderService saleOrderService;

	@Autowired
	private SaleOrderProductService saleOrderProductService;

	@Autowired
	private ProductService productService;

	private MappingModel mappingModel = new MappingModel();

	private static final Integer PAGE_SIZE = 10;

	@RequestMapping(value = { "/admin/order" }, method = RequestMethod.GET)
	public String index(final Model model, final HttpServletRequest request, final HttpServletResponse response)
			throws IOException {
		return "manager/order/order";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/admin/list-order" }, method = RequestMethod.GET)
	public ResponseEntity<Map<String, List<JSONObject>>> getNewOrder(final Model model,
			final HttpServletRequest request, final HttpServletResponse response) throws IOException {
		Map<String, List<JSONObject>> result = new HashMap<String, List<JSONObject>>();

		Integer status;
		Integer page;
		try {
			page = Integer.parseInt(request.getParameter("page"));
			status = Integer.parseInt(request.getParameter("status"));
		} catch (Exception e) {
			page = 1;
			status = 0;
		}

		List<Order> saleOrdersDB = saleOrderService.getListOrderByMutilStatus(status, page, PAGE_SIZE);
		List<JSONObject> saleOrdersJSON = new ArrayList<JSONObject>();

		for (Order item : saleOrdersDB) {
			saleOrdersJSON.add(mappingModel.mappingModel(item));
		}

		List<JSONObject> listPage = new ArrayList<JSONObject>();
		JSONObject pageJSON = new JSONObject();
		pageJSON.put("currentPage", page);
		pageJSON.put("totalPage", saleOrderService.getTotalPageOrderByStatus(status, PAGE_SIZE));

		listPage.add(pageJSON);

		result.put("listOrder", saleOrdersJSON);
		result.put("listPage", listPage);

		return ResponseEntity.ok(result);
	}

	@RequestMapping(value = { "/admin/detail-order" }, method = RequestMethod.GET)
	public ResponseEntity<Map<String, List<JSONObject>>> getDetailOrder(final Model model,
			final HttpServletRequest request, final HttpServletResponse response) throws IOException {
		Map<String, List<JSONObject>> result = new HashMap<String, List<JSONObject>>();
		Integer idOrder;
		try {
			idOrder = Integer.parseInt(request.getParameter("idOrder"));
		} catch (Exception e) {
			return ResponseEntity.ok(null);
		}

		Order saleOrder = saleOrderService.getById(idOrder);
		List<JSONObject> saleOrderJSONs = new ArrayList<JSONObject>();
		JSONObject saleOrderJson = mappingModel.mappingModel(saleOrder);
		saleOrderJSONs.add(saleOrderJson);

		List<OrderDetail> saleOrderProducts = saleOrderProductService.getListProductOrderByIdOrder(idOrder);
		List<JSONObject> saleOrderProductJSONs = new ArrayList<JSONObject>();

		for (OrderDetail saleOrderProduct : saleOrderProducts) {
			saleOrderProductJSONs.add(mappingModel.mappingModel(saleOrderProduct));
		}

		result.put("saleOrder", saleOrderJSONs);
		result.put("saleOrderProduct", saleOrderProductJSONs);
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

		Order saleOrder = saleOrderService.getById(idOrder);

		if (isLogined()) {
			saleOrder.setUpdatedBy(getUserLogined().getId());
		}

		saleOrder.setUpdatedDate(Calendar.getInstance().getTime());

		if (status == 4) {
			List<OrderDetail> saleOrderProducts = saleOrder.getSaleOrderProducts();
			for (OrderDetail saleOrderProduct : saleOrderProducts) {
				Product product = saleOrderProduct.getProduct();
				/* product.setAmount(product.getAmount() + saleOrderProduct.getQuality()); */
				productService.saveOrUpdate(product);
			}
			saleOrder.setProcessingStatus(4);
			saleOrderService.saveOrUpdate(saleOrder);
		} else if (status == 0) {
			List<OrderDetail> saleOrderProducts = saleOrder.getSaleOrderProducts();
			for (OrderDetail saleOrderProduct : saleOrderProducts) {
				Product product = saleOrderProduct.getProduct();
				/* product.setAmount(product.getAmount() - saleOrderProduct.getQuality()); */
				productService.saveOrUpdate(product);
			}
			saleOrder.setProcessingStatus(0);
			saleOrderService.saveOrUpdate(saleOrder);
		} else {
			saleOrder.setUpdatedDate(Calendar.getInstance().getTime());
			saleOrder.setProcessingStatus(status);
			saleOrderService.saveOrUpdate(saleOrder);
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

		Order saleOrder = saleOrderService.getById(idOrder);

		if (isLogined()) {
			saleOrder.setUpdatedBy(getUserLogined().getId());
		}

		saleOrder.setUpdatedDate(Calendar.getInstance().getTime());

		List<OrderDetail> saleOrderProducts = saleOrder.getSaleOrderProducts();
		for (OrderDetail saleOrderProduct : saleOrderProducts) {
			Product product = saleOrderProduct.getProduct();
			/* product.setAmount(product.getAmount() + saleOrderProduct.getQuality()); */
			productService.saveOrUpdate(product);
		}
		saleOrder.setProcessingStatus(4);
		saleOrderService.saveOrUpdate(saleOrder);

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

		if (status==1) {
			Order saleOrder = saleOrderService.getById(idOrder);
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
		}else {
			Order saleOrder = saleOrderService.getById(idOrder);
			/* send email to customer */

			String emailReceiver = saleOrder.getCustomerEmail();
			String fullname = saleOrder.getCustomerName();
			String reason=request.getParameter("content").trim();
			
			MimeMessage message = emailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

			String htmlMsg = "<div>Dear " + fullname + " !</div> <br/><br/>";
			htmlMsg += "<div>Cảm ơn bạn thực hiện giao dịch trên <b>Electronic Device Shop</b>!</div> <br/>";
			htmlMsg += "<div>Yêu cầu hủy đơn hàng mã: <b>" + saleOrder.getCode() + "</b> không được phê duyệt!</div><br/>";
			htmlMsg += "<div>Lý do: "+reason+"</div><br/>";
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
