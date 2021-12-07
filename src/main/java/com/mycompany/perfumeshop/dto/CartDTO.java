package com.mycompany.perfumeshop.dto;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class CartDTO {
	private BigDecimal totalPrice = BigDecimal.ZERO;
	private List<CartItemDTO> cartItems = new ArrayList<CartItemDTO>();

	public CartItemDTO getCartItemByIdProduct(Integer attrProductId) {
		for (CartItemDTO cartItemDTO : cartItems) {
			if (cartItemDTO.getAttrProductId() == attrProductId) {
				return cartItemDTO;
			}
		}
		return null;
	}
}
