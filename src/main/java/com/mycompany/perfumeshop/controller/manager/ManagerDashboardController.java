package com.mycompany.perfumeshop.controller.manager;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mycompany.perfumeshop.conf.GlobalConfig;
import com.mycompany.perfumeshop.controller.BaseController;
import com.mycompany.perfumeshop.service.AttributeProductService;
import com.mycompany.perfumeshop.service.CategoryService;
import com.mycompany.perfumeshop.service.OrderService;
import com.mycompany.perfumeshop.service.ProductService;
import com.mycompany.perfumeshop.utils.Validate;
import com.mycompany.perfumeshop.valueObjects.BestSaleProductVo;
import com.mycompany.perfumeshop.valueObjects.PageVo;
import com.mycompany.perfumeshop.valueObjects.RevenueVo;

@Controller
@RequestMapping("/perfume-shop/")
public class ManagerDashboardController extends BaseController {

	@Autowired
	private ProductService productService;

	@Autowired
	private AttributeProductService attributeProductService;

	@Autowired
	private OrderService orderService;

	@Autowired
	private CategoryService categoryService;

	@Autowired
	private GlobalConfig globalConfig;

	@GetMapping("admin/dashboard.html")
	public String index(Model model) throws Exception {
		model.addAttribute("revenueRecentWeek", orderService.getTotalRevenueRecentWeek());
		model.addAttribute("revenueRecentMonth", orderService.getTotalRevenueRecentMonth());
		model.addAttribute("productQuantity", productService.getTotalProduct());
		model.addAttribute("totalOrderRecentMonth", orderService.totalOrderRecentMonth());
		model.addAttribute("listCategory", categoryService.findAllByStatus(Boolean.TRUE));
		return "manager/dashboard/dashboard";
	}

	@GetMapping("admin/statistical")
	public ResponseEntity<Map<String, Object>> statistical() throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("quantityProductByCategory", productService.getTotalByCategory());
		result.put("revenuePerDay", orderService.getRevenueByDate());
		result.put("revenuePerWeek", orderService.getRevenueByWeek().toArray(new Double[] {}));
		result.put("totalOrderPerWeek", orderService.getTotalOrderPerWeekRecentMonth().toArray(new Long[] {}));
		result.put("revenuePerMonth", orderService.getRevenueFromJanuary());
		return ResponseEntity.ok(result);
	}

	@GetMapping("admin/revenue-by-date/{startDate}/{endDate}/{currentPage}")
	public ResponseEntity<Map<String, Object>> getRevenueByDate(@PathVariable String startDate,
			@PathVariable String endDate, @PathVariable String currentPage) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
		PageVo<RevenueVo> pageOfRevenue = orderService.statisticRevenue(sdf.parse(startDate), sdf.parse(endDate),
				Validate.isNumber(currentPage) ? Integer.parseInt(currentPage) : globalConfig.getInitPage(),
				globalConfig.getSizeManagePage());
		result.put("listRevenueByDate", pageOfRevenue.getContent());
		result.put("totalPage", pageOfRevenue.getTotalPage());
		result.put("currentPage", pageOfRevenue.getCurrentPage());
		return ResponseEntity.ok(result);
	}

	@GetMapping("admin/best-sale-product/{idCategory}/{currentPage}")
	public ResponseEntity<Map<String, Object>> getBestSaleProduct(@PathVariable String idCategory,
			@PathVariable String currentPage) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		PageVo<BestSaleProductVo> pageVo = orderService.getListBestSaleOfProduct(idCategory, currentPage,
				globalConfig.getSizeManagePage());
		if (pageVo == null) {
			result.put("inforMsg", "Not found");
		} else {
			result.put("listBestSaleProduct", pageVo.getContent());
			result.put("totalPage", pageVo.getTotalPage());
			result.put("currentPage", pageVo.getCurrentPage());
		}
		return ResponseEntity.ok(result);
	}
}
