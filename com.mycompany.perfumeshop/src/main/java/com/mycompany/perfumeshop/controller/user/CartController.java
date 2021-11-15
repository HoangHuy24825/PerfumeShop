package com.mycompany.perfumeshop.controller.user;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.mycompany.perfumeshop.controller.BaseController;
import com.mycompany.perfumeshop.dto.CartDTO;
import com.mycompany.perfumeshop.dto.CartItemDTO;
import com.mycompany.perfumeshop.dto.SaleOrderDTO;
import com.mycompany.perfumeshop.entities.AttributeProduct;
import com.mycompany.perfumeshop.entities.Order;
import com.mycompany.perfumeshop.entities.OrderDetail;
import com.mycompany.perfumeshop.entities.User;
import com.mycompany.perfumeshop.service.DetailOrderService;
import com.mycompany.perfumeshop.service.OrderService;
import com.mycompany.perfumeshop.service.ProductAttributeService;
import com.mycompany.perfumeshop.service.ProductService;
import com.mycompany.perfumeshop.service.UserService;

@Controller
public class CartController extends BaseController {

	@Autowired
	private ProductService productService;

	@Autowired
	private UserService userService;

	@Autowired
	private OrderService saleOrderService;

	@Autowired
	private ProductAttributeService attrService;

	@Autowired
	private DetailOrderService saleOrderProductService;

	@Autowired
	private JavaMailSender emailSender;

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "cart/add", method = RequestMethod.POST)
	public ResponseEntity<JSONObject> addCart(final Model model, final HttpServletRequest request,
			final HttpServletResponse respond, @RequestBody CartItemDTO newCartItem) {

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
			AttributeProduct attributeProduct = attrService.getById(newCartItem.getAttrProductId());
			newCartItem.setAvatarProduct(attributeProduct.getProduct().getAvatar());
			newCartItem.setProductName(attributeProduct.getProduct().getTitle());
			newCartItem.setPriceUnit((attributeProduct.getPriceSale() != null
					&& attributeProduct.getPriceSale() != BigDecimal.valueOf(0)) ? attributeProduct.getPriceSale()
							: attributeProduct.getPrice());
			newCartItem.setMaxOrder(attributeProduct.getAmount());
			cartItems.add(newCartItem);
		}
		result.put("code", 200);
		result.put("status", "TC");
		result.put("totalItems", getTotalItems(request));

		session.setAttribute("totalItems", getTotalItems(request));

		return ResponseEntity.ok(result);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/cart/add-product", method = RequestMethod.POST)
	public ResponseEntity<JSONObject> addProductCart(final Model model, final HttpServletRequest request,
			final HttpServletResponse respond, @RequestBody CartItemDTO newCartItem) {

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
			AttributeProduct attributeProduct = attrService.getById(newCartItem.getAttrProductId());
			newCartItem.setAvatarProduct(attributeProduct.getProduct().getAvatar());
			newCartItem.setProductName(attributeProduct.getProduct().getTitle());

			newCartItem.setPriceUnit((attributeProduct.getPriceSale() != null
					&& attributeProduct.getPriceSale() != BigDecimal.valueOf(0)) ? attributeProduct.getPriceSale()
							: attributeProduct.getPrice());
			newCartItem.setMaxOrder(attributeProduct.getAmount());

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

	@RequestMapping(value = "cart", method = RequestMethod.GET)
	public String cart(final Model model, final HttpServletRequest request, final HttpServletResponse respond) {
		return "user/cart/cart";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/Cart/DeleteCart", method = RequestMethod.POST)
	public ResponseEntity<JSONObject> deleteCart(final Model model, final HttpServletRequest request,
			final HttpServletResponse respond, @RequestParam("id_product") Integer idProduct) {
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
	@RequestMapping(value = "/Cart/DeleteSelectedCart", method = RequestMethod.POST)
	public ResponseEntity<JSONObject> deleteChosedCart(final Model model, final HttpServletRequest request,
			final HttpServletResponse respond, @RequestParam("id_product") String idAttr) {

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

	@RequestMapping(value = "/bill", method = RequestMethod.GET)
	public String bill(final Model model, final HttpServletRequest request, HttpServletResponse response,
			@RequestParam("idProduct") Integer idProduct, @RequestParam("amount") Integer amount) {
		model.addAttribute("product", productService.getById(idProduct));
		model.addAttribute("amount", amount);
		model.addAttribute("cartItems", null);
		model.addAttribute("totalMoney", null);
		model.addAttribute("account", getUserLogined());
		return "user/cart/pay";
	}

	@RequestMapping(value = "/bill-cart", method = RequestMethod.GET)
	public String billCart(final Model model, final HttpServletRequest request, HttpServletResponse response,
			@RequestParam("strIdProduct") String strIdProduct) {
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
	@RequestMapping(value = { "/order" }, method = RequestMethod.POST)
	public ResponseEntity<JSONObject> order(final Model model, final HttpServletRequest request,
			final HttpServletResponse response, @ModelAttribute SaleOrderDTO saleOrderDTO,
			@RequestParam("strIdProduct") String strIdProduct, @RequestParam("amount") Integer amount)
			throws Exception {
		HttpSession session = request.getSession();

		Order saleOrder = new Order();

		saleOrder.setCustomerName(saleOrderDTO.getCustomerName());
		saleOrder.setCustomerPhone(saleOrderDTO.getCustomerPhone());
		saleOrder.setCustomerEmail(saleOrderDTO.getCustomerEmail());
		saleOrder.setCustomerAddress(saleOrderDTO.getCustomerAddress());
		saleOrder.setProcessingStatus(0);
		if (isLogined()) {
			User user = getUserLogined();
			saleOrder.setUserID(user.getId());
		}
		saleOrder.setCode("DH" + (System.currentTimeMillis() % 100000));
		saleOrder.setUpdatedDate(Calendar.getInstance().getTime());

		saleOrderService.saveOrUpdate(saleOrder);
		Order orderFromDB = saleOrderService.getLastSaleOrderByCustomer(saleOrder.getCustomerName(),
				saleOrder.getCustomerAddress(), saleOrder.getCustomerPhone(), saleOrder.getCustomerEmail());

		String[] arrStrIdProduct = strIdProduct.split(";");

		if (amount != 0) {
			if (arrStrIdProduct[0] != "" || arrStrIdProduct[0] != null) {
				OrderDetail orderDetail = new OrderDetail();
				AttributeProduct attributeProduct = attrService.getById(Integer.parseInt(arrStrIdProduct[0]));
				BigDecimal currentPrice = (attributeProduct.getPriceSale() != null
						&& attributeProduct.getPriceSale() != BigDecimal.valueOf(0)) ? attributeProduct.getPriceSale()
								: attributeProduct.getPrice();
				orderDetail.setAttributeProduct(attributeProduct);
				orderDetail.setQuantity(amount);
				orderDetail.setPrice(currentPrice);
				orderDetail.setOrder(orderFromDB);

				orderFromDB.setTotal(new BigDecimal(amount * currentPrice.doubleValue()));

				attributeProduct.setAmount(attributeProduct.getAmount() - amount);
				attrService.saveOrUpdate(attributeProduct);
				saleOrderProductService.saveOrUpdate(orderDetail);
				orderFromDB.addSaleOrderProducts(orderDetail);

				CartDTO cart = (CartDTO) session.getAttribute("cart");
				cart.getCartItems().remove(cart.getCartItemByIdProduct(attributeProduct.getId()));
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

				AttributeProduct attributeProduct = attrService.getById(Integer.parseInt(arrStrIdProduct[0]));
				BigDecimal currentPrice = (attributeProduct.getPriceSale() != null
						&& attributeProduct.getPriceSale() != BigDecimal.valueOf(0)) ? attributeProduct.getPriceSale()
								: attributeProduct.getPrice();

				orderDetail.setAttributeProduct(attributeProduct);
				orderDetail.setQuantity(cartItem.getQuantity());
				orderDetail.setPrice(currentPrice);
				orderDetail.setOrder(orderFromDB);

				attributeProduct.setAmount(attributeProduct.getAmount() - cartItem.getQuantity());

				attrService.saveOrUpdate(attributeProduct);

				saleOrderProductService.saveOrUpdate(orderDetail);
				cart.getCartItems().remove(cartItem);

				total += cartItem.getQuantity() * cartItem.getPriceUnit().doubleValue();
				orderFromDB.addSaleOrderProducts(orderDetail);

			}

			orderFromDB.setTotal(new BigDecimal(total));
			session.setAttribute("cart", cart);

		}

		saleOrderService.saveOrUpdate(orderFromDB);
		JSONObject result = new JSONObject();
		result.put("message", "Đặt hàng thành công!");
		result.put("idSaleOrder", orderFromDB.getId());
		session.setAttribute("totalItems", getTotalItems(request));
		return ResponseEntity.ok(result);
	}

	@RequestMapping(value = { "/recent-order" }, method = RequestMethod.GET)
	public String getRecentOrder(final Model model, final HttpServletRequest request,
			final HttpServletResponse response, @RequestParam("idSaleOrder") Integer idSaleOrder) throws IOException {
		model.addAttribute("saleOrder", saleOrderService.getById(idSaleOrder));
		return "user/cart/bill";
	}

	@RequestMapping(value = { "/search-order" }, method = RequestMethod.GET)
	public String searchOrder(final Model model, final HttpServletRequest request, final HttpServletResponse response)
			throws IOException {
		return "user/cart/searchOrder";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/get-code-cancel-bill" }, method = RequestMethod.GET)
	public ResponseEntity<JSONObject> sendCode(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException, MessagingException {
		String emailReceiver = request.getParameter("email");
		String fullname = request.getParameter("fullname");

		Random random = new Random();
		Integer code = random.nextInt(900000) + 100000;

		MimeMessage message = emailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

		String htmlMsg = "<div>Dear " + fullname + " !</div> <br/><br/>";
		htmlMsg += "<div>Cảm ơn bạn đã sử dụng dịch vụ tại <b>Electronic Device Shop</b>!</div> <br/>";
		htmlMsg += "<div>Mã xác nhận hủy đơn hàng của bạn là: <b>" + code + "</b>!</div><br/>";
		htmlMsg += "<div>Thanks & regards,</div><br/>";
		htmlMsg += "<div style=\"color: chartreuse;\"><b>Electronic Device</b></div><br/>";

		message.setContent(htmlMsg, "text/html");
		helper.setTo(emailReceiver);
		helper.setSubject("[Electronic Device Shop] Mã xác nhận hủy đơn hàng.");

		emailSender.send(message);
		JSONObject result = new JSONObject();
		result.put("result", Boolean.TRUE);
		result.put("codeConfirm", code);
		return ResponseEntity.ok(result);
	}
}
