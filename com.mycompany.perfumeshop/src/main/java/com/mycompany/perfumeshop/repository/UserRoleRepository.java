package com.mycompany.perfumeshop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import com.mycompany.perfumeshop.entities.RequestCancelOrder;
import com.mycompany.perfumeshop.entities.UserRole;

@Repository
public interface UserRoleRepository
		extends JpaRepository<UserRole, Integer>, JpaSpecificationExecutor<RequestCancelOrder> {

	List<UserRole> findByStatus(Boolean status);
}
