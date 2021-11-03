package com.mycompany.perfumeshop.service;

import org.springframework.stereotype.Service;

import com.mycompany.perfumeshop.entities.UserRole;

@Service
public class UserRoleService extends BaseService<UserRole> {

	@Override
	protected Class<UserRole> clazz() {
		return UserRole.class;
	}

}
