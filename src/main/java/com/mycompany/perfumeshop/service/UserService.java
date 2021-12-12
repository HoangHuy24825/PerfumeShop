package com.mycompany.perfumeshop.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.web.multipart.MultipartFile;

import com.mycompany.perfumeshop.entities.User;
import com.mycompany.perfumeshop.valueObjects.AdminRequest;

public interface UserService {

	User findUserByUserName(String username) throws Exception;
	
	User findUserByUserNameAndStatus(String username,Boolean status) throws Exception;

	User findUserByEmail(String email) throws Exception;

	Page<User> findAllByAdminRequest(AdminRequest adminRequest) throws Exception;

	/**
	 * This method to save or update user. if typeAccount==null or
	 * typeAccount==false then typeAccount is customer register member else
	 * typeAccount is staff
	 * 
	 * @param user
	 * @param avatar
	 * @param userLogin
	 * @param typeAccount
	 * @return {@link User}
	 * @throws Exception
	 */
	User saveOrUpdate(User user, MultipartFile avatar, User userLogin, Boolean typeAccount) throws Exception;

	Boolean changePassword(String newPassword, String oldPassword, User user) throws Exception;

	public Boolean deleteById(Integer id) throws Exception;

	List<User> findAll() throws Exception;

	User findById(Integer id) throws Exception;

	User findByUserNameAndEmail(String userName, String email) throws Exception;
}
