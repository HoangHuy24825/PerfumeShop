package com.mycompany.perfumeshop.controller.user;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mycompany.perfumeshop.controller.BaseController;
import com.mycompany.perfumeshop.dto.CartDTO;
import com.mycompany.perfumeshop.dto.CartItemDTO;
import com.mycompany.perfumeshop.dto.MappingModel;
import com.mycompany.perfumeshop.entities.Product;
import com.mycompany.perfumeshop.service.CategoryService;
import com.mycompany.perfumeshop.service.ProductService;

@Controller
@RequestMapping("/perfume-shop/")
public class HomeController extends BaseController {

	@Autowired
	private MappingModel mappingModel;

	@Autowired
	private ProductService productService;

	@Autowired
	private CategoryService categoryService;

	@GetMapping({ "", "home.html" })
	public String index(final Model model, HttpSession session) throws Exception {

		List<JSONObject> hotProductsJson = new ArrayList<JSONObject>();
		List<JSONObject> newProductsJson = new ArrayList<JSONObject>();

		List<Product> hotProducts = productService.findTop8ProductHot();
		List<Product> newProducts = productService.findTop8NewProduct();

		hotProducts.forEach(p -> {
			hotProductsJson.add(mappingModel.mappingModel(p));
		});

		newProducts.forEach(p -> {
			newProductsJson.add(mappingModel.mappingModel(p));
		});

		model.addAttribute("hotProducts", hotProductsJson);
		model.addAttribute("newProducts", newProductsJson);
		model.addAttribute("categories", categoryService.findByStatus(true));
		session.setAttribute("totalItems", getTotalItems(session));
		return "user/home/home";
	}

	public Integer getTotalItems(final HttpSession session) {
		if (session.getAttribute("cart") == null) {
			return 0;
		}
		CartDTO cart = (CartDTO) session.getAttribute("cart");
		List<CartItemDTO> cartItems = cart.getCartItems();
		int total = 0;
		for (CartItemDTO item : cartItems) {
			total += item.getQuantity();
		}
		return total;
	}
}
