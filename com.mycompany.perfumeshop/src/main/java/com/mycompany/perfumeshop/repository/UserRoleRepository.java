package com.mycompany.perfumeshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mycompany.perfumeshop.entities.UserRole;

@Repository
public interface UserRoleRepository extends JpaRepository<UserRole, Integer> {
	
}
