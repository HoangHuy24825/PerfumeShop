package com.mycompany.perfumeshop.controller.manager;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mycompany.perfumeshop.controller.BaseController;

@Controller
@RequestMapping("/perfume-shop/")
public class ManagerDashboardController extends BaseController {

	@GetMapping("admin/dashboard.html")
	public String index() {
		return "manager/dashboard/dashboard";
	}
}
