package com.mycompany.perfumeshop.controller.user;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mycompany.perfumeshop.controller.BaseController;
import com.mycompany.perfumeshop.dto.MappingModel;
import com.mycompany.perfumeshop.entities.Product;
import com.mycompany.perfumeshop.request.UserSearchProduct;
import com.mycompany.perfumeshop.service.CategoryService;
import com.mycompany.perfumeshop.service.ProductAttributeService;
import com.mycompany.perfumeshop.service.ProductService;
import com.mycompany.perfumeshop.service.ReviewService;
import com.mycompany.perfumeshop.service.impl.ProductImageServiceImpl;
import com.mycompany.perfumeshop.utils.ConvertUtils;
import com.mycompany.perfumeshop.valueObjects.BaseVo;

@Controller
public class ProductController extends BaseController {

	@Autowired
	private ProductService productService;

	@Autowired
	private ProductImageServiceImpl productImageService;

	@Autowired
	private CategoryService categoryService;

	@Autowired
	private ProductAttributeService attributeService;

	@Autowired
	private ReviewService reviewService;

	private static final Integer PAGE_SIZE = 9;

	@Autowired
	private MappingModel mappingModel;

	@RequestMapping(value = { "/product", "/product/index" }, method = RequestMethod.GET)
	public String index(final Model model, final HttpServletRequest request, final HttpServletResponse response)
			throws IOException {
		model.addAttribute("totalProduct", productService.findAllActive().size());
		model.addAttribute("categories", categoryService.findAllActive());
		model.addAttribute("searchKey", "");
		return "user/product/product";
	}

	@RequestMapping(value = { "/product-category/{seo}" }, method = RequestMethod.GET)
	public String getProductByCategory(final Model model, final HttpServletRequest request,
			final HttpServletResponse response, @ModelAttribute("seo") String seo) throws IOException {

		model.addAttribute("totalProduct", productService.findAllActive().size());
		model.addAttribute("categories", categoryService.findAllActive());
		model.addAttribute("searchKey", "");
		model.addAttribute("idCategory", categoryService.getBySeo(seo).getId());
		return "user/product/product";
	}

	@RequestMapping(value = { "/detail-product/{seo}" }, method = RequestMethod.GET)
	public String detail(final Model model, final HttpServletRequest request, final HttpServletResponse response,
			@PathVariable("seo") String seo) throws IOException {
		model.addAttribute("id_product", productService.getBySeo(seo).getId());
		return "user/product/detail-product";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/all-product" }, method = RequestMethod.GET)
	public ResponseEntity<JSONObject> getAll(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException {

		JSONObject result = null;

		Integer currentPage = ConvertUtils.convertStringToInt(request.getParameter("page"), 1);
		Integer typeFilter = ConvertUtils.convertStringToInt(request.getParameter("filterType"), 0);
		Integer typeOrder = ConvertUtils.convertStringToInt(request.getParameter("typeOrder"), 0);
		Integer idCategory = ConvertUtils.convertStringToInt(request.getParameter("id_category"), 0);
		String searchStr = request.getParameter("searchStr");

		UserSearchProduct userSearchProduct = new UserSearchProduct();
		userSearchProduct.setIdCategory(idCategory);
		userSearchProduct.setKeySearch(searchStr);
		userSearchProduct.setMaxMinPrice(typeFilter);
		userSearchProduct.setTypeOrder(typeOrder);

		BaseVo<Product> baseVo = productService.getListProductByFilter(currentPage, PAGE_SIZE, userSearchProduct);

		if (baseVo != null) {
			result = new JSONObject();

			List<JSONObject> listProduct = new ArrayList<>();
			if (baseVo.getListEntity() != null) {
				List<Product> products = baseVo.getListEntity();
				for (Product product : products) {
					product.setAttributeProducts(attributeService.getListByIdProduct(product.getId()));
					product.setReviews(reviewService.findAllByIdProduct(product.getId()));
					product.setProductImages(productImageService.findByProduct(product));
					listProduct.add(mappingModel.mappingModel(product));
				}

			}
			result.put("products", listProduct);
			result.put("currentPage", baseVo.getCurrentPage());
			result.put("totalPage", baseVo.getTotalPage());
			model.addAttribute("searchKey", searchStr);
		}
		return ResponseEntity.ok(result);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/detail-product-loading" }, method = RequestMethod.GET)
	public ResponseEntity<JSONObject> getProductDetail(final HttpServletRequest request) throws IOException {
		try {
			JSONObject result = new JSONObject();
			Integer idProduct = ConvertUtils.convertStringToInt(request.getParameter("id_product"), null);
			if (idProduct != null) {
				Product product = productService.getById(idProduct);
				product.setAttributeProducts(attributeService.getListByIdProduct(product.getId()));
				product.setReviews(reviewService.findAllByIdProduct(product.getId()));
				product.setProductImages(productImageService.findByProduct(product));
				result.put("product", mappingModel.mappingModel(product));
			}
			return ResponseEntity.ok(result);
		} catch (Exception e) {
			return ResponseEntity.ok(null);
		}
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/new-product" }, method = RequestMethod.GET)
	public ResponseEntity<JSONObject> getNewProduct(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException {
		JSONObject result = new JSONObject();
		List<Product> products = productService.getNewProduct();
		for (Product product : products) {
			product.setAttributeProducts(attributeService.getListByIdProduct(product.getId()));
			product.setReviews(reviewService.findAllByIdProduct(product.getId()));
		}
		result.put("products", products);
		return ResponseEntity.ok(result);
	}
}
