package com.mycompany.perfumeshop.service;

import com.mycompany.perfumeshop.entities.User;
import com.mycompany.perfumeshop.entities.UserRole;

public interface UserRoleService {

	UserRole saveOrUpdate(UserRole userRole, User userLogin) throws Exception;

	Boolean deleteById(Integer id) throws Exception;

	UserRole findById(Integer id) throws Exception;

}
