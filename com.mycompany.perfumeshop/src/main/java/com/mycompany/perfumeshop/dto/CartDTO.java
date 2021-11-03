package com.mycompany.perfumeshop.dto;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class CartDTO {
	private BigDecimal totalPrice = BigDecimal.ZERO;
	private List<CartItemDTO> cartItems = new ArrayList<CartItemDTO>();

	public List<CartItemDTO> getCartItems() {
		return cartItems;
	}

	public void setCartItems(List<CartItemDTO> cartItems) {
		this.cartItems = cartItems;
	}

	public BigDecimal getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(BigDecimal totalPrice) {
		this.totalPrice = totalPrice;
	}

	public CartItemDTO getCartItemByIdProduct(Integer idProduct) {
		for (CartItemDTO cartItemDTO : cartItems) {
			if (cartItemDTO.getProductId() == idProduct) {
				return cartItemDTO;
			}
		}
		return null;
	}
}
