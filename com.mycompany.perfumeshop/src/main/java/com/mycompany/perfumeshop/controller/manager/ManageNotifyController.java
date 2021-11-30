package com.mycompany.perfumeshop.controller.manager;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mycompany.perfumeshop.controller.BaseController;
import com.mycompany.perfumeshop.dto.MappingModel;
import com.mycompany.perfumeshop.entities.OrderDetail;
import com.mycompany.perfumeshop.entities.RequestCancelOrder;
import com.mycompany.perfumeshop.service.DetailOrderService;
import com.mycompany.perfumeshop.service.NotifyService;
import com.mycompany.perfumeshop.service.OrderService;
import com.mycompany.perfumeshop.service.RequestCancelOrderService;

@Controller
@RequestMapping("/perfume-shop/")
public class ManageNotifyController extends BaseController {

	@Autowired
	private RequestCancelOrderService requestCancelOrderService;

	@Autowired
	private MappingModel mappingModel;

	@Autowired
	private OrderService saleOrderService;

	@Autowired
	private NotifyService notifyService;

	@Autowired
	private DetailOrderService saleOrderProductService;

	@SuppressWarnings("unchecked")
	@GetMapping("admin/load-top-three-notify")
	public ResponseEntity<JSONObject> getTopThrewNotify() throws Exception {
		JSONObject result = new JSONObject();
		List<RequestCancelOrder> requestCancelOrders = requestCancelOrderService.getTopThreeContact();

		List<JSONObject> requestCancelOrdersJSON = new ArrayList<JSONObject>();

		requestCancelOrders.forEach(r -> {
			requestCancelOrdersJSON.add(mappingModel.mappingModel(r));
		});

		result.put("notifies", requestCancelOrdersJSON);
		result.put("amountUnread", requestCancelOrderService.countUnreadNotify());

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

	@SuppressWarnings("unchecked")
	@PostMapping("admin/delete-notify")
	public ResponseEntity<JSONObject> delete(HttpServletRequest request) throws IOException {
		try {
			JSONObject result = new JSONObject();
			Integer idNotify = Integer.parseInt(request.getParameter("id-notify"));
			if (notifyService.deleteById(idNotify)) {
				result.put("message", Boolean.TRUE);
				return ResponseEntity.ok(result);
			} else {
				result.put("message", Boolean.FALSE);
				return ResponseEntity.ok(result);
			}

		} catch (Exception e) {
			return ResponseEntity.ok(null);
		}
	}

	@SuppressWarnings("unchecked")
	@GetMapping("admin/detail-order-notify")
	public ResponseEntity<JSONObject> getDetailOrderNotify(HttpServletRequest request) throws Exception {

		JSONObject result = new JSONObject();
		Integer idNotify = Integer.parseInt(request.getParameter("idNotify"));
		String idOrder = request.getParameter("idOrder");

		RequestCancelOrder requestCancelOrder = requestCancelOrderService.findById(idNotify);
		requestCancelOrder.setStatus(true);
		requestCancelOrderService.saveOrUpdate(requestCancelOrder);
		result.put("notify", mappingModel.mappingModel(requestCancelOrderService.findById(idNotify)));

		result.put("saleOrder", mappingModel.mappingModel(saleOrderService.findById(idOrder)));

		List<OrderDetail> saleOrderProducts = saleOrderProductService
				.findAllByOrder(saleOrderService.findById(idOrder));
		List<JSONObject> saleOrderProductJSONs = new ArrayList<JSONObject>();

		for (OrderDetail saleOrderProduct : saleOrderProducts) {
			saleOrderProductJSONs.add(mappingModel.mappingModel(saleOrderProduct));
		}
		result.put("saleOrderProduct", saleOrderProductJSONs);

		return ResponseEntity.ok(result);

	}
}
