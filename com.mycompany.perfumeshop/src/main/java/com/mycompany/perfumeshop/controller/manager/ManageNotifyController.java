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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mycompany.perfumeshop.controller.BaseController;
import com.mycompany.perfumeshop.dto.MappingModel;
import com.mycompany.perfumeshop.entities.RequestCancelOrder;
import com.mycompany.perfumeshop.entities.OrderDetail;
import com.mycompany.perfumeshop.service.RequestCancelOrderService;
import com.mycompany.perfumeshop.service.DetailOrderService;
import com.mycompany.perfumeshop.service.OrderService;

@Controller
public class ManageNotifyController extends BaseController {

	@Autowired
	private RequestCancelOrderService requestCancelOrderService;

	private MappingModel mappingModel = new MappingModel();

	@Autowired
	private OrderService saleOrderService;

	@Autowired
	private DetailOrderService saleOrderProductService;

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/admin/load-top-three-notify" }, method = RequestMethod.GET)
	public ResponseEntity<JSONObject> getTopThrewNotify(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException {
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
	@RequestMapping(value = { "/admin/load-all-notify" }, method = RequestMethod.GET)
	public ResponseEntity<JSONObject> getAll(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException {
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
	@RequestMapping(value = { "/admin/delete-notify" }, method = RequestMethod.POST)
	public ResponseEntity<JSONObject> delete(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException {
		try {
			JSONObject result = new JSONObject();
			Integer idNotify = Integer.parseInt(request.getParameter("id-notify"));
			if (requestCancelOrderService.deleteNotifyById(idNotify)) {
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
	@RequestMapping(value = { "/admin/detail-order-notify" }, method = RequestMethod.GET)
	public ResponseEntity<JSONObject> getDetailOrderNotify(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException {
		try {
			JSONObject result = new JSONObject();
			Integer idNotify = Integer.parseInt(request.getParameter("idNotify"));
			Integer idOrder = Integer.parseInt(request.getParameter("idOrder"));

			RequestCancelOrder requestCancelOrder = requestCancelOrderService.getById(idNotify);
			requestCancelOrder.setStatus(true);
			requestCancelOrderService.saveOrUpdate(requestCancelOrder);
			result.put("notify", mappingModel.mappingModel(requestCancelOrderService.getById(idNotify)));

			result.put("saleOrder", mappingModel.mappingModel(saleOrderService.getById(idOrder)));

			List<OrderDetail> saleOrderProducts = saleOrderProductService.getListProductOrderByIdOrder(idOrder);
			List<JSONObject> saleOrderProductJSONs = new ArrayList<JSONObject>();

			for (OrderDetail saleOrderProduct : saleOrderProducts) {
				saleOrderProductJSONs.add(mappingModel.mappingModel(saleOrderProduct));
			}
			result.put("saleOrderProduct", saleOrderProductJSONs);

			return ResponseEntity.ok(result);
		} catch (Exception e) {
			return ResponseEntity.ok(null);
		}
	}
}
