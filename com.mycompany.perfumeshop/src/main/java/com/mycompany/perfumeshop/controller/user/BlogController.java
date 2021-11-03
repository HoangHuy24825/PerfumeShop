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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mycompany.perfumeshop.controller.BaseController;
import com.mycompany.perfumeshop.dto.MappingModel;
import com.mycompany.perfumeshop.dto.SearchObject;
import com.mycompany.perfumeshop.entities.Blog;
import com.mycompany.perfumeshop.service.BlogService;
import com.mycompany.perfumeshop.service.CategoryBlogService;

@Controller
public class BlogController extends BaseController {

	@Autowired
	private CategoryBlogService categoryBlogService;

	@Autowired
	private BlogService blogService;

	private static final Integer PAGE_SIZE = 5;
	private MappingModel mappingModel = new MappingModel();

	@RequestMapping(value = { "/blog" }, method = RequestMethod.GET)
	public String index(final Model model, final HttpServletRequest request, final HttpServletResponse response)
			throws IOException {
		model.addAttribute("categoryBlogs", categoryBlogService.findAllActive());
		model.addAttribute("amountBlog", blogService.findAllActive().size());
		model.addAttribute("recentPosts", blogService.getRecentPost());
		return "user/blog/blog";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/all-blog" }, method = RequestMethod.GET)
	public ResponseEntity<Map<String, List<JSONObject>>> getAll(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException {

		Map<String, List<JSONObject>> result = new HashMap<String, List<JSONObject>>();

		Integer currentPage;
		Integer idCategory;
		String searchStr = request.getParameter("searchStr");
		try {
			currentPage = Integer.parseInt(request.getParameter("page"));
		} catch (Exception e) {
			currentPage = 1;
		}

		try {
			idCategory = Integer.parseInt(request.getParameter("id_category"));
		} catch (Exception e) {
			idCategory = 0;
		}

		SearchObject searchObject = new SearchObject();
		searchObject.setIdCategory(idCategory);
		searchObject.setKeySearch(searchStr);

		List<Blog> blogs = blogService.getListBlogByFilter(currentPage, PAGE_SIZE, searchObject);

		List<JSONObject> listBlog = new ArrayList<JSONObject>();
		for (Blog blog : blogs) {
			listBlog.add(mappingModel.mappingModel(blog));
		}

		result.put("blogs", listBlog);

		List<JSONObject> listPage = new ArrayList<>();
		JSONObject pageJson = new JSONObject();
		pageJson.put("currentPage", currentPage);
		pageJson.put("totalPage", blogService.getTotalPageBlogByFilter(PAGE_SIZE, searchObject));// pageSize
		listPage.add(pageJson);

		model.addAttribute("searchKey", searchStr);

		result.put("listPage", listPage);
		return ResponseEntity.ok(result);
	}

	@RequestMapping(value = { "/detail-blog" }, method = RequestMethod.GET)
	public ResponseEntity<JSONObject> detail(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException {
		JSONObject blogJSON = new JSONObject();
		Integer idBlog;
		try {
			idBlog = Integer.parseInt(request.getParameter("idBlog"));
		} catch (Exception e) {
			return null;
		}
		blogJSON = mappingModel.mappingModel(blogService.getById(idBlog));
		return ResponseEntity.ok(blogJSON);
	}
}
