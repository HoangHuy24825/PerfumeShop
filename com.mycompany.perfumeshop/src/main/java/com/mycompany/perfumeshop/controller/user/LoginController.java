package com.mycompany.perfumeshop.controller.user;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mycompany.perfumeshop.controller.BaseController;
import com.mycompany.perfumeshop.dto.CartDTO;
import com.mycompany.perfumeshop.dto.CartItemDTO;

@Controller
public class LoginController extends BaseController {

	@RequestMapping(value = { "/login" }, method = RequestMethod.GET)
	public String login(final Model model, final HttpServletRequest request, final HttpServletResponse response)
			throws IOException {
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

}
