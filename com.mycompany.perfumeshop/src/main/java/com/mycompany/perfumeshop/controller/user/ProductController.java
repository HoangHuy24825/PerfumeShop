package com.mycompany.perfumeshop.controller.user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mycompany.perfumeshop.conf.GlobalConfig;
import com.mycompany.perfumeshop.controller.BaseController;
import com.mycompany.perfumeshop.dto.MappingModel;
import com.mycompany.perfumeshop.dto.ReviewDTO;
import com.mycompany.perfumeshop.entities.Product;
import com.mycompany.perfumeshop.entities.Review;
import com.mycompany.perfumeshop.service.AttributeProductService;
import com.mycompany.perfumeshop.service.CategoryService;
import com.mycompany.perfumeshop.service.ProductImageService;
import com.mycompany.perfumeshop.service.ProductService;
import com.mycompany.perfumeshop.service.ReviewService;
import com.mycompany.perfumeshop.utils.ConvertUtils;
import com.mycompany.perfumeshop.valueObjects.UserRequestToProduct;

@Controller
@RequestMapping("/perfume-shop/")
public class ProductController extends BaseController {

	@Autowired
	private ProductService productService;

	@Autowired
	private ProductImageService productImageService;

	@Autowired
	private CategoryService categoryService;

	@Autowired
	private AttributeProductService attributeService;

	@Autowired
	private ReviewService reviewService;

	@Autowired
	private GlobalConfig globalConfig;

	@Autowired
	private MappingModel mappingModel;

	@GetMapping("product.html")
	public String index(final Model model) throws Exception {
		model.addAttribute("totalProduct", productService.findByStatus(true).size());
		model.addAttribute("categories", categoryService.findByStatus(true));
		model.addAttribute("searchKey", "");
		return "user/product/product";
	}

	@GetMapping("product-category/{seo}")
	public String getProductByCategory(final Model model, @ModelAttribute("seo") String seo) throws Exception {
		model.addAttribute("totalProduct", productService.findByStatus(true).size());
		model.addAttribute("categories", categoryService.findByStatus(true));
		model.addAttribute("searchKey", "");
		model.addAttribute("idCategory", categoryService.findBySeo(seo).getId());
		return "user/product/product";
	}

	@GetMapping("detail-product/{seo}")
	public String detail(final Model model, @PathVariable("seo") String seo) throws Exception {
		model.addAttribute("id_product", productService.findBySeo(seo).getId());
		return "user/product/detail-product";
	}

	@SuppressWarnings("unchecked")
	@GetMapping("all-product")
	public ResponseEntity<JSONObject> getAll(final Model model, final HttpServletRequest request) throws Exception {

		JSONObject result = null;

		Integer currentPage = ConvertUtils.convertStringToInt(request.getParameter("page"), 1);
		Integer typeFilter = ConvertUtils.convertStringToInt(request.getParameter("filterType"), 0);
		Integer typeOrder = ConvertUtils.convertStringToInt(request.getParameter("typeOrder"), 0);
		Integer idCategory = ConvertUtils.convertStringToInt(request.getParameter("id_category"), 0);
		String searchStr = request.getParameter("searchStr");

		UserRequestToProduct userSearchProduct = new UserRequestToProduct();
		userSearchProduct.setIdCategory(idCategory);
		userSearchProduct.setKeySearch(searchStr);
		userSearchProduct.setTypeOrder(typeOrder);
		userSearchProduct.setCurrentPage(currentPage);
		userSearchProduct.setSizeOfPage(globalConfig.getSizeClientPage());
		userSearchProduct.setStatus(true);

		Page<Product> page = productService.findByUserRequestToProduct(userSearchProduct);

		if (page != null) {
			result = new JSONObject();

			List<JSONObject> listProduct = new ArrayList<>();
			if (page.getContent() != null) {
				List<Product> products = page.getContent();
				for (Product product : products) {
					product.setAttributeProducts(attributeService.findAllByProduct(product));
					product.setReviews(reviewService.findByProduct(product));
					product.setProductImages(productImageService.findByProduct(product));
					listProduct.add(mappingModel.mappingModel(product));
				}

			}
			result.put("products", listProduct);
			result.put("currentPage", page.getNumber() + 1);
			result.put("totalPage", page.getTotalPages());
			model.addAttribute("searchKey", searchStr);
		}
		return ResponseEntity.ok(result);
	}

	@SuppressWarnings("unchecked")
	@GetMapping("detail-product-loading")
	public ResponseEntity<JSONObject> getProductDetail(final HttpServletRequest request) throws Exception {
		JSONObject result = new JSONObject();
		Product product = productService.findById(request.getParameter("id_product"));
		result.put("product", mappingModel.mappingModel(product));
		return ResponseEntity.ok(result);
	}

	@SuppressWarnings("unchecked")
	@GetMapping("new-product")
	public ResponseEntity<JSONObject> getNewProduct() throws Exception {
		JSONObject result = new JSONObject();
		List<Product> products = productService.findTop8NewProduct();
		for (Product product : products) {
			product.setAttributeProducts(attributeService.findAllByProduct(product));
			product.setReviews(reviewService.findByProduct(product));
		}
		result.put("products", products);
		return ResponseEntity.ok(result);
	}
	
	@PostMapping("reviews-product")
	public ResponseEntity<Map<String, Object>> review(@ModelAttribute ReviewDTO reviewDto) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		Review review = reviewService.saveOrUpdate(mappingModel.mappingModel(reviewDto), getUserLogined());
		System.err.println((review != null && review.getId() != null));
		result.put("success", (review != null && review.getId() != null));
		result.put("code", 200);
		return ResponseEntity.ok(result);
	}

}
