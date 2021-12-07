package com.mycompany.perfumeshop.controller.manager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mycompany.perfumeshop.conf.GlobalConfig;
import com.mycompany.perfumeshop.controller.BaseController;
import com.mycompany.perfumeshop.dto.MappingModel;
import com.mycompany.perfumeshop.entities.Review;
import com.mycompany.perfumeshop.service.ReviewService;
import com.mycompany.perfumeshop.utils.ConvertUtils;
import com.mycompany.perfumeshop.valueObjects.UserRequestReview;

@Controller
@RequestMapping("/perfume-shop/")
public class ManageReviewProducts extends BaseController {

	@Autowired
	private GlobalConfig globalConfig;

	@Autowired
	private ReviewService reviewService;

	@Autowired
	private MappingModel mapping;

	@GetMapping("admin/review-product.html")
	public String showReviewPage() throws Exception {
		return "manager/product/review-product";
	}

	@GetMapping("admin/reviews")
	public ResponseEntity<Map<String, Object>> getAll(@ModelAttribute UserRequestReview userRequestReview)
			throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		userRequestReview.setSizeOfPage(globalConfig.getSizeManagePage());
		Page<Review> page = reviewService.findAll(userRequestReview);
		List<JSONObject> reviews = mapping.mappingModelViewList(page.getContent());
		result.put("listReviews", reviews);
		result.put("currentPage", page.getNumber() + 1);
		result.put("totalPage", page.getTotalPages());
		return ResponseEntity.ok(result);
	}

	@PostMapping("/admin/change-detail-review")
	public ResponseEntity<Boolean> changeDetail(HttpServletRequest request) throws Exception {
		Integer type = ConvertUtils.convertStringToInt(request.getParameter("type"), null);
		Review review = reviewService.findById(request.getParameter("id"));
		if (review == null) {
			return ResponseEntity.ok(Boolean.FALSE);
		}
		if (type != null && type == 0) {
			boolean status = request.getParameter("status").equals("1");
			review.setStatus(status);
		} else if (type != null && type == 1) {
			boolean isHide = request.getParameter("isHide").equals("1");
			review.setIsHide(isHide);
		}
		reviewService.saveOrUpdate(review, getUserLogined());
		return ResponseEntity.ok(Boolean.TRUE);
	}

	@DeleteMapping("review/{id}")
	public ResponseEntity<Boolean> delete(@PathVariable String id) throws Exception {
		return ResponseEntity.ok(reviewService.deleteById(id));
	}

}
