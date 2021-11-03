package com.mycompany.perfumeshop.controller.user;

import java.io.IOException;

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
import com.mycompany.perfumeshop.service.IntroduceSevice;

@Controller
public class IntroduceController extends BaseController {
	@Autowired
	private IntroduceSevice introduceSevice;

	@RequestMapping(value = { "/introduce" }, method = RequestMethod.GET)
	public String getIntroduce(final Model model, final HttpServletRequest request, final HttpServletResponse response)
			throws IOException {
		return "user/introduce/introduce";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/load-introduce" }, method = RequestMethod.GET)
	public ResponseEntity<JSONObject> getHtml(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException {
		JSONObject result = new JSONObject();
		result.put("content", introduceSevice.getById(1));
		return ResponseEntity.ok(result);
	}
}
