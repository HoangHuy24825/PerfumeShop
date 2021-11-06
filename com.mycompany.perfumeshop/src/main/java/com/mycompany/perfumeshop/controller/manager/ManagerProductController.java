package com.mycompany.perfumeshop.controller.manager;

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
import org.springframework.web.bind.annotation.RequestParam;

import com.mycompany.perfumeshop.controller.BaseController;
import com.mycompany.perfumeshop.dto.MappingModel;
import com.mycompany.perfumeshop.dto.ProductDTO;
import com.mycompany.perfumeshop.entities.Product;
import com.mycompany.perfumeshop.entities.ProductImage;
import com.mycompany.perfumeshop.service.CategoryService;
import com.mycompany.perfumeshop.service.ProductImageService;
import com.mycompany.perfumeshop.service.ProductService;
import com.mycompany.perfumeshop.service.UserService;
import com.mycompany.perfumeshop.utils.ConvertUtils;
import com.mycompany.perfumeshop.valueObjects.BaseVo;

@Controller
public class ManagerProductController extends BaseController {

	@Autowired
	private CategoryService categoryService;

	@Autowired
	private ProductService productService;

	@Autowired
	private ProductImageService productImageService;

	@Autowired
	private UserService userService;

	private MappingModel mappingModel = new MappingModel();

	private static final Integer pageSize = 8;

	@RequestMapping(value = { "/admin/product", "/admin/product/index" }, method = RequestMethod.GET)
	public String index(final Model model, final HttpServletRequest request, final HttpServletResponse response)
			throws IOException {
		return "manager/product/index";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/admin/all-product" }, method = RequestMethod.GET)
	public ResponseEntity<JSONObject> getAll(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException {

		Integer currentPage = ConvertUtils.convertStringToInt(request.getParameter("currentPage"), 1);
		Integer idCategory = ConvertUtils.convertStringToInt(request.getParameter("idCategory"), 0);
		Integer statusProduct = ConvertUtils.convertStringToInt(request.getParameter("idCategory"), null);
		String keySearch = request.getParameter("keySearch");

		BaseVo<Product> baseVo = productService.getListProductByFilter(currentPage, pageSize, statusProduct, idCategory,
				keySearch);

		if (baseVo != null) {
			List<JSONObject> listProduct = new ArrayList<>();
			if (baseVo.getListEntity() != null) {
				List<Product> products = baseVo.getListEntity();
				for (Product product : products) {
					listProduct.add(mappingModel.mappingModel(product));
				}
			}
			JSONObject result = new JSONObject();
			result.put("products", listProduct);
			result.put("currentPage", baseVo.getCurrentPage());
			result.put("totalPage", baseVo.getTotalPage());
			return ResponseEntity.ok(result);
		}
		return null;
	}

	@RequestMapping(value = { "/admin/add-update-product" }, method = RequestMethod.POST)
	public ResponseEntity<Object> add(final Model model, final HttpServletRequest request,
			final HttpServletResponse response, @ModelAttribute ProductDTO productDTO) throws Exception {

		productDTO.setDetail(productDTO.getDetail().replaceFirst(",", " ").trim());
		Product product = mappingModel.mappingModel(productDTO);
		product.setCategory(categoryService.getById(productDTO.getId_category()));
		if (product.getId() == null) {
			if (isLogined()) {
				product.setCreatedBy(getUserLogined().getId());
			}
			/* product.setUpdatedDate(Calendar.getInstance().getTime()); */
			productService.save(product, productDTO.getAvatar(), productDTO.getImages());
		} else {
			if (isLogined()) {
				product.setUpdatedBy(getUserLogined().getId());
			}
			productService.edit(product, productDTO.getAvatar(), productDTO.getImages());
		}
		return ResponseEntity.ok(null);
	}

	@RequestMapping(value = { "/admin/product-detail/{seo}" }, method = RequestMethod.GET)
	public String detail(final Model model, final HttpServletRequest request, final HttpServletResponse response,
			@PathVariable("seo") String seo) throws IOException {
		Product product = productService.getBySeo(seo);

		model.addAttribute("createdBy", userService.getById(product.getCreatedBy()));
		if (product.getUpdatedBy() != null) {
			model.addAttribute("updatedBy", userService.getById(product.getUpdatedBy()));
		} else {
			model.addAttribute("updatedBy", null);
		}

		model.addAttribute("product", product);
		return "manager/product/detail";
	}

	@RequestMapping(value = { "/admin/edit-product/{seo}" }, method = RequestMethod.GET)
	public String edit(final Model model, final HttpServletRequest request, final HttpServletResponse response,
			@PathVariable("seo") String seo) throws IOException {
		model.addAttribute("id_product", productService.getBySeo(seo).getId());
		return "manager/product/createOrUpdate";
	}

	@RequestMapping(value = { "/admin/add-product" }, method = RequestMethod.GET)
	public String add(final Model model, final HttpServletRequest request, final HttpServletResponse response)
			throws IOException {
		model.addAttribute("id_product", null);
		return "manager/product/createOrUpdate";
	}

	@RequestMapping(value = { "/admin/detail-product" }, method = RequestMethod.GET)
	public ResponseEntity<Map<String, List<JSONObject>>> detailProduct(final Model model,
			final HttpServletRequest request, final HttpServletResponse response,
			@RequestParam("idProduct") Integer idProduct) throws IOException {

		Map<String, List<JSONObject>> result = new HashMap<>();

		Product product = productService.getById(idProduct);

		List<JSONObject> productJson = new ArrayList<>();
		productJson.add(mappingModel.mappingModel(product));

		List<JSONObject> productImagesJson = new ArrayList<>();
		List<ProductImage> productImages = productImageService.getListByIdProduct(idProduct);

		for (ProductImage productImage : productImages) {
			productImagesJson.add(mappingModel.mappingModel(productImage));
		}

		List<JSONObject> categoryJsons = new ArrayList<>();
		categoryJsons.add(mappingModel.mappingModel(product.getCategory()));
		result.put("product", productJson);
		result.put("productImages", productImagesJson);
		result.put("category", categoryJsons);
		return ResponseEntity.ok(result);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/admin/delete-product" }, method = RequestMethod.POST)
	public ResponseEntity<JSONObject> delete(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException {
		try {
			JSONObject result = new JSONObject();
			Integer idProduct = Integer.parseInt(request.getParameter("idProduct"));
			if (productService.deleteProductById(idProduct)) {
				result.put("message", Boolean.TRUE);
				return ResponseEntity.ok(result);
			} else {
				result.put("message", Boolean.FALSE);
				return ResponseEntity.ok(result);
			}

		} catch (Exception e) {
			return ResponseEntity.ok(null);
		}
	}
}
