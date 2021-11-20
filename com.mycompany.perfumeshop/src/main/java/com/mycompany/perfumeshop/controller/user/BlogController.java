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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mycompany.perfumeshop.conf.GlobalConfig;
import com.mycompany.perfumeshop.controller.BaseController;
import com.mycompany.perfumeshop.dto.MappingModel;
import com.mycompany.perfumeshop.entities.Blog;
import com.mycompany.perfumeshop.request.UserRequest;
import com.mycompany.perfumeshop.service.BlogService;
import com.mycompany.perfumeshop.service.CategoryBlogService;
import com.mycompany.perfumeshop.utils.ConvertUtils;
import com.mycompany.perfumeshop.valueObjects.BaseVo;

@Controller
public class BlogController extends BaseController {

	@Autowired
	private CategoryBlogService categoryBlogService;

	@Autowired
	private BlogService blogService;

	@Autowired
	private MappingModel mappingModel;

	@Autowired
	private GlobalConfig globalConfig;

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
	public ResponseEntity<JSONObject> getAll(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException {
		JSONObject result = new JSONObject();
		Integer currentPage=ConvertUtils.convertStringToInt(request.getParameter("page"), globalConfig.getInitPage());
		Integer idCategory=ConvertUtils.convertStringToInt(request.getParameter("id_category"), null);
		String searchStr = request.getParameter("searchStr");
		UserRequest userRequest = new UserRequest();
		userRequest.setCurrentPage(currentPage);
		userRequest.setIdParent(idCategory);
		userRequest.setSizeOfPage(globalConfig.getSizeClientBlog());
		userRequest.setKeySearch(searchStr);
		userRequest.setStatus(true);
		BaseVo<Blog> baseVo = blogService.getListBlogByFilter(userRequest);
		List<Blog> blogs = baseVo.getListEntity();
		List<JSONObject> listBlog = new ArrayList<JSONObject>();
		for (Blog blog : blogs) {
			listBlog.add(mappingModel.mappingModel(blog));
		}
		result.put("blogs", listBlog);
		result.put("currentPage", currentPage);
		result.put("totalPage", baseVo.getTotalPage());// pageSize
		model.addAttribute("searchKey", userRequest.getKeySearch());
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
