package com.mycompany.perfumeshop.controller.manager;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mycompany.perfumeshop.conf.GlobalConfig;
import com.mycompany.perfumeshop.controller.BaseController;
import com.mycompany.perfumeshop.dto.MappingModel;
import com.mycompany.perfumeshop.dto.UserDTO;
import com.mycompany.perfumeshop.entities.User;
import com.mycompany.perfumeshop.entities.UserRole;
import com.mycompany.perfumeshop.service.UserRoleService;
import com.mycompany.perfumeshop.service.UserService;
import com.mycompany.perfumeshop.utils.ConvertUtils;
import com.mycompany.perfumeshop.valueObjects.AdminRequest;
import com.mycompany.perfumeshop.valueObjects.BaseVo;

@Controller
@RequestMapping("/perfume-shop/")
public class ManagerAccounController extends BaseController {

	@Autowired
	private MappingModel mappingModel;

	@Autowired
	private UserService userService;

	@Autowired
	private UserRoleService userRoleService;

	@Autowired
	private GlobalConfig globalConfig;

	@GetMapping("admin/my-account.html")
	public String index() throws Exception {
		getUserLogined();
		return "manager/account/myAccount";
	}

	@GetMapping("admin/add-account")
	public String addAccount() {
		return "manager/account/addAccountStaff";
	}

	@SuppressWarnings("unchecked")
	@PostMapping("admin/add-update-account")
	public ResponseEntity<JSONObject> addOrUpdate(HttpServletRequest request, @ModelAttribute UserDTO userDTO)
			throws Exception {
		Boolean typeAccount = userDTO.getTypeAccount() == null ? false : userDTO.getTypeAccount().equals("1");
		JSONObject result = new JSONObject();
		if (userDTO.getId() == null) {
			if (userService.findByUserNameAndEmail(userDTO.getUsername(), userDTO.getEmail()) != null) {
				result.put("result", Boolean.FALSE);
				result.put("message", "Tên đăng nhập hoặc email đã tồn tại!");
				return ResponseEntity.ok(result);
			}
		}
		User user = mappingModel.mappingModel(userDTO);
		userService.saveOrUpdate(user, userDTO.getAvatar(), getUserLogined(), typeAccount);
		result.put("result", Boolean.TRUE);
		result.put("message", "Thành công!");
		return ResponseEntity.ok(result);
	}

	@PostMapping("admin/update-password")
	public ResponseEntity<Boolean> changePassword(@RequestParam String OldPassword, @RequestParam String NewPassword)
			throws Exception {
		Boolean result = userService.changePassword(NewPassword, OldPassword, getUserLogined());
		getUserLogined();
		return ResponseEntity.ok(result);
	}

	@GetMapping("admin/account.html")
	public String account(final Model model, final HttpServletRequest request, final HttpServletResponse response)
			throws IOException {
		return "manager/account/manageAccount";
	}

	@GetMapping("admin/list-account")
	public ResponseEntity<BaseVo<User>> findAll(HttpServletRequest request) throws Exception {
		Integer currentPage = ConvertUtils.convertStringToInt(request.getParameter("page"), globalConfig.getInitPage());
		Integer typeAccount = ConvertUtils.convertStringToInt(request.getParameter("type"), 0);
		AdminRequest adminRequest = new AdminRequest(currentPage, globalConfig.getSizeManagePage(),
				getUserLogined().getId(), typeAccount);
		Page<User> page = userService.findAllByAdminRequest(adminRequest);
		BaseVo<User> baseVo = new BaseVo<User>(page.getContent(), page.getNumber() + 1, page.getTotalPages());
		return ResponseEntity.ok(baseVo);
	}

	@GetMapping("admin/decentralization-account/{idAccount}")
	public String decentralization(Model model, @PathVariable("idAccount") Integer idAccount) throws Exception {
		model.addAttribute("user", userService.findById(idAccount));
		return "manager/account/decentralization";
	}

	@PostMapping("admin/change-status-account")
	public ResponseEntity<Boolean> chnageStatusAccount(HttpServletRequest request) throws IOException {
		Integer idAccount = ConvertUtils.convertStringToInt(request.getParameter("id"), null);
		Boolean status = request.getParameter("status").equals("1");
		if (idAccount == null) {
			return ResponseEntity.ok(Boolean.FALSE);
		}
		try {
			User user = userService.findById(idAccount);
			user.setStatus(status);
			userService.saveOrUpdate(user, null, getUserLogined(), null);
			return ResponseEntity.ok(Boolean.TRUE);
		} catch (Exception e) {
			return ResponseEntity.ok(Boolean.FALSE);
		}
	}

	@SuppressWarnings("unchecked")
	@PostMapping("admin/change-status-role")
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

			UserRole userRole = userRoleService.findById(idUserRole);
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
			userRoleService.saveOrUpdate(userRole, getUserLogined());
			result.put("message", Boolean.TRUE);
			return ResponseEntity.ok(result);
		} catch (Exception e) {
			result.put("message", Boolean.FALSE);
			return ResponseEntity.ok(result);
		}
	}
}
