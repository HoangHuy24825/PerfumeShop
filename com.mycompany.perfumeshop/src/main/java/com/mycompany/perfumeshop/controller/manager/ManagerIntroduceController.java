package com.mycompany.perfumeshop.controller.manager;

import java.util.Calendar;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mycompany.perfumeshop.controller.BaseController;
import com.mycompany.perfumeshop.dto.IntroduceDTO;
import com.mycompany.perfumeshop.entities.Introduce;
import com.mycompany.perfumeshop.service.IntroduceService;

@Controller
@RequestMapping("/perfume-shop/")
public class ManagerIntroduceController extends BaseController {

	@Autowired
	private IntroduceService introduceSevice;

	@GetMapping("admin/introduce.html")
	public String index(Model model) throws Exception {
		model.addAttribute("introduce",
				(introduceSevice.findAll() != null && introduceSevice.findAll().size() > 0)
						? introduceSevice.findAll().get(0)
						: new Introduce());
		return "manager/introduce/managerIntroduce";
	}

	@GetMapping("admin/edit-introduce")
	public String getUpdatePage(Model model) throws Exception {
		model.addAttribute("id_introduce",
				(introduceSevice.findAll() != null && introduceSevice.findAll().size() > 0)
						? introduceSevice.findAll().get(0).getId()
						: new Introduce().getId());
		return "manager/introduce/updateIntroduce";
	}

	@SuppressWarnings("unchecked")
	@GetMapping("/admin/introduce-detail")
	public ResponseEntity<JSONObject> getDetail() throws Exception {
		JSONObject result = new JSONObject();
		result.put("introduce", introduceSevice.findById(1));
		return ResponseEntity.ok(result);
	}

	@SuppressWarnings("unchecked")
	@PostMapping("admin/update-introduce")
	public ResponseEntity<JSONObject> update(@ModelAttribute IntroduceDTO introduceDTO) throws Exception {
		Introduce introduce = (introduceSevice.findAll() != null && introduceSevice.findAll().size() > 0)
				? introduceSevice.findAll().get(0)
				: new Introduce();
		introduce.setDetail(introduceDTO.getDetail().replaceFirst(",", " ").trim());
		introduce.setUpdatedBy(getUserLogined().getId());
		introduce.setUpdatedDate(Calendar.getInstance().getTime());
		introduceSevice.saveOrUpdate(introduce, getUserLogined());
		JSONObject result = new JSONObject();
		result.put("message", Boolean.TRUE);
		return ResponseEntity.ok(result);
	}

}
