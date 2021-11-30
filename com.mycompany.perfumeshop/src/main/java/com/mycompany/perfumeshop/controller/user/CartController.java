package com.mycompany.perfumeshop.controller.user;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mycompany.perfumeshop.controller.BaseController;
import com.mycompany.perfumeshop.dto.CartDTO;
import com.mycompany.perfumeshop.dto.CartItemDTO;
import com.mycompany.perfumeshop.dto.SaleOrderDTO;
import com.mycompany.perfumeshop.entities.AttributeProduct;
import com.mycompany.perfumeshop.entities.Order;
import com.mycompany.perfumeshop.entities.OrderDetail;
import com.mycompany.perfumeshop.entities.User;
import com.mycompany.perfumeshop.service.AttributeProductService;
import com.mycompany.perfumeshop.service.OrderService;

@Controller
@RequestMapping("/perfume-shop/")
public class CartController extends BaseController {

	@Autowired
	private OrderService orderService;

	@Autowired
	private AttributeProductService attrService;

	@Autowired
	private JavaMailSender emailSender;

	@SuppressWarnings("unchecked")
	@PostMapping("cart/add")
	public ResponseEntity<JSONObject> addCart(HttpServletRequest request, @RequestBody CartItemDTO newCartItem)
			throws Exception {
		JSONObject result = new JSONObject();
		HttpSession session = request.getSession();
		CartDTO cartDTO;
		if (session.getAttribute("cart") == null) {
			cartDTO = new CartDTO();
			session.setAttribute("cart", cartDTO);
		} else {
			cartDTO = (CartDTO) session.getAttribute("cart");
		}
		List<CartItemDTO> cartItems = cartDTO.getCartItems();

		Boolean isExist = false;
		for (CartItemDTO cartItem : cartItems) {
			if (cartItem.getAttrProductId() == newCartItem.getAttrProductId()) {
				isExist = true;
				cartItem.setQuantity(cartItem.getQuantity() + newCartItem.getQuantity());
				break;
			}
		}

		if (!isExist) {
			AttributeProduct attributeProduct = attrService.findById(newCartItem.getAttrProductId());
			newCartItem.setAvatarProduct(attributeProduct.getProduct().getAvatar());
			newCartItem.setProductName(attributeProduct.getProduct().getTitle());
			newCartItem.setPriceUnit((attributeProduct.getPriceSale() != null
					&& attributeProduct.getPriceSale() != BigDecimal.valueOf(0)) ? attributeProduct.getPriceSale()
							: attributeProduct.getPrice());
			newCartItem.setMaxOrder(attributeProduct.getAmount());
			newCartItem.setCapacity(attributeProduct.getCapacity());
			cartItems.add(newCartItem);
		}
		result.put("code", 200);
		result.put("status", "TC");
		result.put("totalItems", getTotalItems(request));

		session.setAttribute("totalItems", getTotalItems(request));

		return ResponseEntity.ok(result);
	}

	@SuppressWarnings("unchecked")
	@PostMapping("cart/add-product")
	public ResponseEntity<JSONObject> addProductCart(HttpServletRequest request, @RequestBody CartItemDTO newCartItem)
			throws Exception {

		JSONObject result = new JSONObject();
		HttpSession session = request.getSession();

		CartDTO cartDTO;
		if (session.getAttribute("cart") == null) {
			cartDTO = new CartDTO();
			session.setAttribute("cart", cartDTO);
		} else {
			cartDTO = (CartDTO) session.getAttribute("cart");
		}

		List<CartItemDTO> cartItems = cartDTO.getCartItems();

		Boolean isExist = false;
		for (CartItemDTO cartItem : cartItems) {
			if (cartItem.getAttrProductId() == newCartItem.getAttrProductId()) {
				isExist = true;
				cartItem.setQuantity(newCartItem.getQuantity());
				break;
			}
		}

		if (!isExist) {
			AttributeProduct attributeProduct = attrService.findById(newCartItem.getAttrProductId());
			newCartItem.setAvatarProduct(attributeProduct.getProduct().getAvatar());
			newCartItem.setProductName(attributeProduct.getProduct().getTitle());

			newCartItem.setPriceUnit((attributeProduct.getPriceSale() != null
					&& attributeProduct.getPriceSale() != BigDecimal.valueOf(0)) ? attributeProduct.getPriceSale()
							: attributeProduct.getPrice());
			newCartItem.setMaxOrder(attributeProduct.getAmount());
			newCartItem.setCapacity(attributeProduct.getCapacity());
			cartItems.add(newCartItem);
		}
		result.put("code", 200);
		result.put("status", "TC");
		result.put("totalItems", getTotalItems(request));

		session.setAttribute("totalItems", getTotalItems(request));

		return ResponseEntity.ok(result);
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

	@GetMapping("cart.html")
	public String cart() {
		return "user/cart/cart";
	}

	@SuppressWarnings("unchecked")
	@PostMapping("Cart/DeleteCart")
	public ResponseEntity<JSONObject> deleteCart(HttpServletRequest request,
			@RequestParam("id_product") Integer idProduct) {
		HttpSession session = request.getSession();
		CartDTO cartDTO = (CartDTO) session.getAttribute("cart");
		List<CartItemDTO> cartItems = cartDTO.getCartItems();
		cartItems.remove(cartDTO.getCartItemByIdProduct(idProduct));
		JSONObject result = new JSONObject();
		result.put("message", "Xóa thành công");
		session.setAttribute("totalItems", getTotalItems(request));
		return ResponseEntity.ok(result);
	}

	@SuppressWarnings("unchecked")
	@PostMapping("Cart/DeleteSelectedCart")
	public ResponseEntity<JSONObject> deleteChosedCart(HttpServletRequest request,
			@RequestParam("id_product") String idAttr) {

		HttpSession session = request.getSession();
		CartDTO cartDTO = (CartDTO) session.getAttribute("cart");

		String[] arrIdProductStr = (idAttr == "") ? new String[] {} : idAttr.split(";");
		List<CartItemDTO> cartItemDelete = new ArrayList<CartItemDTO>();
		for (int i = 0; i < arrIdProductStr.length; i++) {
			if (arrIdProductStr[i] != "" || arrIdProductStr[i] != null) {
				cartItemDelete.add(cartDTO.getCartItemByIdProduct(Integer.parseInt(arrIdProductStr[i])));
			}
		}

		List<CartItemDTO> cartItems = cartDTO.getCartItems();
		for (CartItemDTO item : cartItemDelete) {
			cartItems.remove(item);
		}

		JSONObject result = new JSONObject();
		result.put("message", "Xóa thành công");
		session.setAttribute("totalItems", getTotalItems(request));

		return ResponseEntity.ok(result);
	}

	@GetMapping("bill")
	public String bill(Model model, @RequestParam("idAttr") Integer idAttr, @RequestParam("amount") Integer amount)
			throws Exception {
		model.addAttribute("attr", attrService.findById(idAttr));
		model.addAttribute("amount", amount);
		model.addAttribute("cartItems", null);
		model.addAttribute("totalMoney", null);
		model.addAttribute("account", getUserLogined());
		return "user/cart/pay";
	}

	@GetMapping("bill-cart")
	public String billCart(Model model, HttpServletRequest request, @RequestParam("strIdProduct") String strIdProduct)
			throws Exception {
		HttpSession session = request.getSession();

		CartDTO cart = (CartDTO) session.getAttribute("cart");

		String[] arrStrIdProduct = strIdProduct.split(";");

		List<CartItemDTO> cartItems = new ArrayList<CartItemDTO>();
		for (int i = 0; i < arrStrIdProduct.length; i++) {
			if (arrStrIdProduct[i] != "" || arrStrIdProduct[i] != null) {
				cartItems.add(cart.getCartItemByIdProduct(Integer.parseInt(arrStrIdProduct[i])));
			}
		}

		model.addAttribute("product", null);
		model.addAttribute("amount", 0);
		model.addAttribute("cartItems", cartItems);
		model.addAttribute("totalMoney", totalPay(cartItems));
		model.addAttribute("account", getUserLogined());

		if (isLogined()) {
			model.addAttribute("account", getUserLogined());
		} else {
			model.addAttribute("account", new User());
		}

		return "user/cart/pay";
	}

	private Double totalPay(List<CartItemDTO> cartItemDTOs) {
		Double total = 0.0;
		for (CartItemDTO cartItemDTO : cartItemDTOs) {
			total += cartItemDTO.getPriceUnit().doubleValue() * cartItemDTO.getQuantity();
		}
		return total;
	}

	@SuppressWarnings("unchecked")
	@PostMapping("order")
	public ResponseEntity<JSONObject> order(HttpServletRequest request, @ModelAttribute SaleOrderDTO saleOrderDTO,
			@RequestParam("strIdProduct") String strIdProduct, @RequestParam("amount") Integer amount)
			throws Exception {
		HttpSession session = request.getSession();

		Order order = new Order();

		order.setCustomerName(saleOrderDTO.getCustomerName());
		order.setCustomerPhone(saleOrderDTO.getCustomerPhone());
		order.setCustomerEmail(saleOrderDTO.getCustomerEmail());
		order.setCustomerAddress(saleOrderDTO.getCustomerAddress());
		order.setProcessingStatus(0);
		if (isLogined()) {
			User user = getUserLogined();
			order.setUserID(user.getId());
		}
		order.setCode("DH" + (System.currentTimeMillis() % 100000));
		order.setUpdatedDate(Calendar.getInstance().getTime());

		String[] arrStrIdProduct = strIdProduct.split(";");

		if (amount != 0) {
			if (arrStrIdProduct[0] != "" || arrStrIdProduct[0] != null) {
				OrderDetail orderDetail = new OrderDetail();
				AttributeProduct attributeProduct = attrService.findById(Integer.parseInt(arrStrIdProduct[0]));
				BigDecimal currentPrice = (attributeProduct.getPriceSale() != null
						&& attributeProduct.getPriceSale() != BigDecimal.valueOf(0)) ? attributeProduct.getPriceSale()
								: attributeProduct.getPrice();
				orderDetail.setAttributeProduct(attributeProduct);
				orderDetail.setQuantity(amount);
				orderDetail.setPrice(currentPrice);
				order.setTotal(new BigDecimal(amount * currentPrice.doubleValue()));

				attributeProduct.setAmount(attributeProduct.getAmount() - amount);
				attrService.saveOrUpdate(attributeProduct, getUserLogined());
				order.addOrderDetail(orderDetail);

				CartDTO cart = (CartDTO) session.getAttribute("cart");
				if (cart != null) {
					cart.getCartItems().remove(cart.getCartItemByIdProduct(attributeProduct.getId()));
				}
				session.setAttribute("cart", cart);

			}
		} else {
			CartDTO cart = (CartDTO) session.getAttribute("cart");

			List<CartItemDTO> cartItemsBuy = new ArrayList<CartItemDTO>();
			for (int i = 0; i < arrStrIdProduct.length; i++) {
				if (arrStrIdProduct[i] != "" || arrStrIdProduct[i] != null) {
					cartItemsBuy.add(cart.getCartItemByIdProduct(Integer.parseInt(arrStrIdProduct[i])));
				}
			}

			double total = 0;

			for (CartItemDTO cartItem : cartItemsBuy) {
				OrderDetail orderDetail = new OrderDetail();
				AttributeProduct attributeProduct = attrService.findById(Integer.parseInt(arrStrIdProduct[0]));
				BigDecimal currentPrice = (attributeProduct.getPriceSale() != null
						&& attributeProduct.getPriceSale() != BigDecimal.valueOf(0)) ? attributeProduct.getPriceSale()
								: attributeProduct.getPrice();
				orderDetail.setAttributeProduct(attributeProduct);
				orderDetail.setQuantity(cartItem.getQuantity());
				orderDetail.setPrice(currentPrice);
				attributeProduct.setAmount(attributeProduct.getAmount() - cartItem.getQuantity());
				attrService.saveOrUpdate(attributeProduct, getUserLogined());
				cart.getCartItems().remove(cartItem);
				total += cartItem.getQuantity() * cartItem.getPriceUnit().doubleValue();
				order.addOrderDetail(orderDetail);
			}
			order.setTotal(new BigDecimal(total));
			session.setAttribute("cart", cart);
		}

		orderService.saveOrUpdate(order, getUserLogined());
		JSONObject result = new JSONObject();
		result.put("message", "Đặt hàng thành công!");
		result.put("idOrder", order.getId());
		session.setAttribute("totalItems", getTotalItems(request));
		return ResponseEntity.ok(result);
	}

	@GetMapping("recent-order")
	public String getRecentOrder(final Model model, @RequestParam("idSaleOrder") String idSaleOrder) throws Exception {
		model.addAttribute("saleOrder", orderService.findById(idSaleOrder));
		return "user/cart/bill";
	}

	@GetMapping("search-order.html")
	public String searchOrder() {
		return "user/cart/searchOrder";
	}

	@SuppressWarnings("unchecked")
	@GetMapping("get-code-cancel-bill/{email}/{fullname}")
	public ResponseEntity<JSONObject> sendCode(@PathVariable String email, @PathVariable String fullname)
			throws Exception {
		String fullNameReceiver = fullname;
		String emailReceiver = email;
		if (isLogined()) {
			fullNameReceiver = getUserLogined().getFullname();
			emailReceiver = getUserLogined().getEmail();
		}
		Random random = new Random();
		Integer code = random.nextInt(900000) + 100000;
		MimeMessage message = emailSender.createMimeMessage();
		message.setContent(message, "text/plain; charset=UTF-8");
		MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
		String htmlMsg = "<div>Dear " + fullNameReceiver + " !</div> <br/><br/>";
		htmlMsg += "<div>Thank you for using the service at <b>Perfume Shop</b>!</div> <br/>";
		htmlMsg += "<div>Your order cancellation confirmation code is: <b>" + code + "</b>!</div><br/>";
		htmlMsg += "<div>Thanks & regards,</div><br/>";
		htmlMsg += "<div style=\"color: chartreuse;\"><b>Perfume Shop</b></div><br/>";
		message.setContent(htmlMsg, "text/html");
		helper.setTo(emailReceiver);
		helper.setSubject("[Perfume Shop] Order cancellation confirmation code.");
		emailSender.send(message);
		JSONObject result = new JSONObject();
		result.put("result", Boolean.TRUE);
		result.put("codeConfirm", code);
		return ResponseEntity.ok(result);
	}
}
