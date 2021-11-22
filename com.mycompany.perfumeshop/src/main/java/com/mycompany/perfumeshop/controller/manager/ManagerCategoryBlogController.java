package com.mycompany.perfumeshop.controller.manager;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mycompany.perfumeshop.conf.GlobalConfig;
import com.mycompany.perfumeshop.controller.BaseController;
import com.mycompany.perfumeshop.dto.CategoryBlogDTO;
import com.mycompany.perfumeshop.dto.MappingModel;
import com.mycompany.perfumeshop.entities.CategoryBlog;
import com.mycompany.perfumeshop.request.UserRequest;
import com.mycompany.perfumeshop.service.CategoryBlogService;
import com.mycompany.perfumeshop.service.UserService;
import com.mycompany.perfumeshop.valueObjects.BaseVo;

@Controller
public class ManagerCategoryBlogController extends BaseController {

	@Autowired
	private CategoryBlogService categoryBlogService;

	@Autowired
	private UserService userService;

	@Autowired
	private MappingModel mappingModel;

	@Autowired
	private GlobalConfig globalConfig;

	@GetMapping({ "/admin/category-blog/index", "/admin/category-blog" })
	public String index() {
		return "manager/categoryBlog/indexCategoryBlog";
	}

	@GetMapping("/admin/category-blog-detail/{seo}")
	public String detail(final Model model, @PathVariable("seo") String seo) throws Exception {
		CategoryBlog category = categoryBlogService.findBySeo(seo);
		model.addAttribute("createdBy", userService.getById(category.getCreatedBy()));
		if (category.getUpdatedBy() != null) {
			model.addAttribute("updatedBy", userService.getById(category.getUpdatedBy()));
		} else {
			model.addAttribute("updatedBy", null);
		}
		model.addAttribute("category", category);
		return "manager/categoryBlog/detailCategoryBlog";
	}

	@GetMapping("/admin/add-category-blog")
	public String add(Model model) {
		model.addAttribute("id_category", null);
		return "manager/categoryBlog/createOrUpdateCategoryBlog";
	}

	@GetMapping("/admin/edit-category-blog/{seo}")
	public String edit(final Model model, @PathVariable("seo") String seo) throws Exception {
		model.addAttribute("id_category", categoryBlogService.findBySeo(seo).getId());
		return "manager/categoryBlog/createOrUpdateCategoryBlog";
	}

	@PostMapping("/admin/add-update-category-blog")
	public ResponseEntity<Boolean> addOrUpdate(@ModelAttribute("category") CategoryBlogDTO categoryBlogDTO)
			throws Exception {
		CategoryBlog category = mappingModel.mappingModel(categoryBlogDTO);
		categoryBlogService.saveOrUpdate(category, categoryBlogDTO.getAvatar(), getUserLogined().getId());
		return ResponseEntity.ok(Boolean.TRUE);
	}

	@GetMapping("/admin/all-category-blog-active")
	public ResponseEntity<List<CategoryBlog>> getAllActive() throws Exception {
		return ResponseEntity.ok(categoryBlogService.findByStatus(true));
	}

	@GetMapping("/admin/all-category-blog")
	public ResponseEntity<BaseVo<CategoryBlog>> getAll(@ModelAttribute UserRequest userRequest) throws Exception {
		userRequest.setSizeOfPage(globalConfig.getSizeManagePage());
		Page<CategoryBlog> page = categoryBlogService.findAllByUserRequest(userRequest);
		BaseVo<CategoryBlog> result = new BaseVo<CategoryBlog>(page.getContent(), page.getNumber() + 1,
				page.getTotalPages());
		return ResponseEntity.ok(result);
	}

	@GetMapping("/admin/detail-category-blog")
	public ResponseEntity<CategoryBlog> detailCategory(@RequestParam("idCategory") String idCategory) throws Exception {
		return ResponseEntity.ok(categoryBlogService.findById(idCategory).get());
	}
	
	@PostMapping("/admin/delete-category-blog")
	public ResponseEntity<Boolean> delete(@RequestParam("idCategory") Integer idCategory) throws Exception {
		return ResponseEntity.ok(categoryBlogService.deleteById(idCategory));
	}

}
