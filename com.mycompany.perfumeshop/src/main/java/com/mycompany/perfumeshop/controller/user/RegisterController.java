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
public class RegisterController extends BaseController{

	@Autowired
	private JavaMailSender emailSender;

	private MappingModel mappingModel = new MappingModel();

	@Autowired
	private UserService userService;

	@RequestMapping(value = { "/register" }, method = RequestMethod.GET)
	public String register(final Model model, final HttpServletRequest request, final HttpServletResponse response)
			throws IOException {
		return "user/login/register";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/code-confirm" }, method = RequestMethod.GET)
	public ResponseEntity<JSONObject> sendCode(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException, MessagingException {
		String emailReceiver = request.getParameter("email");
		String fullname = request.getParameter("fullname");

		Random random = new Random();
		Integer code = random.nextInt(900000) + 100000;

		MimeMessage message = emailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

		String htmlMsg = "<div>Dear " + fullname + " !</div> <br/><br/>";
		htmlMsg += "<div>Cảm ơn bạn đã đăng ký tài khoản tại <b>Electronic Device Shop</b>!</div> <br/>";
		htmlMsg += "<div>Mã xác nhận của bạn là: <b>" + code + "</b>!</div><br/>";
		htmlMsg += "<div>Vui lòng không cung cấp mã này cho bất kỳ ai để tránh việc bị mất thông tin cá nhân.</div><br/>";
		htmlMsg += "<div>Thanks & regards,</div><br/>";
		htmlMsg += "<div style=\"color: chartreuse;\"><b>Electronic Device</b></div><br/>";

		message.setContent(htmlMsg, "text/html");
		helper.setTo(emailReceiver);
		helper.setSubject("[Electronic Device Shop] Mã xác nhận đăng ký tài khoản.");

		emailSender.send(message);
		JSONObject result = new JSONObject();
		result.put("result", Boolean.TRUE);
		result.put("codeConfirm", code);
		return ResponseEntity.ok(result);
	}
	

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/check-username" }, method = RequestMethod.GET)
	public ResponseEntity<JSONObject> checkUserExisted(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws IOException {
		String username = request.getParameter("username");
		JSONObject result = new JSONObject();
		List<User> users = userService.findAll();
		for (User user : users) {
			if (user.getUsername().equalsIgnoreCase(username)) {
				result.put("result", Boolean.FALSE);
				return ResponseEntity.ok(result);
			}
		}
		result.put("result", Boolean.TRUE);
		return ResponseEntity.ok(result);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/register-account" }, method = RequestMethod.POST)
	public ResponseEntity<JSONObject> register(final Model model, final HttpServletRequest request,
			final HttpServletResponse response, @ModelAttribute UserDTO userDTO) throws IOException {
		JSONObject result = new JSONObject();
		try {
			User user = mappingModel.mappingModel(userDTO);
			userService.save(user, null, 2);
			result.put("message", Boolean.TRUE);
			return ResponseEntity.ok(result);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("message", Boolean.FALSE);
			return ResponseEntity.ok(result);
		}
	}

}
