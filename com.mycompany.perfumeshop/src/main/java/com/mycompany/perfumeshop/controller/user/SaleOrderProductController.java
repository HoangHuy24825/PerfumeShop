package com.mycompany.perfumeshop.controller.user;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.mycompany.perfumeshop.dto.MappingModel;
import com.mycompany.perfumeshop.entities.Order;
import com.mycompany.perfumeshop.entities.OrderDetail;
import com.mycompany.perfumeshop.service.DetailOrderService;
import com.mycompany.perfumeshop.service.OrderService;

@Controller
public class SaleOrderProductController extends BaseController {

	@Autowired
	private OrderService saleOrderService;

	@Autowired
	private DetailOrderService saleOrderProductService;

	private MappingModel mappingModel = new MappingModel();

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/load-sale-order-id-account" }, method = RequestMethod.GET)
	public ResponseEntity<JSONObject> getSaleOrderByAccount(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException {
		JSONObject result = new JSONObject();
		Integer idAccount;
		try {
			idAccount = Integer.parseInt(request.getParameter("idAccount"));
		} catch (Exception e) {
			return ResponseEntity.ok(result);
		}
		List<Order> saleOrders = saleOrderService.getSaleOrderByAccount(idAccount);

		List<JSONObject> saleOrdersJson = new ArrayList<JSONObject>();

		saleOrders.forEach(s -> {
			saleOrdersJson.add(mappingModel.mappingModel(s));
		});

		result.put("saleOrders", saleOrdersJson);
		return ResponseEntity.ok(result);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/load-sale-order-user-searching" }, method = RequestMethod.GET)
	public ResponseEntity<JSONObject> getSaleOrderByUser(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException {
		JSONObject result = new JSONObject();

		String fullname = request.getParameter("fullname");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");

		List<Order> saleOrders = saleOrderService.getSaleOrderByUser(fullname, email, phone);

		List<JSONObject> saleOrdersJson = new ArrayList<JSONObject>();

		saleOrders.forEach(s -> {
			saleOrdersJson.add(mappingModel.mappingModel(s));
		});

		result.put("saleOrders", saleOrdersJson);
		return ResponseEntity.ok(result);
	}

	@RequestMapping(value = { "/sale-order-product-id-order" }, method = RequestMethod.GET)
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
		result.put("saleOrderProducts", saleOrderProductJSONs);
		return ResponseEntity.ok(result);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/load-sale-order-id-order" }, method = RequestMethod.GET)
	public ResponseEntity<JSONObject> getSaleOrderByIdOrder(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException {
		JSONObject result = new JSONObject();
		Integer idOrder;
		try {
			idOrder = Integer.parseInt(request.getParameter("idOrder"));
		} catch (Exception e) {
			return ResponseEntity.ok(result);
		}

		JSONObject saleOrdersJson = mappingModel.mappingModel(saleOrderService.getById(idOrder));

		result.put("saleOrder", saleOrdersJson);
		return ResponseEntity.ok(result);
	}
}
