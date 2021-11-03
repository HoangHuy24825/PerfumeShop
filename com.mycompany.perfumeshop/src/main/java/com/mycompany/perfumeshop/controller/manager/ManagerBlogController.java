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
import com.mycompany.perfumeshop.dto.BlogDTO;
import com.mycompany.perfumeshop.dto.MappingModel;
import com.mycompany.perfumeshop.entities.Blog;
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

	private static final Integer pageSize = 8;

	private MappingModel mappingModel = new MappingModel();

	@RequestMapping(value = { "/admin/blog" }, method = RequestMethod.GET)
	public String index(final Model model, final HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		return "manager/blog/managerBlog";
	}

	@RequestMapping(value = { "/admin/blog-detail/{seo}" }, method = RequestMethod.GET)
	public String detail(final Model model, final HttpServletRequest request, HttpServletResponse response,
			@PathVariable("seo") String seo) throws IOException {
		Blog blog = blogService.getBySeo(seo);
		model.addAttribute("createdBy", userService.getById(blog.getCreatedBy()));
		if (blog.getUpdatedBy() != null) {
			model.addAttribute("updatedBy", userService.getById(blog.getUpdatedBy()));
		} else {
			model.addAttribute("updatedBy", null);
		}
		model.addAttribute("blog", blog);
		return "manager/blog/managerDetailBlog";
	}

	@RequestMapping(value = { "/admin/add-blog" }, method = RequestMethod.GET)
	public String add(final Model model, final HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		model.addAttribute("id_blog", null);
		return "manager/blog/createOrUpdateBlog";
	}

	@RequestMapping(value = { "/admin/edit-blog/{seo}" }, method = RequestMethod.GET)
	public String edit(final Model model, final HttpServletRequest request, HttpServletResponse response,
			@PathVariable("seo") String seo) throws IOException {

		model.addAttribute("id_blog", blogService.getBySeo(seo).getId());
		return "manager/blog/createOrUpdateBlog";
	}

	@RequestMapping(value = { "/admin/add-update-blog" }, method = RequestMethod.POST)
	public ResponseEntity<Object> addOrUpdate(final Model model, final HttpServletRequest request,
			HttpServletResponse response, @ModelAttribute("Blog") BlogDTO blogDTO) throws Exception {
		blogDTO.setDetail(blogDTO.getDetail().replaceFirst(",", " ").trim());
		Blog blog = mappingModel.mappingModel(blogDTO);
		blog.setCategoryBlog(categoryBlogService.getById(blogDTO.getId_category_blog()));
		if (blog.getId() == null) {
			if (isLogined()) {
				blog.setCreatedBy(getUserLogined().getId());
			}
			/* blog.setUpdatedDate(Calendar.getInstance().getTime()); */
			blogService.save(blog, blogDTO.getAvatar());
		} else {
			if (isLogined()) {
				blog.setUpdatedBy(getUserLogined().getId());
			}
			blogService.edit(blog, blogDTO.getAvatar());
		}
		return ResponseEntity.ok(null);
	}

	@RequestMapping(value = { "/admin/all-blog-active" }, method = RequestMethod.GET)
	public ResponseEntity<List<JSONObject>> getAllActive(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException {

		List<Blog> blogs = blogService.findAllActive();
		List<JSONObject> listBlog = new ArrayList<>();
		for (Blog blog : blogs) {
			listBlog.add(mappingModel.mappingModel(blog));
		}
		return ResponseEntity.ok(listBlog);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/admin/all-blog" }, method = RequestMethod.GET)
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

		List<Blog> blogs = blogService.getListBlogByFilter(currentPage, pageSize, keySearch);
		List<JSONObject> listBlog = new ArrayList<>();
		for (Blog blog : blogs) {
			listBlog.add(mappingModel.mappingModel(blog));
		}

		Map<String, List<JSONObject>> result = new HashMap<>();
		result.put("blogs", listBlog);

		List<JSONObject> listPage = new ArrayList<>();
		JSONObject pageJson = new JSONObject();
		pageJson.put("currentPage", currentPage);
		pageJson.put("totalPage", blogService.getTotalPageBlogByFilter(pageSize, keySearch));// pageSize
		listPage.add(pageJson);

		result.put("listPage", listPage);

		return ResponseEntity.ok(result);
	}

	@RequestMapping(value = { "/admin/detail-blog" }, method = RequestMethod.GET)
	public ResponseEntity<Map<String, List<JSONObject>>> detailBlog(final Model model, final HttpServletRequest request,
			final HttpServletResponse response, @RequestParam("idBlog") Integer idBlog) throws IOException {

		Map<String, List<JSONObject>> result = new HashMap<>();

		Blog blog = blogService.getById(idBlog);

		List<JSONObject> blogJson = new ArrayList<>();
		blogJson.add(mappingModel.mappingModel(blog));

		result.put("blog", blogJson);

		return ResponseEntity.ok(result);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/admin/delete-blog" }, method = RequestMethod.POST)
	public ResponseEntity<JSONObject> delete(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException {
		try {
			JSONObject result = new JSONObject();
			Integer idBlog = Integer.parseInt(request.getParameter("idBlog"));
			if (blogService.deleteBlogById(idBlog)) {
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
