package com.mycompany.perfumeshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mycompany.perfumeshop.entities.Role;

@Repository
public interface RoleRepository extends JpaRepository<Role, Integer> {
	Role findByCode(String code);
}
