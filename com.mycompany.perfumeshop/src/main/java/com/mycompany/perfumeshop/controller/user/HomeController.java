package com.mycompany.perfumeshop.controller.user;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mycompany.perfumeshop.controller.BaseController;
import com.mycompany.perfumeshop.dto.CartDTO;
import com.mycompany.perfumeshop.dto.CartItemDTO;
import com.mycompany.perfumeshop.dto.MappingModel;
import com.mycompany.perfumeshop.entities.Product;
import com.mycompany.perfumeshop.service.CategoryService;
import com.mycompany.perfumeshop.service.ProductService;

@Controller
public class HomeController extends BaseController {

	@Autowired
	private MappingModel mappingModel;

	@Autowired
	private ProductService productService;

	@Autowired
	private CategoryService categoryService;

	@RequestMapping(value = { "/", "/home" }, method = RequestMethod.GET)
	public String index(final Model model, final HttpServletRequest request, final HttpServletResponse response)
			throws IOException {

		List<JSONObject> hotProductsJson = new ArrayList<JSONObject>();
		List<JSONObject> newProductsJson = new ArrayList<JSONObject>();

		List<Product> hotProducts = productService.getHotProduct();
		List<Product> newProducts = productService.getNewProduct();

		hotProducts.forEach(p -> {
			hotProductsJson.add(mappingModel.mappingModel(p));
		});

		newProducts.forEach(p -> {
			newProductsJson.add(mappingModel.mappingModel(p));
		});

		model.addAttribute("hotProducts", hotProductsJson);
		model.addAttribute("newProducts", newProductsJson);
		model.addAttribute("categories", categoryService.findAllActive());
		HttpSession session = request.getSession();
		session.setAttribute("totalItems", getTotalItems(request));
		return "user/home/home";
	}

	public Integer getTotalItems(final HttpServletRequest request) {
		HttpSession httpSession = request.getSession();

		if (httpSession.getAttribute("cart") == null) {
			return 0;
		}

		CartDTO cart = (CartDTO) httpSession.getAttribute("cart");
		List<CartItemDTO> cartItems = cart.getCartItems();

		int total = 0;
		for (CartItemDTO item : cartItems) {
			total += item.getQuantity();
		}

		return total;
	}
}
