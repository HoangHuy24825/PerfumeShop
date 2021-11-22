package com.mycompany.perfumeshop.controller.manager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.RequestParam;

import com.mycompany.perfumeshop.conf.GlobalConfig;
import com.mycompany.perfumeshop.controller.BaseController;
import com.mycompany.perfumeshop.dto.BlogDTO;
import com.mycompany.perfumeshop.dto.MappingModel;
import com.mycompany.perfumeshop.entities.Blog;
import com.mycompany.perfumeshop.request.UserRequest;
import com.mycompany.perfumeshop.service.BlogService;
import com.mycompany.perfumeshop.service.CategoryBlogService;
import com.mycompany.perfumeshop.service.UserService;

@Controller
public class ManagerBlogController extends BaseController {

	@Autowired
	private BlogService blogService;

	@Autowired
	private UserService userService;

	@Autowired
	private CategoryBlogService categoryBlogService;

	@Autowired
	private GlobalConfig globalConfig;

	@Autowired
	private MappingModel mappingModel;

	@GetMapping("/admin/blog")
	public String index() {
		return "manager/blog/managerBlog";
	}

	@GetMapping("/admin/blog-detail/{seo}")
	public String detail(Model model, @PathVariable("seo") String seo) throws Exception {
		Blog blog = blogService.findBySeo(seo);
		model.addAttribute("createdBy", userService.getById(blog.getCreatedBy()));
		if (blog.getUpdatedBy() != null) {
			model.addAttribute("updatedBy", userService.getById(blog.getUpdatedBy()));
		} else {
			model.addAttribute("updatedBy", null);
		}
		model.addAttribute("blog", blog);
		return "manager/blog/managerDetailBlog";
	}

	@GetMapping("/admin/add-blog")
	public String add(final Model model) {
		model.addAttribute("id_blog", null);
		return "manager/blog/createOrUpdateBlog";
	}

	@GetMapping("/admin/edit-blog/{seo}")
	public String edit(final Model model, @PathVariable("seo") String seo) throws Exception {
		model.addAttribute("id_blog", blogService.findBySeo(seo).getId());
		return "manager/blog/createOrUpdateBlog";
	}

	@PostMapping("/admin/add-update-blog")
	public ResponseEntity<Boolean> addOrUpdate(@ModelAttribute("Blog") BlogDTO blogDTO) throws Exception {
		blogDTO.setDetail(blogDTO.getDetail().replaceFirst(",", " ").trim());
		Blog blog = mappingModel.mappingModel(blogDTO);
		blog.setCategoryBlog(categoryBlogService.findById(blogDTO.getId_category_blog().toString()).get());
		blogService.saveOrUpdate(blog, blogDTO.getAvatar(), getUserLogined().getId());
		return ResponseEntity.ok(Boolean.TRUE);
	}

	@GetMapping("/admin/all-blog-active")
	public ResponseEntity<List<Blog>> getAllActive() throws Exception {
		return ResponseEntity.ok(blogService.findByStatus(true));
	}

	@GetMapping("/admin/all-blog")
	public ResponseEntity<Map<String, Object>> getAll(@RequestParam("currentPage") Integer currentPageStr,
			@RequestParam("keySearch") String keySearch) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		UserRequest userRequest = new UserRequest(currentPageStr, globalConfig.getSizeManagePage(), keySearch, null,
				null);
		Page<Blog> page = blogService.getListBlogByFilter(userRequest);
		result.put("listBlog", page.getContent());
		result.put("currentPage", page.getNumber());
		result.put("totalPage", page.getTotalPages());
		return ResponseEntity.ok(result);
	}

	@GetMapping("/admin/detail-blog")
	public ResponseEntity<JSONObject> detailBlog(@RequestParam("idBlog") String idBlog) throws Exception {
		return ResponseEntity.ok(mappingModel.mappingModel(blogService.findById(idBlog).get()));
	}

	@PostMapping("/admin/delete-blog")
	public ResponseEntity<Boolean> delete(@RequestParam("idBlog") String idBlog) throws Exception {
		return blogService.deleteById(idBlog) ? ResponseEntity.ok(Boolean.TRUE) : ResponseEntity.ok(Boolean.FALSE);
	}

}
