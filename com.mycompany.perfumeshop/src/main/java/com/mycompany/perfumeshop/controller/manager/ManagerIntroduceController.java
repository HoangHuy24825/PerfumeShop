package com.mycompany.perfumeshop.controller.manager;

import java.io.IOException;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mycompany.perfumeshop.controller.BaseController;
import com.mycompany.perfumeshop.dto.IntroduceDTO;
import com.mycompany.perfumeshop.entities.Introduce;
import com.mycompany.perfumeshop.service.IntroduceSevice;

@Controller
public class ManagerIntroduceController extends BaseController {
	@Autowired
	private IntroduceSevice introduceSevice;

	@RequestMapping(value = { "/admin/introduce" }, method = RequestMethod.GET)
	public String index(final Model model, final HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		model.addAttribute("introduce", introduceSevice.findAll().get(0));
		return "manager/introduce/managerIntroduce";
	}

	@RequestMapping(value = { "/admin/edit-introduce" }, method = RequestMethod.GET)
	public String getUpdatePage(final Model model, final HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		model.addAttribute("id_introduce", introduceSevice.findAll().get(0).getId());
		return "manager/introduce/updateIntroduce";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/admin/introduce-detail" }, method = RequestMethod.GET)
	public ResponseEntity<JSONObject> getDetail(final Model model, final HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		JSONObject result = new JSONObject();
		result.put("introduce", introduceSevice.getById(1));
		return ResponseEntity.ok(result);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/admin/update-introduce" }, method = RequestMethod.POST)
	public ResponseEntity<JSONObject> update(final Model model, final HttpServletRequest request,
			HttpServletResponse response, @ModelAttribute IntroduceDTO introduceDTO) throws IOException {
		Introduce introduce = introduceSevice.getById(1);
		introduce.setDetail(introduceDTO.getDetail().replaceFirst(",", " ").trim());
		introduce.setUpdatedBy(getUserLogined().getId());
		introduce.setUpdatedDate(Calendar.getInstance().getTime());
		introduceSevice.saveOrUpdate(introduce);
		JSONObject result = new JSONObject();
		result.put("message", Boolean.TRUE);
		return ResponseEntity.ok(result);
	}

}
