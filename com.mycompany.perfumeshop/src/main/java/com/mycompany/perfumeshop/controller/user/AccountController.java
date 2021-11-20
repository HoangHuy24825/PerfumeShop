package com.mycompany.perfumeshop.controller.user;

import java.io.IOException;
import java.util.List;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mycompany.perfumeshop.controller.BaseController;
import com.mycompany.perfumeshop.dto.MappingModel;
import com.mycompany.perfumeshop.dto.UserDTO;
import com.mycompany.perfumeshop.entities.User;
import com.mycompany.perfumeshop.service.UserService;

@Controller
public class AccountController extends BaseController {

	@Autowired
	private UserService userService;

	@Autowired
	private MappingModel mappingModel;

	@Autowired
	private JavaMailSender emailSender;

	@RequestMapping(value = { "/my-account" }, method = RequestMethod.GET)
	public String getMyCccount(final Model model, final HttpServletRequest request, final HttpServletResponse response)
			throws IOException {

		return "user/account/myAccountUser";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/update-password" }, method = RequestMethod.POST)
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

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/add-update-account" }, method = RequestMethod.POST)
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

	@RequestMapping(value = { "/forget-password" }, method = RequestMethod.GET)
	public String forgetPassword(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException {

		return "user/login/forgetPassword";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/change-password-forget" }, method = RequestMethod.GET)
	public ResponseEntity<JSONObject> changePasswordForget(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException {
		String email = request.getParameter("email");
		email = email.replace("-", "@");
		String password = request.getParameter("password");
		User user = userService.getUserByEmail(email);
		user.setPassword(new BCryptPasswordEncoder().encode(password));
		userService.saveOrUpdate(user);
		JSONObject result = new JSONObject();
		result.put("message", Boolean.TRUE);
		return ResponseEntity.ok(result);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/code-request-forget-password" }, method = RequestMethod.GET)
	public ResponseEntity<JSONObject> checkEmail(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException, MessagingException {
		JSONObject result = new JSONObject();
		String emailReceiver = request.getParameter("email");
		emailReceiver = emailReceiver.replace("-", "@");
		User user = userService.getUserByEmail(emailReceiver);
		if (user != null) {
			result.put("result", Boolean.TRUE);
			return ResponseEntity.ok(result);
		} else {
			result.put("message", "Không tìm thấy tài khoản phù hợp");
			result.put("code", 0);
			return ResponseEntity.ok(result);
		}
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/send-email-code-confirm" }, method = RequestMethod.GET)
	public ResponseEntity<JSONObject> sendEmail(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException, MessagingException {
		JSONObject result = new JSONObject();
		String emailReceiver = request.getParameter("email");
		emailReceiver = emailReceiver.replace("-", "@");
		User user = userService.getUserByEmail(emailReceiver);
		String fullname = user.getFullname();

		Random random = new Random();
		Integer code = random.nextInt(900000) + 100000;

		MimeMessage message = emailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

		String htmlMsg = "<div>Dear " + fullname + " !</div> <br/><br/>";
		htmlMsg += "<div>Cảm ơn bạn đã đăng sử dụng dịch vụ tại <b>Electronic Device Shop</b>!</div> <br/>";
		htmlMsg += "<div>Mã xác nhận của bạn là: <b>" + code + "</b>!</div><br/>";
		htmlMsg += "<div>Vui lòng không cung cấp mã này cho bất kỳ ai để tránh việc bị mất thông tin cá nhân.</div><br/>";
		htmlMsg += "<div>Thanks & regards,</div><br/>";
		htmlMsg += "<div style=\"color: chartreuse;\"><b>Electronic Device</b></div><br/>";

		message.setContent(htmlMsg, "text/html");
		helper.setTo(emailReceiver);
		helper.setSubject("[Electronic Device Shop] Mã xác nhận lấy lại mật khẩu.");

		emailSender.send(message);

		result.put("result", Boolean.TRUE);
		result.put("codeConfirm", code);
		return ResponseEntity.ok(result);
	}

}
