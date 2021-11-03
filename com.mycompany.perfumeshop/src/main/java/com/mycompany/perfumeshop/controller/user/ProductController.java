package com.mycompany.perfumeshop.controller.user;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.mycompany.perfumeshop.dto.UserSearchProduct;
import com.mycompany.perfumeshop.entities.Product;
import com.mycompany.perfumeshop.entities.ProductImage;
import com.mycompany.perfumeshop.service.CategoryService;
import com.mycompany.perfumeshop.service.ProductImageService;
import com.mycompany.perfumeshop.service.ProductService;

@Controller
public class ProductController extends BaseController {
	@Autowired
	private ProductService productService;

	@Autowired
	private ProductImageService productImageService;

	@Autowired
	private CategoryService categoryService;

	private static final Integer PAGE_SIZE = 9;

	private MappingModel mappingModel = new MappingModel();

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
	public ResponseEntity<Map<String, List<JSONObject>>> getAll(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException {

		Map<String, List<JSONObject>> result = new HashMap<String, List<JSONObject>>();

		Integer currentPage;
		Integer typeFilter;
		Integer typeOrder;
		Integer idCategory;
		String searchStr = request.getParameter("searchStr");
		try {
			currentPage = Integer.parseInt(request.getParameter("page"));
		} catch (Exception e) {
			currentPage = 1;
		}

		try {
			typeFilter = Integer.parseInt(request.getParameter("filterType"));
		} catch (Exception e) {
			typeFilter = 0;
		}

		try {
			typeOrder = Integer.parseInt(request.getParameter("typeOrder"));
		} catch (Exception e) {
			typeOrder = 0;
		}

		try {
			idCategory = Integer.parseInt(request.getParameter("id_category"));
		} catch (Exception e) {
			idCategory = 0;
		}

		UserSearchProduct userSearchProduct = new UserSearchProduct();
		userSearchProduct.setIdCategory(idCategory);
		userSearchProduct.setKeySearch(searchStr);
		userSearchProduct.setMaxMinPrice(typeFilter);
		userSearchProduct.setTypeOrder(typeOrder);

		List<Product> products = productService.getListProductByFilter(currentPage, PAGE_SIZE, userSearchProduct);

		List<JSONObject> listProduct = new ArrayList<>();
		for (Product product : products) {
			listProduct.add(mappingModel.mappingModel(product));
		}

		result.put("products", listProduct);

		List<JSONObject> listPage = new ArrayList<>();
		JSONObject pageJson = new JSONObject();
		pageJson.put("currentPage", currentPage);
		pageJson.put("totalPage", productService.getTotalPageProductByFilter(PAGE_SIZE, userSearchProduct));// pageSize
		listPage.add(pageJson);

		model.addAttribute("searchKey", searchStr);

		result.put("listPage", listPage);
		return ResponseEntity.ok(result);
	}

	@RequestMapping(value = { "/detail-product-loading" }, method = RequestMethod.GET)
	public ResponseEntity<Map<String, List<JSONObject>>> getProductDetail(final Model model,
			final HttpServletRequest request, final HttpServletResponse response) throws IOException {
		try {
			Map<String, List<JSONObject>> result = new HashMap<String, List<JSONObject>>();
			Integer idProduct = Integer.parseInt(request.getParameter("id_product"));

			List<JSONObject> product = new ArrayList<JSONObject>();
			product.add(mappingModel.mappingModel(productService.getById(idProduct)));

			List<ProductImage> images = productImageService.getListByIdProduct(idProduct);
			if (images.size() > 0) {
				List<JSONObject> imagesJSON = new ArrayList<JSONObject>();
				for (ProductImage image : images) {
					imagesJSON.add(mappingModel.mappingModel(image));
				}
				result.put("images", imagesJSON);
			} else {
				result.put("images", null);
			}

			result.put("product", product);
			return ResponseEntity.ok(result);
		} catch (Exception e) {
			return ResponseEntity.ok(null);
		}
	}

	@RequestMapping(value = { "/new-product" }, method = RequestMethod.GET)
	public ResponseEntity<List<JSONObject>> getNewProduct(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException {

		List<Product> products = productService.getNewProduct();
		List<JSONObject> listProduct = new ArrayList<>();
		for (Product product : products) {
			listProduct.add(mappingModel.mappingModel(product));
		}
		return ResponseEntity.ok(listProduct);
	}
}
