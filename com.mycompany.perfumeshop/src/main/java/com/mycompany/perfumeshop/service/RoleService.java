package com.mycompany.perfumeshop.service;

import org.springframework.stereotype.Service;

import com.mycompany.perfumeshop.entities.Role;

@Service
public class RoleService extends BaseService<Role> {

	@Override
	protected Class<Role> clazz() {
		return Role.class;
	}

	public Role getRoleByCode(String code) {
		return super.executeNativeSql("SELECT * FROM electronicdeviceshop.tbl_roles WHERE code='" + code+"'").get(0);
	}
}
