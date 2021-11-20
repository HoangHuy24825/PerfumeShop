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
import com.mycompany.perfumeshop.dto.CategoryBlogDTO;
import com.mycompany.perfumeshop.dto.MappingModel;
import com.mycompany.perfumeshop.entities.CategoryBlog;
import com.mycompany.perfumeshop.service.CategoryBlogService;
import com.mycompany.perfumeshop.service.UserService;

@Controller
public class ManagerCategoryBlogController extends BaseController {

	@Autowired
	private CategoryBlogService categoryBlogService;

	@Autowired
	private UserService userService;

	private static final Integer pageSize = 8;

	@Autowired
	private MappingModel mappingModel;

	@RequestMapping(value = { "/admin/category-blog/index", "/admin/category-blog" }, method = RequestMethod.GET)
	public String index(final Model model, final HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		return "manager/categoryBlog/indexCategoryBlog";
	}

	@RequestMapping(value = { "/admin/category-blog-detail/{seo}" }, method = RequestMethod.GET)
	public String detail(final Model model, final HttpServletRequest request, HttpServletResponse response,
			@PathVariable("seo") String seo) throws IOException {
		System.out.println(seo);
		CategoryBlog category = categoryBlogService.getBySeo(seo);
		model.addAttribute("createdBy", userService.getById(category.getCreatedBy()));
		if (category.getUpdatedBy() != null) {
			model.addAttribute("updatedBy", userService.getById(category.getUpdatedBy()));
		} else {
			model.addAttribute("updatedBy", null);
		}
		model.addAttribute("category", categoryBlogService.getBySeo(seo));
		return "manager/categoryBlog/detailCategoryBlog";
	}

	@RequestMapping(value = { "/admin/add-category-blog" }, method = RequestMethod.GET)
	public String add(final Model model, final HttpServletRequest request, HttpServletResponse response)
			throws IOException {

		model.addAttribute("id_category", null);
		return "manager/categoryBlog/createOrUpdateCategoryBlog";
	}

	@RequestMapping(value = { "/admin/edit-category-blog/{seo}" }, method = RequestMethod.GET)
	public String edit(final Model model, final HttpServletRequest request, HttpServletResponse response,
			@PathVariable("seo") String seo) throws IOException {

		model.addAttribute("id_category", categoryBlogService.getBySeo(seo).getId());
		return "manager/categoryBlog/createOrUpdateCategoryBlog";
	}

	@RequestMapping(value = { "/admin/add-update-category-blog" }, method = RequestMethod.POST)
	public ResponseEntity<Object> addOrUpdate(final Model model, final HttpServletRequest request,
			HttpServletResponse response, @ModelAttribute("category") CategoryBlogDTO categoryBlogDTO)
			throws Exception {
		CategoryBlog category = mappingModel.mappingModel(categoryBlogDTO);
		if (category.getId() == null) {
			if (isLogined()) {
				category.setCreatedBy(getUserLogined().getId());
			}
			/* category.setUpdatedDate(Calendar.getInstance().getTime()); */
			categoryBlogService.save(category, categoryBlogDTO.getAvatar());
		} else {
			if (isLogined()) {
				category.setUpdatedBy(getUserLogined().getId());
			}
			categoryBlogService.edit(category, categoryBlogDTO.getAvatar());
		}
		return ResponseEntity.ok(null);
	}

	@RequestMapping(value = { "/admin/all-category-blog-active" }, method = RequestMethod.GET)
	public ResponseEntity<List<JSONObject>> getAllActive(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException {

		List<CategoryBlog> categories = categoryBlogService.findAllActive();
		List<JSONObject> listCategory = new ArrayList<>();
		for (CategoryBlog category : categories) {
			listCategory.add(mappingModel.mappingModel(category));
		}
		return ResponseEntity.ok(listCategory);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/admin/all-category-blog" }, method = RequestMethod.GET)
	public ResponseEntity<Map<String, List<JSONObject>>> getAll(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException {

		Integer currentPage;
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		} catch (Exception e) {
			currentPage = 1;
		}

		String keySearch;
		keySearch = request.getParameter("keySearch");

		List<CategoryBlog> categories = categoryBlogService.getListCategoryByFilter(currentPage, pageSize, keySearch);
		List<JSONObject> listCategory = new ArrayList<>();
		for (CategoryBlog category : categories) {
			listCategory.add(mappingModel.mappingModel(category));
		}

		Map<String, List<JSONObject>> result = new HashMap<>();
		result.put("categories", listCategory);

		List<JSONObject> listPage = new ArrayList<>();
		JSONObject pageJson = new JSONObject();
		pageJson.put("currentPage", currentPage);
		pageJson.put("totalPage", categoryBlogService.getTotalPageCategoryByFilter(pageSize, keySearch));// pageSize
		listPage.add(pageJson);

		result.put("listPage", listPage);

		return ResponseEntity.ok(result);
	}

	@RequestMapping(value = { "/admin/detail-category-blog" }, method = RequestMethod.GET)
	public ResponseEntity<Map<String, List<JSONObject>>> detailCategory(final Model model,
			final HttpServletRequest request, final HttpServletResponse response,
			@RequestParam("idCategory") Integer idCategory) throws IOException {

		Map<String, List<JSONObject>> result = new HashMap<>();

		CategoryBlog category = categoryBlogService.getById(idCategory);

		List<JSONObject> categoryJson = new ArrayList<>();
		categoryJson.add(mappingModel.mappingModel(category));

		result.put("category", categoryJson);

		return ResponseEntity.ok(result);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/admin/delete-category-blog" }, method = RequestMethod.POST)
	public ResponseEntity<JSONObject> delete(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException {
		try {
			JSONObject result = new JSONObject();
			Integer idCategory = Integer.parseInt(request.getParameter("idCategory"));
			if (categoryBlogService.deleteCategoryById(idCategory)) {
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
