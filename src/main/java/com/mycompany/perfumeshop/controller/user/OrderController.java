package com.mycompany.perfumeshop.controller.user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mycompany.perfumeshop.controller.BaseController;
import com.mycompany.perfumeshop.dto.MappingModel;
import com.mycompany.perfumeshop.entities.Order;
import com.mycompany.perfumeshop.service.OrderService;
import com.mycompany.perfumeshop.valueObjects.CustomerOrder;

@Controller
@RequestMapping("/perfume-shop/")
public class OrderController extends BaseController {

	@Autowired
	private OrderService orderService;

	@Autowired
	private MappingModel mappingModel;

	@GetMapping("order-by-account")
	public ResponseEntity<Map<String, Object>> getSaleOrderByAccount(@RequestParam("idAccount") Integer idAccount)
			throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Order> saleOrders = orderService.findByUserID(idAccount);
		List<JSONObject> saleOrdersJson = new ArrayList<JSONObject>();
		saleOrders.forEach(s -> {
			saleOrdersJson.add(mappingModel.mappingModel(s));
		});
		result.put("orders", saleOrdersJson);
		return ResponseEntity.ok(result);
	}

	@PostMapping("customer-order-searching")
	public ResponseEntity<Map<String, Object>> getSaleOrderByUser(@ModelAttribute CustomerOrder customerOrder)
			throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Order> orders = orderService.findAllByCustomer(customerOrder);
		List<JSONObject> orderJsons = new ArrayList<JSONObject>();
		orders.forEach(s -> {
			orderJsons.add(mappingModel.mappingModel(s));
		});
		result.put("orders", orderJsons);
		return ResponseEntity.ok(result);
	}

	@SuppressWarnings("unchecked")
	@GetMapping("oder-detail")
	public ResponseEntity<JSONObject> getDetailOrder(@RequestParam("idOrder") String idOrder) throws Exception {
		JSONObject result = new JSONObject();
		Order order = orderService.findById(idOrder);
		JSONObject orderJson = mappingModel.mappingModel(order);
		result.put("order", orderJson);
		return ResponseEntity.ok(result);
	}

	@GetMapping("order")
	public ResponseEntity<Order> getSaleOrderByIdOrder(@RequestParam("idOrder") String idOrder) throws Exception {
		return ResponseEntity.ok(orderService.findById(idOrder));
	}
}
