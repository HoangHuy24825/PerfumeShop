package com.mycompany.perfumeshop.controller.manager;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mycompany.perfumeshop.controller.BaseController;

@Controller
public class ManagerDashboardController extends BaseController{
	
	@RequestMapping(value = { "/admin", "/admin/dashboard" }, method = RequestMethod.GET)
	public String index(final Model model, final HttpServletRequest request, final HttpServletResponse response)
			throws IOException {
		return "manager/dashboard/dashboard";
	}
}
