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

import com.mycompany.perfumeshop.controller.BaseController;
import com.mycompany.perfumeshop.dto.MappingModel;
import com.mycompany.perfumeshop.entities.Category;
import com.mycompany.perfumeshop.service.CategoryService;

@Controller
public class CategoryController extends BaseController{
	@Autowired
	private CategoryService categoryService;

	@Autowired
	private MappingModel mappingModel;

	@RequestMapping(value = { "/category-slide-home" }, method = RequestMethod.GET)
	public ResponseEntity<List<JSONObject>> getAllSlide(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException {

		List<Category> categories = categoryService.getCategorySlider();
		List<JSONObject> listCategory = new ArrayList<>();
		for (Category category : categories) {
			listCategory.add(mappingModel.mappingModel(category));
		}
		return ResponseEntity.ok(listCategory);
	}
	
	/*
	 * @RequestMapping(value = { "/all-category-active" }, method =
	 * RequestMethod.GET) public ResponseEntity<List<JSONObject>> getAllActive(final
	 * Model model, final HttpServletRequest request, final HttpServletResponse
	 * response) throws IOException {
	 * 
	 * List<Category> categories = categoryService.findAllActive(); List<JSONObject>
	 * listCategory = new ArrayList<>(); for (Category category : categories) {
	 * listCategory.add(mappingModel.mappingModel(category)); } return
	 * ResponseEntity.ok(listCategory); }
	 */
}
