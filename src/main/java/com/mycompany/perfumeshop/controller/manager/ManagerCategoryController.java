package com.mycompany.perfumeshop.controller.manager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import org.springframework.web.bind.annotation.RequestParam;

import com.mycompany.perfumeshop.conf.GlobalConfig;
import com.mycompany.perfumeshop.controller.BaseController;
import com.mycompany.perfumeshop.dto.CategoryDTO;
import com.mycompany.perfumeshop.dto.MappingModel;
import com.mycompany.perfumeshop.entities.Category;
import com.mycompany.perfumeshop.service.CategoryService;
import com.mycompany.perfumeshop.service.UserService;
import com.mycompany.perfumeshop.valueObjects.UserRequest;

@Controller
@RequestMapping("/perfume-shop/")
public class ManagerCategoryController extends BaseController {

	@Autowired
	private CategoryService categoryService;

	@Autowired
	private UserService userService;

	@Autowired
	private GlobalConfig globalConfig;

	@Autowired
	private MappingModel mappingModel;

	@GetMapping("admin/category.html")
	public String index() {
		return "manager/category/index";
	}

	@GetMapping("admin/category-detail/{seo}")
	public String detail(final Model model, @PathVariable("seo") String seo) throws Exception {
		Category category = categoryService.findBySeo(seo);
		model.addAttribute("createdBy", userService.findById(category.getCreatedBy()));
		if (category.getUpdatedBy() != null) {
			model.addAttribute("updatedBy", userService.findById(category.getUpdatedBy()));
		} else {
			model.addAttribute("updatedBy", null);
		}
		model.addAttribute("category", category);
		return "manager/category/detail";
	}

	@GetMapping("admin/add-category")
	public String add(final Model model) {
		model.addAttribute("id_category", null);
		return "manager/category/createOrUpdate";
	}

	@GetMapping("admin/edit-category/{seo}")
	public String edit(final Model model, @PathVariable("seo") String seo) throws Exception {
		model.addAttribute("id_category", categoryService.findBySeo(seo).getId());
		return "manager/category/createOrUpdate";
	}

	@PostMapping("admin/add-update-category")
	public ResponseEntity<Boolean> addOrUpdate(final Model model, final HttpServletRequest request,
			HttpServletResponse response, @ModelAttribute("category") CategoryDTO categoryDTO) throws Exception {
		Category category = mappingModel.mappingModel(categoryDTO);
		categoryService.saveOrUpdate(category, categoryDTO.getAvatar(), getUserLogined());
		return ResponseEntity.ok(Boolean.TRUE);
	}

	@PostMapping("admin/change-status-category")
	public ResponseEntity<Boolean> changeStatus(@RequestParam("id") Integer id,
			@RequestParam("status") String statusStr) throws Exception {
		boolean status = statusStr.equals("1");
		Category category = categoryService.findById(id);
		category.setStatus(status);
		categoryService.saveOrUpdate(category, null, getUserLogined());
		return ResponseEntity.ok(Boolean.TRUE);
	}

	@GetMapping("admin/all-category-active")
	public ResponseEntity<List<Category>> getAllActive() throws Exception {
		return ResponseEntity.ok(categoryService.findByStatus(true));
	}

	@GetMapping("admin/all-category")
	public ResponseEntity<Map<String, Object>> getAll(@RequestParam("keySearch") String keySearch,
			@RequestParam("currentPage") Integer currentPage) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		UserRequest userRequest = new UserRequest(currentPage, globalConfig.getSizeManagePage(), keySearch, null, null);
		Page<Category> page = categoryService.findAllByUserRequest(userRequest);
		result.put("categories", page.getContent());
		result.put("currentPage", page.getNumber() + 1);
		result.put("totalPage", page.getTotalPages());
		return ResponseEntity.ok(result);
	}

	@GetMapping("admin/detail-category")
	public ResponseEntity<Category> detailCategory(@RequestParam("idCategory") Integer idCategory) throws Exception {
		Category category = categoryService.findById(idCategory);
		return ResponseEntity.ok(category);
	}

	@DeleteMapping("admin/delete-category/{id}")
	public ResponseEntity<Boolean> delete(@PathVariable("id") Integer id) throws Exception {
		return ResponseEntity.ok(categoryService.deleteById(id));
	}

}
