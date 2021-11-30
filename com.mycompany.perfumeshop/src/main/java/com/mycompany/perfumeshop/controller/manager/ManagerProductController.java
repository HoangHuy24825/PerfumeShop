package com.mycompany.perfumeshop.controller.manager;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mycompany.perfumeshop.conf.GlobalConfig;
import com.mycompany.perfumeshop.controller.BaseController;
import com.mycompany.perfumeshop.dto.MappingModel;
import com.mycompany.perfumeshop.dto.ProductDTO;
import com.mycompany.perfumeshop.entities.AttributeProduct;
import com.mycompany.perfumeshop.entities.Product;
import com.mycompany.perfumeshop.entities.ProductImage;
import com.mycompany.perfumeshop.service.AttributeProductService;
import com.mycompany.perfumeshop.service.CategoryService;
import com.mycompany.perfumeshop.service.ProductImageService;
import com.mycompany.perfumeshop.service.ProductService;
import com.mycompany.perfumeshop.service.UserService;
import com.mycompany.perfumeshop.utils.ConvertUtils;
import com.mycompany.perfumeshop.valueObjects.UserRequestToProduct;

@Controller
@RequestMapping("/perfume-shop/")
public class ManagerProductController extends BaseController {

	@Autowired
	private CategoryService categoryService;

	@Autowired
	private ProductService productService;

	@Autowired
	private ProductImageService productImageService;

	@Autowired
	private AttributeProductService productAttrService;

	@Autowired
	private UserService userService;

	@Autowired
	private MappingModel mappingModel;

	@Autowired
	private GlobalConfig globalConfig;

	@GetMapping("admin/product.html")
	public String index() {
		return "manager/product/index";
	}

	@SuppressWarnings("unchecked")
	@GetMapping("admin/all-product")
	public ResponseEntity<JSONObject> getAll(HttpServletRequest request) throws Exception {
		Integer currentPage = ConvertUtils.convertStringToInt(request.getParameter("currentPage"), 1);
		Integer idCategory = ConvertUtils.convertStringToInt(request.getParameter("idCategory"), 0);
		String statusFromReq = request.getParameter("status");
		Boolean status = null;
		if (statusFromReq != null && statusFromReq.equals("1")) {
			status = true;
		} else if (statusFromReq != null && statusFromReq.equals("0")) {
			status = false;
		}
		String keySearch = request.getParameter("keySearch");

		UserRequestToProduct requestToProduct = new UserRequestToProduct(keySearch, null, null, null, idCategory,
				currentPage, globalConfig.getSizeManagePage(), status);

		Page<Product> page = productService.findByUserRequestToProduct(requestToProduct);
		List<JSONObject> listProduct = new ArrayList<>();
		List<Product> products = page.getContent();
		for (Product product : products) {
			listProduct.add(mappingModel.mappingModel(product));
		}
		JSONObject result = new JSONObject();
		result.put("products", listProduct);
		result.put("currentPage", page.getNumber() + 1);
		result.put("totalPage", page.getTotalPages());
		return ResponseEntity.ok(result);
	}

	@PostMapping("admin/add-update-product")
	public ResponseEntity<Object> add(@ModelAttribute ProductDTO productDTO) throws Exception {

		productDTO.setDetail(productDTO.getDetail().replaceFirst(",", " ").trim());
		Product product = mappingModel.mappingModel(productDTO);
		product.setCategory(categoryService.findById(productDTO.getId_category()));
		if (product.getId() == null) {
			if (isLogined()) {
				product.setCreatedBy(getUserLogined().getId());
			}
			productService.saveOrUpdate(product, productDTO.getAvatar(), productDTO.getImages(), getUserLogined());
		} else {
			if (isLogined()) {
				product.setUpdatedBy(getUserLogined().getId());
			}
			productService.saveOrUpdate(product, productDTO.getAvatar(), productDTO.getImages(), getUserLogined());
		}
		return ResponseEntity.ok(null);
	}

	@GetMapping("admin/product-detail/{seo}")
	public String detail(Model model, @PathVariable("seo") String seo) throws Exception {
		Product product = productService.findBySeo(seo);

		model.addAttribute("createdBy", userService.findById(product.getCreatedBy()));
		if (product.getUpdatedBy() != null) {
			model.addAttribute("updatedBy", userService.findById(product.getUpdatedBy()));
		} else {
			model.addAttribute("updatedBy", null);
		}

		model.addAttribute("product", product);
		return "manager/product/detail";
	}

	@GetMapping("admin/edit-product/{seo}")
	public String edit(Model model, @PathVariable("seo") String seo) throws Exception {
		model.addAttribute("id_product", productService.findBySeo(seo).getId());
		return "manager/product/createOrUpdate";
	}

	@RequestMapping(value = { "/admin/add-product" }, method = RequestMethod.GET)
	public String add(Model model) {
		model.addAttribute("id_product", null);
		return "manager/product/createOrUpdate";
	}

	@GetMapping("product/{id}")
	public ResponseEntity<Product> detailProduct(@PathVariable String id) throws Exception {
		Product product = productService.findById(id);
		List<ProductImage> productImages = productImageService.findByProduct(product);
		List<AttributeProduct> attributeProducts = productAttrService.findAllByProduct(product);
		product.setAttributeProducts(attributeProducts);
		product.setProductImages(productImages);
		return ResponseEntity.ok(product);
	}

	@DeleteMapping("product/{id}")
	public ResponseEntity<Boolean> delete(@PathVariable String id) throws Exception {
		return ResponseEntity.ok(productService.deleteById(id));
	}

	@PostMapping("/admin/change-detail-product")
	public ResponseEntity<Boolean> changeDetail(HttpServletRequest request) throws Exception {
		Integer type = ConvertUtils.convertStringToInt(request.getParameter("type"), null);
		Product product = productService.findById(request.getParameter("id"));
		if (product == null) {
			return ResponseEntity.ok(Boolean.FALSE);
		}
		if (type != null && type == 0) {
			boolean status = request.getParameter("status").equals("1");
			product.setStatus(status);
		} else if (type != null && type == 1) {
			boolean isHot = request.getParameter("isHot").equals("1");
			product.setIsHot(isHot);
		}
		if (isLogined()) {
			product.setUpdatedBy(getUserLogined().getId());
		}
		product.setUpdatedDate(Calendar.getInstance().getTime());
		productService.saveOrUpdate(product, getUserLogined());
		return ResponseEntity.ok(Boolean.TRUE);
	}
}
