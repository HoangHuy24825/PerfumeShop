package com.mycompany.perfumeshop.controller.manager;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mycompany.perfumeshop.conf.GlobalConfig;
import com.mycompany.perfumeshop.controller.BaseController;
import com.mycompany.perfumeshop.entities.Contact;
import com.mycompany.perfumeshop.service.ContactService;

@Controller
@RequestMapping("/perfume-shop/admin/")
public class ManageContactController extends BaseController {

	@Autowired
	private ContactService contactService;

	@Autowired
	private GlobalConfig globalConfig;

	@GetMapping("contact.html")
	public String showContact() {
		return "manager/contact/contact";
	}

	@GetMapping("contact/{keySearch}/{currentPage}")
	public ResponseEntity<Map<String, Object>> getListContact(@PathVariable(required = false) String keySearch,
			@PathVariable String currentPage) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		Page<Contact> page = contactService.findAll(keySearch, currentPage, globalConfig.getSizeManagePage());
		result.put("currentPage", page.getNumber() + 1);
		result.put("totalPage", page.getTotalPages());
		result.put("listContact", page.getContent());
		return ResponseEntity.ok(result);
	}

	@GetMapping("contact/{id}")
	public ResponseEntity<Contact> detailContact(@PathVariable String id) throws Exception {
		return ResponseEntity.ok(contactService.findById(id));
	}

	@DeleteMapping("contact/{id}")
	public ResponseEntity<Boolean> delete(@PathVariable String id) throws Exception {
		return ResponseEntity.ok(contactService.delete(id));
	}

}
