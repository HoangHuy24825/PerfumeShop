package com.mycompany.perfumeshop.controller.manager;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mycompany.perfumeshop.controller.BaseController;
import com.mycompany.perfumeshop.dto.MappingModel;
import com.mycompany.perfumeshop.dto.UserDTO;
import com.mycompany.perfumeshop.entities.User;
import com.mycompany.perfumeshop.entities.UserRole;
import com.mycompany.perfumeshop.service.UserRoleService;
import com.mycompany.perfumeshop.service.UserService;
import com.mycompany.perfumeshop.utils.Constants;
import com.mycompany.perfumeshop.utils.ConvertUtils;
import com.mycompany.perfumeshop.valueObjects.BaseVo;

@Controller
public class ManagerAccounController extends BaseController {

	private MappingModel mappingModel = new MappingModel();

	@Autowired
	private UserService userService;

	@Autowired
	private UserRoleService userRoleService;

	private static final Integer PAGE_SIZE = 10;

	@RequestMapping(value = { "/admin/my-account" }, method = RequestMethod.GET)
	public String index(final Model model, final HttpServletRequest request, final HttpServletResponse response)
			throws IOException {
		getUserLogined();
		return "manager/account/myAccount";
	}

	@RequestMapping(value = { "/admin/add-account" }, method = RequestMethod.GET)
	public String addAccount(final Model model, final HttpServletRequest request, final HttpServletResponse response)
			throws IOException {
		return "manager/account/addAccountStaff";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/admin/add-update-account" }, method = RequestMethod.POST)
	public ResponseEntity<JSONObject> addOrUpdate(final Model model, final HttpServletRequest request,
			final HttpServletResponse response, @ModelAttribute UserDTO userDTO) throws Exception {
		Integer typeAccount;
		try {
			typeAccount = Integer.parseInt(request.getParameter("typeAccount"));
		} catch (Exception e) {
			typeAccount = 0;
		}
		JSONObject result = new JSONObject();
		User user = mappingModel.mappingModel(userDTO);
		if (user.getId() == null) {
			List<User> users = userService.findAll();
			for (User userItem : users) {
				if (userItem.getUsername().equalsIgnoreCase(user.getUsername())) {
					result.put("result", Boolean.FALSE);
					result.put("message", "Tên đăng nhập đã tồn tại!");
					return ResponseEntity.ok(result);
				}
			}
			if (isLogined()) {
				user.setCreatedBy(getUserLogined().getId());
			}
			userService.save(user, userDTO.getAvatar(), typeAccount);
		} else {
			if (isLogined()) {
				user.setUpdatedBy(getUserLogined().getId());
			}
			userService.edit(user, userDTO.getAvatar());
		}
		result.put("result", Boolean.TRUE);
		result.put("message", "Thành công!");
		return ResponseEntity.ok(result);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/admin/update-password" }, method = RequestMethod.POST)
	public ResponseEntity<JSONObject> changePassword(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException {
		JSONObject result = new JSONObject();
		String oldPass = request.getParameter("oldPass");
		String newPass = request.getParameter("newPass");
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		User currentUser = getUserLogined();
		if (passwordEncoder.matches(oldPass, currentUser.getPassword())) {
			currentUser.setPassword(passwordEncoder.encode(newPass));
			userService.saveOrUpdate(currentUser);
			getUserLogined();
			result.put("message", Boolean.TRUE);
		} else {
			result.put("message", Boolean.FALSE);
		}
		return ResponseEntity.ok(result);
	}

	@RequestMapping(value = { "/admin/account" }, method = RequestMethod.GET)
	public String account(final Model model, final HttpServletRequest request, final HttpServletResponse response)
			throws IOException {
		return "manager/account/manageAccount";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/admin/list-account" }, method = RequestMethod.GET)
	public ResponseEntity<JSONObject> findAll(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException {

		JSONObject result = new JSONObject();
		Integer currentPage = ConvertUtils.convertStringToInt(request.getParameter("page"), Constants.INIT_PAGE);
		Integer typeAccount = ConvertUtils.convertStringToInt(request.getParameter("type"), 0);

		BaseVo<User> baseVo = userService.getListUserByRole(typeAccount, currentPage, PAGE_SIZE,
				getUserLogined().getId());
		if (baseVo != null) {
			List<JSONObject> jsonUsers = new ArrayList<JSONObject>();
			if (baseVo.getListEntity() != null && baseVo.getListEntity().size() > 0) {
				List<User> users = baseVo.getListEntity();
				for (User user : users) {
					jsonUsers.add(mappingModel.mappingModel(user));
				}
			}
			result.put("users", jsonUsers);
			result.put("currentPage", currentPage);
			result.put("totalPage", baseVo.getTotalPage());
			return ResponseEntity.ok(result);
		}
		return null;
	}

	@RequestMapping(value = { "/admin/decentralization-account/{idAccount}" }, method = RequestMethod.GET)
	public String decentralization(final Model model, final HttpServletRequest request,
			final HttpServletResponse response, @PathVariable("idAccount") Integer idAccount) throws IOException {
		model.addAttribute("user", userService.getById(idAccount));
		return "manager/account/decentralization";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/admin/change-status-account" }, method = RequestMethod.POST)
	public ResponseEntity<JSONObject> chnageStatusAccount(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException {
		JSONObject result = new JSONObject();
		Integer idAccount = ConvertUtils.convertStringToInt(request.getParameter("id"), null);
		Boolean status = request.getParameter("status").equals("1");
		if (idAccount == null) {
			result.put("message", Boolean.FALSE);
			return ResponseEntity.ok(result);
		}
		try {
			User user = userService.getById(idAccount);
			user.setStatus(status);
			userService.saveOrUpdate(user);
			result.put("message", Boolean.TRUE);
			return ResponseEntity.ok(result);
		} catch (Exception e) {
			result.put("message", Boolean.FALSE);
			return ResponseEntity.ok(result);
		}
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/admin/change-status-role" }, method = RequestMethod.POST)
	public ResponseEntity<JSONObject> chnageStatusRole(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException {
		JSONObject result = new JSONObject();
		Integer idUserRole;
		Boolean status;
		Integer type;
		try {
			idUserRole = Integer.parseInt(request.getParameter("idUserRole"));
		} catch (Exception e) {
			result.put("message", Boolean.FALSE);
			return ResponseEntity.ok(result);
		}

		try {
			status = Boolean.parseBoolean(request.getParameter("status"));
		} catch (Exception e) {
			result.put("message", Boolean.FALSE);
			return ResponseEntity.ok(result);
		}

		try {
			type = Integer.parseInt(request.getParameter("type"));
		} catch (Exception e) {
			result.put("message", Boolean.FALSE);
			return ResponseEntity.ok(result);
		}

		try {

			UserRole userRole = userRoleService.getById(idUserRole);
			switch (type) {
			case 1:
				userRole.setView(status);
				break;
			case 2:
				userRole.setInsert(status);
				break;
			case 3:
				userRole.setUpdate(status);
				break;
			case 4:
				userRole.setDelete(status);
				break;
			default:
				break;
			}
			if (status) {
				userRole.setView(true);
			}
			userRoleService.saveOrUpdate(userRole);
			result.put("message", Boolean.TRUE);
			return ResponseEntity.ok(result);
		} catch (Exception e) {
			result.put("message", Boolean.FALSE);
			return ResponseEntity.ok(result);
		}
	}
}
