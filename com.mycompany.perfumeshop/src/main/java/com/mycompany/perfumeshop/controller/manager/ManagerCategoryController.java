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
import com.mycompany.perfumeshop.dto.CategoryDTO;
import com.mycompany.perfumeshop.dto.MappingModel;
import com.mycompany.perfumeshop.entities.Category;
import com.mycompany.perfumeshop.service.CategoryService;
import com.mycompany.perfumeshop.service.UserService;
import com.mycompany.perfumeshop.utils.Constants;
import com.mycompany.perfumeshop.utils.ConvertUtils;
import com.mycompany.perfumeshop.valueObjects.BaseVo;

@Controller
public class ManagerCategoryController extends BaseController {

	@Autowired
	private CategoryService categoryService;

	@Autowired
	private UserService userService;

	private static final Integer pageSize = 8;

	private MappingModel mappingModel = new MappingModel();

	@RequestMapping(value = { "/admin/category/index", "/admin/category" }, method = RequestMethod.GET)
	public String index(final Model model, final HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		return "manager/category/index";
	}

	@RequestMapping(value = { "/admin/category-detail/{seo}" }, method = RequestMethod.GET)
	public String detail(final Model model, final HttpServletRequest request, HttpServletResponse response,
			@PathVariable("seo") String seo) throws IOException {
		Category category = categoryService.getBySeo(seo);
		model.addAttribute("createdBy", userService.getById(category.getCreatedBy()));
		if (category.getUpdatedBy() != null) {
			model.addAttribute("updatedBy", userService.getById(category.getUpdatedBy()));
		} else {
			model.addAttribute("updatedBy", null);
		}
		model.addAttribute("category", category);
		return "manager/category/detail";
	}

	@RequestMapping(value = { "/admin/add-category" }, method = RequestMethod.GET)
	public String add(final Model model, final HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		model.addAttribute("id_category", null);
		return "manager/category/createOrUpdate";
	}

	@RequestMapping(value = { "/admin/edit-category/{seo}" }, method = RequestMethod.GET)
	public String edit(final Model model, final HttpServletRequest request, HttpServletResponse response,
			@PathVariable("seo") String seo) throws IOException {

		model.addAttribute("id_category", categoryService.getBySeo(seo).getId());
		return "manager/category/createOrUpdate";
	}

	@RequestMapping(value = { "/admin/add-update-category" }, method = RequestMethod.POST)
	public ResponseEntity<Object> addOrUpdate(final Model model, final HttpServletRequest request,
			HttpServletResponse response, @ModelAttribute("category") CategoryDTO categoryDTO) throws Exception {
		Category category = mappingModel.mappingModel(categoryDTO);
		if (category.getId() == null) {
			if (isLogined()) {
				category.setCreatedBy(getUserLogined().getId());
			}
			/* category.setUpdatedDate(Calendar.getInstance().getTime()); */
			categoryService.save(category, categoryDTO.getAvatar());
		} else {
			if (isLogined()) {
				category.setUpdatedBy(getUserLogined().getId());
			}
			categoryService.edit(category, categoryDTO.getAvatar());
		}
		return ResponseEntity.ok(null);
	}

	@RequestMapping(value = { "/admin/all-category-active" }, method = RequestMethod.GET)
	public ResponseEntity<List<JSONObject>> getAllActive(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException {

		List<Category> categories = categoryService.findAllActive();
		List<JSONObject> listCategory = new ArrayList<>();
		for (Category category : categories) {
			listCategory.add(mappingModel.mappingModel(category));
		}
		return ResponseEntity.ok(listCategory);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/admin/all-category" }, method = RequestMethod.GET)
	public ResponseEntity<JSONObject> getAll(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException {

		JSONObject result = new JSONObject();
		Integer currentPage = ConvertUtils.convertStringToInt(request.getParameter("currentPage"), Constants.INIT_PAGE);
		String keySearch = request.getParameter("keySearch");

		BaseVo<Category> baseVo = categoryService.getListCategoryByFilter(currentPage, pageSize, keySearch);
		if (baseVo != null) {
			List<JSONObject> listCategory = new ArrayList<>();
			List<Category> categories = baseVo.getListEntity();
			if (categories != null && categories.size() > 0) {
				for (Category category : categories) {
					listCategory.add(mappingModel.mappingModel(category));
				}
			}
			result.put("categories", listCategory);
			result.put("currentPage", baseVo.getCurrentPage());
			result.put("totalPage", baseVo.getTotalPage());
			return ResponseEntity.ok(result);
		}
		return null;
	}

	@RequestMapping(value = { "/admin/detail-category" }, method = RequestMethod.GET)
	public ResponseEntity<Map<String, List<JSONObject>>> detailCategory(final Model model,
			final HttpServletRequest request, final HttpServletResponse response,
			@RequestParam("idCategory") Integer idCategory) throws IOException {

		Map<String, List<JSONObject>> result = new HashMap<>();

		Category category = categoryService.getById(idCategory);

		List<JSONObject> categoryJson = new ArrayList<>();
		categoryJson.add(mappingModel.mappingModel(category));

		result.put("category", categoryJson);

		return ResponseEntity.ok(result);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/admin/delete-category" }, method = RequestMethod.POST)
	public ResponseEntity<JSONObject> delete(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException {
		try {
			JSONObject result = new JSONObject();
			Integer idCategory = Integer.parseInt(request.getParameter("idCategory"));
			if (categoryService.deleteCategoryById(idCategory)) {
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
