package com.mycompany.perfumeshop.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class UserDTO extends BaseDTO {
	private String username;
	private String password;
	private String email;
	private String fullname;
	private String address;
	private String phone;
	private String typeAccount;
	private MultipartFile avatar;

}
