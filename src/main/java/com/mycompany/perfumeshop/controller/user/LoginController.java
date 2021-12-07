package com.mycompany.perfumeshop.controller.user;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mycompany.perfumeshop.controller.BaseController;
import com.mycompany.perfumeshop.dto.CartDTO;
import com.mycompany.perfumeshop.dto.CartItemDTO;
import com.mycompany.perfumeshop.entities.User;

@Controller
@RequestMapping("/perfume-shop/")
public class LoginController extends BaseController {

	@GetMapping("login.html")
	public String login(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.setAttribute("totalItems", getTotalItems(request));
		return "user/login/login";
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

	@GetMapping("login-success")
	public String showPageSuccess() throws Exception {
		User user = getUserLogined();
		if ("GUEST".equals(user.getUserRoles().get(0).getRoleName())) {
			return "redirect:/perfume-shop/home.html";
		} else {
			return "redirect:/perfume-shop/admin/dashboard.html";
		}
	}

}
