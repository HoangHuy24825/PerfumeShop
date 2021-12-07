package com.mycompany.perfumeshop.controller.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mycompany.perfumeshop.controller.BaseController;
import com.mycompany.perfumeshop.dto.MappingModel;
import com.mycompany.perfumeshop.service.ReviewService;

@Controller
@RequestMapping("/perfume-shop/")
public class NotifiesController extends BaseController {

	@Autowired
	private ReviewService reviewService;

	@Autowired
	private MappingModel mappingModel;

	
}
