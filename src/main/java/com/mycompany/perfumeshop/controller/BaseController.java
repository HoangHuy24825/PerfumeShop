package com.mycompany.perfumeshop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.mycompany.perfumeshop.conf.GlobalConfig;
import com.mycompany.perfumeshop.entities.User;
import com.mycompany.perfumeshop.entities.UserRole;
import com.mycompany.perfumeshop.service.UserService;

@Controller
public abstract class BaseController {

	@Autowired
	private UserService userService;

	@Autowired
	private GlobalConfig globalConfig;

	@ModelAttribute("isLogined")
	public boolean isLogined() {
		boolean isLogined = false;
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if (principal instanceof UserDetails) {
			isLogined = true;
		}
		return isLogined;
	}

	@ModelAttribute("userLogined")
	public User getUserLogined() throws Exception {
		Object userLogined = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if (userLogined != null && userLogined instanceof UserDetails) {
			User user = (User) userLogined;
			User userBD = userService.findById(user.getId());
			user.setStatus(userBD.getStatus());
			user.setCreatedBy(userBD.getCreatedBy());
			user.setUpdatedBy(userBD.getUpdatedBy());
			user.setCreatedDate(userBD.getCreatedDate());
			user.setUpdatedDate(userBD.getUpdatedDate());

			user.setUsername(userBD.getUsername());
			user.setPassword(userBD.getPassword());
			user.setEmail(userBD.getEmail());
			user.setFullname(userBD.getFullname());
			user.setAddress(userBD.getAddress());
			user.setPhone(userBD.getPhone());
			user.setAvatar(userBD.getAvatar());
			return user;
		}
		return null;
	}

	@ModelAttribute("categoryRole")
	public UserRole getCategoryRole() throws Exception {
		User user = getUserLogined();
		if (user != null) {
			for (UserRole userRole : user.getUserRoles()) {
				if (userRole.getRole().getCode().equalsIgnoreCase("MC")) {
					return userRole;
				}
			}
		}
		return null;
	}

	@ModelAttribute("productRole")
	public UserRole getProductRole() throws Exception {
		User user = getUserLogined();
		if (user != null) {
			for (UserRole userRole : user.getUserRoles()) {
				if (userRole.getRole().getCode().equalsIgnoreCase("MP")) {
					return userRole;
				}
			}
		}
		return null;
	}

	@ModelAttribute("categoryBlogRole")
	public UserRole getCategoryBlofRole() throws Exception {
		User user = getUserLogined();
		if (user != null) {
			for (UserRole userRole : user.getUserRoles()) {
				if (userRole.getRole().getCode().equalsIgnoreCase("MCB")) {
					return userRole;
				}
			}
		}
		return null;
	}

	@ModelAttribute("blogRole")
	public UserRole getBlogRole() throws Exception {
		User user = getUserLogined();
		if (user != null) {
			for (UserRole userRole : user.getUserRoles()) {
				if (userRole.getRole().getCode().equalsIgnoreCase("MB")) {
					return userRole;
				}
			}
		}
		return null;
	}

	@ModelAttribute("orderRole")
	public UserRole getOrderRole() throws Exception {
		User user = getUserLogined();
		if (user != null) {
			for (UserRole userRole : user.getUserRoles()) {
				if (userRole.getRole().getCode().equalsIgnoreCase("MO")) {
					return userRole;
				}
			}
		}
		return null;
	}

	@ModelAttribute("accountRole")
	public UserRole getAccountRole() throws Exception {
		User user = getUserLogined();
		if (user != null) {
			for (UserRole userRole : user.getUserRoles()) {
				if (userRole.getRole().getCode().equalsIgnoreCase("MA")) {
					return userRole;
				}
			}
		}
		return null;
	}

	@ModelAttribute("introduceRole")
	public UserRole getIntroduceRole() throws Exception {
		User user = getUserLogined();
		if (user != null) {
			for (UserRole userRole : user.getUserRoles()) {
				if (userRole.getRole().getCode().equalsIgnoreCase("MI")) {
					return userRole;
				}
			}
		}
		return null;
	}

	@ModelAttribute("notifyRole")
	public UserRole getNotifyRole() throws Exception {
		User user = getUserLogined();
		if (user != null) {
			for (UserRole userRole : user.getUserRoles()) {
				if (userRole.getRole().getCode().equalsIgnoreCase("MN")) {
					return userRole;
				}
			}
		}
		return null;
	}

	@ModelAttribute("tileWebsite")
	public String getTitleWebSite() {
		return globalConfig.getTitleWebsite();
	}

}
