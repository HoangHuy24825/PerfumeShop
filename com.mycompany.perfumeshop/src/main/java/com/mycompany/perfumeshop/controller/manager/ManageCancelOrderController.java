package com.mycompany.perfumeshop.controller.manager;

import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mycompany.perfumeshop.controller.BaseController;
import com.mycompany.perfumeshop.dto.MappingModel;
import com.mycompany.perfumeshop.entities.RequestCancelOrder;
import com.mycompany.perfumeshop.service.NotifyService;
import com.mycompany.perfumeshop.service.OrderService;
import com.mycompany.perfumeshop.service.RequestCancelOrderService;

@Controller
@RequestMapping("/perfume-shop/")
public class ManageCancelOrderController extends BaseController {

	@Autowired
	private RequestCancelOrderService requestCancelOrderService;

	@Autowired
	private MappingModel mappingModel;

	@Autowired
	private OrderService saleOrderService;

	@Autowired
	private NotifyService notifyService;

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

	@PostMapping("admin/delete-notify/{id}")
	public ResponseEntity<Boolean> delete(@PathVariable String id) throws Exception {
		return ResponseEntity.ok(notifyService.deleteById(id));
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
}
